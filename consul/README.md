# Consul（单节点 server）

对照 HashiCorp 官方 Docker 单节点 server 示例。镜像 `hashicorp/consul:1.21.3`，开启 UI，`bootstrap-expect=1`。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `8500` / `8600` 空闲

## 一键运行

```bash
cd consul
docker compose up -d
```

```bash
docker compose logs -f
docker compose down
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `hashicorp/consul:1.21.3` |
| UI / HTTP API | http://127.0.0.1:8500 |
| DNS | `8600`（tcp/udp） |
| ACL | 未启用（与官方单节点示意一致） |
| 数据卷 | `./data` → `/consul/data` |

## 验收

```bash
docker compose ps
docker exec consul consul members
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8500/v1/status/leader
# members 应看到 server-1；leader 接口期望 200
```

浏览器：http://127.0.0.1:8500

## 说明

- 单机演示；生产请 ≥3 台 server，见官方多节点 Compose 示例
- 官方生产建议关注网络模式（`--net=host` 等），本模板用 bridge + 端口映射便于本机验收

## 官方文档与仓库

- 详解：[docs/consul/README.md](../docs/consul/README.md)
- 部署文档：https://developer.hashicorp.com/consul/docs/deploy/server/docker
- Docker 说明：https://developer.hashicorp.com/consul/docs/docker
- 上游仓库：https://github.com/hashicorp/consul
- 镜像：https://hub.docker.com/r/hashicorp/consul
