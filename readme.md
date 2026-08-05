# EsayEnv

**让天下没有难配置的环境**

可复用的安装脚本与生产级部署经验归档（ADS：Archive Deploy Standard）。把「装得上、起得来、踩过的坑不再踩第二次」固化为版本钉死的模块资产。

> **推荐**：中间件与业务组件优先使用 **Docker / Compose** 部署（见 [docker/](docker/) 与 [docs/docker/install.md](docs/docker/install.md)）。

---

## 定位

| 是 | 不是 |
|----|------|
| 运维脚本与 Compose 模板库 | 业务应用代码库 |
| 实战沉淀（含踩坑与验收） | 未经验证的命令堆砌 |
| 一工具 / 一服务一目录 | 大一统万能安装器 |

权威规范：[docs/conventions.md](docs/conventions.md)

---

## 设计原则

1. **版本钉死** — 生产模板禁止 `:latest`，镜像与安装通道可追溯  
2. **可执行入口** — `install.sh` / `main.sh` 真脚本，而非注释备忘  
3. **文档分层** — 根 README 索引；模块短说明；长文进 `docs/<module>/`  
4. **机密零入库** — 占位符（如 `YOUR_IP_ADDRESS`），不提交密码与 token  
5. **变更克制** — 只改需求范围，不擅自替换既定技术路径  
6. **Docker 优先** — 能容器化的服务优先 Compose 一键拉起  

---

## 仓库结构

```text
EsayEnv/
├── README.md                 # 本页：总览与索引
├── LICENSE                   # MIT © omount
├── docs/
│   ├── conventions.md        # ADS 官方规范
│   ├── bun/install.md        # Bun 官方脚本 + 编译安装
│   ├── docker/install.md     # Docker Win/Linux/macOS + 推荐部署
│   └── ...
├── templates/module/         # 新模块脚手架
├── bun/                      # Bun 运行时安装
├── docker/                   # Docker Engine / Desktop 安装
├── mysql/                    # MySQL 8.4
├── redis/                    # Redis 7.4
├── pgsql/                    # PostgreSQL 16
├── minio/                    # MinIO（未阉割老版本）
├── openwebui/                # Open WebUI
└── gitlab/                   # GitLab CE Compose + 运维 CLI
```

---

## 模块目录

| 模块 | 能力 | 入口 | 文档 |
|------|------|------|------|
| [bun](bun/) | 安装 Bun（官方脚本 / 编译） | `./install.sh` · `./build-from-source.sh` | [模块说明](bun/README.md) · [安装详解](docs/bun/install.md) |
| [docker](docker/) | Windows / Linux / macOS 安装 Docker | `./install.sh` · `./ubuntu-install.sh` · `./build-from-source.sh` | [模块说明](docker/README.md) · [安装详解](docs/docker/install.md) |
| [mysql](mysql/) | MySQL 8.4（root / 123456，数据 `./data`） | `docker-compose.yml` | [模块说明](mysql/README.md) · [参数](docs/mysql/parameters.md) |
| [redis](redis/) | Redis 7.4（仅密码 123456，数据 `./data`） | `docker-compose.yml` | [模块说明](redis/README.md) · [参数](docs/redis/parameters.md) |
| [pgsql](pgsql/) | PostgreSQL 16（root / 123456，数据 `./data`） | `docker-compose.yml` | [模块说明](pgsql/README.md) · [参数](docs/pgsql/parameters.md) |
| [minio](minio/) | MinIO 未阉割版（admin / 12345678，默认公开读，AWS S3 直传） | `docker-compose.yml` | [模块说明](minio/README.md) · [访问策略](docs/minio/access.md) |
| [openwebui](openwebui/) | Open WebUI（端口 3000，API URL/Key 按需填写） | `docker-compose.yml` | [模块说明](openwebui/README.md) |
| [gitlab](gitlab/) | GitLab CE 单机 Compose + 运维命令 | `docker-compose.yml` · `./main.sh` | [模块说明](gitlab/README.md) · [踩坑详解](docs/gitlab/pitfalls.md) |

### 快速一览

```bash
# 1) 安装 Docker（强烈推荐，后续组件均按 Compose 部署）
cd docker && ./install.sh          # Linux 便捷脚本
# Windows / macOS 见 docs/docker/install.md（Docker Desktop）

# 2) （可选）开发机安装 Bun
cd bun && ./install.sh

# 3) 用 Docker 拉起中间件
cd mysql && docker compose up -d
cd redis && docker compose up -d
cd pgsql && docker compose up -d
cd minio && docker compose up -d
cd openwebui && docker compose up -d

# GitLab CE（先改 YOUR_IP_ADDRESS）
cd gitlab && ./main.sh help
```

---

## 典型链路

```text
docker/ 安装引擎（推荐） → Compose 部署 mysql/redis/pgsql/minio/... 
         ↑
    bun/（可选，开发机运行时）
```

---

## 新增模块

```bash
cp -r templates/module <新模块名>
# 编辑 README 与入口；长文放 docs/<新模块名>/；更新本页模块表
```

规范见 [ADS](docs/conventions.md)。

---

## 治理

- **规范唯一权威**：`docs/conventions.md`  
- **长文归属**：仅 `docs/`  
- **提交说明**：中文（在明确要求提交时）  
- **Serena**：`.serena/`（本地配置已忽略）  

---

## License

[MIT](LICENSE) © omount

复制到目标主机前请：

1. 核对系统与权限是否匹配模块前置条件  
2. 替换全部占位符与演示口令，勿把文档示例直接用于生产  
3. 生产变更前阅读对应 `docs/<module>/` 说明（如有）  
