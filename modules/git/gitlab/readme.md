# GitLab CE（Docker Compose）

单机部署 GitLab CE 的 Compose 模板与常用运维命令。

## 官方出处

- Docker 安装：https://docs.gitlab.com/ee/install/docker/  
- Docker Hub：https://hub.docker.com/r/gitlab/gitlab-ce  
- 上游仓库（Omnibus）：https://gitlab.com/gitlab-org/omnibus-gitlab  
- 产品仓库：https://gitlab.com/gitlab-org/gitlab  

## 前置条件

- 已安装 Docker 与 Compose V2（可用本仓库 `modules/runtime/docker/`）
- 建议内存 ≥ 4GB（生产建议更高）
- 将 `docker-compose.yml` 中的 `YOUR_IP_ADDRESS` 换成实际 IP

## 文件

| 文件 | 说明 |
|------|------|
| `docker-compose.yml` | 镜像钉死 `gitlab/gitlab-ce:18.9.2-ce.0`，HTTP `5401`，SSH `5403` |
| `main.sh` | 运维入口：进容器 / 查初始密码 / 重置 root 密码 |

## 连接信息（部署完成后）

| 项 | 值 |
|----|-----|
| Web | `http://<YOUR_IP_ADDRESS>:5401` |
| 用户 | `root` |
| 密码 | 首次用 `./main.sh show-password` 查看（`initial_root_password`，约 24 小时后文件可能删除） |
| SSH Git | 端口 `5403`（以 compose 为准） |

## 首次部署

```bash
cd modules/git/gitlab
# 或复制本目录到目标机后改 YOUR_IP_ADDRESS
mkdir -p config logs data
docker compose up -d
# 或: ./esayenv.sh up gitlab
docker logs -f gitlab
```

日志出现 `gitlab Reconfigured!`（常见 5～15 分钟）后验收：

```bash
curl -sI http://127.0.0.1:5401/-/readiness
./main.sh show-password   # 或在本仓库 gitlab 目录执行
```

- Web：`http://<IP>:5401`
- 用户：`root`
- 密码：`initial_root_password` 中 `Password:` 后的值（约 24 小时后文件会删除）

## 运维命令

```bash
./main.sh shell            # 进入容器
./main.sh show-password    # 查看初始 root 密码
./main.sh reset-password   # 重置 root 密码（需 reconfigure 已成功）
./main.sh help
```

## 详细文档

端口规则、踩坑与验收清单：[`docs/gitlab/pitfalls.md`](../../../docs/gitlab/pitfalls.md)
