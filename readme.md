# 归档部署方式

**ADS — Archive Deploy Standard**

可复用的安装脚本与生产级部署经验归档。把「装得上、起得来、踩过的坑不再踩第二次」固化为版本钉死的模块资产。

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

---

## 仓库结构

```text
归档部署方式/
├── README.md                 # 本页：总览与索引
├── docs/
│   ├── conventions.md        # ADS 官方规范
│   └── gitlab/pitfalls.md    # GitLab 踩坑与详解
├── templates/module/         # 新模块脚手架
├── bun/                      # Bun 运行时安装
├── docker/                   # Docker Engine 安装
├── mysql/                    # MySQL 8.4
├── redis/                    # Redis 7.4
├── pgsql/                    # PostgreSQL 16
├── openwebui/                # Open WebUI
└── gitlab/                   # GitLab CE Compose + 运维 CLI
```

---

## 模块目录

| 模块 | 能力 | 入口 | 文档 |
|------|------|------|------|
| [bun](bun/) | 安装 Bun（Linux / macOS / Windows） | `./install.sh` | [模块说明](bun/README.md) |
| [docker](docker/) | 通用安装 / Ubuntu 官方 apt 源 | `./install.sh` · `./ubuntu-install.sh` | [模块说明](docker/README.md) |
| [mysql](mysql/) | MySQL 8.4（root / 123456，数据 `./data`） | `docker-compose.yml` | [模块说明](mysql/README.md) |
| [redis](redis/) | Redis 7.4（仅密码 123456，数据 `./data`） | `docker-compose.yml` | [模块说明](redis/README.md) |
| [pgsql](pgsql/) | PostgreSQL 16（root / 123456，数据 `./data`） | `docker-compose.yml` | [模块说明](pgsql/README.md) |
| [openwebui](openwebui/) | Open WebUI（端口 3000，API URL/Key 按需填写） | `docker-compose.yml` | [模块说明](openwebui/README.md) |
| [gitlab](gitlab/) | GitLab CE 单机 Compose + 运维命令 | `docker-compose.yml` · `./main.sh` | [模块说明](gitlab/README.md) · [踩坑详解](docs/gitlab/pitfalls.md) |

### 快速一览

```bash
# 运行时
cd bun && ./install.sh

# 容器引擎（推荐便捷脚本；Ubuntu 可用官方源）
cd docker && ./install.sh
# cd docker && ./ubuntu-install.sh

# 中间件（数据映射到各模块 ./data）
cd mysql && docker compose up -d
cd redis && docker compose up -d
cd pgsql && docker compose up -d

# Open WebUI（按需取消注释 OPENAI_API_BASE_URL / OPENAI_API_KEY）
cd openwebui && docker compose up -d

# GitLab CE（先改 YOUR_IP_ADDRESS，再 compose up）
cd gitlab && ./main.sh help
```

---

## 典型链路

从裸机到可用的 GitLab，推荐顺序：

```text
docker/ 安装引擎  →  gitlab/ 部署 CE  →  main.sh 取密 / 验收
         ↑
    bun/（可选，开发机运行时）
```

GitLab 模块当前钉死镜像：`gitlab/gitlab-ce:18.9.2-ce.0`  
HTTP `5401` · SSH Git `5403` · 占位符 `YOUR_IP_ADDRESS`

---

## 新增模块

按 ADS 脚手架扩展，保持一目录一服务：

```bash
cp -r templates/module <新模块名>
# 1. 编辑 <新模块名>/README.md 与入口脚本
# 2. 需要长文时创建 docs/<新模块名>/
# 3. 在本页「模块目录」表追加一行
```

模块必备清单与脚本约定见 [ADS 规范](docs/conventions.md)。

---

## 治理

- **规范唯一权威**：`docs/conventions.md`  
- **长文归属**：仅 `docs/`  
- **提交说明**：中文（在明确要求提交时）  
- **Serena**：项目记忆与符号索引位于 `.serena/`（本地配置已忽略）  

---

## License / 使用说明

本仓库为内部运维经验归档。复制到目标主机前请：

1. 核对系统与权限是否匹配模块前置条件  
2. 替换全部占位符，勿使用文档中的示例公网 IP 作为生产配置  
3. 生产变更前阅读对应 `docs/<module>/` 踩坑章节（如有）  
