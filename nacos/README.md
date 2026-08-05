# Nacos（单机 Derby）

对照官方 Docker 示例的单机部署。镜像 `nacos/nacos-server:v3.2.3`，内嵌 Derby，控制台端口 `8080`，主端口 `8848`。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `8080` / `8848` / `9848` 空闲

## 一键运行

```bash
cd nacos
docker compose up -d
```

```bash
docker compose logs -f
docker compose down
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `nacos/nacos-server:v3.2.3` |
| 控制台 | http://127.0.0.1:8080/index.html |
| 主端口 | `8848`（客户端 / OpenAPI） |
| gRPC | `9848` |
| 控制台账号 | `nacos` / `nacos`（官方默认） |
| 数据 | `./data/data` → `/home/nacos/data` |
| 日志 | `./data/logs` → `/home/nacos/logs` |

`NACOS_AUTH_*` 为服务端身份密钥（与官方 `standalone-derby.yaml` 一致），**不是**控制台登录密码。

## 验收

```bash
docker compose ps
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8080/index.html
# 期望 200
```

浏览器打开 http://127.0.0.1:8080/index.html ，使用 `nacos` / `nacos` 登录（若提示强制改密，按控制台指引修改并自行记录）。

## 说明

- 单机演示；生产请用集群 + 外置存储，见官方文档
- Arm Mac 若拉取失败，官方说明可改用 `v3.2.3-slim`（见 nacos-docker README）
- 演示密钥仅归档用，生产务必更换 `NACOS_AUTH_*`

## 官方文档与仓库

- 详解：[docs/nacos/README.md](../docs/nacos/README.md)
- Docker 项目：https://github.com/nacos-group/nacos-docker
- 官方示例：https://github.com/nacos-group/nacos-docker/blob/master/example/standalone-derby.yaml
- 上游仓库：https://github.com/alibaba/nacos
- 官网文档：https://nacos.io/docs/latest/manual/admin/deployment/deployment-standalone/
