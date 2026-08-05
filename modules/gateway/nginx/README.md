# Nginx 1.27

官方 `nginx` 镜像。默认提供静态欢迎页；**无登录账号**（HTTP 静态站点）。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `8088` 空闲（映射到容器 80，避开本机 80）

## 一键运行

```bash
cd modules/gateway/nginx
docker compose up -d
# 或: ./EasyEnv.sh up nginx
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `nginx:1.27.4` |
| 访问 URL | http://127.0.0.1:8088 |
| 用户 / 密码 | 无（未启用 basic auth） |
| 静态文件 | `./html` → `/usr/share/nginx/html` |

反向代理、TLS、鉴权：取消 compose 中 conf 挂载注释，自备 `./conf/default.conf`。

## 客户端示例

```bash
curl -sI http://127.0.0.1:8088/
curl -s http://127.0.0.1:8088/
```

## 验收

```bash
docker compose ps
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8088/
# 期望 200
```

## 说明

- 详解：[docs/nginx/README.md](../../../docs/nginx/README.md)

## 官方出处

- Hub：https://hub.docker.com/_/nginx
- 文档：https://nginx.org/en/docs/
- 上游：https://github.com/nginx/nginx
