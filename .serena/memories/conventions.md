# Conventions (ADS — adopted)

Authoritative: `docs/conventions.md`. License: MIT © omount.

- One dir per tool/service; long-form in `docs/`; root README index
- Module: short README + entry (install.sh/compose); optional `docs/<module>/`
- Scripts: shebang + `set -euo pipefail`; pin image tags; placeholders for secrets
- Compose: no `version` key
- `.gitignore` excludes runtime `**/data/**` (keep `data/.gitignore`), node_modules, go.sum in examples, caches
- MinIO: default bucket `data`, public-read; signed read via `S3_READ_MODE=signed` + drop policy — see `docs/minio/access.md`
- Chinese commit messages when user requests commit; scope discipline