# EsayEnv

**让天下没有难配置的环境**

版本钉死的 Docker Compose / 安装脚本归档（ADS）。对照官方文档编写与验收，一分类一目了然，**打开对应文件夹即可用**，不必先克隆整仓。

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Compose](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Modules](https://img.shields.io/badge/modules-21+-green.svg)](catalog.yml)

权威规范：[docs/conventions.md](docs/conventions.md) · 模块清单：[catalog.yml](catalog.yml)

---

## 即开即用（不必克隆整仓）

多数中间件模块是**自包含目录**：进去就能 `docker compose up -d`。适合「只要 MySQL / Redis / 某一个服务」的场景。

**推荐用法（GitHub 网页）**

1. 在下方分类表点击模块链接，进入例如 [`modules/database/mysql/`](modules/database/mysql/)  
2. 查看该目录下的 `README.md` 与 `docker-compose.yml`（可配置项在 compose 注释里）  
3. 任选其一拿到文件：
   - 只复制 / 下载该文件夹（Code → Download，或第三方「Download directory」）
   - 或只保存 `docker-compose.yml`（及目录内必要的 `conf/`、`html/`、`prometheus.yml` 等）
4. 本机已装 Docker 后，在该目录执行：

```bash
docker compose up -d
```

**不必**先 `git clone` 整个 EsayEnv；整仓克隆只在你需要 `./esayenv.sh` 批量管理、或本地改很多模块时更方便。

| 方式 | 适合 |
|------|------|
| 打开单个 `modules/...` 目录即用 | 只要一个服务、快速验收 |
| `git clone` + `./esayenv.sh` | 多模块、统一 list/up/down |
| 长文说明 | 仍看仓库 [`docs/<模块>/`](docs/)，网页点开即可读，无需克隆 |

说明：个别模块同目录还有附属文件（如 nginx 的 `html/`、prometheus 的 `prometheus.yml`、elk 的 `.env`），请整夹带走，不要只拷一个 yml 漏文件。

---

## Quick Start（整仓时）

```bash
git clone <本仓库 URL>
cd <仓库目录>

# 列表
./esayenv.sh list

# 拉起（需已安装 Docker）
./esayenv.sh up mysql
./esayenv.sh up redis

# 停止
./esayenv.sh down mysql
```

Windows 请用 **Git Bash** 或 WSL 执行 `esayenv.sh`。亦可进入单模块目录：

```bash
cd modules/database/mysql && docker compose up -d
```

---

## 模块目录（分类）

路径根：`modules/<category>/<name>/` — **点进文件夹即可复制使用**

### 运行时 / 基础

| 模块 | 说明 | 入口 |
|------|------|------|
| [bun](modules/runtime/bun/) | Bun 安装 | `install.sh` |
| [nodejs](modules/runtime/nodejs/) | Node.js（nvm） | `install.sh` |
| [docker](modules/runtime/docker/) | Docker 安装 | `install.sh` |

### 数据存储

| 模块 | 说明 | 端口 |
|------|------|------|
| [mysql](modules/database/mysql/) | MySQL 8.4 | 3306 |
| [redis](modules/database/redis/) | Redis 7.4 | 6379 |
| [pgsql](modules/database/pgsql/) | PostgreSQL 16 | 5432 |
| [mongodb](modules/database/mongodb/) | MongoDB 7.0 | 27017 |
| [minio](modules/storage/minio/) | MinIO | 9000/9001 |

### 消息队列

| 模块 | 说明 | 端口 |
|------|------|------|
| [rabbitmq](modules/mq/rabbitmq/) | RabbitMQ management | 5672/15672 |
| [kafka](modules/mq/kafka/) | Kafka KRaft 单机 | 9092 |

### 注册配置中心

| 模块 | 说明 | 端口 |
|------|------|------|
| [nacos](modules/discovery/nacos/) | Nacos 单机 | 8080/8848 |
| [consul](modules/discovery/consul/) | Consul 单节点 | 8500 |

### 网关

| 模块 | 说明 | 端口 |
|------|------|------|
| [nginx](modules/gateway/nginx/) | Nginx | 8088 |

### Git / GUI / Mail

| 模块 | 说明 | 端口 |
|------|------|------|
| [gitlab](modules/git/gitlab/) | GitLab CE | 见模块 README |
| [adminer](modules/gui/adminer/) | Adminer | 8081 |
| [mailpit](modules/mail/mailpit/) | Mailpit | 1025/8025 |

### 可观测性

| 模块 | 说明 | 端口 |
|------|------|------|
| [elk](modules/monitoring/elk/) | ELK 8.17 | 9200/5601 |
| [grafana](modules/monitoring/grafana/) | Grafana | 3001 |
| [prometheus](modules/monitoring/prometheus/) | Prometheus | 9090 |

### AI

| 模块 | 说明 | 端口 |
|------|------|------|
| [openwebui](modules/ai/openwebui/) | Open WebUI | 3000 |
| [ollama](modules/ai/ollama/) | Ollama | 11434 |

---

## 设计原则

1. 版本钉死，禁止生产模板 `:latest`  
2. Compose **最小可跑**；可配置项以注释给出建议值与配置方式（见 conventions §5.1）  
3. **单模块自包含**：优先做到「打开 `modules/...` 目录即可用」，不强求先克隆整仓  
4. 对照官方文档；开源标注上游仓库  
5. 长文只放 `docs/`（网页可读；与 compose 目录分离但不挡即开即用）  

---

## Roadmap（阶段二）

gitea · caddy · phpmyadmin · pgadmin · redisinsight · hoppscotch · filebrowser · harbor · registry · jenkins · sonarqube · frp · cloudflared · wireguard · tailscale · qdrant · searxng · flowise · anythingllm · 独立 elasticsearch 等。

---

## 新增模块

```bash
cp -r templates/module modules/<category>/<name>
# 编辑 compose / README；登记 catalog.yml；更新本页表格
```

---

## License

[MIT](LICENSE) © omount

复制到目标主机前请替换演示口令与占位符，勿直接用于生产。
