# Conventions (ADS — adopted)

Authoritative human doc: `docs/conventions.md`.

## Purpose

Archive reusable install scripts and deploy notes. Version-pinned, copy-paste-ready.

## Directory

- Top-level: one dir per tool/service.
- Long-form: `docs/` only.
- Root `README.md`: index + how to add modules.
- Per module: short `README.md` + scripts/compose; pitfalls in `docs/<module>/`.
- Scaffold: `templates/module/`.

## Module checklist

1. `README.md` — purpose, prerequisites, steps, verify, links to docs
2. Entry — `install.sh` / compose / named ops script
3. Pin versions
4. Placeholders only for secrets
5. Optional `docs/<module>/pitfalls.md`

## Scripts

- `#!/usr/bin/env bash` + `set -euo pipefail`
- Real executables with subcommands/flags where useful (`gitlab/main.sh`, `docker/install.sh --test`)
- No emoji in scripts; short comments; do not delete existing comments unasked

## Compose

- No Compose `version` key; pin image tags; document ports with `external_url` together.

## Git / scope

- Chinese commit messages when committing is requested.
- Change only requested scope; do not swap deploy techniques unasked.