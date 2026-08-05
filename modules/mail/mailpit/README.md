# Mailpit

开发用邮件捕获（非生产 SMTP 中继）。SMTP 收信 + Web 查看；**默认 UI/SMTP 无登录密码**。

## 前置条件

- Docker 与 Compose V2
- 端口 `1025`（SMTP）、`8025`（UI）空闲

## 一键运行

```bash
cd modules/mail/mailpit
docker compose up -d
# 或: ./EasyEnv.sh up mailpit
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `axllent/mailpit:v1.22.3` |
| SMTP | `127.0.0.1:1025`（无加密、默认无 SMTP 认证） |
| Web UI | http://127.0.0.1:8025 |
| UI 用户 / 密码 | 无（可取消注释 `MP_UI_AUTH=admin:123456` 启用） |
| 数据 | `./data` → `/data` |

应用发信示例（Node / 任意 SMTP 客户端）：Host `127.0.0.1`，Port `1025`，无用户密码。

## 客户端示例

```bash
# 打开 UI
# http://127.0.0.1:8025

# 健康（UI）
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8025/
```

启用 UI 基本认证：编辑 compose，取消 `environment` 中 `MP_UI_AUTH` 注释后重建容器，再用 `admin` / `123456` 登录。

## 验收

```bash
docker compose ps
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8025/
# 期望 200
```

## 说明

- 仅开发捕获；详解：[docs/mailpit/README.md](../../../docs/mailpit/README.md)

## 官方出处

- 上游：https://github.com/axllent/mailpit
- Hub：https://hub.docker.com/r/axllent/mailpit
