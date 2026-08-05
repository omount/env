# Core

**EsayEnv** — 让天下没有难配置的环境.
Ops archive (ADS). License: MIT © omount (`LICENSE`).

Prefer **Docker Compose** for middleware (mysql/redis/pgsql/minio/openwebui/gitlab).

## Layout

- `README.md` — EsayEnv index
- `docs/conventions.md` `docs/bun/install.md` `docs/docker/install.md` (Win/Linux/macOS + recommend Docker)
- `bun/install.sh` (official bun.sh script) + `bun/build-from-source.sh` (oven-sh/bun contributing)
- `docker/install.sh` (get.docker.com) + `ubuntu-install.sh` + `build-from-source.sh` (moby/moby)
- modules: mysql redis pgsql minio openwebui gitlab templates

## Pins / demos

See prior middleware defaults; MinIO bucket `data` public-read; admin/12345678.

## Memory map

`mem:tech_stack` `mem:suggested_commands` `mem:conventions` `mem:task_completion` `mem:gitlab/core` `mem:minio/core`