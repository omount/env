# ADS 仓库规范（Archive Deploy Standard）

项目名：**EsayEnv** — 让天下没有难配置的环境。

本文件为本仓库唯一权威规范。根 `README.md` 仅作索引；模块细节见各模块 `README.md` 与 `docs/<module>/`。

## 1. 仓库定位

归档可复用的安装脚本与部署经验。不是业务应用仓库。

## 2. 目录结构

```text
/
├── README.md              # 总索引
├── docs/
│   ├── conventions.md     # 本规范
│   └── <module>/          # 模块长文（踩坑、验收等）
├── templates/module/      # 新模块脚手架
└── <module>/              # 一工具 / 一服务一目录
```

## 3. 模块必备

新增顶层目录时必须具备：

1. `README.md`：用途、前置条件、步骤、验收命令；长文链接到 `docs/<module>/`
2. 主入口：`install.sh` / `docker-compose.yml` / 明确命名的运维脚本
3. 版本钉死（禁止生产模板使用 `:latest`）
4. 机密用占位符（如 `YOUR_IP_ADDRESS`），禁止提交真实密码与 token
5. 可选：`docs/<module>/pitfalls.md` 等长文

## 4. 脚本规范

- 可执行 bash：`#!/usr/bin/env bash` 与 `set -euo pipefail`
- 优先真可执行脚本；备忘命令应收入脚本子命令或模块 README，避免无入口的注释堆
- 尽量幂等；失败时打印明确下一步
- 代码与脚本中不使用 emoji；注释简洁，未经要求不删除已有注释

## 5. Compose / 镜像

- 省略 Compose `version` 字段
- 端口、`external_url`、宿主机映射在文档中一并说明
- 变更 IP / 端口时同步：`hostname`、`external_url`、`ports` 与 SSH 相关配置

## 6. 文档与 Git

- 详细文档只放 `docs/`
- 提交说明使用中文（仅在明确要求提交时）
- 不提交 `.env` 机密、初始密码文件、未脱敏的生产密钥

## 7. 变更纪律

- 只改需求范围内的路径与内容
- 不擅自替换用户指定的技术路径（例如要求 `docker push` 时不得改成 `scp`）

## 8. 新增模块流程

```bash
cp -r templates/module <新模块名>
# 编辑 <新模块名>/README.md 与 install.sh（或 compose）
# 如有长文：创建 docs/<新模块名>/...
# 在根 README.md 模块表中追加一行
```
