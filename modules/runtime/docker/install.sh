#!/usr/bin/env bash
set -euo pipefail

# 官方便捷安装脚本封装（Linux 为主）
# 出处:
#   - 脚本仓库: https://github.com/docker/docker-install
#   - 稳定通道: https://get.docker.com
#   - 测试通道: https://test.docker.com
# Windows / macOS 请安装 Docker Desktop，见 docs/docker/install.md
# 详解: docs/docker/install.md

usage() {
  cat <<'EOF'
用法: ./install.sh [--test]

  （默认）curl https://get.docker.com | sh
  --test     使用 https://test.docker.com

Windows / macOS 不走本脚本，请按 docs/docker/install.md 安装 Docker Desktop。
从源码构建请使用: ./build-from-source.sh
EOF
}

channel_host="get.docker.com"

case "${1:-}" in
  "" )
    ;;
  --test)
    channel_host="test.docker.com"
    ;;
  -h|--help|help)
    usage
    exit 0
    ;;
  *)
    echo "未知参数: $1" >&2
    usage >&2
    exit 1
    ;;
esac

os="$(uname -s 2>/dev/null || echo unknown)"
case "$os" in
  MINGW*|MSYS*|CYGWIN*|Darwin*)
    echo "当前系统为 $os。" >&2
    echo "请使用 Docker Desktop，指引见: docs/docker/install.md" >&2
    exit 1
    ;;
esac

echo "使用官方脚本: https://${channel_host}"
echo "出处: https://github.com/docker/docker-install"
tmp_script="$(mktemp)"
trap 'rm -f "$tmp_script"' EXIT

curl -fsSL "https://${channel_host}" -o "$tmp_script"
sh "$tmp_script"

echo "安装完成。请执行: docker --version && docker compose version"
echo "EsayEnv 推荐用 Docker Compose 部署各中间件模块。"
echo "详解: docs/docker/install.md"
