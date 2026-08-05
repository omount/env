# Suggested commands

Windows PowerShell listing/search differs from unix:

- List: `Get-ChildItem -Recurse -Name`
- Search: Cursor Grep / `rg` / `Select-String`
- Serena: `serena memories check` from project root

Module entrypoints (bash / Git Bash):

- `bun/install.sh`
- `docker/install.sh` / `docker/install.sh --test`
- `docker/ubuntu-install.sh`
- `gitlab/main.sh shell|show-password|reset-password|help`

GitLab host after deploy:

- `docker compose up -d`
- `docker logs -f gitlab`
- `curl -sI http://127.0.0.1:5401/-/readiness`

No project-local test/lint/format entrypoints.