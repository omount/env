# Adminer 4.8.1

官方 `adminer` 镜像。UI: http://127.0.0.1:8081

连接本仓库 MySQL/PgSQL 时，服务器填 `host.docker.internal`（或 compose 同网络服务名）。

## 运行

```bash
cd modules/gui/adminer && docker compose up -d
```

## 验收

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8081/
# 期望 200
```

## 官方

- [docs/adminer/README.md](../../../docs/adminer/README.md)
- https://hub.docker.com/_/adminer
- https://github.com/vrana/adminer
