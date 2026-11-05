# AvalAI Antigravity Bridge

A Windows-first companion installer and documentation layer for connecting AvalAI's OpenAI-compatible API to the standalone Antigravity desktop app through the upstream **Antigravity Custom Model Enabler** project.

> **Important:** This repository does not contain Google's Antigravity application, proprietary application binaries, or a copied/forked copy of the upstream patch. It downloads the upstream project from its official GitHub repository at install time, runs its compatibility preflight, and only deploys if that preflight succeeds.

## Current support status

- Target OS: Windows 10/11
- Target application: standalone Antigravity Electron desktop app
- User-reported Antigravity version: `2.29.0`
- App resources path observed from the user's screenshots: `%LOCALAPPDATA%\Programs\antigravity\resources`
- Runtime compatibility: **not yet verified**. The upstream preflight is authoritative; this wrapper does not force a patch on an unknown runtime.

## What this project provides

- Guided PowerShell installer
- Upstream download/build orchestration
- Compatibility check before deployment
- Explicit confirmation before modifying Antigravity
- Restore helper
- AvalAI endpoint and configuration instructions
- Persian and English documentation
- No API key embedded in source code

## Prerequisites

- Windows PowerShell 5.1 or PowerShell 7
- Node.js 22.12.0 or newer (22.13+ recommended)
- Internet access to GitHub and AvalAI
- Antigravity fully closed during deployment

The installer checks for Node.js. It does not silently install software or change execution policy permanently.

## Quick start

1. Download and extract this repository.
2. Close Antigravity.
3. Right-click `installer\Install.bat` and choose **Run as administrator** only if your Windows permissions require it. Normally, a per-user Antigravity installation does not need elevation.
4. Follow the prompts.
5. If the upstream compatibility check succeeds, confirm deployment.
6. Start Antigravity and open **Settings → Models & Usage → Custom Models**.
7. Add an OpenAI-compatible provider using the AvalAI values in `docs/AVALAI-CONFIGURATION.fa.md`.
8. Add the exact model ID shown in your AvalAI account. Do not assume a model slug.

## AvalAI connection values

- Base URL: `https://api.avalai.ir/v1`
- Chat Completions endpoint: `https://api.avalai.ir/v1/chat/completions`
- Authentication: Bearer token
- API key: enter locally in the model manager; never commit it to GitHub.

Use the base URL or full endpoint according to the upstream model manager's field label. Do not append `/chat/completions` twice.

## Updating Antigravity

An Antigravity update may replace the patched application files. After every Antigravity update:

1. Close Antigravity.
2. Run `installer\Check-Compatibility.ps1`.
3. If the check passes, run `installer\Install-AvalAI.ps1` and approve redeployment.
4. If the check fails, do not force the patch. Wait for an upstream compatibility update.

The upstream project keeps restore data and documents its own recovery behavior. This wrapper does **not** promise unattended automatic re-patching after every vendor update. A future scheduled/background updater would need a separate opt-in design and compatibility tests.

## Restore

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\installer\Restore-Antigravity.ps1
```

Restore is delegated to the upstream installer and is subject to its safety checks. It should not overwrite files changed by a later Antigravity update.

## Project relationship and attribution

This project is a companion wrapper/documentation project. The actual Antigravity application patch, model manager, proxy, and provider routing are maintained by:

- Upstream: https://github.com/vahapogut/antigravity-add-model
- Upstream license: Apache-2.0 (see upstream repository for current terms)

AvalAI API documentation: https://docs.avalai.org/en/api-reference/introduction

## Security

- Never put API keys in source files, JSON examples, screenshots, issues, or commits.
- Enter credentials only in the local model manager.
- Treat model providers as third parties that may process prompts and attachments.
- Review upstream changes before deploying updates.
- See [SECURITY.md](SECURITY.md).

## Disclaimer

Not affiliated with, endorsed by, or sponsored by Google, Antigravity, or AvalAI. Antigravity is a product name of its respective owner. Compatibility can change with application updates.
