# RabbitMQ（对照官方）

模块：[`modules/mq/rabbitmq/`](../../modules/mq/rabbitmq/)

## 依据

- https://hub.docker.com/_/rabbitmq
- 上游：https://github.com/rabbitmq/rabbitmq-server

## 差异

| 项 | 官方 | 本仓库 |
|----|------|--------|
| 镜像 | `rabbitmq:management` | 钉死 `3.13.7-management` |
| 用户 | 默认可改 `RABBITMQ_DEFAULT_*` | admin / 123456 |
