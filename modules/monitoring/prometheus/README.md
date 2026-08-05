# Prometheus v2.55

官方 `prom/prometheus` 单机，自监控。UI: http://127.0.0.1:9090

## 运行

```bash
cd modules/monitoring/prometheus && docker compose up -d
```

## 验收

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:9090/-/healthy
# 期望 200
```

## 官方

- [docs/prometheus/README.md](../../../docs/prometheus/README.md)
- https://prometheus.io/docs/prometheus/latest/installation/
- https://github.com/prometheus/prometheus
