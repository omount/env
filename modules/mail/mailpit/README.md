# Mailpit

官方 Mailpit 开发邮件捕获。SMTP `1025`，UI http://127.0.0.1:8025

## 运行

```bash
cd modules/mail/mailpit && docker compose up -d
```

## 验收

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8025/
# 期望 200
```

## 官方

- [docs/mailpit/README.md](../../../docs/mailpit/README.md)
- https://github.com/axllent/mailpit
