# Nginx 1.27

官方 `nginx` 镜像。宿主机 **8088** → 容器 80。

## 运行

```bash
cd modules/gateway/nginx && docker compose up -d
```

打开 http://127.0.0.1:8088

## 验收

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8088/
# 期望 200
```

## 官方

- [docs/nginx/README.md](../../../docs/nginx/README.md)
- https://hub.docker.com/_/nginx
- https://github.com/nginx/nginx
