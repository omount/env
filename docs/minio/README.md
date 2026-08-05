# MinIO 部署说明

对应模块：[`minio/`](../../minio/)

## 为何钉死老版本

| 版本 | 说明 |
|------|------|
| `RELEASE.2025-04-22T22-12-26Z` | 本模板采用；控制台功能较完整 |
| `RELEASE.2025-05-24T17-08-30Z` 及之后 | Web 管理能力被大幅裁剪 |
| `latest` | **禁止** |

镜像：https://hub.docker.com/r/minio/minio/tags

## 官方 / 参考文档

| 文档 | 链接 |
|------|------|
| Docker Hub | https://hub.docker.com/r/minio/minio |
| MinIO + Nginx 反代 | https://min.io/docs/minio/linux/integrations/setup-nginx-proxy-with-minio.html |
| 本模块 Nginx 片段 | [`minio/nginx/minio.conf`](../../minio/nginx/minio.conf) |
| 浏览器直传 | [direct-upload.md](direct-upload.md) |
| 公开读 / 签名读 | [access.md](access.md) |

## 默认凭据

| 变量 | 值 |
|------|-----|
| `MINIO_ROOT_USER` | `admin` |
| `MINIO_ROOT_PASSWORD` | `12345678` |

## 默认访问策略

- 桶 `data`：**公开读**（匿名 `GetObject`）
- 上传：仍须 Presigned PUT 或管理员凭据（未开放匿名写）
- 配置说明：[access.md](access.md)

## 端口与数据

- API：`9000`
- Console：`9001`
- 数据：`./data` → `/data`

## 反代注意

1. API 与 Console 建议分域名
2. Console 需 WebSocket
3. 填写 `MINIO_SERVER_URL` / `MINIO_BROWSER_REDIRECT_URL` 为对外 URL
