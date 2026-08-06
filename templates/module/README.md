# \<模块名\>

路径：`modules/<category>/<name>/`

## 用途

一句话说明本模块解决什么问题。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `xxxx` 空闲

## 一键运行

```bash
cd modules/<category>/<name>
docker compose up -d
# 或（整仓）: ./easyenv.sh up <id>
```

```bash
docker compose logs -f
docker compose down
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `repo:tag` |
| 主机 | `127.0.0.1`（或宿主机 IP） |
| 端口 | `xxxx` |
| 用户 | `…`（无则写「无」） |
| 密码 | `…`（无认证则写「无 / 未启用 ACL」） |
| 管理台 | `http://127.0.0.1:xxxx`（无则删本行） |
| 数据卷 | `./data` → 容器内路径 |

## 客户端示例

```bash
# 至少一条可复制命令，写明如何带账号密码连接
```

## 验收

```bash
docker compose ps
# 期望健康或业务探活命令
```

## 说明

- 演示口令仅归档用，生产请更换
- 可配置项见 `docker-compose.yml` 注释（建议值 + 配置方式）

## 官方出处

- 详解（如有）：[docs/\<模块\>/](../../../docs/\<模块\>/)
- 官方文档：https://…
- 上游仓库：https://github.com/…
- 镜像页：https://…

登记：根目录 `catalog.yml`。
