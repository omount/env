# Ollama

官方 Docker 文档单机。API: http://127.0.0.1:11434

## 运行

```bash
cd modules/ai/ollama && docker compose up -d
docker exec -it ollama ollama pull tinyllama
```

无 NVIDIA GPU 时使用 CPU（较慢）。GPU 见 compose 内注释（官方 docker.md）。

## 验收

```bash
curl -s http://127.0.0.1:11434/api/tags
```

## 官方

- [docs/ollama/README.md](../../../docs/ollama/README.md)
- https://github.com/ollama/ollama/blob/main/docs/docker.md
- https://github.com/ollama/ollama
