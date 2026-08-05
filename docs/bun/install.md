# Bun 安装说明

模块目录：[`bun/`](../../modules/runtime/bun/)

## 官方出处

| 项 | 链接 |
|----|------|
| 官网 / 安装总览 | https://bun.sh/docs/installation |
| Linux / macOS 官方脚本 | https://bun.sh/install （或 https://bun.com/install） |
| Windows 官方脚本 | https://bun.sh/install.ps1 |
| 源码仓库 | https://github.com/oven-sh/bun |
| 从源码构建（贡献文档） | https://bun.com/docs/project/contributing |

## 方式一：官方安装脚本（推荐）

本仓库封装：[`bun/install.sh`](../../modules/runtime/bun/install.sh)

```bash
cd bun
./install.sh
```

等价于官方命令：

```bash
# Linux / macOS
curl -fsSL https://bun.sh/install | bash

# Windows PowerShell
powershell -c "irm bun.sh/install.ps1 | iex"
```

其他官方渠道（可选）：`npm install -g bun`、Homebrew `brew install oven-sh/bun/bun`、Scoop `scoop install bun`。

验收：`bun --version`

## 方式二：从源码编译

官方说明：编译 Bun **需要先安装一个已发布的 Bun**（用于代码生成与构建脚本），再克隆仓库构建。

本仓库封装：[`bun/build-from-source.sh`](../../modules/runtime/bun/build-from-source.sh)

```bash
cd bun
./build-from-source.sh          # debug 构建，产物 build/debug/bun-debug
./build-from-source.sh release  # release 构建
```

脚本会：

1. 若本机无 `bun`，先走官方脚本安装  
2. `git clone https://github.com/oven-sh/bun.git`（可设 `BUN_SRC_DIR`）  
3. 执行 `bun run build` 或 `bun run build:release`  

依赖与磁盘空间要求见官方 contributing 文档（约需较大磁盘与较长时间）。Windows 编译另见：https://github.com/oven-sh/bun/blob/main/docs/project/building-windows.mdx

## 建议

- 日常使用：**官方安装脚本**即可  
- 贡献 / 定制：再使用**源码编译**  
- 业务运行时环境优先用 Docker 部署应用；Bun 多用于开发机  
