# Docker Registry 2.8.3

官方 Distribution Registry。**默认无认证**，仅适合本机演示。

## 前置

- Docker Compose V2；端口 `5000` 空闲
- 推送 HTTP 仓库需在 Docker daemon 配置 `insecure-registries: ["127.0.0.1:5000"]`

## 运行

```bash
cd modules/registry/registry
docker compose up -d
# 或: ./easyenv.sh up registry
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `registry:2.8.3` |
| API | http://127.0.0.1:5000/v2/ |
| 用户/密码 | 无 |
| 数据 | `./data` → `/var/lib/registry` |

## 客户端示例

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:5000/v2/
# 期望 200
# docker tag alpine:latest 127.0.0.1:5000/alpine:demo
# docker push 127.0.0.1:5000/alpine:demo
```

## 官方

- [docs/registry/README.md](../../../docs/registry/README.md)
- https://hub.docker.com/_/registry
- https://distribution.github.io/distribution/
