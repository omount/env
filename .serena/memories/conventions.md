# Conventions (ADS — authoritative in docs/conventions.md)

**EsayEnv** (spelling fixed, not EasyEnv). Slogan: 让天下没有难配置的环境. MIT © omount.

Prefer Docker Compose for middleware.

## Structure

One dir/service; root README index; long-form only under `docs/`; scaffold `templates/module/`.

## Module must-haves

README + entry (install.sh/compose); pin tags (no :latest); link docs; demo creds per password ladder.

## Password ladder (demo)

User: `root` or `admin` as appropriate.
Password try in order: `123456` → `12345678` → `12345678910` → longer by appending digits; document chosen value. MinIO uses admin/12345678 (min 8).

## Scripts / Compose

Shebang + `set -euo pipefail`; no emoji in scripts; no Compose `version` key.

## Bun / Docker install (required pattern)

If upstream has one-liner: cite official URLs, wrap in `install.sh`, provide `build-from-source.sh` + `docs/<module>/install.md`.
- Bun: bun.sh/install + contributing build
- Docker: get.docker.com / Desktop Win-Mac / Ubuntu docs + moby source build; recommend Compose deploy

## Git

Chinese commits when requested; gitignore runtime data/node_modules/src build worktrees; no real prod secrets.

## Official docs + upstream repos (mandatory)

All scripts/compose/docs must be written and verified against official documentation URLs (no invented config). Open-source modules must label upstream repo (GitHub/GitLab). See docs/conventions.md §12.

## Scope

Only change requested paths; do not swap user’s technical approach.