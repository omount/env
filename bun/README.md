# Bun

安装 [Bun](https://bun.sh/) 运行时。

## 前置条件

- Linux / macOS：可用 `curl`、`bash`
- Windows：建议在 Git Bash 下执行本脚本，或直接在 PowerShell 中安装

## 使用

```bash
cd bun
./install.sh
```

## 验收

```bash
bun --version
```

## 说明

脚本按 `uname` 选择官方安装方式；Windows（MINGW/MSYS/CYGWIN）会调用 `powershell.exe`。
