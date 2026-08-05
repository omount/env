# Gitea（对照官方）

模块：[`modules/git/gitea/`](../../modules/git/gitea/)

## 依据

- https://docs.gitea.com/installation/install-with-docker
- 上游：https://github.com/go-gitea/gitea

## 差异

| 项 | 官方示例 | 本仓库 |
|----|----------|--------|
| 镜像 | `docker.gitea.com/gitea:1.27.1` | Hub 钉死 `gitea/gitea:1.27.1` |
| HTTP | 3000:3000 | **3002:3000**（避 openwebui） |
| SSH | 222:22 | **2222:22** |
| DB | SQLite 最小 / 可 MySQL | 默认 SQLite；MySQL 项在 compose 注释 |
