# Gitea 1.27.1

对照官方 Docker Compose（SQLite 最小可跑）。Web 映射 **3002**（避开 openwebui 3000）。

## 前置条件

- Docker Compose V2
- 端口 `3002`、`2222` 空闲

## 一键运行

```bash
cd modules/git/gitea
docker compose up -d
# 或: ./easyenv.sh up gitea
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `gitea/gitea:1.27.1`（官方文档亦写 `docker.gitea.com/gitea:1.27.1`） |
| Web | http://127.0.0.1:3002 |
| SSH（Git） | `127.0.0.1:2222` |
| 预置管理员 | **无** — 首次打开安装向导自行创建 |
| 数据库 | 默认 SQLite（数据在 `./data`） |
| 数据卷 | `./data` → `/data` |

## 客户端示例

1. 浏览器打开 http://127.0.0.1:3002  
2. 按安装向导完成（SQLite 可直接下一步）  
3. 创建管理员账号（自定用户名/密码，建议演示用 `admin` / `123456`）

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3002/
```

## 验收

```bash
docker compose ps
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3002/
# 期望 200；完成向导后可用自建账号登录
```

## 说明

- 详解：[docs/gitea/README.md](../../../docs/gitea/README.md)
- 官方：https://docs.gitea.com/installation/install-with-docker
- 上游：https://github.com/go-gitea/gitea
