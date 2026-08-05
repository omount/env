# Suggested commands

Windows: `Get-ChildItem -Recurse -Name`; Grep/`rg`/`Select-String`
Serena: `serena memories check`

Entrypoints:
- `bun/install.sh` `docker/install.sh[--test]` `docker/ubuntu-install.sh`
- `mysql|redis|pgsql|openwebui|minio`: `docker compose up -d`
- `gitlab/main.sh shell|show-password|reset-password|help`
- MinIO examples: `python examples/python/upload.py`; `node examples/nodejs/upload.js`; `go run .` in `examples/go`
- Public object URL: `http://127.0.0.1:9000/data/<key>`

GitLab host: compose up, logs, readiness on :5401