---
name: easyenv-module
description: >-
  Adds or updates EasyEnv (ADS) modules under modules/<category>/<name>/ with
  pinned Compose/install, official-doc citations, connection tables, and
  catalog.yml registration. Use when creating or fixing EasyEnv modules,
  docker-compose templates, catalog entries, module READMEs, docs/<module>/,
  easyenv.sh paths, or Archive Deploy Standard / ADS work in this repo.
---

# EasyEnv 模块 Skill

项目：**EasyEnv**（拼写 Easy，非 Esay）· 口号：让天下没有难配置的环境  
权威规范：仓库内 [`docs/conventions.md`](../../../docs/conventions.md)（本 Skill 是执行摘要；冲突以 conventions 为准）。

## 何时用

- 新增 / 修补 `modules/**` 环境模块
- 写或改 `docker-compose.yml`、模块 `README.md`、`docs/<id>/`、`catalog.yml`
- 用户提到 ADS、归档部署、钉死镜像、对照官方、演示口令阶梯

## 硬性纪律

1. **只做要求的事**：未要求不擅自加 CI、别的模块、重构、推送。
2. **对照官方**：配置与 tag 必须能对应官方文档 / Hub；差异（端口、演示口令、节点裁剪）写进 README / `docs/<id>/`。禁止臆造 env 名或 tag。
3. **版本钉死**：禁止生产模板 `:latest`。
4. **中文**：回复与 commit message（仅用户明确要求提交时）用中文；代码/注释不用 emoji。
5. **文档位置**：长文只放 `docs/`；根 README 只做索引表更新。
6. **分批提交**：多模块时**每个环境单独一次** `feat(<id>): …`，最后可再 `feat(catalog): …`；未要求提交则不 commit。

## 新增 Compose 模块（标准流程）

```text
进度:
- [ ] 查官方 Docker/Install 页 + Hub tag（可 docker manifest / pull 核验）
- [ ] cp -r templates/module modules/<category>/<name>
- [ ] 写 docker-compose.yml（§5.1）+ data/.gitignore（若有卷）
- [ ] 写模块 README（§3.1 全节）
- [ ] 写 docs/<name>/README.md（对照官方差异表）
- [ ] 追加 catalog.yml；更新根 README 分类表
- [ ] docker compose config -q
- [ ] 本地 up + 验收命令；结束后 compose down
- [ ] （可选）./easyenv.sh path <id>
```

脚手架：

```bash
cp -r templates/module modules/<category>/<name>
```

`catalog.yml` 字段（扁平块，供 `easyenv.sh` 解析）：

```yaml
- id: <id>
  category: <category>
  path: modules/<category>/<name>
  summary: 一句话
  official_docs: https://…
  upstream: https://github.com/…
  ports: "宿主机端口,逗号分隔"
  status: stable
```

CLI 入口脚本名：**`easyenv.sh`**（小写）。

## Compose §5.1（易踩坑）

1. **最小可跑**：默认未取消注释即可 `docker compose up -d`。
2. **注释可配置项**：官方常用 env / command / 挂载 conf；每条含 **名称 + 建议值 + 方式**（`[environment]` | `[command]` | `[挂载]`）+ 一句用途。
3. **文件头**：官方文档、上游、镜像页、本仓 `docs/<module>/`。
4. **禁止空 YAML 键**：`environment:` / `ports:` / `volumes:` / `command:` / `networks:` 若**没有真实条目**，不要写该键。仅注释的可配置项写在**同级已有块旁**，例如：

```yaml
    ports:
      - "5000:5000"
    # [environment] REGISTRY_STORAGE_DELETE_ENABLED: "true" — 允许删除；需要时新增 environment 块
    volumes:
      - ./data:/var/lib/registry
```

空键会导致 IDE / schema：`Expected "object | array"`，且 `docker compose config` 失败。

样板：`templates/module/docker-compose.yml`。参考高质量模块：`modules/database/mysql/`。

## 模块 README §3.1（强制）

必须有：用途、前置、一键运行（含 `cd modules/...` 与可选 `./easyenv.sh up <id>`）、**连接信息表**（镜像/端口/用户密码或「无认证」/卷/管理台）、**客户端示例**、验收、说明、官方出处（文档+上游+Hub+`docs/`）。

禁止只有「up -d + 官方链接」的低信息量 README。

## 演示口令（§9）

| 角色 | 默认用户 |
|------|----------|
| 库/系统超管 | `root`（适用时） |
| 控制台/对象存储 | `admin`（适用时） |

密码递进：`123456` → `12345678` → `12345678910` → 继续加长；取第一条通过软件校验的，并在 README 写明。  
文档标明：**仅归档演示，禁止直接用于生产**。

## 端口避让（本仓已占用，新增勿撞）

| 端口 | 模块 |
|------|------|
| 3000 | openwebui |
| 3001 | grafana |
| 3002 / 2222 | gitea |
| 3300 / 3310 / 3170 | hoppscotch |
| 5000 | registry |
| 5540 | redisinsight |
| 6333 / 6334 | qdrant |
| 8080 / 8848 | nacos |
| 8081 | adminer |
| 8082 | phpmyadmin |
| 8083 | pgadmin |
| 8084 | filebrowser |
| 8085 / 50000 | jenkins |
| 8088 | nginx |
| 8089 | caddy |

改端口须同步 README、catalog `ports`、以及依赖该 URL 的 env（如 `ROOT_URL`）。

## 验收最低标准

```bash
cd modules/<category>/<name>
docker compose config -q
docker compose up -d
# README 中的验收命令（curl / ping / 登录探测）
docker compose down
```

特殊：

- **Hoppscotch CE**：官方要求先 Postgres，再 `prisma migrate deploy`，再起 AIO。
- **Gitea / Jenkins**：首次向导；无预置管理员或密码在容器文件/日志。
- **File Browser**：`admin` + **日志随机密码**（非固定 admin）。
- **phpMyAdmin / pgAdmin / RedisInsight**：GUI 自身账号与「连本仓 DB」分开写清。

## 提交（仅用户要求时）

- 每模块单独：`feat(<id>): 新增/修复 …环境`
- 共享索引：`feat(catalog): 登记…并同步规范`
- 不 push、不改 git config、不把真实生产密钥提交进仓

## 更多清单

逐步勾选见 [checklist.md](checklist.md)。
