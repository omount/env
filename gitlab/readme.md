# GitLab CE Docker 部署模板与踩坑指南

适用环境：单机 Docker Compose 部署 GitLab CE（示例主机 `45.253.245.36`，HTTP `5401`，SSH `5403`）。  
镜像版本：`gitlab/gitlab-ce:18.9.2-ce.0`（钉死小版本，禁止生产直接用 `:latest`）。

目录约定：`/opt/gitlab/{docker-compose.yml,config,logs,data}`

---

## 1. 最终 docker-compose.yml

```yaml
services:
  gitlab:
    image: gitlab/gitlab-ce:18.9.2-ce.0
    container_name: gitlab
    restart: always
    hostname: '45.253.245.36'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://45.253.245.36:5401'
        gitlab_rails['gitlab_shell_ssh_port'] = 5403
        gitlab_rails['time_zone'] = 'Asia/Shanghai'
        # 不要写 initial_root_password；让 GitLab 自动生成强密码
        # 不要写 grafana['enable']（18.x 已移除，写了会 reconfigure 失败）
    ports:
      - '5401:5401'
      - '5403:22'
    volumes:
      - './config:/etc/gitlab'
      - './logs:/var/log/gitlab'
      - './data:/var/opt/gitlab'
    shm_size: '256m'
```

### 首次安装命令

```bash
cd /opt/gitlab
mkdir -p config logs data
# 将上面内容写入 docker-compose.yml 后：
docker compose up -d
docker logs -f gitlab
```

等到日志出现 `gitlab Reconfigured!`（首次通常 5～15 分钟），再验收：

```bash
curl -sI http://127.0.0.1:5401/-/readiness
docker exec -it gitlab cat /etc/gitlab/initial_root_password
```

- Web：`http://45.253.245.36:5401`
- 用户：`root`
- 密码：`initial_root_password` 文件中 `Password:` 后的值（约 24 小时后文件会被删除，尽快登录并改密）

### 干净重装（数据可丢时）

```bash
cd /opt/gitlab
docker compose down
rm -rf ./config/* ./data/* ./logs/*
docker compose up -d
docker logs -f gitlab
```

---

## 2. 端口与 URL 对应关系（官方规则）

| 用途 | external_url / 配置 | 宿主机映射 | 说明 |
|------|---------------------|------------|------|
| HTTP | `http://IP:5401` | `5401:5401` | URL 带非标准端口时，容器内 nginx 也监听该端口 |
| SSH Git | `gitlab_shell_ssh_port = 5403` | `5403:22` | 容器内 SSH 仍是 22，对外是 5403 |
| HTTPS | 未启用则不要映射 443 | — | 纯 HTTP 时映射 443 无意义 |

错误示例（会导致连不上或 reset）：

```yaml
# 错误：URL 是 :5401，却映射到容器 80
ports:
  - '5401:80'
```

正确：

```yaml
ports:
  - '5401:5401'
```

若坚持 `5401:80`，必须额外配置：

```ruby
external_url 'http://45.253.245.36:5401'
nginx['listen_port'] = 80
nginx['listen_https'] = false
```

推荐直接用 `5401:5401`，少一层坑。

---

## 3. 踩坑指南（本次实战）

### 坑 1：`grafana['enable'] = false` 导致无限重启

**现象**

```text
Mixlib::Config::UnknownConfigOptionError: Reading unsupported config value grafana.
RestartCount 上千
容器内存只有几十 MB，CPU 很高
```

**原因**  
GitLab 18.x Omnibus 已移除 Grafana，该配置项非法，`gitlab-ctl reconfigure` 直接失败，容器反复重启。

**处理**  
删除所有 `grafana[...]` 配置。监控精简只用：

```ruby
prometheus_monitoring['enable'] = false
```

---

### 坑 2：PostgreSQL 大版本倒挂（17 → 16）

**现象**

```text
VERSION: postgres 17.10  →  被改成 16.11
PG::ConnectionBad: Connection refused (.../.s.PGSQL.5432)
```

**原因**  
先用 `:latest`（或更新镜像）初始化出 **PG17** 数据目录，再换成 `18.9.2-ce.0`（自带 **PG16**）。官方不支持 PostgreSQL 降级。

**处理**

1. 无重要数据：清空 `config/` `data/` `logs/` 后用固定版本重装。
2. 有重要数据：改用仍支持该 PG 大版本的 GitLab 镜像，或从该版本备份恢复；不能指望 16 打开 17 的数据目录。

**预防**  
生产钉死镜像 tag，不要在 `latest` 与固定版之间来回切换。

---

### 坑 3：初始 root 密码太弱 / 含用户名

**现象**

```text
Could not create the default administrator account:
--> Password must not contain commonly used combinations of words and letters
```

**原因**

- `12345678` 等弱口令被拒绝
- 手写密码含 `root` / `gitlab` / `password` 等常见词也可能被拒
- 管理员 seed 失败 → 整个 reconfigure 失败

**处理（官方推荐）**

- **不要**设置 `gitlab_rails['initial_root_password']`
- 让 GitLab 自动生成，安装成功后读取：

```bash
docker exec -it gitlab cat /etc/gitlab/initial_root_password
```

若必须手写，用足够随机的密码（避免用户名、常见词、纯数字）。

---

### 坑 4：改密码后不清空数据，继续失败

**现象**  
compose 已改强密码，日志仍报弱密码 / 管理员创建失败。

**原因**

- `initial_root_password` 主要在**首次**空数据安装时生效
- `./config` / `./data` 里已有半成品 seed，状态不一致

**处理**  
确认无保留数据后：

```bash
docker compose down
rm -rf ./config/* ./data/* ./logs/*
docker compose up -d
```

---

### 坑 5：`docker compose` 参数写错

```bash
# 错误
docker compose up -d --forcerecreate

# 正确
docker compose up -d --force-recreate
```

Compose V2 不需要 `version: "3.9"` 字段，可省略。

---

### 坑 6：过早 curl / 误判挂了

**现象**

```text
curl: (56) Recv failure: 连接被对方重置
STATUS: Up 5 seconds (health: starting)
```

**原因**  
Omnibus 还在 `reconfigure` / 起 Puma，端口已映射但应用未 ready。

**处理**  
盯日志到 `Reconfigured!`，再用：

```bash
curl -sI http://127.0.0.1:5401/-/readiness
```

返回 200 再访问 Web。

---

### 坑 7：可忽略的噪音日志

```text
/proc/sys/fs/file-max: Read-only file system
```

Docker 容器内无法写宿主机 sysctl，官方场景常见，一般可忽略。

```text
ss: command not found
```

部分精简镜像无 `ss`，用 `curl` 探活即可，不代表 GitLab 未启动。

---

### 坑 8：密码文件不存在 / rake 报 rails-rc

**现象**

```text
grep: /etc/gitlab/initial_root_password: No such file or directory
could not load /opt/gitlab/etc/gitlab-rails-rc
```

**原因**  
reconfigure 从未成功，GitLab 未完成初始化。

**处理**  
先解决 reconfigure 失败根因（grafana / PG 版本 / 弱密码），不要先重置密码。

成功后再：

```bash
docker exec -it gitlab gitlab-rake "gitlab:password:reset[root]"
```

---

### 坑 9：低配精简配置写错 key

若以后要在小内存机关监控，注意 18.x 字段名：

| 错误 | 正确 / 说明 |
|------|-------------|
| `grafana['enable']` | 已删除，禁止写 |
| `pages['enable']` | 用 `gitlab_pages['enable']` |
| `prometheus_monitoring['enable'] = false` | 可用，关闭内置监控 |

小内存示例（本机若 ≥8GB 不必强行加）：

```ruby
puma['worker_processes'] = 0
sidekiq['concurrency'] = 5
prometheus_monitoring['enable'] = false
gitlab_kas['enable'] = false
registry['enable'] = false
gitlab_pages['enable'] = false
mattermost['enable'] = false
```

---

## 4. 验收清单

- [ ] `docker ps` 中 gitlab 状态为 `Up`，且 `RestartCount` 不再狂涨
- [ ] 日志有 `gitlab Reconfigured!`
- [ ] `curl -sI http://127.0.0.1:5401/-/readiness` 为 200
- [ ] 能打开 `http://45.253.245.36:5401` 并 root 登录
- [ ] SSH clone 使用端口 5403（clone URL 中带 `:5403`）
- [ ] 已修改默认 root 密码；需要时备份 `config/gitlab-secrets.json` 与整机 data

---

## 5. 常用运维命令

```bash
# 日志
docker logs -f gitlab --tail 200

# 状态
docker exec -it gitlab gitlab-ctl status

# 重新应用配置（改 OMNIBUS_CONFIG 或 gitlab.rb 后）
docker exec -it gitlab gitlab-ctl reconfigure

# 健康
curl -sI http://127.0.0.1:5401/-/health
curl -sI http://127.0.0.1:5401/-/readiness

# 重置 root 密码（仅在 reconfigure 成功后）
docker exec -it gitlab gitlab-rake "gitlab:password:reset[root]"
```

---

## 6. 变更主机 IP / 端口时

同时改这三处并 `docker compose up -d` + `gitlab-ctl reconfigure`：

1. `hostname`
2. `external_url`
3. `ports` 与 `gitlab_shell_ssh_port`（若 SSH 端口变了）

改完后检查项目里已有 clone 地址是否需更新。
