# Docker 安装与部署指引

模块目录：[`docker/`](../../modules/runtime/docker/)

## EsayEnv 推荐

**优先使用 Docker（及 Compose）部署本仓库中的 mysql / redis / pgsql / minio / openwebui / gitlab 等组件。**  
装好 Docker 后，进入对应模块执行 `docker compose up -d` 即可，避免在宿主机直接编译安装各中间件。

| 平台 | 推荐方式 | 说明 |
|------|----------|------|
| **Windows** | Docker Desktop | 官方图形安装，自带 Engine + Compose |
| **macOS** | Docker Desktop | Apple Silicon / Intel 分别下载 |
| **Linux** | 官方 `get.docker.com` 脚本或发行版 apt/yum 源 | 服务器最常见 |

---

## 官方出处

| 项 | 链接 |
|----|------|
| Docker Engine 安装总览 | https://docs.docker.com/engine/install/ |
| 便捷安装脚本仓库 | https://github.com/docker/docker-install |
| 稳定通道脚本 | https://get.docker.com |
| 测试通道脚本 | https://test.docker.com |
| Ubuntu 官方源安装 | https://docs.docker.com/engine/install/ubuntu/ |
| Docker Desktop Windows | https://docs.docker.com/desktop/setup/install/windows-install/ |
| Docker Desktop macOS | https://docs.docker.com/desktop/setup/install/mac-install/ |
| 静态二进制 | https://docs.docker.com/engine/install/binaries/ |
| 从源码构建（Moby） | https://github.com/moby/moby |

---

## Windows

1. 打开官方文档：https://docs.docker.com/desktop/setup/install/windows-install/  
2. 下载并安装 **Docker Desktop for Windows**  
3. 启用 WSL 2（按安装向导）  
4. 验收：

```powershell
docker --version
docker compose version
```

PowerShell 也可用官方包管理（若环境已配置 winget）：

```powershell
winget install Docker.DockerDesktop
```

装好后，用 PowerShell / Git Bash 进入本仓库各模块执行 `docker compose up -d`。

---

## macOS

1. 文档：https://docs.docker.com/desktop/setup/install/mac-install/  
2. 下载对应芯片的 `Docker.dmg`：  
   - Apple silicon：https://desktop.docker.com/mac/main/arm64/Docker.dmg  
   - Intel：https://desktop.docker.com/mac/main/amd64/Docker.dmg  
3. 将 Docker 拖入「应用程序」并启动  
4. 验收：`docker --version && docker compose version`

命令行安装示例（下载 dmg 后）：

```bash
sudo hdiutil attach Docker.dmg
sudo /Volumes/Docker/Docker.app/Contents/MacOS/install
sudo hdiutil detach /Volumes/Docker
```

---

## Linux

### A. 官方便捷脚本（推荐，本仓库封装）

出处：https://github.com/docker/docker-install → https://get.docker.com

```bash
cd docker
./install.sh
# 测试通道: ./install.sh --test
```

等价：

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

### B. Ubuntu 官方 apt 源（本仓库封装）

官方步骤：https://docs.docker.com/engine/install/ubuntu/

```bash
cd docker
./ubuntu-install.sh
```

### C. 其他发行版

按 https://docs.docker.com/engine/install/ 选择 CentOS / Debian / Fedora / RHEL 等页面操作。

非 root 使用：

```bash
sudo usermod -aG docker "$USER"
# 重新登录后生效
```

---

## 从源码 / 二进制编译安装

### 静态二进制（官方提供，非完整自行编译）

https://docs.docker.com/engine/install/binaries/

适合无法用包管理器时手动放置 `dockerd` / `docker` 二进制。

### 从 Moby 源码构建

出处：https://github.com/moby/moby  

本仓库封装：[`docker/build-from-source.sh`](../../modules/runtime/docker/build-from-source.sh)

```bash
cd docker
./build-from-source.sh
```

脚本会克隆 `moby/moby` 并执行官方 `make binary`（需本机已有 Docker 或完整 Go 构建环境；详见 Moby 仓库 README）。  
**日常部署请优先用官方脚本或 Desktop，源码构建仅用于定制 / 贡献。**

---

## 用 Docker 部署 EsayEnv 组件（推荐路径）

```bash
# 确认 Docker 可用
docker --version
docker compose version

# 示例：拉起数据库与对象存储
cd mysql && docker compose up -d
cd ../redis && docker compose up -d
cd ../pgsql && docker compose up -d
cd ../minio && docker compose up -d
```

各模块 `README.md` 含端口、账号与验收命令。
