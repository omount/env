# Docker

安装 Docker Engine / Compose 插件。

## 前置条件

- `install.sh`：需 root/sudo，适用于官方便捷脚本支持的发行版
- `ubuntu-install.sh`：仅 Ubuntu，通过 Docker 官方 apt 源安装

## 使用

通用安装（推荐）：

```bash
cd docker
./install.sh
# 测试通道: ./install.sh --test
```

Ubuntu 官方源安装：

```bash
cd docker
./ubuntu-install.sh
```

## 验收

```bash
docker --version
docker compose version
```

## 说明

- `install.sh` 来源：https://github.com/docker/docker-install
- `ubuntu-install.sh` 参考：https://www.cnblogs.com/autopwn/p/18706526
