# Jenkins（对照官方）

模块：[`modules/cicd/jenkins/`](../../modules/cicd/jenkins/)

## 依据

- https://www.jenkins.io/doc/book/installing/docker/
- https://hub.docker.com/r/jenkins/jenkins

## 差异

| 项 | 官方示例 | 本仓库 |
|----|----------|--------|
| 镜像 | 文档常写当前 LTS | 钉死 `2.504.2-lts-jdk17` |
| HTTP | 8080:8080 | **8085:8080** |
| user | jenkins | 本地演示可用 `root` 规避卷权限（已注释说明） |
