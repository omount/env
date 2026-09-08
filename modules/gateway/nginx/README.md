# Nginx 1.27

官方 `nginx` 镜像。默认提供静态欢迎页；**无登录账号**（HTTP 静态站点）。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `8088` 空闲（映射到容器 80，避开本机 80）
- 必须整夹部署（含 `conf/`、`html/`）。只拷 `docker-compose.yml` 会导致 conf 路径被建成目录，容器无法启动

## 一键运行

```bash
cd modules/gateway/nginx
docker compose up -d
# 或: ./easyenv.sh up nginx
```

已在 `/opt/env/nginx` 踩过 `nginx.conf` 被建成目录、OCI mount 失败时，先跑 [docs/nginx/README.md](../../../docs/nginx/README.md) 里的一键修复，再 `up -d`。

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `nginx:1.27.4` |
| 访问 URL | http://127.0.0.1:8088 |
| 用户 / 密码 | 无（未启用 basic auth） |
| 静态文件 | `./html` → `/usr/share/nginx/html` |
| 主配置 | `./conf/nginx.conf` → `/etc/nginx/nginx.conf`（文件） |
| 站点配置 | `./conf/conf.d` → `/etc/nginx/conf.d`（目录） |

`conf/conf.d` 已带示例，改 `server_name` / `proxy_pass` 即可，不必从零写：

| 文件 | 用途 | 是否加载 |
|------|------|----------|
| `default.conf` | 官方默认静态站（`localhost:80`） | 是 |
| `reverse-proxy.conf` | HTTP 反代（`app.example.com` → `127.0.0.1:3000`） | 是 |
| `websocket.conf` | WebSocket 反代（`ws.example.com`） | 是 |
| `ssl.conf.example` | TLS；复制为 `ssl.conf` 并挂证书后生效 | 否（非 `*.conf`） |

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
test -f conf/nginx.conf && test -d conf/conf.d
test -f conf/conf.d/default.conf
test -f conf/conf.d/reverse-proxy.conf
# nginx.conf 必须是文件，conf.d 必须是目录
```

## 说明

- 详解与一键修复：[docs/nginx/README.md](../../../docs/nginx/README.md)

## 官方出处

- Hub：https://hub.docker.com/_/nginx
- 文档：https://nginx.org/en/docs/
- 上游：https://github.com/nginx/nginx
