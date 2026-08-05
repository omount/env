# PostgreSQL 16

官方镜像单机部署。用户 `root` / 密码 `123456`，默认库 `root`，数据目录映射到 `./data`。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `5432` 空闲

## 一键运行

### docker compose

```bash
cd pgsql
docker compose up -d
```

```bash
docker compose logs -f
docker compose down
```

### docker run

与 compose 等价（需在 `pgsql` 目录执行，以便 `./data` 落在本模块下）：

```bash
cd pgsql
mkdir -p data
docker run -d \
  --name pgsql \
  --restart always \
  -e POSTGRES_USER=root \
  -e POSTGRES_PASSWORD=123456 \
  -e POSTGRES_DB=root \
  -p 5432:5432 \
  -v "$(pwd)/data:/var/lib/postgresql/data" \
  postgres:16
```

```bash
docker logs -f pgsql
docker stop pgsql && docker rm pgsql
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `postgres:16` |
| 主机 | `127.0.0.1`（或宿主机 IP） |
| 端口 | `5432` |
| 用户 | `root` |
| 密码 | `123456` |
| 数据库 | `root` |
| 数据卷 | `./data` → `/var/lib/postgresql/data` |

```bash
docker exec -it pgsql psql -U root -d root
```

## 验收

```bash
docker compose ps
docker exec -it pgsql pg_isready -U root
```

## 说明

- `./data` 已 gitignore，勿把库文件提交进仓库
- 密码仅作归档演示，生产请自行更换
