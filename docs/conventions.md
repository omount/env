# ADS 仓库规范（Archive Deploy Standard）

项目名：**EsayEnv**（固定拼写，非 EasyEnv）  
口号：**让天下没有难配置的环境**

本文件为本仓库唯一权威规范。根 `README.md` 仅作索引；模块细节见各模块 `README.md` 与 `docs/<module>/`。

许可：[MIT](../LICENSE) © omount

---

## 1. 仓库定位

归档可复用的安装脚本与部署经验。**不是**业务应用代码库。

| 是 | 不是 |
|----|------|
| 运维脚本与 Compose 模板库 | 业务应用代码库 |
| 实战沉淀（含踩坑与验收） | 未经验证的命令堆砌 |
| 一工具 / 一服务一目录 | 大一统万能安装器 |

**部署偏好**：能容器化的组件优先使用 **Docker / Compose** 部署。

---

## 2. 目录结构

```text
EsayEnv/
├── README.md              # 总索引
├── LICENSE                # MIT © omount
├── docs/
│   ├── conventions.md     # 本规范（唯一权威）
│   └── <module>/          # 模块长文（安装、参数、踩坑、验收等）
├── templates/module/      # 新模块脚手架
└── <module>/              # 一工具 / 一服务一目录
```

- 根 `README.md`：索引与原则，不堆长教程  
- 模块 `README.md`：用途、前置、步骤、验收，长文链到 `docs/<module>/`  
- 详细说明**只**放 `docs/`

---

## 3. 模块必备

新增顶层目录时必须具备：

1. `README.md`：用途、前置条件、步骤、验收命令；长文链接到 `docs/<module>/`  
2. 主入口：`install.sh` / `docker-compose.yml` / 明确命名的运维脚本  
3. 版本钉死（禁止生产模板使用 `:latest`）  
4. 机密与演示口令遵守第 9 节；禁止提交真实生产 token / 未脱敏密钥  
5. 可选：`docs/<module>/pitfalls.md`、`parameters.md`、`install.md` 等长文  

---

## 4. 脚本规范

- 可执行 bash：`#!/usr/bin/env bash` 与 `set -euo pipefail`  
- 优先真可执行脚本；备忘命令收入子命令或模块 README，避免无入口的注释堆  
- 尽量幂等；失败时打印明确下一步  
- 代码与脚本中不使用 emoji；注释简洁，未经要求不删除已有注释  

---

## 5. Compose / 镜像

- 省略 Compose `version` 字段  
- 端口、`external_url`、宿主机映射在文档中一并说明  
- 变更 IP / 端口时同步：`hostname`、`external_url`、`ports` 与 SSH 相关配置  
- 生产模板镜像 tag 钉死，禁止依赖 `:latest`  

---

## 6. 文档与 Git

- 详细文档只放 `docs/`  
- 提交说明使用中文（仅在明确要求提交时）  
- 不提交 `.env` 生产机密、初始密码文件、未脱敏密钥  
- `.gitignore` 屏蔽运行时数据（`**/data/**`，保留 `data/.gitignore`）、`node_modules`、示例 `go.sum`、编译工作区（如 `bun/src/`、`docker/src/`）等非主体内容  

---

## 7. 变更纪律

- 只改需求范围内的路径与内容  
- 不擅自替换用户指定的技术路径（例如要求 `docker push` 时不得改成 `scp`）  

---

## 8. 新增模块流程

```bash
cp -r templates/module <新模块名>
# 1. 编辑 <新模块名>/README.md 与入口脚本（或 compose）
# 2. 需要长文时创建 docs/<新模块名>/
# 3. 在根 README.md 模块表中追加一行
```

---

## 9. 演示账号与密码递进规则

归档演示默认约定：

| 角色含义 | 默认用户名 |
|----------|------------|
| 系统/库超级用户 | `root`（适用时） |
| 控制台/对象存储管理员 | `admin`（适用时） |

**密码递进**（按软件硬性长度限制依次尝试，取第一条能通过校验的）：

1. `123456`（6 位）  
2. 若不支持 6 位 → `12345678`（8 位）  
3. 若不支持 8 位 → `12345678910`（11 位）  
4. 仍不满足则继续按「在末尾追加递增数字、保证严格更长」类推，并在模块 README 写明最终采用值与原因  

示例：MinIO 要求 Secret 至少 8 位，故采用 `admin` / `12345678`。

演示口令允许进入仓库，但文档必须标明：**仅供归档演示，禁止直接用于生产**。

---

## 10. Bun / Docker 安装规范

凡提供运行时/引擎安装的模块，若官方有一键脚本，必须：

1. **标明出处**（官方文档 URL + 脚本 URL）  
2. **封装可执行安装脚本**（本仓库 `install.sh` 等），注释中写清等价官方命令  
3. **同时提供编译/源码安装方案**（独立脚本如 `build-from-source.sh` + `docs/<module>/install.md`）  
4. 模块 README 链到详解文档；日常推荐官方脚本，编译仅用于定制/贡献  

### 10.1 Bun（已落地）

| 项 | 约定 |
|----|------|
| 官方脚本出处 | https://bun.sh/docs/installation ；Linux/macOS：https://bun.sh/install ；Windows：https://bun.sh/install.ps1 |
| 本仓库脚本 | `bun/install.sh`（调用上述官方脚本） |
| 编译方案 | `bun/build-from-source.sh`；出处 https://bun.com/docs/project/contributing 、https://github.com/oven-sh/bun |
| 详解 | `docs/bun/install.md` |

### 10.2 Docker（已落地）

| 项 | 约定 |
|----|------|
| 官方出处 | Engine：https://docs.docker.com/engine/install/ ；脚本：https://get.docker.com （https://github.com/docker/docker-install）；Ubuntu：https://docs.docker.com/engine/install/ubuntu/ |
| Windows | Docker Desktop：https://docs.docker.com/desktop/setup/install/windows-install/ |
| macOS | Docker Desktop：https://docs.docker.com/desktop/setup/install/mac-install/ |
| Linux 本仓库脚本 | `docker/install.sh`（get.docker.com）、`docker/ubuntu-install.sh`（官方 apt 源） |
| 编译方案 | `docker/build-from-source.sh`（Moby：https://github.com/moby/moby）；另可参考官方二进制：https://docs.docker.com/engine/install/binaries/ |
| 详解 | `docs/docker/install.md` |
| 部署推荐 | 装好 Docker 后，各中间件模块优先 `docker compose up -d` |

---

## 11. 已落地模块惯例（纳入本规范）

| 模块 | 约定摘要 |
|------|----------|
| mysql / redis / pgsql | 官方镜像钉死版本；演示口令按第 9 节；参数注释 + `docs/*/parameters.md` |
| minio | 钉死未阉割社区版（禁止 `:latest`）；默认桶名 `data`；默认**公开读**；直传使用 **AWS S3 SDK**（不用 MinIO SDK）；签名读见 `docs/minio/access.md` |
| openwebui | 钉死版本 tag；`OPENAI_API_BASE_URL` / `OPENAI_API_KEY` 默认注释，按需填写 |
| gitlab | 钉死 CE 小版本；模块短 README；长文 `docs/gitlab/pitfalls.md` |

新增同类中间件时：默认公开读/私有读策略、SDK 选型等若与上表冲突，须先改本规范再改实现。
