# Node.js 安装说明（对照官方）

模块目录：[`nodejs/`](../../modules/runtime/nodejs/)

## 验收依据（官方）

| 项 | URL |
|----|-----|
| Node.js 官网下载 | https://nodejs.org/en/download |
| 上游仓库 | https://github.com/nodejs/node |
| nvm 仓库 / Install 脚本 | https://github.com/nvm-sh/nvm#install--update-script |
| nvm 当前 README 钉死版本 | `v0.40.6`：`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh \| bash` |
| nvm 安装 LTS | `nvm install --lts`（nvm README Usage） |
| 源码构建 | https://github.com/nodejs/node/blob/main/BUILDING.md |

## 方式一：nvm（Linux / macOS，本仓库封装）

```bash
cd nodejs
./install.sh
```

等价官方步骤：

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh | bash
# 重新打开 shell 或 source nvm.sh 后：
nvm install --lts
```

Windows：请使用 https://nodejs.org/en/download 或 https://github.com/coreybutler/nvm-windows（非本 bash 脚本范围）。

## 方式二：从源码编译

```bash
cd nodejs
./build-from-source.sh
```

依据：https://github.com/nodejs/node/blob/main/BUILDING.md（`./configure && make`）。
