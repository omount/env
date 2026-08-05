#!/usr/bin/env bash
set -euo pipefail

# 官方安装脚本封装
# 出处:
#   - 安装说明: https://bun.sh/docs/installation
#   - Linux/macOS: https://bun.sh/install  (curl -fsSL https://bun.sh/install | bash)
#   - Windows:     https://bun.sh/install.ps1  (irm bun.sh/install.ps1 | iex)
#   - 上游仓库: https://github.com/oven-sh/bun
# 详解: docs/bun/install.md

usage() {
  cat <<'EOF'
用法: ./install.sh

按当前环境调用 Bun 官方安装脚本：
  - Linux / macOS: curl -fsSL https://bun.sh/install | bash
  - Windows (Git Bash/MSYS): powershell.exe 执行 irm bun.sh/install.ps1 | iex

从源码编译请使用: ./build-from-source.sh
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || "${1:-}" == "help" ]]; then
  usage
  exit 0
fi

os="$(uname -s 2>/dev/null || echo unknown)"

case "$os" in
  Linux*|Darwin*)
    echo "使用官方脚本: curl -fsSL https://bun.sh/install | bash"
    curl -fsSL https://bun.sh/install | bash
    ;;
  MINGW*|MSYS*|CYGWIN*)
    if ! command -v powershell.exe >/dev/null 2>&1; then
      echo "未找到 powershell.exe，请在 PowerShell 中执行:" >&2
      echo '  irm bun.sh/install.ps1 | iex' >&2
      exit 1
    fi
    echo "使用官方脚本: irm bun.sh/install.ps1 | iex"
    powershell.exe -NoProfile -Command "irm bun.sh/install.ps1 | iex"
    ;;
  *)
    echo "无法识别的系统: $os" >&2
    echo "Linux/macOS: curl -fsSL https://bun.sh/install | bash" >&2
    echo "Windows:     irm bun.sh/install.ps1 | iex" >&2
    exit 1
    ;;
esac

echo "安装完成。请执行: bun --version"
echo "详解文档: docs/bun/install.md"
