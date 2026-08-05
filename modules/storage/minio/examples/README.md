# MinIO 直传示例（AWS S3 SDK）

先启动：

```bash
cd minio
docker compose up -d
```

凭据：`admin` / `12345678`  
**默认公开读**：`minio-init` 会把 `data` 桶设为匿名可下载。  
示例统一使用 **AWS S3 SDK**，不用 MinIO 官方 SDK。

## 直传 + 读取

1. 服务端签发 Presigned PUT（上传仍需签名）  
2. 客户端对该 URL 直接 PUT  
3. 默认用**公开直链**校验：`http://127.0.0.1:9000/data/<key>`  
4. 需要私有读时：`S3_PUBLIC_READ=false` + `S3_READ_MODE=signed`

详见：[docs/minio/access.md](../../../docs/minio/access.md)

## 运行

### Python（boto3）

```bash
cd examples/python
pip install -r requirements.txt
python upload.py
# 签名读: set S3_READ_MODE=signed && python upload.py
```

### Node.js（@aws-sdk/client-s3）

```bash
cd examples/nodejs
npm install
node upload.js
```

### Go（aws-sdk-go-v2）

```bash
cd examples/go
go run .
```

文档：[docs/minio/direct-upload.md](../../../docs/minio/direct-upload.md)
