# Hoppscotch CE AIO 2026.7.0

对照官方 [Install and build](https://docs.hoppscotch.io/documentation/self-host/community-edition/install-and-build)：AIO + Postgres。**首次必须跑迁移**。

## 前置

- Docker Compose V2
- 端口 `3300` / `3310` / `3170` 空闲

## 一键运行（含首次迁移）

```bash
cd modules/debug/hoppscotch
docker compose up -d hoppscotch-db
# 官方：先迁移再启 AIO（否则 backend 报 Database migration not found）
docker compose run --rm --entrypoint sh hoppscotch -c "pnpm exec prisma migrate deploy"
docker compose up -d
# 或: ./easyenv.sh up hoppscotch  （仍需本目录执行一次 migrate）
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `hoppscotch/hoppscotch:2026.7.0` |
| App | http://127.0.0.1:3300 |
| Admin | http://127.0.0.1:3310 |
| Backend | http://127.0.0.1:3170 |
| 预置登录 | **无** — 打开 Admin 按[官方 Setup](https://docs.hoppscotch.io/documentation/self-host/community-edition/setup-and-access) 创建 |
| Postgres | 同 compose `hoppscotch` / `123456` / DB `hoppscotch` |
| 加密密钥 | `.env` 中 `DATA_ENCRYPTION_KEY`（演示用 32 字符；生产请更换） |

## 验收

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3300/
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3310/
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3170/ping
```

## 官方

- [docs/hoppscotch/README.md](../../../docs/hoppscotch/README.md)
- https://docs.hoppscotch.io/documentation/self-host/community-edition/install-and-build
