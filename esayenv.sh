#!/usr/bin/env bash
set -euo pipefail

# EsayEnv CLI — 从 catalog.yml 解析模块并 docker compose up/down
# Windows: Git Bash / WSL

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CATALOG="${ROOT}/catalog.yml"

usage() {
  cat <<'EOF'
用法: ./esayenv.sh <list|up|down|path> [module_id]

  list           列出 catalog.yml 中全部模块
  up <id>        在模块目录执行 docker compose up -d
  down <id>      在模块目录执行 docker compose down
  path <id>      打印模块相对路径

示例:
  ./esayenv.sh list
  ./esayenv.sh up mysql
  ./esayenv.sh down redis
EOF
}

# 解析: 在匹配 id 的块内取 path 字段（扁平 - id: 块）
module_field() {
  local id="$1"
  local field="$2"
  awk -v id="$id" -v field="$field" '
    $0 ~ /^- id:[[:space:]]*/ {
      cur = $0
      sub(/^- id:[[:space:]]*/, "", cur)
      gsub(/[[:space:]]+$/, "", cur)
      inblock = (cur == id)
      next
    }
    inblock && $0 ~ ("^[[:space:]]*" field ":[[:space:]]*") {
      line = $0
      sub("^[[:space:]]*" field ":[[:space:]]*", "", line)
      gsub(/^["'\'']|["'\'']$/, "", line)
      print line
      exit
    }
  ' "$CATALOG"
}

cmd_list() {
  printf "%-14s %-12s %-40s %s\n" "ID" "CATEGORY" "PATH" "STATUS"
  printf "%-14s %-12s %-40s %s\n" "--------------" "------------" "----------------------------------------" "------"
  local id category path status
  while IFS= read -r id; do
    [[ -z "$id" ]] && continue
    category="$(module_field "$id" category)"
    path="$(module_field "$id" path)"
    status="$(module_field "$id" status)"
    printf "%-14s %-12s %-40s %s\n" "$id" "$category" "$path" "$status"
  done < <(awk '/^- id:[[:space:]]*/ { sub(/^- id:[[:space:]]*/,""); gsub(/[[:space:]]+$/,""); print }' "$CATALOG")
}

require_compose_module() {
  local id="$1"
  local path
  path="$(module_field "$id" path)"
  if [[ -z "$path" ]]; then
    echo "未知模块: $id（请先 ./esayenv.sh list）" >&2
    exit 1
  fi
  local abs="${ROOT}/${path}"
  if [[ ! -f "${abs}/docker-compose.yml" ]]; then
    echo "模块 ${id} 无 docker-compose.yml: ${path}" >&2
    echo "（runtime 类请进入目录执行 install.sh）" >&2
    exit 1
  fi
  echo "$abs"
}

cmd_up() {
  local abs
  abs="$(require_compose_module "$1")"
  (cd "$abs" && docker compose up -d)
}

cmd_down() {
  local abs
  abs="$(require_compose_module "$1")"
  (cd "$abs" && docker compose down)
}

cmd_path() {
  local path
  path="$(module_field "$1" path)"
  if [[ -z "$path" ]]; then
    echo "未知模块: $1" >&2
    exit 1
  fi
  echo "$path"
}

main() {
  if [[ ! -f "$CATALOG" ]]; then
    echo "缺少 catalog.yml: $CATALOG" >&2
    exit 1
  fi
  local op="${1:-}"
  case "$op" in
    list) cmd_list ;;
    up)
      [[ $# -ge 2 ]] || { usage; exit 1; }
      cmd_up "$2"
      ;;
    down)
      [[ $# -ge 2 ]] || { usage; exit 1; }
      cmd_down "$2"
      ;;
    path)
      [[ $# -ge 2 ]] || { usage; exit 1; }
      cmd_path "$2"
      ;;
    -h|--help|help|"") usage ;;
    *)
      echo "未知命令: $op" >&2
      usage
      exit 1
      ;;
  esac
}

main "$@"
