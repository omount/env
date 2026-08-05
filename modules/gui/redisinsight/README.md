# Redis Insight 3.8.0

官方 GUI。**默认无 Web 登录墙**；在 UI 中添加本仓 Redis（`127.0.0.1:6379` 或 `host.docker.internal:6379`，本仓无密码）。

## 前置

- Docker Compose V2；端口 `5540` 空闲
- 可选：`./easyenv.sh up redis`

## 运行

```bash
cd modules/gui/redisinsight
docker compose up -d
# 或: ./easyenv.sh up redisinsight
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `redis/redisinsight:3.8.0` |
| URL | http://127.0.0.1:5540 |
| Web 账号 | 无（本地默认） |
| 数据卷 | `./data` → `/data` |

### 添加本仓 Redis

| 字段 | 值 |
|------|-----|
| Host | `host.docker.internal` |
| Port | `6379` |
| Password | （本仓默认无） |

## 客户端示例

浏览器打开 http://127.0.0.1:5540 。

## 验收

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:5540/
# 期望 200
```

## 官方

- [docs/redisinsight/README.md](../../../docs/redisinsight/README.md)
- https://redis.io/docs/latest/operate/redisinsight/install/install-on-docker/
- https://hub.docker.com/r/redis/redisinsight
