#!/usr/bin/env bash
set -euo pipefail

# Ubuntu：按 Docker 官方 apt 源安装 Engine + Compose 插件
# 出处: https://docs.docker.com/engine/install/ubuntu/
# 详解: docs/docker/install.md

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || "${1:-}" == "help" ]]; then
  cat <<'EOF'
用法: ./ubuntu-install.sh

按官方文档在 Ubuntu 上安装:
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

官方步骤: https://docs.docker.com/engine/install/ubuntu/
EOF
  exit 0
fi

echo "出处: https://docs.docker.com/engine/install/ubuntu/"

# 更新包索引并安装依赖
sudo apt update
sudo apt install -y ca-certificates curl gnupg

# 添加 Docker 官方 GPG 密钥
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# 添加 Docker 官方仓库
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 更新包索引并安装 Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "安装完成。可执行: docker --version && docker compose version"
echo "EasyEnv 推荐用 Docker Compose 部署各中间件模块。"
