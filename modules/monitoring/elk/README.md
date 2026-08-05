# ELK（Elasticsearch + Logstash + Kibana）

基于 **Elastic 官方 Docker / Compose 文档** 整理的单节点归档模板（非自创安全关闭方案）。

## 官方出处（验收依据）

| 文档 | URL |
|------|-----|
| Elasticsearch Docker（含 Compose） | https://www.elastic.co/guide/en/elasticsearch/reference/8.17/docker.html |
| 官方 `docker-compose.yml`（8.17 分支） | https://github.com/elastic/elasticsearch/blob/8.17/docs/reference/setup/install/docker/docker-compose.yml |
| 官方 `.env` | https://github.com/elastic/elasticsearch/blob/8.17/docs/reference/setup/install/docker/.env |
| Logstash Docker 配置 | https://www.elastic.co/guide/en/logstash/8.17/docker-config.html |
| Logstash ES output 插件 | https://www.elastic.co/guide/en/logstash/8.17/plugins-outputs-elasticsearch.html |
| 上游仓库 Elasticsearch | https://github.com/elastic/elasticsearch |
| 上游仓库 Logstash | https://github.com/elastic/logstash |
| 上游仓库 Kibana | https://github.com/elastic/kibana |

与官方三节点示例的差异（仅资源裁剪，安全模型保持官方）：

- 仅保留 `es01` 单节点（`discovery.type=single-node`）
- 增加 Logstash（官方 Compose 原文不含 Logstash，按 Logstash Docker 文档挂载 `pipeline/`）
- Logstash → ES 使用官方现行项 `ssl_enabled` + `ssl_certificate_authorities`（`cacert` 已 Deprecated）

## 版本与凭据

| 项 | 值 |
|----|-----|
| `STACK_VERSION` | `8.17.10`（与官方 8.17 Docker 页 `docker pull ...:8.17.10` 一致） |
| `elastic` | `123456`（官方：至少 6 位字母数字） |
| `kibana_system`（Kibana 连 ES） | `123456`（`KIBANA_PASSWORD`） |
| Kibana 登录用户 | `elastic` / `123456`（官方 Compose 文档登录说明） |

## 前置

- Docker Desktop / Linux：建议内存 ≥ 4GB（官方 Docker 文档要求）
- Linux 若 ES 无法启动：`vm.max_map_count=262144`（官方生产建议常见项）

## 一键运行

```bash
cd modules/monitoring/elk
mkdir -p data/elasticsearch data/kibana data/logstash
docker compose up -d
# 或: ./EasyEnv.sh up elk
```

## 客户端示例

```bash
# HTTPS + CA（证书在 named volume certs 内；容器内探测）
docker compose exec es01 curl -s --cacert config/certs/ca/ca.crt -u elastic:123456 https://localhost:9200

# Kibana：浏览器 http://127.0.0.1:5601
# 用户 elastic / 密码 123456
```

停止：`docker compose down`（官方：数据在 volume/绑定目录中保留）

## 说明

- 演示口令仅供归档，禁止直接用于生产  
- 详解：[docs/elk/README.md](../../../docs/elk/README.md)
