# MongoDB（对照官方）

对应模块：[`modules/database/mongodb/`](../../modules/database/mongodb/)

## 验收依据

- https://hub.docker.com/_/mongo
- 上游：https://github.com/mongodb/mongo

## 相对官方

| 项 | 官方 | 本仓库 |
|----|------|--------|
| 镜像 | `mongo` | 钉死 `mongo:7.0.16` |
| 认证 | `MONGO_INITDB_ROOT_*` | root / 123456 |
| 数据 | `/data/db` | `./data/db`，宿主机使用子目录避开 `data/.gitignore` |
