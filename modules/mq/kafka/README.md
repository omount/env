# Apache Kafka 3.9（KRaft 单机）

官方 `apache/kafka` 镜像单节点。对外 `9092`。

## 运行

```bash
cd modules/mq/kafka && docker compose up -d
# 或 ./esayenv.sh up kafka
```

## 验收

```bash
docker compose ps
docker exec kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
```

## 官方

- [docs/kafka/README.md](../../../docs/kafka/README.md)
- https://hub.docker.com/r/apache/kafka
- https://github.com/apache/kafka
- https://kafka.apache.org/documentation/#quickstart
