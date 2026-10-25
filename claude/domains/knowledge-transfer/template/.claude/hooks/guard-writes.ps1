# PreToolUse hook: runs before every Write and Edit call.
# It blocks two things:
#   1. Writing anywhere outside docs/kt/.
#   2. Text that looks like a secret (password, key, token, connection string).
# Exit code 2 blocks the call and sends the reason back to Claude.

$hookInput = [Console]::In.ReadToEnd() | ConvertFrom-Json
$toolInput = $hookInput.tool_input

$projectDir = $env:CLAUDE_PROJECT_DIR
$allowedDir = [IO.Path]::GetFullPath((Join-Path $projectDir 'docs/kt')).TrimEnd('\', '/') + [IO.Path]::DirectorySeparatorChar
$path = $toolInput.file_path
if (-not [IO.Path]::IsPathRooted($path)) { $path = Join-Path $projectDir $path }
$target = [IO.Path]::GetFullPath($path)

if (-not $target.StartsWith($allowedDir, [StringComparison]::OrdinalIgnoreCase)) {
    [Console]::Error.WriteLine("Blocked: you may only write inside docs/kt/. Target was: $target")
    exit 2
}

# Write sends the whole file as 'content'. Edit sends only the new text as 'new_string'.
$text = if ($null -ne $toolInput.content) { $toolInput.content } else { $toolInput.new_string }
if (-not $text) { exit 0 }

# Placeholders such as <PASSWORD> are allowed, because '<' and '>' are excluded from values.
$secretPatterns = [ordered]@{
    'a password, key or token value' = '(?i)\b(password|passwd|pwd|secret|api[_-]?key|access[_-]?key|client[_-]?secret|token)\b["'']?\s*[:=]\s*["'']?[^\s"''<>]{8,}'
    'a connection string password'   = '(?i)\b(password|pwd)\s*=\s*[^;\s"''<>]+;'
    'a private key'                  = '-----BEGIN [A-Z ]*PRIVATE KEY-----'
    'a storage account key'          = '(?i)AccountKey=[A-Za-z0-9+/=]{20,}'
    'an AWS access key'              = '\bAKIA[0-9A-Z]{16}\b'
    'a GitHub token'                 = '\bgh[pousr]_[A-Za-z0-9]{36,}\b'
    'a JSON web token'               = '\beyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.'
}

foreach ($name in $secretPatterns.Keys) {
    if ($text -match $secretPatterns[$name]) {
        [Console]::Error.WriteLine("Blocked: the text looks like it contains $name. Write where the secret is kept, never its value. If this is a false alarm, reword the text or ask a human.")
        exit 2
    }
}

exit 0
