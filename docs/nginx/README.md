# Nginx（对照官方）

模块：[`modules/gateway/nginx/`](../../modules/gateway/nginx/)

## 依据

- https://hub.docker.com/_/nginx
- https://nginx.org/en/docs/
- 反代：https://nginx.org/en/docs/http/ngx_http_proxy_module.html
- WebSocket：https://nginx.org/en/docs/http/websocket.html
- HTTPS：https://nginx.org/en/docs/http/configuring_https_servers.html
- 上游：https://github.com/nginx/nginx

## 差异

| 项 | 说明 |
|----|------|
| 端口 | 宿主机 8088（避免占用 80） |
| 静态页 | `./html` 最小演示页 |
| 主配置 | 官方 `nginx:1.27.4` 的 `/etc/nginx/nginx.conf`（`pid /var/run/nginx.pid`） |
| 站点目录 | 整目录挂载 `./conf/conf.d` → `/etc/nginx/conf.d` |
| default.conf | 与镜像内官方文件一致（`listen 80`） |
| reverse-proxy.conf | 本仓附加：HTTP 反代示例（官方镜像 conf.d 仅有 default.conf） |
| websocket.conf | 本仓附加：WebSocket 反代示例 |
| ssl.conf.example | 本仓附加：TLS 示例；不加载，避免缺证书起不来 |

从镜像核对默认配置：

```bash
docker run --rm --entrypoint=cat nginx:1.27.4 /etc/nginx/nginx.conf
docker run --rm --entrypoint=cat nginx:1.27.4 /etc/nginx/conf.d/default.conf
```

反代用法：改 `conf/conf.d/reverse-proxy.conf` 里的 `server_name` 与 `proxy_pass`，不必新建文件。未匹配的 Host 仍走 `default.conf`。

TLS：`cp conf/conf.d/ssl.conf.example conf/conf.d/ssl.conf`，填证书路径，compose 取消注释 `8443:443` 与 `./certs` 挂载。

## 踩坑：把文件挂成目录

报错形如：

```text
error mounting ".../conf/nginx.conf" to rootfs at "/etc/nginx/nginx.conf"
not a directory: Are you trying to mount a directory onto a file (or vice-versa)?
```

原因：compose 把宿主机 `./conf/nginx.conf` 挂到容器内**文件** `/etc/nginx/nginx.conf`。宿主机该路径若不存在，Docker 会先建成**目录**，再 bind mount 就会失败。`conf.d` 必须是**目录**。

处理：删掉误建目录，写成真正的配置文件，再启动。不要 `mkdir nginx.conf`。

## 一键修复（已部署到 /opt/env/nginx）

在宿主机执行。会停容器、清掉误建路径、写入主配置与 `conf.d` 示例后重新启动。自定义过的 conf 请先备份。

```bash
#!/usr/bin/env bash
set -euo pipefail
NGINX_ROOT="${NGINX_ROOT:-/opt/env/nginx}"
CONF_DIR="${NGINX_ROOT}/conf"
CONFD_DIR="${CONF_DIR}/conf.d"

if [ -f "${NGINX_ROOT}/docker-compose.yml" ]; then
  docker compose -f "${NGINX_ROOT}/docker-compose.yml" down || true
fi
docker rm -f nginx 2>/dev/null || true

if [ -d "${CONF_DIR}/nginx.conf" ]; then
  rm -rf "${CONF_DIR}/nginx.conf"
fi
if [ -d "${CONF_DIR}/default.conf" ]; then
  rm -rf "${CONF_DIR}/default.conf"
fi
if [ -f "${CONFD_DIR}" ]; then
  rm -f "${CONFD_DIR}"
fi

mkdir -p "${CONFD_DIR}"

cat > "${CONF_DIR}/nginx.conf" << 'EOF'

user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    keepalive_timeout  65;
    include /etc/nginx/conf.d/*.conf;
}
EOF

cat > "${CONFD_DIR}/default.conf" << 'EOF'
server {
    listen       80;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
EOF

cat > "${CONFD_DIR}/reverse-proxy.conf" << 'EOF'
server {
    listen 80;
    server_name app.example.com;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Connection "";
    }
}
EOF

cat > "${CONFD_DIR}/websocket.conf" << 'EOF'
map $http_upgrade $connection_upgrade {
    default upgrade;
    ''      close;
}

server {
    listen 80;
    server_name ws.example.com;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_read_timeout 86400s;
    }
}
EOF

cat > "${CONFD_DIR}/ssl.conf.example" << 'EOF'
# 复制为 ssl.conf 并取消注释；同时挂证书与 8443:443
# server {
#     listen 443 ssl;
#     server_name ssl.example.com;
#     ssl_certificate     /etc/nginx/certs/fullchain.pem;
#     ssl_certificate_key /etc/nginx/certs/privkey.pem;
#     location / {
#         proxy_pass http://127.0.0.1:3000;
#         proxy_http_version 1.1;
#         proxy_set_header Host $host;
#         proxy_set_header X-Real-IP $remote_addr;
#         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#         proxy_set_header X-Forwarded-Proto $scheme;
#     }
# }
EOF

test -f "${CONF_DIR}/nginx.conf"
test -d "${CONFD_DIR}"
test -f "${CONFD_DIR}/default.conf"
test -f "${CONFD_DIR}/reverse-proxy.conf"

if [ -f "${NGINX_ROOT}/docker-compose.yml" ]; then
  docker compose -f "${NGINX_ROOT}/docker-compose.yml" up -d
else
  echo "未找到 ${NGINX_ROOT}/docker-compose.yml，请自行 up -d"
  exit 1
fi

docker compose -f "${NGINX_ROOT}/docker-compose.yml" ps
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8088/
```

compose 必须是：

```yaml
- ./conf/nginx.conf:/etc/nginx/nginx.conf:ro
- ./conf/conf.d:/etc/nginx/conf.d:ro
```
