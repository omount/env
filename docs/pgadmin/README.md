# pgAdmin（对照官方）

模块：[`modules/gui/pgadmin/`](../../modules/gui/pgadmin/)

## 依据

- https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html
- https://hub.docker.com/r/dpage/pgadmin4

## 差异

| 项 | 说明 |
|----|------|
| 镜像 | 钉死 `dpage/pgadmin4:9.6.0` |
| 端口 | 8083 |
| 演示账号 | `admin@example.com` / `123456`（符合本仓密码阶梯） |
