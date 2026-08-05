# Jenkins 2.504.2 LTS (JDK17)

对照官方 Docker 安装。Web 映射 **8085**（避开 nacos 8080）。

## 前置

- Docker Compose V2；端口 `8085`、`50000` 空闲

## 运行

```bash
cd modules/cicd/jenkins
docker compose up -d
# 或: ./easyenv.sh up jenkins
```

## 连接信息

| 项 | 值 |
|----|-----|
| 镜像 | `jenkins/jenkins:2.504.2-lts-jdk17` |
| URL | http://127.0.0.1:8085 |
| 初始管理员密码 | 容器内 `/var/jenkins_home/secrets/initialAdminPassword` |
| Agent 端口 | `50000` |
| 数据卷 | `./data` → `/var/jenkins_home` |

### 取初始密码

```bash
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

## 客户端示例

1. 打开 http://127.0.0.1:8085  
2. 粘贴上表命令得到的密码  
3. 按安装向导完成（可 Install suggested plugins）

## 验收

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8085/login
# 期望 200
```

## 官方

- [docs/jenkins/README.md](../../../docs/jenkins/README.md)
- https://www.jenkins.io/doc/book/installing/docker/
- https://hub.docker.com/r/jenkins/jenkins
