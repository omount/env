# Nacos（单机 Derby）

对照官方 Docker 单机示例。控制台默认账号为官方 **`nacos` / `nacos`**（不是 EsayEnv 递进的 123456）。

## 前置条件

- Docker 与 Compose V2
- 端口 `8080`（控制台）、`8848`（主端口）、`9848`（gRPC）空闲

## 一键运行

```bash
cd modules/discovery/nacos
docker compose up -d
# 或: ./esayenv.sh up nacos
```

首次启动较慢，等控制台可打开后再登录。

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `nacos/nacos-server:v3.2.3` |
| 控制台 | http://127.0.0.1:8080/index.html |
| 主端口 | `8848` |
| gRPC | `9848` |
| 控制台用户 | `nacos` |
| 控制台密码 | `nacos`（官方默认；若提示强制改密，按页面改并自行记录） |
| 服务端身份密钥 | compose 中 `NACOS_AUTH_*`（与官方 standalone-derby 示例一致，**不是**登录密码） |
| 数据 / 日志 | `./data/data`、`./data/logs` |

## 客户端示例

1. 浏览器打开 http://127.0.0.1:8080/index.html  
2. 用户名 `nacos`，密码 `nacos` 登录  
3. OpenAPI 示例需先登录拿 token（以当前版本控制台/文档为准）

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8080/index.html
# 期望 200
```

## 验收

```bash
docker compose ps
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8080/index.html
```

## 说明

- Arm Mac 若镜像异常，官方可用 `v3.2.3-slim`
- 详解：[docs/nacos/README.md](../../../docs/nacos/README.md)

## 官方出处

- https://github.com/nacos-group/nacos-docker
- 上游：https://github.com/alibaba/nacos
- Hub：https://hub.docker.com/r/nacos/nacos-server
