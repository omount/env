# phpMyAdmin 5.2.3

连本仓 **MySQL**（`modules/database/mysql`，root/`123456`）。PMA 本身无独立账号。

## 前置

- 先启动 MySQL：`./easyenv.sh up mysql`
- 端口 `8082` 空闲

## 运行

```bash
cd modules/gui/phpmyadmin
docker compose up -d
# 或: ./easyenv.sh up phpmyadmin
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `phpmyadmin:5.2.3` |
| URL | http://127.0.0.1:8082 |
| PMA 登录 | 使用 **MySQL** 账号 |
| 演示 MySQL | host=`host.docker.internal` port=`3306` user=`root` password=`123456` |
| 无独立认证 | phpMyAdmin 登录即数据库账号 |

## 客户端示例

浏览器打开 http://127.0.0.1:8082 ，服务器已预填 `host.docker.internal`，用户 `root` / `123456`。

## 验收

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8082/
# 期望 200；再登录 MySQL
```

## 官方

- [docs/phpmyadmin/README.md](../../../docs/phpmyadmin/README.md)
- https://docs.phpmyadmin.net/en/latest/setup.html#docker
- https://hub.docker.com/_/phpmyadmin
