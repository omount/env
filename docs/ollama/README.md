# Ollama（对照官方）

模块：[`modules/ai/ollama/`](../../modules/ai/ollama/)

## 依据

- https://github.com/ollama/ollama/blob/main/docs/docker.md
- 上游：https://github.com/ollama/ollama

## 差异

| 项 | 说明 |
|----|------|
| 镜像 | 钉死 `ollama/ollama:0.6.5` |
| GPU | 默认关闭；按官方注释启用 |
