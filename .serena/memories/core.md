# Core

Ops script / deployment experience archive (ADS).

## Layout

- `README.md` — index
- `docs/conventions.md` — ADS standard
- `docs/gitlab/pitfalls.md` — GitLab long-form
- `templates/module/` — scaffold
- `bun/` `docker/` `gitlab/` — install / CE deploy
- `mysql/` `redis/` `pgsql/` — Compose middlewares, data in `./data` (gitignored contents)

## Middleware defaults (demo only)

- MySQL 8.4: root / 123456, port 3306, `./data` → `/var/lib/mysql`
- Redis 7.4: password-only 123456 (no ACL user), port 6379, `./data` → `/data`, AOF on
- Postgres 16: root / 123456, db root, port 5432, `./data` → `/var/lib/postgresql/data`
- No Dockerfiles for these three; official images via compose only

## Invariants

- One tool/service per top-level directory; pin tags; no secrets beyond documented demo passwords in compose for archive demos
- Long-form docs under `docs/` only

## Memory map

- `mem:tech_stack` `mem:suggested_commands` `mem:conventions` `mem:task_completion` `mem:gitlab/core`