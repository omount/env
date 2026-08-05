# MinIO 公开读 / 签名读

对应模块：[`minio/`](../../modules/storage/minio/)  
策略文件：[`minio/policies/public-read.json`](../../modules/storage/minio/policies/public-read.json)

## 本项目默认

**全部对象公开读（Public Read）**：`docker compose up` 后 `minio-init` 会把 `data` 桶设为匿名可下载。

公开直链形式（path-style）：

```text
http://<host>:9000/<bucket>/<object-key>
```

示例：`http://127.0.0.1:9000/data/direct-upload/hello-python.txt`

无需签名、无需登录即可 GET。上传（PUT）仍需要凭据或 Presigned PUT。

## 两种读法对比

| 模式 | 何时用 | URL 形态 | 配置要点 |
|------|--------|----------|----------|
| **公开读**（默认） | 静态资源、可公开文件 | `http://host:9000/bucket/key` | 桶策略允许匿名 `s3:GetObject` |
| **签名读** | 私有文件、临时授权 | Presigned GET（带 `X-Amz-*`） | 关闭匿名读；服务端用 AK/SK 签发短时 URL |

```text
公开读:  任何人 --GET--> MinIO/对象
签名读:  客户端 --申请--> 业务服务 --Presign GET--> MinIO
         客户端 --GET 预签名 URL--> MinIO
```

## 如何配置公开读（已默认启用）

### 方式 A：Compose 自动初始化（推荐）

`docker-compose.yml` 中的 `minio-init` 运行 `scripts/ensure_public_read.py`：

1. 等待 MinIO 就绪  
2. 创建桶 `data`（若不存在）  
3. 写入公开读策略（与 `policies/public-read.json` 一致）

### 方式 B：控制台

1. 打开 http://127.0.0.1:9001  
2. 进入桶 `data` → Access Policy → 设为 **Download**（公开读）或自定义 JSON  

### 方式 C：AWS S3 SDK（`PutBucketPolicy`）

对桶写入与 `public-read.json` 相同内容。示例代码在 `examples/*/upload.py|js|go` 启动时也会确保公开读策略（可用环境变量关闭）。

## 如何改为签名读（私有桶）

1. 关闭匿名访问：删除桶策略或改为 Private（控制台操作），或：

```bash
# 使用 AWS CLI / boto3 删除桶策略后即为私有读
python -c "import boto3; from botocore.client import Config; s3=boto3.client('s3',endpoint_url='http://127.0.0.1:9000',aws_access_key_id='admin',aws_secret_access_key='12345678',region_name='us-east-1',config=Config(signature_version='s3v4',s3={'addressing_style':'path'})); s3.delete_bucket_policy(Bucket='data'); print('policy removed')"
```

2. 业务侧用 AWS S3 SDK 签发 Presigned GET，示例环境变量：

```bash
# 默认 public；私有桶校验时改为 signed
export S3_READ_MODE=signed
export S3_PUBLIC_READ=false
```

3. 客户端只能用带签名的临时 URL 下载，公开直链会返回 403。

## 示例环境变量

| 变量 | 默认 | 含义 |
|------|------|------|
| `S3_PUBLIC_READ` | `true` | 是否在示例里写入公开读桶策略 |
| `S3_READ_MODE` | `public` | 校验读取时用 `public` 直链还是 `signed` 预签名 |

## 安全说明

- 公开读意味着**知道 URL 即可下载**；不要把敏感文件放进公开桶  
- 生产若需混合模式：公开桶 / 私有桶分离，或按前缀写更细的策略  
- 上传请继续使用 Presigned PUT 或服务端带密钥上传，勿对匿名开放 `PutObject`（本模板未开放匿名写）

## 参考

- MinIO 匿名访问: https://min.io/docs/minio/linux/administration/identity-access-management/policy-based-access-control.html  
- AWS 预签名 GET: https://docs.aws.amazon.com/AmazonS3/latest/userguide/ShareObjectPreSignedURL.html  
- 直传上传: [direct-upload.md](direct-upload.md)
