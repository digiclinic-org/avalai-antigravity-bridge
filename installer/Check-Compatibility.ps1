[CmdletBinding()]
param([string]$Resources = "")

$ErrorActionPreference = "Stop"
$WorkRoot = Join-Path $env:LOCALAPPDATA "AvalAI-Antigravity-Bridge"
$SourceDir = Join-Path $WorkRoot "antigravity-add-model"

if ([string]::IsNullOrWhiteSpace($Resources)) {
    $candidate = Join-Path $env:LOCALAPPDATA "Programs\antigravity\resources"
    if (Test-Path (Join-Path $candidate "app.asar")) { $Resources = $candidate }
}
if (-not (Test-Path (Join-Path $Resources "app.asar"))) {
    Write-Error "Antigravity resources/app.asar not found. Pass -Resources explicitly."
    exit 1
}
if (-not (Test-Path (Join-Path $SourceDir "deploy.ps1"))) {
    Write-Host "Upstream source is not cached; run Install-AvalAI.ps1 -CheckOnly first."
    exit 2
}
$running = Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.ProcessName -match 'antigravity' }
if ($running) {
    Write-Error "Close Antigravity completely before compatibility check."
    exit 1
}
Push-Location $SourceDir
try {
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\deploy.ps1" --check --resources $Resources
    exit $LASTEXITCODE
}
finally { Pop-Location }
