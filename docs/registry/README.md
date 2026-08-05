# Registry（对照官方）

模块：[`modules/registry/registry/`](../../modules/registry/registry/)

## 依据

- https://hub.docker.com/_/registry
- https://distribution.github.io/distribution/

## 差异

| 项 | 说明 |
|----|------|
| 镜像 | 钉死 `registry:2.8.3`（v2 线稳定版） |
| 鉴权 | 默认关闭；生产见官方 htpasswd/TLS |
