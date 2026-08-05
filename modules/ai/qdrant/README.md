# Qdrant v1.14.1

对照官方 Docker 安装。REST **6333**、gRPC **6334**。默认**无认证**。

## 前置

- Docker Compose V2；端口 `6333`、`6334` 空闲

## 运行

```bash
cd modules/ai/qdrant
docker compose up -d
# 或: ./easyenv.sh up qdrant
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `qdrant/qdrant:v1.14.1` |
| REST / Dashboard | http://127.0.0.1:6333 （UI: `/dashboard`） |
| gRPC | `127.0.0.1:6334` |
| API Key | 无（compose 内注释可开） |
| 数据 | `./data` → `/qdrant/storage` |

## 客户端示例

```bash
curl -s http://127.0.0.1:6333/
# 期望 JSON welcome
```

## 验收

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:6333/
# 期望 200
```

## 官方

- [docs/qdrant/README.md](../../../docs/qdrant/README.md)
- https://qdrant.tech/documentation/guides/installation/
- https://hub.docker.com/r/qdrant/qdrant
