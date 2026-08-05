# Hoppscotch（对照官方 CE）

模块：[`modules/debug/hoppscotch/`](../../modules/debug/hoppscotch/)

## 依据

- https://docs.hoppscotch.io/documentation/self-host/community-edition/install-and-build

## 差异

| 项 | 官方示例 | 本仓库 |
|----|----------|--------|
| 镜像 | `hoppscotch/hoppscotch` | 钉死 `2026.7.0` |
| 端口 | 3000/3100/3170 | **3300**/3310/3170（避 openwebui） |
| DB | 自备 Postgres | 同目录 `postgres:16.9` |
| env | 无引号 | `.env` 无引号，URL 改为宿主机映射端口 |
