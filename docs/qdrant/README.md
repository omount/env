# Qdrant（对照官方）

模块：[`modules/ai/qdrant/`](../../modules/ai/qdrant/)

## 依据

- https://qdrant.tech/documentation/guides/installation/
- https://hub.docker.com/r/qdrant/qdrant

## 差异

| 项 | 说明 |
|----|------|
| 镜像 | 钉死 `qdrant/qdrant:v1.14.1` |
| 端口 | 官方 6333/6334 原样暴露 |
| API Key | 默认关；注释项可开 |
