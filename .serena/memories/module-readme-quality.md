# 缺陷归档：模块 README 不得「过低信息量」

## 问题
曾出现仅写「官方镜像 + up -d + 官方链接」，缺少账号密码、连接方式、客户端示例、端口与数据卷说明（如早期 rabbitmq README）。

## 强制结构（Compose 模块 README）
1. 标题 + 一句话用途
2. 前置条件（Docker、端口）
3. 一键运行（`cd modules/...` 与 `./EasyEnv.sh up <id>`）
4. **连接信息表**（镜像、主机、端口、用户、密码/无认证说明、数据卷、管理台 URL）
5. **客户端/调用示例**（至少一条可复制命令或连接串）
6. 验收命令
7. 说明（演示口令、生产勿用、附属文件）
8. 官方文档 + 上游仓库 + `docs/<module>/`

安装类（bun/nodejs/docker）不强制连接信息表，但须步骤与验收清晰。

## 参考
现有高质量样板：`modules/database/mysql/README.md`
脚手架：`templates/module/README.md`
规范：`docs/conventions.md` 模块 README 必备节
