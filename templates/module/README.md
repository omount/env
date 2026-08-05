# \<模块名\>

路径建议：`modules/<category>/<name>/`

## 用途

一句话说明本模块解决什么问题。

## 官方出处

- 官方文档：https://…  
- 上游仓库：https://github.com/…  
- 官方镜像页（若适用）：https://…  

## 前置条件

- Docker Compose V2（或安装类所需系统）

## 使用

```bash
# Compose 模块
cd modules/<category>/<name>
docker compose up -d
# 或
./esayenv.sh up <id>

# 安装类
./install.sh
```

## 验收

```bash
# 填写可判定成功的命令
```

## Compose 约定

- 默认最小可跑  
- 可配置项写在 `docker-compose.yml` 注释中（建议值 + 配置方式：environment / command / 挂载 conf）  
- 详见 `docs/conventions.md` 第 5.1 节  

## 详细文档

长文见 `docs/<模块名>/`（如有）。记得在根 `catalog.yml` 登记。
