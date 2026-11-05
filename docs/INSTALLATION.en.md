# Windows installation

## Prerequisites

Install Node.js 22.12.0 or newer from https://nodejs.org/.

## Install

1. Fully close Antigravity.
2. Extract this repository.
3. Run `installer\Install.bat`.
4. The script checks the default `%LOCALAPPDATA%\Programs\antigravity\resources` path.
5. It downloads the upstream project from GitHub.
6. It installs dependencies and builds the upstream project.
7. It runs the upstream compatibility preflight.
8. Deployment is attempted only after a successful preflight and explicit user confirmation.

## Custom resources path

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\installer\Install-AvalAI.ps1 -Resources "D:\Apps\Antigravity\resources"
```

## Check only

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\installer\Install-AvalAI.ps1 -CheckOnly
```

Logs are stored in `%LOCALAPPDATA%\AvalAI-Antigravity-Bridge\logs`.

Do not bypass an unsupported-runtime or failed preflight result.
