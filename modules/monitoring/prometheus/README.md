# Prometheus v2.55

官方 `prom/prometheus` 单机，默认 scrape 自身。**默认无登录账号**（UI 未开鉴权）。

## 前置条件

- Docker 与 Compose V2
- 宿主机端口 `9090` 空闲

## 一键运行

```bash
cd modules/monitoring/prometheus
docker compose up -d
# 或: ./EasyEnv.sh up prometheus
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `prom/prometheus:v2.55.1` |
| UI / API | http://127.0.0.1:9090 |
| 用户 / 密码 | 无（未启用 `--web.config.file` 等鉴权） |
| 配置文件 | `./prometheus.yml` → `/etc/prometheus/prometheus.yml` |
| 数据卷 | `./data` → `/prometheus` |

## 客户端示例

```bash
curl -s http://127.0.0.1:9090/-/healthy
curl -s "http://127.0.0.1:9090/api/v1/query?query=up"
```

浏览器打开 http://127.0.0.1:9090 → Status → Targets 查看 scrape。

## 验收

```bash
docker compose ps
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:9090/-/healthy
# 期望 200
```

## 说明

- 演示默认对局域网暴露无密码，生产请加反向代理或官方 web 鉴权
- 详解：[docs/prometheus/README.md](../../../docs/prometheus/README.md)

## 官方出处

- 安装：https://prometheus.io/docs/prometheus/latest/installation/
- 上游：https://github.com/prometheus/prometheus
