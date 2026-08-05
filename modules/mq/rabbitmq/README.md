# RabbitMQ 3.13（management）

官方 `rabbitmq:*-management` 单机。管理台用户 `admin` / `123456`。

## 运行

```bash
cd modules/mq/rabbitmq && docker compose up -d
# 或 ./esayenv.sh up rabbitmq
```

管理台: http://127.0.0.1:15672

## 验收

```bash
docker compose ps
docker exec rabbitmq rabbitmq-diagnostics -q ping
```

## 官方

- [docs/rabbitmq/README.md](../../../docs/rabbitmq/README.md)
- https://hub.docker.com/_/rabbitmq
- https://github.com/rabbitmq/rabbitmq-server
