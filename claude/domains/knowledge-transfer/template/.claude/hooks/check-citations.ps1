# Stop hook: checks citations before Claude is allowed to finish.
# A "cited document" is a Markdown file in docs/kt/ whose first line is <!-- kt:cited -->.
# For each cited document that changed:
#   - every bullet, numbered step and table data row must cite a source:
#     [src: <path under source/>], [src: <path>:<line>] or [int: I<number>]
#   - every [src: ...] path must exist under source/
#   - every [int: ...] must have a matching file in docs/kt/interviews/
#   - the document must stay under the line limit
# Exit code 2 blocks the stop and sends the problems back to Claude to fix.

$MaxLines = 300

$hookInput = [Console]::In.ReadToEnd() | ConvertFrom-Json

# If Claude is already continuing because of this hook, let it stop so it cannot loop forever.
if ($hookInput.stop_hook_active) { exit 0 }

Set-Location $env:CLAUDE_PROJECT_DIR

# Changed or new Markdown files under docs/kt/. Each line looks like "XY path" or "XY old -> new".
$changed = git status --porcelain --untracked-files=all -- docs/kt |
    ForEach-Object { ($_.Substring(3) -split ' -> ')[-1].Trim('"') } |
    Where-Object { $_ -like '*.md' -and (Test-Path $_) }

# Nothing changed (for example, Claude only answered a question), so there is nothing to check.
if (-not $changed) { exit 0 }

$tableSeparator = '^\s*\|[\s:|-]+\|\s*$'
$problems = [System.Collections.Generic.List[string]]::new()

foreach ($file in $changed) {
    $lines = @(Get-Content $file)
    if ($lines.Count -eq 0 -or $lines[0].Trim() -ne '<!-- kt:cited -->') { continue }

    if ($lines.Count -gt $MaxLines) {
        $problems.Add("${file}: $($lines.Count) lines, over the $MaxLines line limit. Split it and update outline.md.")
    }

    $inCodeBlock = $false
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        $where = "${file}:$($i + 1)"

        # Templates inside code blocks are examples, not facts.
        if ($line.TrimStart().StartsWith('```')) { $inCodeBlock = -not $inCodeBlock; continue }
        if ($inCodeBlock) { continue }

        $isListItem = $line -match '^\s*([-*+]|\d+\.)\s+\S'
        $isTableRow = $line -match '^\s*\|' -and $line -notmatch $tableSeparator
        $isTableHeader = $isTableRow -and ($i + 1 -lt $lines.Count) -and ($lines[$i + 1] -match $tableSeparator)
        if (-not ($isListItem -or ($isTableRow -and -not $isTableHeader))) { continue }

        $srcRefs = [regex]::Matches($line, '\[src:\s*([^\]]+?)\s*\]')
        $intRefs = [regex]::Matches($line, '\[int:\s*(I\d+)\s*\]')

        if ($srcRefs.Count -eq 0 -and $intRefs.Count -eq 0) {
            $problems.Add("${where}: no source. Add [src: ...] or [int: ...], or move the fact to open-questions.md.")
            continue
        }
        foreach ($ref in $srcRefs) {
            $path = $ref.Groups[1].Value -replace ':\d+(-\d+)?$', ''
            if (-not (Test-Path (Join-Path 'source' $path))) {
                $problems.Add("${where}: [src: $($ref.Groups[1].Value)] - file not found under source/.")
            }
        }
        foreach ($ref in $intRefs) {
            $id = $ref.Groups[1].Value
            if (-not (Get-ChildItem 'docs/kt/interviews' -Filter "$id-*.md" -ErrorAction SilentlyContinue)) {
                $problems.Add("${where}: [int: $id] - no file docs/kt/interviews/$id-*.md.")
            }
        }
    }
}

if ($problems.Count -gt 0) {
    # Send only the first problems, so a badly broken file doesn't flood the context.
    $shown = $problems | Select-Object -First 40
    $more = if ($problems.Count -gt 40) { "`n...and $($problems.Count - 40) more." } else { '' }
    [Console]::Error.WriteLine("Citation check failed:`n" + ($shown -join "`n") + $more)
    exit 2
}

exit 0
