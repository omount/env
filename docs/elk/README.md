# ELK 部署说明（对照官方）

对应模块：[`elk/`](../../modules/monitoring/elk/)

## 验收依据（官方）

1. https://www.elastic.co/guide/en/elasticsearch/reference/8.17/docker.html  
2. https://github.com/elastic/elasticsearch/blob/8.17/docs/reference/setup/install/docker/docker-compose.yml  
3. https://github.com/elastic/elasticsearch/blob/8.17/docs/reference/setup/install/docker/.env  
4. Logstash Docker：https://www.elastic.co/guide/en/logstash/8.17/docker-config.html  
5. Logstash ES output：https://www.elastic.co/guide/en/logstash/8.17/plugins-outputs-elasticsearch.html  

上游仓库：https://github.com/elastic/elasticsearch 、https://github.com/elastic/logstash 、https://github.com/elastic/kibana  

## 本仓库相对官方原文的改动

| 项 | 官方原文 | 本仓库 |
|----|----------|--------|
| 节点数 | es01/es02/es03 | 仅 es01 + `discovery.type=single-node` |
| 版本 | `.env` 中 `STACK_VERSION` | 钉死 `8.17.10` |
| 密码 | `.env` 留空待填 | 演示填入 `123456`（满足官方 ≥6 位字母数字） |
| Logstash | 官方该 Compose **不含** | 按 Logstash Docker 文档增加，并挂载 CA |
| 数据卷 | 官方 named volume | 本仓库 bind `./data/*`（便于归档查看） |

Logstash → ES 输出使用官方现行项 `ssl_enabled` + `ssl_certificate_authorities`（`cacert` 已 Deprecated in 11.14.0）。

未采用「关闭 xpack.security / 关闭 SSL」的非官方捷径。

## 端口

| 服务 | 端口 |
|------|------|
| Elasticsearch HTTPS | 9200 |
| Kibana | 5601 |
| Logstash Beats | 5044 |
