# phpMyAdmin（对照官方）

模块：[`modules/gui/phpmyadmin/`](../../modules/gui/phpmyadmin/)

## 依据

- https://docs.phpmyadmin.net/en/latest/setup.html#docker
- https://hub.docker.com/_/phpmyadmin

## 差异

| 项 | 说明 |
|----|------|
| 镜像 | 钉死 `phpmyadmin:5.2.3` |
| 端口 | 8082（避 adminer 8081） |
| 主机 | 默认 `host.docker.internal` 连宿主机映射的 MySQL；同网可改 `PMA_HOST=mysql` |
