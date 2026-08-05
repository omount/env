# Node.js

安装 [Node.js](https://nodejs.org/)（对照 nvm / 官网 / BUILDING.md）。

## 官方出处

- Node.js 下载：https://nodejs.org/en/download  
- 上游仓库：https://github.com/nodejs/node  
- nvm（安装脚本）：https://github.com/nvm-sh/nvm#install--update-script（`v0.40.6`）  
- 编译：https://github.com/nodejs/node/blob/main/BUILDING.md  

详解：[docs/nodejs/install.md](../../../docs/nodejs/install.md)

## 安装（Linux / macOS）

```bash
cd nodejs
./install.sh
```

## 从源码编译

```bash
cd nodejs
./build-from-source.sh
```

## 验收

```bash
node --version
npm --version
```
