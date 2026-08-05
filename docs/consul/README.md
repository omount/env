# Consul 部署说明（对照官方）

对应模块：[`consul/`](../../modules/discovery/consul/)

## 验收依据（官方）

1. https://developer.hashicorp.com/consul/docs/deploy/server/docker  
2. https://developer.hashicorp.com/consul/docs/docker  
3. 上游仓库：https://github.com/hashicorp/consul  
4. 镜像：https://hub.docker.com/r/hashicorp/consul  

## 本仓库相对官方原文的改动

| 项 | 官方原文 | 本仓库 |
|----|----------|--------|
| 形态 | 单节点 `docker run` 示例 | 等价 Compose |
| 镜像 tag | 单节点命令未钉 tag；多节点示例 `1.21.3` | 钉死 `hashicorp/consul:1.21.3` |
| 数据 | 容器内 `/consul/data` | 绑定 `./data` |
| 节点数 | 另有 3 节点集群示例 | **仅单节点**（`bootstrap-expect=1`） |

## 端口

| 用途 | 端口 |
|------|------|
| UI / HTTP API | 8500 |
| DNS | 8600 tcp/udp |
