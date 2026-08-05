# MongoDB 7.0

官方 `mongo` 镜像单机。账号 `root` / `123456`。

## 前置

- Docker Compose V2；端口 `27017` 空闲

## 运行

```bash
cd modules/database/mongodb
docker compose up -d
# 或: ./esayenv.sh up mongodb
```

## 连接

| 项 | 值 |
|----|-----|
| 镜像 | `mongo:7.0.16` |
| 端口 | 27017 |
| 用户 / 密码 | root / 123456 |

```bash
docker exec -it mongodb mongosh -u root -p 123456 --authenticationDatabase admin
```

## 验收

```bash
docker compose ps
docker exec mongodb mongosh -u root -p 123456 --authenticationDatabase admin --eval "db.runCommand({ ping: 1 })"
```

## 官方

- 详解: [docs/mongodb/README.md](../../../docs/mongodb/README.md)
- Hub: https://hub.docker.com/_/mongo
- 上游: https://github.com/mongodb/mongo
