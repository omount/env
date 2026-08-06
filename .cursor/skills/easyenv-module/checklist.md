# EasyEnv 模块验收清单

与 [`docs/conventions.md`](../../../docs/conventions.md) 对照使用。

## 文件

- [ ] `modules/<category>/<name>/docker-compose.yml` 或 `install.sh`
- [ ] `modules/<category>/<name>/README.md`（§3.1 全节）
- [ ] `data/.gitignore`（`*` + `!.gitignore`，若有持久卷）
- [ ] `docs/<name>/README.md`（官方对照与本仓差异）
- [ ] `catalog.yml` 已追加
- [ ] 根 `README.md` 分类表已更新

## Compose

- [ ] 镜像 tag 钉死；Hub/官方可查
- [ ] 文件头含官方文档、上游、镜像页、`docs/` 路径
- [ ] 最小可跑；可配置项注释含建议值与 `[environment|command|挂载]`
- [ ] 无空 `environment:` / `ports:` / `volumes:` / `command:` / `networks:` 键
- [ ] 宿主机端口不与上表冲突；README / catalog 一致
- [ ] `docker compose config -q` 通过

## README

- [ ] 连接信息表含用户/密码或明确「无认证」
- [ ] 至少一条客户端示例
- [ ] 验收命令可判定成功
- [ ] 演示口令声明禁止用于生产
- [ ] 官方文档 + 上游仓库（或注明无公开源码仓）

## 运行时安装模块（bun / nodejs / docker）

- [ ] 官方脚本 URL + 本仓封装 `install.sh`
- [ ] 另有编译/源码方案脚本 + `docs/<name>/install.md`

## 本地冒烟

- [ ] `up -d` 成功
- [ ] 验收命令通过（含特殊首次步骤）
- [ ] `down` 释放端口
