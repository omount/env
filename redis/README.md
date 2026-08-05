# Redis 7.4

官方镜像单机部署。仅密码认证（无独立用户名），密码 `123456`，数据目录映射到 `./data`。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `6379` 空闲

## 一键运行

### docker compose

```bash
cd redis
docker compose up -d
```

```bash
docker compose logs -f
docker compose down
```

### docker run

与 compose 等价（需在 `redis` 目录执行，以便 `./data` 落在本模块下）：

```bash
cd redis
mkdir -p data
docker run -d \
  --name redis \
  --restart always \
  -p 6379:6379 \
  -v "$(pwd)/data:/data" \
  redis:7.4 \
  redis-server --requirepass 123456 --appendonly yes
```

```bash
docker logs -f redis
docker stop redis && docker rm redis
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `redis:7.4` |
| 主机 | `127.0.0.1`（或宿主机 IP） |
| 端口 | `6379` |
| 用户名 | 无（仅密码） |
| 密码 | `123456` |
| 数据卷 | `./data` → `/data`（AOF 已开启） |

```bash
docker exec -it redis redis-cli -a 123456 ping
```

## 验收

```bash
docker compose ps
docker exec -it redis redis-cli -a 123456 ping
# 期望返回 PONG
```

## 说明

- 使用 `--requirepass`，未配置 ACL 用户 `root`
- `./data` 已 gitignore，勿把持久化文件提交进仓库
- 密码仅作归档演示，生产请自行更换
