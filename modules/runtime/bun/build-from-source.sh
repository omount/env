#!/usr/bin/env bash
set -euo pipefail

# 从源码编译 Bun
# 出处: https://bun.com/docs/project/contributing
#       https://github.com/oven-sh/bun
# 说明: 官方构建流程需要先有一个已发布的 bun 二进制
# 详解: docs/bun/install.md

usage() {
  cat <<'EOF'
用法: ./build-from-source.sh [debug|release]

  debug    默认，执行 bun run build，产物约在 build/debug/
  release  执行 bun run build:release

环境变量:
  BUN_SRC_DIR  源码目录，默认 ./src/bun（相对本脚本目录的上级 bun/src/bun）
EOF
}

mode="${1:-debug}"
case "$mode" in
  -h|--help|help)
    usage
    exit 0
    ;;
  debug|release)
    ;;
  *)
    echo "未知参数: $mode" >&2
    usage >&2
    exit 1
    ;;
esac

ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="${BUN_SRC_DIR:-$ROOT/src/bun}"

if ! command -v bun >/dev/null 2>&1; then
  echo "未检测到 bun，先执行官方安装脚本（构建依赖已发布的 bun）..."
  "$ROOT/install.sh"
  # shellcheck disable=SC1090
  if [[ -f "$HOME/.bun/bin/bun" ]]; then
    export PATH="$HOME/.bun/bin:$PATH"
  fi
fi

if ! command -v bun >/dev/null 2>&1; then
  echo "仍未找到 bun，请先手动安装后再编译" >&2
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "需要 git" >&2
  exit 1
fi

if [[ ! -d "$SRC_DIR/.git" ]]; then
  mkdir -p "$(dirname "$SRC_DIR")"
  echo "克隆 https://github.com/oven-sh/bun.git -> $SRC_DIR"
  git clone --depth 1 https://github.com/oven-sh/bun.git "$SRC_DIR"
fi

cd "$SRC_DIR"
echo "源码目录: $SRC_DIR"
echo "构建模式: $mode（官方: bun run build / bun run build:release）"

if [[ "$mode" == "release" ]]; then
  bun run build:release
else
  bun run build
fi

echo "编译完成。请查看 $SRC_DIR/build/ 下产物，并将对应目录加入 PATH。"
echo "官方文档: https://bun.com/docs/project/contributing"
