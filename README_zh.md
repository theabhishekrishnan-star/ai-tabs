# ai-tabs (macOS) 🚀

[English](README.md) | [简体中文](README_zh.md)

> **在 macOS 上一键批量打开多个 AI CLI 工具为 VS Code 的“编辑器标签页”。**

不同的 AI CLI 工具（OpenCode, Gemini, Iflow, Kilo 等）通常有各自的免费额度或速率限制。这个工具让您一次性全部打开，这样当一个工具正在忙碌或触及额度上限时，您可以直接切换到另一个继续工作。

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg)

## 🌟 特性

- **混合发现引擎**: 自动扫描系统路径 (PATH, Brew, NPM, NVM 等)，同时支持通过 `.env` 强制指定特定工具路径。
- **自愈启动**: 优先尝试恢复上次对话；如果没有历史记录，则自动开启新对话，告别报错。
- **"编辑器即终端"**: 终端直接作为**独立编辑器标签页**打开，像切换代码文件一样切换 AI 工具。
- **Turbo 核心**: 结合 AppleScript 与剪贴板桥接，实现极速、精准的自动化引导。
- **零开销**: 使用 `exec` 替换进程，保持开发环境轻快。

## 🎥 演示

![ai-tabs Demo](assets/demo.mp4)

系统会自动探测以下 CLI 并应用相应的恢复逻辑：

| AI 命令行工具 | 恢复指令 (Resume) |
| :--- | :--- |
| **Claude Code** | `--continue` |
| **OpenCode** | `--continue` |
| **Gemini CLI** | `--resume latest` |
| **GitHub Copilot** | `--continue` |
| **iFlow CLI** | `--continue` |
| **Cline CLI** | `--continue` |
| **Kimi CLI** | `--continue` |
| **Codex CLI** | `resume --last` |
| **Kilo CLI** | `--continue` |

> [!TIP]
> 如果恢复指令失败（例如没有历史记录），仪表盘会自动切换到开启“新会话”模式，确保顺滑启动。

## 🚀 快速开始

### 1. 准备工作 (macOS)

无需任何配置！最新版本 (v1.0.0+) 已实现自动指令发现，您甚至不需要手动绑定快捷键。

### 2. 部署

只需将脚本下载到项目根目录即可。

```bash
git clone https://github.com/Fu-Jie/ai-tabs.git
cp ai-tabs/ai-tabs.sh your-project/
# 可选:
# cp ai-tabs/.env.example your-project/.env
```

### 3. 使用

赋予执行权限并启动：

```bash
chmod +x ai-tabs.sh
./ai-tabs.sh
```

脚本将自动完成全系统的工具扫描，并在几秒钟内搭建好您的 ai-tabs。

## 📜 许可证

本项目采用 [MIT 许可证](LICENSE)。
