# EsayEnv

**让天下没有难配置的环境**

版本钉死的 Docker Compose / 安装脚本归档（ADS）。对照官方文档编写与验收，一分类一目了然，一键拉起。

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Compose](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Modules](https://img.shields.io/badge/modules-21+-green.svg)](catalog.yml)

权威规范：[docs/conventions.md](docs/conventions.md) · 模块清单：[catalog.yml](catalog.yml)

---

## Quick Start

```bash
# 列表
./esayenv.sh list

# 拉起（需已安装 Docker）
./esayenv.sh up mysql
./esayenv.sh up redis

# 停止
./esayenv.sh down mysql
```

Windows 请用 **Git Bash** 或 WSL 执行 `esayenv.sh`。亦可：

```bash
cd modules/database/mysql && docker compose up -d
```

---

## 模块目录（分类）

路径根：`modules/<category>/<name>/`

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
3. 对照官方文档；开源标注上游仓库  
4. 长文只放 `docs/`  

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
