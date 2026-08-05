# Open WebUI

官方镜像单机部署。Web 端口 `3000`，数据目录映射到 `./data`。  
OpenAI 兼容接口的 Base URL / API Key 默认注释，按需要填写后启用。

## 官方出处

- Quick Start（Docker）：https://docs.openwebui.com/getting-started/quick-start/  
- 上游仓库：https://github.com/open-webui/open-webui  
- 官方镜像：`ghcr.io/open-webui/open-webui`（文档亦列出 Docker Hub `openwebui/open-webui`）  
- 本模板钉死：`v0.11.0`（官方建议生产钉版本 tag，勿用滚动 `:main` / `:latest`）

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `3000` 空闲

## 一键运行

### docker compose

```bash
cd modules/ai/openwebui
docker compose up -d
# 或: ./EasyEnv.sh up openwebui
```

```bash
docker compose logs -f
docker compose down
```

需要对接 OpenAI 兼容 API 时：编辑 `docker-compose.yml`，取消注释整段 `environment` 并填写：

```yaml
# environment:
#   OPENAI_API_BASE_URL: "https://api.openai.com/v1"
#   OPENAI_API_KEY: "sk-xxx"
```

### docker run

与 compose 等价（需在 `openwebui` 目录执行）：

```bash
cd modules/ai/openwebui
mkdir -p data
docker run -d \
  --name openwebui \
  --restart always \
  -p 3000:8080 \
  -v "$(pwd)/data:/app/backend/data" \
  ghcr.io/open-webui/open-webui:v0.11.0
```

按需要追加环境变量（取消对应行注释后使用）：

```bash
# -e OPENAI_API_BASE_URL="https://api.openai.com/v1" \
# -e OPENAI_API_KEY="sk-xxx" \
```

完整示例（已填写时）：

```bash
cd modules/ai/openwebui
mkdir -p data
docker run -d \
  --name openwebui \
  --restart always \
  -p 3000:8080 \
  -v "$(pwd)/data:/app/backend/data" \
  -e OPENAI_API_BASE_URL="https://api.openai.com/v1" \
  -e OPENAI_API_KEY="sk-xxx" \
  ghcr.io/open-webui/open-webui:v0.11.0
```

```bash
docker logs -f openwebui
docker stop openwebui && docker rm openwebui
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `ghcr.io/open-webui/open-webui:v0.11.0` |
| Web | http://127.0.0.1:3000 |
| 预置管理员 | **无**（首次打开页面自行注册，第一位用户为管理员） |
| 数据卷 | `./data` → `/app/backend/data` |
| `OPENAI_API_BASE_URL` / `KEY` | 默认注释，对接 OpenAI 兼容 API 时在 compose 取消注释并填写 |

浏览器打开 http://127.0.0.1:3000 ，按引导创建账号（自定邮箱/用户名/密码），之后用该账号登录。

## 验收

```bash
docker compose ps
curl -sI http://127.0.0.1:3000
```

浏览器打开 `http://127.0.0.1:3000`，首次访问按引导创建管理员账号。

## 说明

- `./data` 已 gitignore，勿把业务数据提交进仓库
- 也可在 WebUI 管理界面内配置模型供应商，不必依赖环境变量
