# Bun

安装 [Bun](https://bun.sh/) 运行时。

## 官方出处

- 安装总览：https://bun.sh/docs/installation  
- Linux/macOS 脚本：`curl -fsSL https://bun.sh/install | bash`  
- Windows 脚本：`irm bun.sh/install.ps1 | iex`  
- 源码编译：https://bun.com/docs/project/contributing  
- 上游仓库：https://github.com/oven-sh/bun  

详解：[docs/bun/install.md](../../../docs/bun/install.md)

## 官方脚本安装（推荐）

```bash
cd bun
./install.sh
```

## 从源码编译

```bash
cd bun
./build-from-source.sh          # debug
./build-from-source.sh release  # release
```

## 验收

```bash
bun --version
```
