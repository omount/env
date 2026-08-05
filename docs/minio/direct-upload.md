# MinIO 浏览器直传（Presigned PUT，AWS S3 SDK）

业务服务用 **AWS S3 兼容 SDK** 签发短期预签名 URL，客户端把文件直接 PUT 到 MinIO（不经过业务服务器中转文件流）。

```text
客户端 --(1) 申请上传--> 业务服务 --(2) Presign PUT--> MinIO
客户端 --(3) PUT 文件----------------------> MinIO
```

本仓库示例**不使用** `minio-go` / `minio-py` / `minio-js`，统一用 AWS S3 SDK 对接 MinIO。

## 运行环境变量

| 变量 | 默认 | 含义 |
|------|------|------|
| `S3_ENDPOINT` | `http://127.0.0.1:9000` | S3 API 地址 |
| `AWS_ACCESS_KEY_ID` | `admin` | Access Key |
| `AWS_SECRET_ACCESS_KEY` | `12345678` | Secret Key |
| `S3_BUCKET` | `data` | 桶名 |
| `S3_REGION` | `us-east-1` | 区域（兼容字段） |
| `S3_PUBLIC_READ` | `true` | 是否写入公开读桶策略 |
| `S3_READ_MODE` | `public` | 校验读：`public` 直链 / `signed` 预签名 |

本项目**默认全部公开读**。公开读与签名读逻辑见 [access.md](access.md)。

## 示例

| 语言 | SDK | 路径 |
|------|-----|------|
| Go | `aws-sdk-go-v2` | [`minio/examples/go`](../../minio/examples/go) |
| Python | `boto3` | [`minio/examples/python`](../../minio/examples/python) |
| Node.js | `@aws-sdk/client-s3` | [`minio/examples/nodejs`](../../minio/examples/nodejs) |

步骤见 [`minio/examples/README.md`](../../minio/examples/README.md)。

## 参考

- AWS S3 Presigned URL: https://docs.aws.amazon.com/AmazonS3/latest/userguide/PresignedUrlUploadObject.html
- MinIO 作为 S3 兼容端点: https://min.io/docs/minio/linux/developers/minio-drivers.html
