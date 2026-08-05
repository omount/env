# Apache Kafka 3.9（KRaft 单机）

官方 `apache/kafka` 单节点（broker+controller 合并）。**默认无 SASL 账号密码**（PLAINTEXT）。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `9092` 空闲

## 一键运行

```bash
cd modules/mq/kafka
docker compose up -d
# 或: ./esayenv.sh up kafka
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `apache/kafka:3.9.0` |
| Bootstrap | `127.0.0.1:9092` |
| 协议 | PLAINTEXT（无用户名/密码） |
| 认证 | 未启用 |
| advertised | `PLAINTEXT://127.0.0.1:9092`（本机客户端；换机器请改 compose） |
| 数据卷 | `./data` → `/var/lib/kafka/data` |

## 客户端示例

```bash
# 列主题
docker exec kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list

# 创建主题
docker exec kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 \
  --create --topic demo --partitions 1 --replication-factor 1
```

应用配置示例：`bootstrap.servers=127.0.0.1:9092`（无 `security.protocol` 额外认证项）。

## 验收

```bash
docker compose ps
docker exec kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
```

## 说明

- 单机演示无 ACL/SASL；生产请按官方启用安全配置
- 详解：[docs/kafka/README.md](../../../docs/kafka/README.md)

## 官方出处

- Hub：https://hub.docker.com/r/apache/kafka
- 文档：https://kafka.apache.org/documentation/#quickstart
- 上游：https://github.com/apache/kafka
