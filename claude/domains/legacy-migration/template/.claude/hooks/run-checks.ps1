# Stop hook: runs the build and tests before Claude is allowed to finish.
# Exit code 2 blocks the stop and sends the error text back to Claude to fix.

# Edit these commands to match your target stack.
$Checks = @(
    'dotnet build --nologo',
    'dotnet test --nologo --no-build'
)

$hookInput = [Console]::In.ReadToEnd() | ConvertFrom-Json

# If Claude is already continuing because of this hook, let it stop so it cannot loop forever.
if ($hookInput.stop_hook_active) { exit 0 }

Set-Location $env:CLAUDE_PROJECT_DIR

# Nothing changed (for example, Claude only answered a question), so there is nothing to check.
if (-not (git status --porcelain)) { exit 0 }

foreach ($check in $Checks) {
    $output = Invoke-Expression "$check 2>&1" | Out-String
    if ($LASTEXITCODE -ne 0) {
        # Send only the end of the output, where the errors usually are.
        $tail = ($output -split "`n" | Select-Object -Last 60) -join "`n"
        [Console]::Error.WriteLine("Check failed: $check`n$tail")
        exit 2
    }
}

exit 0
