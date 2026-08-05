# MySQL 8.4

官方镜像单机部署。账号 `root` / `123456`，数据目录映射到 `./data`。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `3306` 空闲

## 一键运行

### docker compose

```bash
cd mysql
docker compose up -d
```

```bash
docker compose logs -f
docker compose down
```

### docker run

与 compose 等价（需在 `mysql` 目录执行，以便 `./data` 落在本模块下）：

```bash
cd mysql
mkdir -p data
docker run -d \
  --name mysql \
  --restart always \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -p 3306:3306 \
  -v "$(pwd)/data:/var/lib/mysql" \
  mysql:8.4 \
  --character-set-server=utf8mb4 \
  --collation-server=utf8mb4_unicode_ci \
  --sql-mode=ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION
```

```bash
docker logs -f mysql
docker stop mysql && docker rm mysql
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `mysql:8.4` |
| 主机 | `127.0.0.1`（或宿主机 IP） |
| 端口 | `3306` |
| 用户 | `root` |
| 密码 | `123456` |
| 数据卷 | `./data` → `/var/lib/mysql` |

```bash
docker exec -it mysql mysql -uroot -p123456
```

## 验收

```bash
docker compose ps
docker exec -it mysql mysqladmin ping -uroot -p123456
```

## 说明

- 字符集默认 `utf8mb4`
- 已显式开启 `ONLY_FULL_GROUP_BY`（随 `sql_mode` 一并设置）
- `./data` 已 gitignore，勿把库文件提交进仓库
- 密码仅作归档演示，生产请自行更换

## 参数与官方文档

- 本仓库参数说明：[docs/mysql/parameters.md](../docs/mysql/parameters.md)
- Docker Hub：https://hub.docker.com/_/mysql
- docker-library：https://github.com/docker-library/docs/blob/master/mysql/README.md

可选环境变量 / 卷 / `mysqld` 参数已在 `docker-compose.yml` 中注释说明，按需取消注释。
