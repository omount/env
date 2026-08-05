#!/usr/bin/env bash
set -euo pipefail

# 来源: https://bun.sh/

usage() {
  cat <<'EOF'
用法: ./install.sh

按当前环境安装 Bun：
  - Linux / macOS: curl 官方安装脚本
  - Windows (Git Bash/MSYS 等): 调用 PowerShell 官方安装脚本
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || "${1:-}" == "help" ]]; then
  usage
  exit 0
fi

os="$(uname -s 2>/dev/null || echo unknown)"

case "$os" in
  Linux*|Darwin*)
    curl -fsSL https://bun.sh/install | bash
    ;;
  MINGW*|MSYS*|CYGWIN*)
    if ! command -v powershell.exe >/dev/null 2>&1; then
      echo "未找到 powershell.exe，请在 PowerShell 中执行:" >&2
      echo '  irm bun.sh/install.ps1 | iex' >&2
      exit 1
    fi
    powershell.exe -NoProfile -Command "irm bun.sh/install.ps1 | iex"
    ;;
  *)
    echo "无法识别的系统: $os" >&2
    echo "Windows PowerShell 可手动执行: irm bun.sh/install.ps1 | iex" >&2
    echo "macOS/Linux 可手动执行: curl -fsSL https://bun.sh/install | bash" >&2
    exit 1
    ;;
esac
