# Docker

安装 Docker Engine / Desktop，并**推荐用 Docker Compose 部署 EsayEnv 各中间件**。

## 官方出处

- Engine：https://docs.docker.com/engine/install/  
- 便捷脚本：https://get.docker.com （仓库 https://github.com/docker/docker-install）  
- Desktop Windows：https://docs.docker.com/desktop/setup/install/windows-install/  
- Desktop macOS：https://docs.docker.com/desktop/setup/install/mac-install/  
- Ubuntu：https://docs.docker.com/engine/install/ubuntu/  
- 源码（Moby）：https://github.com/moby/moby  

详解（含 Win / Linux / macOS）：[docs/docker/install.md](../docs/docker/install.md)

## 按平台

| 平台 | 做法 |
|------|------|
| Windows | 安装 Docker Desktop（见详解文档） |
| macOS | 安装 Docker Desktop（见详解文档） |
| Linux | `./install.sh` 或 `./ubuntu-install.sh` |

```bash
cd docker
./install.sh                 # Linux：get.docker.com
./ubuntu-install.sh          # Ubuntu 官方 apt 源
./build-from-source.sh       # Moby 源码构建（可选）
```

## 验收

```bash
docker --version
docker compose version
```

## 推荐部署方式

装好 Docker 后，进入 `mysql/`、`redis/`、`pgsql/`、`minio/` 等目录执行：

```bash
docker compose up -d
```
