#!/usr/bin/env bash
set -euo pipefail

# 来源文章: https://www.cnblogs.com/autopwn/p/18706526
# Ubuntu 通过官方 apt 源安装 Docker CE

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || "${1:-}" == "help" ]]; then
  cat <<'EOF'
用法: ./ubuntu-install.sh

在 Ubuntu 上添加 Docker 官方 apt 源并安装:
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
EOF
  exit 0
fi

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
