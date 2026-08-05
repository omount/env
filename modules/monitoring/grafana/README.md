# Grafana

对照官方 Docker 配置文档的 Compose 模板。

## 官方出处（验收依据）

| 项 | URL |
|----|-----|
| Configure Grafana Docker image | https://grafana.com/docs/grafana/latest/setup-grafana/configure-docker/ |
| 环境变量覆盖配置 | https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#override-configuration-with-environment-variables |
| 官方镜像 | https://hub.docker.com/r/grafana/grafana （tag `11.5.2` 存在于 Docker Hub） |
| 上游仓库 | https://github.com/grafana/grafana |

官方示例使用宿主机 `3000:3000`。本仓库为避开 Open WebUI（已占用 3000），映射为 **`3001:3000`**（仅端口映射差异，环境变量仍按官方 `GF_*` 约定）。

官方文档说明可通过环境变量覆盖配置，例如管理员账号相关使用 `GF_SECURITY_*` 前缀（见官方 Configure Docker 页）。

| 项 | 值 |
|----|-----|
| 镜像 | `grafana/grafana:11.5.2` |
| Web | http://127.0.0.1:3001 |
| 用户 | `admin`（`GF_SECURITY_ADMIN_USER`） |
| 密码 | `123456`（`GF_SECURITY_ADMIN_PASSWORD`，EasyEnv 演示递进） |
| 数据 | `./data` → `/var/lib/grafana`（官方默认路径） |

## 一键运行

```bash
cd modules/monitoring/grafana
docker compose up -d
# 或: ./EasyEnv.sh up grafana
```

浏览器打开 http://127.0.0.1:3001 ，用户 `admin`，密码 `123456` 登录。

### docker run（对照官方习惯写法）

```bash
cd modules/monitoring/grafana
mkdir -p data
docker run -d \
  --name grafana \
  --restart always \
  -e GF_SECURITY_ADMIN_USER=admin \
  -e GF_SECURITY_ADMIN_PASSWORD=123456 \
  -e GF_USERS_ALLOW_SIGN_UP=false \
  -p 3001:3000 \
  -v "$(pwd)/data:/var/lib/grafana" \
  grafana/grafana:11.5.2
```

## 验收

```bash
curl -sI http://127.0.0.1:3001/login
# 浏览器打开 http://127.0.0.1:3001
```

详解：[docs/grafana/README.md](../../../docs/grafana/README.md)
