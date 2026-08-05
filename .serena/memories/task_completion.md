# Task completion

No automated lint/test/format pipeline in this repo.

Before considering a task done:

1. Only touched paths in scope of the user request.
2. If scripts changed: shebang + `set -euo pipefail` when claiming they are runnable; placeholders still present (no leaked secrets).
3. If docs changed: files under `docs/` (except root/module README index pages as allowed by conventions).
4. If Serena memories affected: update relevant `mem:*` and run `serena memories check` when structure changed.
5. Smoke-read key paths (compose YAML indent; script quoting) — there is no CI gate.