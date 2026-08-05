# Prometheus（对照官方）

模块：[`modules/monitoring/prometheus/`](../../modules/monitoring/prometheus/)

## 依据

- https://prometheus.io/docs/prometheus/latest/installation/
- https://prometheus.io/docs/prometheus/latest/configuration/configuration/
- 上游：https://github.com/prometheus/prometheus

## 差异

| 项 | 说明 |
|----|------|
| 镜像 | 钉死 `prom/prometheus:v2.55.1` |
| 配置 | 最小自监控 `prometheus.yml` |
