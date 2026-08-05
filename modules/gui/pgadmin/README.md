# pgAdmin 4 9.6.0

Web 管理 PostgreSQL。演示登录见下表；连库在 UI 中手动添加（本仓 `pgsql`：postgres/`123456`）。

## 前置

- Docker Compose V2；端口 `8083` 空闲
- 可选：`./easyenv.sh up pgsql`

## 运行

```bash
cd modules/gui/pgadmin
docker compose up -d
# 或: ./easyenv.sh up pgadmin
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `dpage/pgadmin4:9.6.0` |
| URL | http://127.0.0.1:8083 |
| 登录邮箱 | `admin@example.com` |
| 登录密码 | `123456` |
| 数据卷 | `./data` → `/var/lib/pgadmin` |

### 添加本仓 PostgreSQL（示例）

| 字段 | 值 |
|------|-----|
| Host | `host.docker.internal` |
| Port | `5432` |
| Username | `postgres` |
| Password | `123456` |

## 客户端示例

浏览器打开 http://127.0.0.1:8083 ，用上表邮箱/密码登录。

## 验收

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8083/misc/ping
# 官方 ping 常返回 `Ping` / 200
```

## 官方

- [docs/pgadmin/README.md](../../../docs/pgadmin/README.md)
- https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html
- https://hub.docker.com/r/dpage/pgadmin4
