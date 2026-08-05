# Core

Ops script / deployment experience archive (ADS). Not an application codebase.
Path: `C:\\Users\\bitst\\OneDrive\\Desktop\\归档部署方式`

## Layout

- `README.md` — index
- `docs/conventions.md` — authoritative repo standard
- `docs/<module>/` — long-form docs (e.g. `docs/gitlab/pitfalls.md`)
- `templates/module/` — scaffold for new modules
- `bun/` — Bun installer (`install.sh`)
- `docker/` — Docker installers (`install.sh`, `ubuntu-install.sh`)
- `gitlab/` — CE Compose template + `main.sh` CLI; short `README.md`

## Invariants

- One tool/service per top-level directory.
- Pin versions in production templates (no `:latest`).
- No secrets in repo; placeholders like `YOUR_IP_ADDRESS`.
- Human long-form docs under `docs/` only.
- Git commit messages in Chinese when user requests commit.
- Executable bash scripts: shebang + `set -euo pipefail`.

## Memory map

- Stack: `mem:tech_stack`
- Commands: `mem:suggested_commands`
- Standards: `mem:conventions`
- Done checklist: `mem:task_completion`
- GitLab: `mem:gitlab/core`