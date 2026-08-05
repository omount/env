# Kafka（对照官方）

模块：[`modules/mq/kafka/`](../../modules/mq/kafka/)

## 依据

- https://hub.docker.com/r/apache/kafka
- https://kafka.apache.org/documentation/#quickstart
- 上游：https://github.com/apache/kafka

## 差异

| 项 | 说明 |
|----|------|
| 形态 | 单机 KRaft（非集群） |
| 镜像 | 钉死 `apache/kafka:3.9.0` |
| advertised | `127.0.0.1:9092`（本机客户端；改宿主机 IP 时请同步） |
