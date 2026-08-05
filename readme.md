# 归档部署方式

运维脚本与部署经验归档仓库（ADS：Archive Deploy Standard）。

规范正文：[docs/conventions.md](docs/conventions.md)

## 模块

| 目录 | 说明 |
|------|------|
| [bun](bun/) | Bun 安装 |
| [docker](docker/) | Docker 安装（通用脚本 / Ubuntu apt） |
| [gitlab](gitlab/) | GitLab CE Docker Compose 模板与运维入口 |

## 新增模块

```bash
cp -r templates/module <新模块名>
# 编辑 README 与入口脚本，必要时补充 docs/<新模块名>/
# 在上方模块表追加一行
```

脚手架见 [templates/module](templates/module/)。
