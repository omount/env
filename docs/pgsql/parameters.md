# PostgreSQL 官方镜像参数说明（postgres:16）

对应 Compose：[`pgsql/docker-compose.yml`](../../modules/database/pgsql/docker-compose.yml)

## 官方文档

| 文档 | 链接 |
|------|------|
| Docker Hub `postgres` | https://hub.docker.com/_/postgres |
| docker-library 完整说明 | https://github.com/docker-library/docs/blob/master/postgres/README.md |
| 上游仓库 | https://github.com/postgres/postgres |
| PostgreSQL 16 运行时配置 | https://www.postgresql.org/docs/16/runtime-config.html |
| `pg_hba.conf` 认证 | https://www.postgresql.org/docs/16/auth-pg-hba-conf.html |
| `initdb` | https://www.postgresql.org/docs/16/app-initdb.html |

> Docker 专用环境变量**仅在数据目录为空（首次 `initdb`）时生效**。

## 环境变量

| 变量 | 作用 |
|------|------|
| `POSTGRES_PASSWORD` | **必填**（除非 `POSTGRES_HOST_AUTH_METHOD=trust`）。超级用户密码。 |
| `POSTGRES_USER` | 可选。超级用户名，默认 `postgres`；本模板为 `root`。会创建同名角色（及默认库，见下）。 |
| `POSTGRES_DB` | 可选。首次创建的数据库名；默认与 `POSTGRES_USER` 同名。本模板为 `root`。 |
| `POSTGRES_INITDB_ARGS` | 可选。传给 `initdb` 的参数字符串，如 `--data-checksums`。 |
| `POSTGRES_INITDB_WALDIR` | 可选。WAL 目录独立存放路径。 |
| `POSTGRES_HOST_AUTH_METHOD` | 可选。写入 `pg_hba` 的 host 认证方式；14+ 默认偏 `scram-sha-256`；`trust` 极不安全。 |
| `PGDATA` | 数据目录。PG16 默认 `/var/lib/postgresql/data`；修改必须与 volume 一致。 |
| `*_FILE` | 从文件读入。支持：`POSTGRES_PASSWORD`、`POSTGRES_USER`、`POSTGRES_DB`、`POSTGRES_INITDB_ARGS`。 |

## Compose / 卷

| 项 | 作用 |
|----|------|
| `shm_size: 128mb` | 官方 Compose 示例建议；按需在 compose 中取消注释。 |
| `./data/pgdata` → `/var/lib/postgresql/data` | **PG17 及以下容器内必须挂到 `.../data`**，宿主机使用子目录避开 `data/.gitignore`。 |
| `./initdb` → `/docker-entrypoint-initdb.d` | 首次初始化执行 `*.sql` / `*.sql.gz` / `*.sh`。 |
| 自定义 `postgresql.conf` | 挂载后通过 `command: ["postgres", "-c", "config_file=..."]` 启用。 |

## `command`（`-c`）常用项

任意 [`postgresql.conf`](https://www.postgresql.org/docs/16/runtime-config.html) 参数均可：

- `listen_addresses=*` — 允许容器外连接（跨容器访问时常需要）
- `max_connections` — 最大连接数
- `shared_buffers` — 共享缓冲
- `timezone` / `log_timezone` — 时区

Compose 中已注释示例，按需启用。
