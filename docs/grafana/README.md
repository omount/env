# Grafana 部署说明（对照官方）

对应模块：[`grafana/`](../../modules/monitoring/grafana/)

## 验收依据

- https://grafana.com/docs/grafana/latest/setup-grafana/configure-docker/  
- https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#override-configuration-with-environment-variables  
- https://hub.docker.com/r/grafana/grafana/tags?name=11.5.2  
- 上游仓库：https://github.com/grafana/grafana  

## 配置说明

| 项 | 官方 | 本仓库 |
|----|------|--------|
| 镜像名 | `grafana/grafana` | `grafana/grafana:11.5.2`（钉死） |
| 容器端口 | 3000 | 3000 |
| 宿主机端口 | 文档示例常为 3000 | **3001**（避开 openwebui） |
| 管理员 | 可通过 `GF_SECURITY_ADMIN_USER` / `GF_SECURITY_ADMIN_PASSWORD` 设置 | `admin` / `123456` |
| 数据目录 | `/var/lib/grafana` | 绑定 `./data` |

未使用非官方镜像或私有 fork。
