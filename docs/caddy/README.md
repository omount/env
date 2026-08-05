# Caddy（对照官方）

模块：[`modules/gateway/caddy/`](../../modules/gateway/caddy/)

## 依据

- https://caddyserver.com/docs/install#docker
- https://hub.docker.com/_/caddy

## 差异

| 项 | 说明 |
|----|------|
| 镜像 | 钉死 `caddy:2.11.4` |
| 端口 | 宿主机 8089（避 nginx 8088） |
