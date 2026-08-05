# Adminer 4.8.1

官方 `adminer` 数据库 Web GUI。**Adminer 自身无独立登录账号**；连接目标库时使用该库的用户/密码（如本仓库 MySQL `root`/`123456`）。

## 前置条件

- Docker 与 Compose V2
- 端口 `8081` 空闲（避开 nacos `8080`）
- 目标数据库已启动（可选）

## 一键运行

```bash
cd modules/gui/adminer
docker compose up -d
# 或: ./EasyEnv.sh up adminer
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `adminer:4.8.1` |
| UI | http://127.0.0.1:8081 |
| Adminer 账号 | 无（打开即进入连接表单） |
| 默认服务器字段 | `host.docker.internal`（连宿主机上的库） |

### 连接本仓库 MySQL 示例（表单填写）

| 表单项 | 建议值 |
|--------|--------|
| 系统 | MySQL |
| 服务器 | `host.docker.internal`（Linux 若不通见 compose `extra_hosts` 注释） |
| 用户名 | `root` |
| 密码 | `123456` |
| 数据库 | （可空，登录后再选） |

PostgreSQL：系统选 PostgreSQL，用户/密码用 pgsql 模块的 `root` / `123456`（以该模块 README 为准）。

## 客户端示例

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8081/
# 期望 200，再浏览器填写上方表单
```

## 验收

```bash
docker compose ps
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8081/
```

## 说明

- 详解：[docs/adminer/README.md](../../../docs/adminer/README.md)

## 官方出处

- Hub：https://hub.docker.com/_/adminer
- 上游：https://github.com/vrana/adminer
