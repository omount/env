# Tech stack

- Shell scripts (bash); authoring often on Windows PowerShell
- Docker / Compose V2
- Pins: mysql:8.4, redis:7.4, postgres:16, gitlab/gitlab-ce:18.9.2-ce.0
- MinIO: minio/minio:RELEASE.2025-04-22T22-12-26Z (not latest; post-2025-05-24 console gutted)
- Open WebUI: ghcr.io/open-webui/open-webui:v0.11.0
- MinIO examples: AWS SDKs only — boto3, @aws-sdk/client-s3, aws-sdk-go-v2
- minio-init: python:3.12-slim + boto3 (`scripts/ensure_public_read.py`)
- Bun installers; UTF-8; License MIT (omount)