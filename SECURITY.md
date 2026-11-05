# Security policy

## Reporting

Do not publish API keys, credentials, personal data, or unredacted logs in public issues. Report security concerns privately to the repository maintainer.

## Credential handling

This wrapper never asks for or stores AvalAI credentials. Enter API keys only in the local model manager supplied by the upstream project. Do not put secrets in example JSON, source files, screenshots, or Git commits.

## Runtime modification

The upstream installer modifies the installed Antigravity runtime. Review upstream source and release notes before deployment. Always keep a recoverable backup and never force deployment after a failed compatibility check.
