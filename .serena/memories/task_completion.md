# Task completion

No project lint/test CI.

Before done:
1. Scope only requested paths
2. Scripts: shebang + pipefail when claiming runnable; no leaked real secrets beyond documented demos
3. Docs under `docs/` when ops/config changed
4. Update `mem:*` when layout/invariants change; `serena memories check` if structure changed
5. MinIO/middleware: smoke compose config / health if touched
6. License remains MIT (omount) unless user changes it