# File Browser v2.32.3

对照官方 Docker 安装。**用户 `admin`，密码见首次 `docker logs`（随机，只打印一次）**。

> 上游已宣布归档（2026），本模块仅本地演示；勿对公网暴露。

## 前置

- Docker Compose V2；端口 `8084` 空闲

## 运行

```bash
cd modules/files/filebrowser
docker compose up -d
docker logs filebrowser 2>&1 | findstr /i password
# Linux/macOS: docker logs filebrowser 2>&1 | grep -i password
# 或: ./easyenv.sh up filebrowser
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `filebrowser/filebrowser:v2.32.3` |
| URL | http://127.0.0.1:8084 |
| 用户 | `admin` |
| 密码 | **日志随机生成**（非固定 `admin`） |
| 文件根 | `./srv` → `/srv` |
| 数据库 | `./data` → `/database` |

### 忘记密码

```bash
docker compose run --rm filebrowser users update admin --password '123456'
```

## 验收

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8084/
# 期望 200；用日志密码登录
```

## 官方

- [docs/filebrowser/README.md](../../../docs/filebrowser/README.md)
- https://github.com/filebrowser/filebrowser/blob/master/www/docs/installation.md
