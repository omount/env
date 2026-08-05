#!/usr/bin/env bash
set -euo pipefail

# 来源: https://github.com/docker/docker-install
# 正式（推荐）: get.docker.com
# 测试通道: ./install.sh --test

usage() {
  cat <<'EOF'
用法: ./install.sh [--test]

  （默认）使用 https://get.docker.com 安装 Docker
  --test     使用 https://test.docker.com 测试通道
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

tmp_script="$(mktemp)"
trap 'rm -f "$tmp_script"' EXIT

curl -fsSL "https://${channel_host}" -o "$tmp_script"
sh "$tmp_script"
