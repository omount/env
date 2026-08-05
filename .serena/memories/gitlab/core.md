# GitLab module

- `gitlab/docker-compose.yml` — template, pin `gitlab/gitlab-ce:18.9.2-ce.0`
- `gitlab/main.sh` — CLI: `shell` | `show-password` | `reset-password` | `help`
- `gitlab/README.md` — short ops guide
- Long pitfalls: `docs/gitlab/pitfalls.md`

## Pins / ports

- HTTP 5401:5401; SSH Git 5403:22; `gitlab_shell_ssh_port = 5403`
- Volumes: `./config`, `./logs`, `./data`
- Placeholder: `YOUR_IP_ADDRESS`

## Hard pitfalls (do not regress)

- No `grafana[...]` on 18.x.
- Do not mix `:latest` (PG17) data dir with 18.9.2 (PG16).
- Prefer auto-generated root password.
- Wait for `Reconfigured!` / readiness before judging failure.
- Port map must match `external_url` listen port.

Stack: `mem:tech_stack`. Commands: `mem:suggested_commands`.