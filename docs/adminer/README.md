# Adminer（对照官方）

模块：[`modules/gui/adminer/`](../../modules/gui/adminer/)

## 依据

- https://hub.docker.com/_/adminer
- 上游：https://github.com/vrana/adminer

## 差异

| 项 | 说明 |
|----|------|
| 端口 | 宿主机 8081（避开 nacos 8080） |
| 默认服务器 | `host.docker.internal` |
