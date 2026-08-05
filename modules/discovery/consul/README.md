# Consul（单节点 server）

对照 HashiCorp 官方 Docker 单节点示例。开启 UI；**默认未启用 ACL，无登录用户名密码**。

## 前置条件

- Docker 与 Compose V2
- 端口 `8500`（HTTP/UI）、`8600`（DNS）空闲

## 一键运行

```bash
cd modules/discovery/consul
docker compose up -d
# 或: ./esayenv.sh up consul
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `hashicorp/consul:1.21.3` |
| UI / HTTP API | http://127.0.0.1:8500 |
| DNS | `8600` tcp/udp |
| ACL / 登录 | 未启用（打开 UI 即可操作演示集群） |
| 节点名 | `server-1` |
| 数据卷 | `./data` → `/consul/data` |

启用 ACL 需按官方另行配置，本模板演示不加。

## 客户端示例

```bash
docker exec consul consul members
curl -s http://127.0.0.1:8500/v1/status/leader
# 浏览器: http://127.0.0.1:8500
```

写 KV 示例：

```bash
docker exec consul consul kv put demo/hello world
docker exec consul consul kv get demo/hello
```

## 验收

```bash
docker compose ps
docker exec consul consul members
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8500/v1/status/leader
```

## 说明

- 详解：[docs/consul/README.md](../../../docs/consul/README.md)

## 官方出处

- https://developer.hashicorp.com/consul/docs/deploy/server/docker
- 上游：https://github.com/hashicorp/consul
- Hub：https://hub.docker.com/r/hashicorp/consul
