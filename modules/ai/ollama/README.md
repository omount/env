# Ollama

官方 Docker 文档单机。提供本地模型 HTTP API；**默认无管理台登录账号**（API 未设 token）。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `11434` 空闲
- GPU 可选（见 compose 内官方 NVIDIA 注释）；无 GPU 用 CPU（较慢）

## 一键运行

```bash
cd modules/ai/ollama
docker compose up -d
# 或: ./EasyEnv.sh up ollama
```

首次拉模型（示例）：

```bash
docker exec -it ollama ollama pull tinyllama
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `ollama/ollama:0.6.5` |
| API | http://127.0.0.1:11434 |
| 用户 / 密码 | 无（默认未启用 API Key） |
| 模型数据 | `./data` → `/root/.ollama` |

Open WebUI 等对接时可填 Base URL：`http://host.docker.internal:11434`（视网络而定）。

## 客户端示例

```bash
curl -s http://127.0.0.1:11434/api/tags
curl -s http://127.0.0.1:11434/api/generate -d "{\"model\":\"tinyllama\",\"prompt\":\"hi\",\"stream\":false}"
docker exec -it ollama ollama list
```

## 验收

```bash
docker compose ps
curl -s http://127.0.0.1:11434/api/tags
```

## 说明

- 详解：[docs/ollama/README.md](../../../docs/ollama/README.md)
- 官方 Docker：https://github.com/ollama/ollama/blob/main/docs/docker.md

## 官方出处

- 上游：https://github.com/ollama/ollama
