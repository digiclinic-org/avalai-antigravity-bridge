[CmdletBinding()]
param(
    [string]$Resources = "",
    [switch]$CheckOnly,
    [switch]$SkipBuild
)

$ErrorActionPreference = "Stop"
$UpstreamRepo = "https://github.com/vahapogut/antigravity-add-model"
$WorkRoot = Join-Path $env:LOCALAPPDATA "AvalAI-Antigravity-Bridge"
$SourceDir = Join-Path $WorkRoot "antigravity-add-model"
$LogDir = Join-Path $WorkRoot "logs"
New-Item -ItemType Directory -Force -Path $WorkRoot, $LogDir | Out-Null
$LogFile = Join-Path $LogDir ("install-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".log")
Start-Transcript -Path $LogFile -Force | Out-Null

function Stop-WithMessage([string]$Message) {
    Write-Host "`n[STOP] $Message" -ForegroundColor Red
    Write-Host "Log: $LogFile"
    Stop-Transcript | Out-Null
    exit 1
}

try {
    Write-Host "`nAvalAI for Antigravity - Windows setup" -ForegroundColor Cyan
    Write-Host "This installer downloads the upstream project and uses its compatibility checks."
    Write-Host "It will not force-patch an unknown Antigravity runtime.`n"

    $node = Get-Command node -ErrorAction SilentlyContinue
    $npm = Get-Command npm -ErrorAction SilentlyContinue
    if (-not $node -or -not $npm) {
        Stop-WithMessage "Node.js/npm was not found. Install Node.js 22.12.0 or newer from https://nodejs.org/ and reopen PowerShell."
    }

    $nodeVersionText = (& node --version 2>$null | Select-Object -First 1)
    if ($nodeVersionText -notmatch '^v?(\d+)\.(\d+)\.(\d+)') {
        Stop-WithMessage "Could not parse Node.js version: $nodeVersionText"
    }
    $major = [int]$Matches[1]; $minor = [int]$Matches[2]
    if (($major -lt 22) -or (($major -eq 22) -and ($minor -lt 12))) {
        Stop-WithMessage "Node.js 22.12.0 or newer is required. Detected $nodeVersionText"
    }
    Write-Host "[OK] Node.js $nodeVersionText"

    if ([string]::IsNullOrWhiteSpace($Resources)) {
        $candidate = Join-Path $env:LOCALAPPDATA "Programs\antigravity\resources"
        if (Test-Path (Join-Path $candidate "app.asar")) { $Resources = $candidate }
    }
    if ([string]::IsNullOrWhiteSpace($Resources) -or -not (Test-Path $Resources)) {
        Stop-WithMessage "Antigravity Resources folder not found. Rerun with -Resources 'C:\path\to\resources'."
    }
    $Resources = (Resolve-Path $Resources).Path
    if (-not (Test-Path (Join-Path $Resources "app.asar"))) {
        Stop-WithMessage "The selected folder does not contain app.asar: $Resources"
    }
    Write-Host "[OK] Resources: $Resources"

    $proc = Get-Process -ErrorAction SilentlyContinue | Where-Object {
        $_.ProcessName -match 'antigravity'
    }
    if ($proc) {
        Stop-WithMessage "Antigravity appears to be running. Close Antigravity completely (including tray/background processes), then run again."
    }

    if (Test-Path $SourceDir) {
        Remove-Item -Recurse -Force $SourceDir
    }
    New-Item -ItemType Directory -Force -Path $SourceDir | Out-Null

    $zipPath = Join-Path $WorkRoot "upstream-main.zip"
    $zipUrl = "https://github.com/vahapogut/antigravity-add-model/archive/refs/heads/main.zip"
    Write-Host "`n[1/4] Downloading upstream source..."
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
    Expand-Archive -Path $zipPath -DestinationPath $WorkRoot -Force
    $extracted = Join-Path $WorkRoot "antigravity-add-model-main"
    if (-not (Test-Path $extracted)) { Stop-WithMessage "Upstream archive extraction failed." }
    Move-Item -Path (Join-Path $extracted "*") -Destination $SourceDir -Force
    Remove-Item -Recurse -Force $extracted
    Write-Host "[OK] Downloaded $UpstreamRepo"

    Push-Location $SourceDir
    try {
        if (-not $SkipBuild) {
            Write-Host "`n[2/4] Installing dependencies and building upstream project..."
            & npm ci --ignore-scripts
            if ($LASTEXITCODE -ne 0) { Stop-WithMessage "npm ci failed." }
            & npm run build
            if ($LASTEXITCODE -ne 0) { Stop-WithMessage "Upstream build failed." }
        }

        Write-Host "`n[3/4] Running upstream compatibility preflight..."
        & powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\deploy.ps1" --check --resources $Resources
        if ($LASTEXITCODE -ne 0) {
            Stop-WithMessage "Upstream preflight rejected this Antigravity runtime. No deployment was attempted. Share the log with the upstream maintainers."
        }

        if ($CheckOnly) {
            Write-Host "`n[OK] Compatibility preflight passed. CheckOnly requested; no patch was deployed." -ForegroundColor Green
            return
        }

        Write-Host "`nThe upstream preflight passed."
        $answer = Read-Host "Deploy the custom-model addon to this Antigravity installation? Type YES"
        if ($answer -cne "YES") {
            Write-Host "Deployment cancelled. No application files were changed."
            return
        }

        Write-Host "`n[4/4] Deploying upstream addon..."
        & powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\deploy.ps1" --resources $Resources
        if ($LASTEXITCODE -ne 0) {
            Stop-WithMessage "Deployment failed. Review the upstream restore instructions and this log."
        }

        Write-Host "`nDeployment command completed." -ForegroundColor Green
        Write-Host "Next: start Antigravity → Settings → Models & Usage → Custom Models."
        Write-Host "Add AvalAI using docs\AVALAI-CONFIGURATION.fa.md."
        Write-Host "This wrapper does not enter or store your API key."
    }
    finally {
        Pop-Location
    }
}
catch {
    Write-Host "`n[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Log: $LogFile"
    Stop-Transcript | Out-Null
    exit 1
}
finally {
    try { Stop-Transcript | Out-Null } catch {}
}
