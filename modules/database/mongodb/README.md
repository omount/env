# MongoDB 7.0

官方 `mongo` 镜像单机。超级用户 `root` / `123456`，认证库 `admin`。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `27017` 空闲

## 一键运行

```bash
cd modules/database/mongodb
docker compose up -d
# 或: ./EasyEnv.sh up mongodb
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `mongo:7.0.16` |
| 主机 | `127.0.0.1` |
| 端口 | `27017` |
| 用户 | `root`（`MONGO_INITDB_ROOT_USERNAME`） |
| 密码 | `123456`（`MONGO_INITDB_ROOT_PASSWORD`） |
| 认证库 | `admin` |
| 数据卷 | `./data` → `/data/db` |

连接串示例：

```text
mongodb://root:123456@127.0.0.1:27017/?authSource=admin
```

## 客户端示例

```bash
docker exec -it mongodb mongosh -u root -p 123456 --authenticationDatabase admin
```

## 验收

```bash
docker compose ps
docker exec mongodb mongosh -u root -p 123456 --authenticationDatabase admin --eval "db.runCommand({ ping: 1 })"
```

## 说明

- 演示口令仅归档用；可配置项见 compose 注释
- 详解：[docs/mongodb/README.md](../../../docs/mongodb/README.md)

## 官方出处

- Docker Hub：https://hub.docker.com/_/mongo
- 上游：https://github.com/mongodb/mongo
