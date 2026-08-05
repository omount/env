# Redis 官方镜像参数说明（redis:7.4）

对应 Compose：[`redis/docker-compose.yml`](../../modules/database/redis/docker-compose.yml)

## 官方文档

| 文档 | 链接 |
|------|------|
| Docker Hub `redis` | https://hub.docker.com/_/redis |
| docker-library 完整说明 | https://github.com/docker-library/docs/blob/master/redis/README.md |
| 上游仓库 | https://github.com/redis/redis |
| Redis 配置参数 | https://redis.io/docs/latest/operate/oss_and_stack/management/config/ |
| Redis 持久化 | https://redis.io/docs/latest/operate/oss_and_stack/management/persistence/ |
| Redis 安全 / Protected mode | https://redis.io/docs/latest/operate/oss_and_stack/management/security/ |

## 镜像说明（7.4）

- 官方镜像**主要通过** `redis-server` 命令行参数或挂载 `redis.conf` 配置，而不是大量 Docker 环境变量。
- Hub 文档中的 `SKIP_DROP_PRIVS` / `SKIP_FIX_PERMS` 标注为 **8.0.2+**，不适用于本模板的 `redis:7.4`，故未写入 Compose。
- 镜像为便于容器网络，默认关闭 Protected mode；**对公网暴露端口时必须设置密码**（本模板已用 `--requirepass`）。

## 卷

| 挂载 | 作用 |
|------|------|
| `./data` → `/data` | 持久化目录（RDB/AOF）。本模板已启用。 |
| `./conf` → `/usr/local/etc/redis` | 自定义 `redis.conf`；需把 `command` 改为指向该文件。 |

## 常用 `redis-server` 参数

| 参数 | 作用 |
|------|------|
| `--requirepass` | 访问密码（本模板已启用）。 |
| `--appendonly yes` | 开启 AOF 持久化（本模板已启用）。 |
| `--appendfsync` | AOF 刷盘策略：`always` / `everysec` / `no`。 |
| `--save <秒> <次数>` | RDB 快照条件；可配置多条。 |
| `--loglevel` | 日志级别：`debug` / `verbose` / `notice` / `warning`。 |
| `--maxmemory` | 最大内存上限。 |
| `--maxmemory-policy` | 超内存淘汰策略（如 `allkeys-lru`）。 |
| `--databases` | 逻辑库数量（默认 16）。 |
| `--timeout` | 空闲客户端超时秒数（`0` 不超时）。 |
| `--tcp-keepalive` | TCP keepalive 秒数。 |
| `--protected-mode` | 保护模式开关。 |
| `--bind` / `--port` | 监听地址与端口。 |

更多键名以 [Redis 配置文档](https://redis.io/docs/latest/operate/oss_and_stack/management/config/) 为准；Compose 内已按上述项注释示例。
