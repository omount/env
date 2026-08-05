# Nginx（对照官方）

模块：[`modules/gateway/nginx/`](../../modules/gateway/nginx/)

## 依据

- https://hub.docker.com/_/nginx
- https://nginx.org/en/docs/
- 上游：https://github.com/nginx/nginx

## 差异

| 项 | 说明 |
|----|------|
| 端口 | 宿主机 8088（避免占用 80） |
| 静态页 | `./html` 最小演示页 |
