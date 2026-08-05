# RabbitMQ 3.13（management）

官方 `rabbitmq:*-management` 单机。AMQP + 管理台；演示用户 `admin` / `123456`。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `5672`（AMQP）、`15672`（管理台）空闲

## 一键运行

```bash
cd modules/mq/rabbitmq
docker compose up -d
# 或: ./EasyEnv.sh up rabbitmq
```

```bash
docker compose logs -f
docker compose down
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `rabbitmq:3.13.7-management` |
| 主机 | `127.0.0.1` |
| AMQP 端口 | `5672` |
| 管理台 | http://127.0.0.1:15672 |
| 用户 | `admin`（由 `RABBITMQ_DEFAULT_USER` 设置；勿用默认仅本机可用的 `guest` 对外） |
| 密码 | `123456`（`RABBITMQ_DEFAULT_PASS`） |
| 默认 vhost | `/`（`RABBITMQ_DEFAULT_VHOST`） |
| 数据卷 | `./data` → `/var/lib/rabbitmq` |

管理台登录：浏览器打开 http://127.0.0.1:15672 ，用户名 `admin`，密码 `123456`。

## 客户端示例

AMQP 连接串（应用侧）：

```text
amqp://admin:123456@127.0.0.1:5672/
```

容器内探活 / 列用户：

```bash
docker exec rabbitmq rabbitmq-diagnostics -q ping
docker exec rabbitmq rabbitmqctl list_users
```

## 验收

```bash
docker compose ps
docker exec rabbitmq rabbitmq-diagnostics -q ping
# 浏览器登录管理台成功即通过
```

## 说明

- 演示口令仅归档用，生产请更换并限制管理台暴露
- 更多项见 `docker-compose.yml` 注释；详解 [docs/rabbitmq/README.md](../../../docs/rabbitmq/README.md)

## 官方出处

- Docker Hub：https://hub.docker.com/_/rabbitmq
- 上游仓库：https://github.com/rabbitmq/rabbitmq-server
