# Core

Ops script / deployment experience archive (ADS). License: MIT, Copyright (c) 2026 omount (`LICENSE`).

## Layout

- `README.md` — index; `LICENSE` — MIT (omount)
- `docs/conventions.md` — ADS standard
- `docs/gitlab/pitfalls.md` — GitLab long-form
- `docs/mysql|redis|pgsql/parameters.md` — official image params
- `docs/minio/` — MinIO deploy, access (public vs signed), direct-upload
- `templates/module/` — scaffold
- `bun/` `docker/` `gitlab/` — install / CE deploy
- `mysql/` `redis/` `pgsql/` — Compose middlewares; data `./data` gitignored
- `minio/` — uncastrated pin + nginx + AWS S3 SDK examples + public-read init
- `openwebui/` — Open WebUI v0.11.0
- `.gitignore` — hides runtime data, node_modules, go.sum, caches

## Middleware defaults (demo)

- MySQL 8.4: root/123456, 3306, sql_mode includes ONLY_FULL_GROUP_BY
- Redis 7.4: password-only 123456, 6379, AOF
- Postgres 16: root/123456, db root, 5432
- MinIO `RELEASE.2025-04-22T22-12-26Z`: admin/12345678, API 9000 Console 9001, default bucket `data`, **public-read** via `minio-init` + `policies/public-read.json`; upload via AWS S3 Presigned PUT; examples under `minio/examples/{go,python,nodejs}` (AWS SDK only, not minio SDK)
- Open WebUI: port 3000, OPENAI_* commented

## Invariants

- One tool/service per top-level dir; pin tags; no `:latest` for prod templates
- Long-form docs under `docs/` only
- Demo passwords are archive defaults only

## Memory map

- `mem:tech_stack` `mem:suggested_commands` `mem:conventions` `mem:task_completion`
- `mem:gitlab/core` `mem:minio/core`