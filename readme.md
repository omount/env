# EasyEnv

**让天下没有难配置的环境**

版本钉死的 Docker Compose / 安装脚本归档（ADS）。对照官方文档编写与验收，一分类一目了然，**打开对应文件夹即可用**，不必先克隆整仓。

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Compose](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Modules](https://img.shields.io/badge/modules-31+-green.svg)](catalog.yml)

权威规范：[docs/conventions.md](docs/conventions.md) · 模块清单：[catalog.yml](catalog.yml)

---

## 欢迎提 Issue

缺环境、想要的环境、文档对不上、端口冲突、compose 起不来——**请直接开 Issue**，例如：

- 仓库里还没有的中间件 / 运行时 / GUI
- 已有模块缺连接信息、演示账号、验收命令
- 官方升级后钉死版本需要跟进
- 本机冒烟失败（附 OS、Docker 版本、报错）

Issue 标题建议：`[模块请求] xxx` / `[缺陷] <id> …` / `[文档] …`。你提得越具体，归档越快补齐。

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

**不必**先 `git clone` 整个 EasyEnv；整仓克隆只在你需要 `./easyenv.sh` 批量管理、或本地改很多模块时更方便。

| 方式 | 适合 |
|------|------|
| 打开单个 `modules/...` 目录即用 | 只要一个服务、快速验收 |
| `git clone` + `./easyenv.sh` | 多模块、统一 list/up/down |
| 长文说明 | 仍看仓库 [`docs/<模块>/`](docs/)，网页点开即可读，无需克隆 |

说明：个别模块同目录还有附属文件（如 nginx 的 `html/`、prometheus 的 `prometheus.yml`、elk / hoppscotch 的 `.env`），请整夹带走，不要只拷一个 yml 漏文件。

---

## Quick Start（整仓时）

```bash
git clone <本仓库 URL>
cd <仓库目录>

# 列表
./easyenv.sh list

# 拉起（需已安装 Docker）
./easyenv.sh up mysql
./easyenv.sh up redis

# 停止
./easyenv.sh down mysql
```

Windows 请用 **Git Bash** 或 WSL 执行 `easyenv.sh`。亦可进入单模块目录：

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
| [caddy](modules/gateway/caddy/) | Caddy | 8089 |

### Git / GUI / Mail / Files / Debug

| 模块 | 说明 | 端口 |
|------|------|------|
| [gitlab](modules/git/gitlab/) | GitLab CE | 见模块 README |
| [gitea](modules/git/gitea/) | Gitea（SQLite） | 3002 / 2222 |
| [adminer](modules/gui/adminer/) | Adminer | 8081 |
| [phpmyadmin](modules/gui/phpmyadmin/) | phpMyAdmin | 8082 |
| [pgadmin](modules/gui/pgadmin/) | pgAdmin 4 | 8083 |
| [redisinsight](modules/gui/redisinsight/) | Redis Insight | 5540 |
| [mailpit](modules/mail/mailpit/) | Mailpit | 1025/8025 |
| [filebrowser](modules/files/filebrowser/) | File Browser | 8084 |
| [hoppscotch](modules/debug/hoppscotch/) | Hoppscotch CE AIO | 3300/3310/3170 |

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
| [qdrant](modules/ai/qdrant/) | Qdrant 向量库 | 6333/6334 |

### CI/CD · Registry

| 模块 | 说明 | 端口 |
|------|------|------|
| [jenkins](modules/cicd/jenkins/) | Jenkins LTS | 8085 / 50000 |
| [registry](modules/registry/registry/) | Docker Registry v2 | 5000 |

---

## 设计原则

1. 版本钉死，禁止生产模板 `:latest`  
2. Compose **最小可跑**；可配置项以注释给出建议值与配置方式（见 conventions §5.1）  
3. **单模块自包含**：优先做到「打开 `modules/...` 目录即可用」，不强求先克隆整仓  
4. 对照官方文档；开源标注上游仓库；本地 `docker compose config` / 冒烟验收  
5. 长文只放 `docs/`（网页可读；与 compose 目录分离但不挡即开即用）  

---

## Roadmap

### 第二阶段（已落地）

gitea · caddy · phpmyadmin · pgadmin · redisinsight · hoppscotch · filebrowser · registry · jenkins · qdrant

### 第三阶段（规划）

| 方向 | 候选（对照官方后再钉死） |
|------|--------------------------|
| 制品 / 质量 | Harbor · SonarQube |
| 内网穿透 / VPN | frp · cloudflared · WireGuard · Tailscale |
| 检索 / LLM 编排 | SearXNG · Flowise · AnythingLLM |
| 可观测拆分 | 独立 Elasticsearch（与 ELK 套件解耦） |
| 工程化 | 可选 docs 站点 · CI 对 `catalog.yml` 做 compose config 冒烟 |

缺什么直接 [开 Issue](#欢迎提-issue)。

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
