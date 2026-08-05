#!/usr/bin/env bash
set -euo pipefail

CONTAINER="${GITLAB_CONTAINER:-gitlab}"

usage() {
  cat <<'EOF'
用法: ./main.sh <命令>

命令:
  shell            进入 GitLab 容器 bash
  show-password    查看 /etc/gitlab/initial_root_password
  reset-password   重置 root 密码（gitlab-rake）
  help             显示本说明

环境变量:
  GITLAB_CONTAINER  容器名，默认 gitlab
EOF
}

require_docker() {
  if ! command -v docker >/dev/null 2>&1; then
    echo "未找到 docker 命令" >&2
    exit 1
  fi
}

cmd="${1:-help}"

case "$cmd" in
  help|-h|--help)
    usage
    ;;
  shell)
    require_docker
    docker exec -it "$CONTAINER" /bin/bash
    ;;
  show-password)
    require_docker
    docker exec -it "$CONTAINER" cat /etc/gitlab/initial_root_password
    ;;
  reset-password)
    require_docker
    docker exec -it "$CONTAINER" gitlab-rake "gitlab:password:reset[root]"
    ;;
  *)
    echo "未知命令: $cmd" >&2
    usage >&2
    exit 1
    ;;
esac
