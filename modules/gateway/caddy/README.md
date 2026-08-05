# Caddy 2.11.4

官方 `caddy` 镜像。宿主机 **8089**→80。**无登录账号**。

## 前置

- Docker Compose V2；端口 `8089` 空闲

## 运行

```bash
cd modules/gateway/caddy
docker compose up -d
# 或: ./easyenv.sh up caddy
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `caddy:2.11.4` |
| URL | http://127.0.0.1:8089 |
| 用户/密码 | 无 |
| Caddyfile | `./Caddyfile` |
| 站点 | `./site` → `/srv` |

## 客户端示例

```bash
curl -sI http://127.0.0.1:8089/
```

## 验收

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8089/
# 期望 200
```

## 官方

- [docs/caddy/README.md](../../../docs/caddy/README.md)
- https://caddyserver.com/docs/install#docker
- https://hub.docker.com/_/caddy
- https://github.com/caddyserver/caddy
