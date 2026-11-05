# Compatibility test record

## User-provided environment

- OS: Windows
- Antigravity version shown in About: 2.29.0
- Installation root observed: `%LOCALAPPDATA%\Programs\antigravity`
- Resources directory: `%LOCALAPPDATA%\Programs\antigravity\resources`
- `app.asar`: present
- `app.asar.bak`: present
- `app.asar.unpacked`: present

## Status

**Not verified by an executable preflight in this repository.**

The presence of Electron/ASAR files is not sufficient to establish compatibility. The upstream deployer's `--check` result must be captured on the target machine before deployment.

## Required evidence before marking supported

- [ ] `node scripts/deploy.mjs --check --resources "<resources>"` succeeds
- [ ] Deployment completes and reports success
- [ ] Antigravity launches
- [ ] Built-in Google models still work
- [ ] AvalAI model appears in the model picker
- [ ] Non-streaming completion succeeds
- [ ] Streaming completion succeeds
- [ ] Tool calling is tested separately if required
- [ ] Restore succeeds on a test installation

Do not mark Antigravity 2.29.0 as supported until these checks are recorded.
