# MinIO module

- Image pin: `minio/minio:RELEASE.2025-04-22T22-12-26Z` (avoid latest / post-2025-05-24 gutted console)
- Creds: `MINIO_ROOT_USER=admin`, `MINIO_ROOT_PASSWORD=12345678` (secret must be >=8)
- Ports: 9000 API, 9001 Console; volume `./data` → `/data`
- Default bucket: `data`, public-read (`minio-init` + `policies/public-read.json` + `scripts/ensure_public_read.py`)
- Upload: AWS S3 Presigned PUT (examples in go/python/nodejs — **AWS SDK only**)
- Read: default public URL `http://host:9000/data/<key>`; signed via `S3_READ_MODE=signed` / `S3_PUBLIC_READ=false`
- Nginx: `minio/nginx/minio.conf`
- Docs: `docs/minio/README.md`, `access.md`, `direct-upload.md`