#!/usr/bin/env bash
set -euo pipefail

# 从 Moby 源码构建 Docker Engine（dockerd 等）
# 出处: https://github.com/moby/moby
# 官方二进制安装（非编译）: https://docs.docker.com/engine/install/binaries/
# 详解: docs/docker/install.md
#
# 注意: 日常请优先 ./install.sh 或 Docker Desktop；本脚本面向定制 / 贡献。

usage() {
  cat <<'EOF'
用法: ./build-from-source.sh

克隆 moby/moby 并执行 make binary。
环境变量:
  MOBY_SRC_DIR  源码目录，默认 ./src/moby
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || "${1:-}" == "help" ]]; then
  usage
  exit 0
fi

ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="${MOBY_SRC_DIR:-$ROOT/src/moby}"

if ! command -v git >/dev/null 2>&1; then
  echo "需要 git" >&2
  exit 1
fi

if ! command -v make >/dev/null 2>&1; then
  echo "需要 make（以及 Moby 文档要求的 Go / 构建依赖）" >&2
  exit 1
fi

if [[ ! -d "$SRC_DIR/.git" ]]; then
  mkdir -p "$(dirname "$SRC_DIR")"
  echo "克隆 https://github.com/moby/moby.git -> $SRC_DIR"
  git clone --depth 1 https://github.com/moby/moby.git "$SRC_DIR"
fi

cd "$SRC_DIR"
echo "源码目录: $SRC_DIR"
echo "执行官方构建: make binary"
make binary

echo "编译完成。产物通常在 bundles/ 下，请按 Moby 文档安装/运行。"
echo "官方仓库: https://github.com/moby/moby"
echo "日常部署仍推荐: ./install.sh 或 Docker Desktop（docs/docker/install.md）"
