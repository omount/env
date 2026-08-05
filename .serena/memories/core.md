# Core

**EasyEnv** — 让天下没有难配置的环境. MIT © omount. Norms: `docs/conventions.md`.

Modules: bun, nodejs (nvm+build), docker, mysql, redis, pgsql, minio, elk(8.17.10 elastic/123456), grafana(11.5.2 admin/123456 :3001), openwebui, gitlab.

Prefer Compose. Password ladder 123456→12345678→12345678910.

Mandatory: scripts/compose must cite and follow official docs (no invented config); open-source modules must label upstream repo URLs. See docs/conventions.md §12.

Memory: `mem:conventions` `mem:tech_stack` `mem:minio/core` `mem:gitlab/core`