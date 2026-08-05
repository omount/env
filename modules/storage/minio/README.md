# MinIO（未阉割老版本）

钉死镜像：`minio/minio:RELEASE.2025-04-22T22-12-26Z`（**勿用 `latest`**）。

默认用户 `admin`，后台密码 `12345678`（官方要求 Secret 至少 8 位）。数据映射到 `./data`。

## 官方出处

- Docker Hub：https://hub.docker.com/r/minio/minio  
- 官方文档：https://min.io/docs/minio/linux/index.html  
- 上游仓库：https://github.com/minio/minio  
- 本仓库详解：[docs/minio/README.md](../../../docs/minio/README.md)

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `9000`（API）、`9001`（Console）空闲

## 一键运行

### docker compose

```bash
cd minio
docker compose up -d
```

```bash
docker compose logs -f
docker compose down
```

### docker run

```bash
cd minio
mkdir -p data
docker run -d \
  --name minio \
  --restart always \
  -e MINIO_ROOT_USER=admin \
  -e MINIO_ROOT_PASSWORD=12345678 \
  -p 9000:9000 \
  -p 9001:9001 \
  -v "$(pwd)/data:/data" \
  minio/minio:RELEASE.2025-04-22T22-12-26Z \
  server /data --address ":9000" --console-address ":9001"
```

```bash
docker logs -f minio
docker stop minio && docker rm minio
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `minio/minio:RELEASE.2025-04-22T22-12-26Z` |
| API (S3) | `http://127.0.0.1:9000` |
| Console | `http://127.0.0.1:9001` |
| 用户 / Access Key | `admin` |
| 密码 / Secret Key | `12345678` |
| 数据卷 | `./data` → `/data` |

## 浏览器直传

Presigned PUT 直传示例（Go / Python / Node.js，AWS S3 SDK）：

- [`examples/`](examples/)
- [docs/minio/direct-upload.md](../../../docs/minio/direct-upload.md)
- 公开读 / 签名读：[docs/minio/access.md](../../../docs/minio/access.md)

默认桶 `data` **公开读**；公开直链：`http://127.0.0.1:9000/data/<object-key>`

## Nginx 反代

片段见 [`nginx/minio.conf`](nginx/minio.conf)。走域名时取消注释：

```yaml
# MINIO_SERVER_URL: "https://s3.example.com"
# MINIO_BROWSER_REDIRECT_URL: "https://console.example.com"
```

## 验收

```bash
docker compose ps
curl -sI http://127.0.0.1:9000/minio/health/live
# 浏览器打开 http://127.0.0.1:9001 ，用 admin / 12345678 登录
```

## 说明

- 密码为 `12345678`（满足 MinIO 至少 8 位要求；对应约定「123456」的加长演示值）
- `./data` 已 gitignore
- 总览：[docs/minio/README.md](../../../docs/minio/README.md)
