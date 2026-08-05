# MySQL 官方镜像参数说明（mysql:8.4）

对应 Compose：[`mysql/docker-compose.yml`](../../mysql/docker-compose.yml)

## 官方文档

| 文档 | 链接 |
|------|------|
| Docker Hub `mysql` | https://hub.docker.com/_/mysql |
| docker-library 完整说明 | https://github.com/docker-library/docs/blob/master/mysql/README.md |
| MySQL 环境变量（服务端） | https://dev.mysql.com/doc/refman/8.4/en/environment-variables.html |
| 列出全部 mysqld 选项 | `docker run -it --rm mysql:8.4 --verbose --help` |

> 以下 Docker 专用环境变量**仅在数据目录为空（首次初始化）时生效**；已有 `./data` 时改环境变量不会改库内账号。

## 环境变量

| 变量 | 作用 |
|------|------|
| `MYSQL_ROOT_PASSWORD` | **必填（常规场景）**。设置 `root` 超级用户密码。 |
| `MYSQL_DATABASE` | 可选。首次启动时创建该数据库；若同时有 `MYSQL_USER`，该用户对该库 `GRANT ALL`。 |
| `MYSQL_USER` / `MYSQL_PASSWORD` | 可选，成对使用。创建普通用户及其密码（不能替代创建 root）。 |
| `MYSQL_ROOT_HOST` | 可选。限制/放宽 `root` 允许连接的主机；`%` 表示任意主机（有安全风险）。亦支持 `_FILE`。 |
| `MYSQL_ALLOW_EMPTY_PASSWORD` | 设为非空允许 root 空密码；**不推荐**。 |
| `MYSQL_RANDOM_ROOT_PASSWORD` | 设为非空则随机生成 root 密码并打印到日志。 |
| `MYSQL_ONETIME_PASSWORD` | 设为非空则初始化后强制 root 首次登录改密（5.6+）。 |
| `MYSQL_INITDB_SKIP_TZINFO` | 设为非空则跳过加载时区信息（默认会加载）。 |
| `*_FILE` | 从文件读取对应变量值，用于 Docker Secrets。支持：`MYSQL_ROOT_PASSWORD`、`MYSQL_ROOT_HOST`、`MYSQL_DATABASE`、`MYSQL_USER`、`MYSQL_PASSWORD`。 |

## 卷与初始化

| 挂载 | 作用 |
|------|------|
| `./data` → `/var/lib/mysql` | 数据文件持久化（本模板已启用）。 |
| `./conf.d` → `/etc/mysql/conf.d` | 自定义 `.cnf` 配置片段。 |
| `./initdb` → `/docker-entrypoint-initdb.d` | 首次初始化执行 `.sh` / `.sql` / `.sql.gz` 等脚本。 |

## 常用 `command`（mysqld）参数

本模板已启用：`character-set-server`、`collation-server`、`sql-mode`（含 `ONLY_FULL_GROUP_BY`）。

Compose 中另以注释列出：`innodb-buffer-pool-size`、`max-connections`、慢查询、`default-time-zone` 等，按需取消注释。完整列表见官方 `--verbose --help`。
