#!/usr/bin/env bash
set -euo pipefail

# 从源码编译 Node.js
# 出处: https://github.com/nodejs/node#building-nodejs
#       https://github.com/nodejs/node/blob/main/BUILDING.md
# 详解: docs/nodejs/install.md

usage() {
  cat <<'EOF'
用法: ./build-from-source.sh

克隆 nodejs/node 并执行 ./configure && make -j$(nproc)
环境变量:
  NODE_SRC_DIR   源码目录，默认 ./src/node
  NODE_GIT_REF   git 引用，默认 main（可改为 v22.14.0）
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || "${1:-}" == "help" ]]; then
  usage
  exit 0
fi

ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="${NODE_SRC_DIR:-$ROOT/src/node}"
GIT_REF="${NODE_GIT_REF:-main}"

for cmd in git python3 make g++; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "缺少依赖命令: $cmd（详见官方 BUILDING.md）" >&2
    exit 1
  fi
done

if [[ ! -d "$SRC_DIR/.git" ]]; then
  mkdir -p "$(dirname "$SRC_DIR")"
  echo "克隆 https://github.com/nodejs/node.git -> $SRC_DIR"
  git clone --depth 1 --branch "$GIT_REF" https://github.com/nodejs/node.git "$SRC_DIR" \
    || git clone --depth 1 https://github.com/nodejs/node.git "$SRC_DIR"
fi

cd "$SRC_DIR"
echo "源码目录: $SRC_DIR"
./configure
JOBS="$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 2)"
make -j"$JOBS"

echo "编译完成。可执行: $SRC_DIR/out/Release/node --version"
echo "安装到系统（可选）: sudo make install"
echo "官方文档: https://github.com/nodejs/node/blob/main/BUILDING.md"
