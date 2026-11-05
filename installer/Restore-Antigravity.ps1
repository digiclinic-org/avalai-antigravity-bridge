[CmdletBinding()]
param([string]$Resources = "")

$ErrorActionPreference = "Stop"
$WorkRoot = Join-Path $env:LOCALAPPDATA "AvalAI-Antigravity-Bridge"
$SourceDir = Join-Path $WorkRoot "antigravity-add-model"
if ([string]::IsNullOrWhiteSpace($Resources)) {
    $candidate = Join-Path $env:LOCALAPPDATA "Programs\antigravity\resources"
    if (Test-Path (Join-Path $candidate "app.asar")) { $Resources = $candidate }
}
if (-not (Test-Path (Join-Path $SourceDir "deploy.ps1"))) {
    throw "Upstream source is missing. Run installer\Install-AvalAI.ps1 first to download it."
}
$running = Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.ProcessName -match 'antigravity' }
if ($running) { throw "Close Antigravity completely before restore." }
Push-Location $SourceDir
try {
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\deploy.ps1" --restore --resources $Resources
    if ($LASTEXITCODE -ne 0) { throw "Upstream restore failed. See upstream recovery documentation." }
}
finally { Pop-Location }
