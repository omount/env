# Nacos 部署说明（对照官方）

对应模块：[`nacos/`](../../modules/discovery/nacos/)

## 验收依据（官方）

1. https://github.com/nacos-group/nacos-docker  
2. https://github.com/nacos-group/nacos-docker/blob/master/example/standalone-derby.yaml  
3. https://github.com/nacos-group/nacos-docker/blob/master/example/.env （`NACOS_VERSION=v3.2.3`）  
4. 上游仓库：https://github.com/alibaba/nacos  
5. 单机部署说明：https://nacos.io/docs/latest/manual/admin/deployment/deployment-standalone/  

## 本仓库相对官方原文的改动

| 项 | 官方原文 | 本仓库 |
|----|----------|--------|
| 镜像 tag | `example/.env` 中 `v3.2.3` | 钉死 `nacos/nacos-server:v3.2.3` |
| Compose 内容 | 含 prometheus / grafana | **仅 Nacos**（Grafana 见本仓库 `grafana/`） |
| 卷 | 仅挂 logs | 增加 `./data/data` → `/home/nacos/data` |
| `NACOS_AUTH_*` | 官方示例固定值 | 原样采用（演示） |

## 端口

| 用途 | 端口 |
|------|------|
| 控制台 | 8080 |
| 主端口 | 8848 |
| gRPC | 9848 |

## 账号

控制台默认 `nacos` / `nacos`（官方默认）。`NACOS_AUTH_TOKEN` 等为服务端身份密钥，不是登录密码。
