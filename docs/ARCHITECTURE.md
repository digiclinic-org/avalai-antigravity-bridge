# Architecture

```text
Windows user
    |
    v
AvalAI Antigravity Bridge (this repository)
    |
    +-- Detect resources directory
    +-- Check Node.js
    +-- Download upstream source archive
    +-- npm ci / npm run build
    +-- invoke upstream preflight
    +-- require explicit confirmation
    |
    v
Antigravity Custom Model Enabler (upstream)
    |
    +-- Electron desktop integration
    +-- local model manager / proxy
    +-- provider protocol adapters
    |
    v
AvalAI OpenAI-compatible API
    https://api.avalai.ir/v1
```

## Design boundaries

This repository is a companion installer, not a reimplementation of the upstream runtime patch. It does not ship Antigravity binaries or patch the app.asar itself. Compatibility checks and transactional deployment are delegated to the upstream project.

## Credentials

No API key is embedded, generated, collected, or transmitted by this wrapper. The user enters the key in the upstream local model manager. Do not commit local credential files.

## Update lifecycle

The wrapper downloads the upstream `main` branch on each installation run. For reproducible releases, maintainers should pin a reviewed upstream commit or release tag before publishing a production installer. After an Antigravity update, rerun preflight and redeploy only if supported.
