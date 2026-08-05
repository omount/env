#!/usr/bin/env bash
set -euo pipefail

# Node.js 安装（经 nvm 官方安装脚本，再 nvm install --lts）
# 出处（验收依据）:
#   - nvm README Install: https://github.com/nvm-sh/nvm#install--update-script
#     curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh | bash
#   - nvm 安装 LTS: nvm install --lts （见 nvm README「Usage」）
#   - Node.js 官网下载: https://nodejs.org/en/download
#   - 上游仓库: https://github.com/nodejs/node
# 详解: docs/nodejs/install.md

usage() {
  cat <<'EOF'
用法: ./install.sh

1) 使用 nvm 官方 install.sh（版本钉死 v0.40.6，与 nvm README 一致）
2) 执行: nvm install --lts && nvm alias default 'lts/*'

环境变量:
  NVM_VERSION   默认 v0.40.6

从源码编译请使用: ./build-from-source.sh
Windows 请用官网安装包或 nvm-windows（见 docs/nodejs/install.md）
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || "${1:-}" == "help" ]]; then
  usage
  exit 0
fi

NVM_VERSION="${NVM_VERSION:-v0.40.6}"
# 与 nvm README 一致使用 curl -o-
NVM_INSTALL_URL="https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh"

os="$(uname -s 2>/dev/null || echo unknown)"
case "$os" in
  MINGW*|MSYS*|CYGWIN*)
    echo "Windows 不在本脚本范围。请按官方说明:" >&2
    echo "  Node.js 安装包: https://nodejs.org/en/download" >&2
    echo "  nvm-windows: https://github.com/coreybutler/nvm-windows" >&2
    exit 1
    ;;
esac

if [[ ! -s "${NVM_DIR:-$HOME/.nvm}/nvm.sh" ]]; then
  echo "使用 nvm 官方脚本: curl -o- ${NVM_INSTALL_URL} | bash"
  curl -o- "$NVM_INSTALL_URL" | bash
fi

# shellcheck disable=SC1090
. "${NVM_DIR:-$HOME/.nvm}/nvm.sh"

echo "执行官方用法: nvm install --lts"
nvm install --lts
nvm alias default 'lts/*'
nvm use default

echo "安装完成:"
node --version
npm --version
echo "详解: docs/nodejs/install.md"
