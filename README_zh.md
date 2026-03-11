# ai-tabs (macOS) 🚀

> **VS Code 多 Agent 编排工具：一键批量启动 AI CLI，让 AI 们并联工作且永不休息，彻底打通多模型生产力。**

[English](README.md) | [简体中文](README_zh.md)

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg)](#)
[![Version](https://img.shields.io/badge/version-1.0.0-green.svg)](#)

## 🎥 演示

![ai-tabs Demo](assets/demo.gif)

## 💡 为什么需要 ai-tabs？

在 AI 辅助编程的时代，开发者往往面临以下痛点：
1. **额度焦虑**: 单个 AI 工具（如 Claude 或 Gemini）的免费额度有限，频繁触发 Rate Limit。
2. **模型局限**: 没有一个模型是全能的，复杂任务通常需要在不同模型间来回比对和切换。
3. **上下文断层**: 在不同的终端窗口间切换，操作繁琐且难以保持专注。

**ai-tabs 的出现，让 AI 们“并行工作，永不休息”**：通过将多个 AI CLI 并联为 VS Code 标签页，您可以像切换代码文件一样切换 AI Agent。

### 核心价值：
- **消除上下文切换摩擦**: 无需在独立终端 App 或浏览器间来回穿梭，AI 就在您的代码旁边。
- **多模型协作方案**: 
    - 让 **Claude** 进行高层架构设计；
    - 让 **Gemini** 并行编写单元测试；
    - 让 **OpenCode** 实时审查性能瓶颈。
- **资源利用最大化**: 灵活调度不同模型的免费额度，一个模型触碰 Rate Limit 时，点击标签页即可无缝接力。

## 🌟 核心特性

- **"编辑器即终端"**: 终端不再隐藏在底部面板，而是作为**独立编辑器标签页**打开。
- **混合发现引擎**: 自动扫描系统路径 (PATH, Brew, NPM, NVM 等)，同时支持 `.env` 灵活配置。
- **自动上下文恢复**: 优先尝试恢复上次对话 (`--continue`/`--resume`)，若无历史则自动开启新绘画。
- **Turbo 自动化**: 结合 AppleScript 与剪贴板桥接，实现零配置、秒级的一键全启动。
- **极致轻量**: 基于原生 Bash 脚本，使用 `exec` 替换进程，不累赘、不占资源。

## 🛠 支持自动识别的工具

系统会自动探测以下 CLI 并应用相应的恢复逻辑：

| AI 命令行工具 | 恢复指令 (Resume) | 说明 |
| :--- | :--- | :--- |
| **Claude Code** | `--continue` | Anthropic 官方 CLI |
| **OpenCode** | `--continue` | 极速代码推理 |
| **Gemini CLI** | `--resume latest` | Google 多模态能力 |
| **GitHub Copilot** | `--continue` | GitHub 原生支持 |
| **iFlow CLI** | `--continue` | 结构化任务处理 |
| **Cline CLI** | `--continue` | 开源 Agent 专家 |
| **Kimi CLI** | `--continue` | 长文本处理专家 |
| **Codex CLI** | `resume --last` | 经典代码助手 |
| **Kilo CLI** | `--continue` | 轻量级推理 |

## 🚀 快速开始

### 1. 准备工作
- **操作系统**: macOS
- **编辑器**: VS Code
- **权限**: 无需特殊配置，脚本运行前会自动引导

### 2. 部署与启动

只需将脚本下载到项目根目录，赋予执行权限即可启动：

```bash
# 克隆仓库
git clone https://github.com/Fu-Jie/ai-tabs.git

# 部署并运行
chmod +x ai-tabs/ai-tabs.sh
./ai-tabs/ai-tabs.sh
```

## ⚙️ 工作原理

`ai-tabs` 通过 AppleScript 模拟用户行为，自动完成以下“繁琐”动作：
1. 启动命令面板 (`Cmd+Shift+P`)。
2. 搜索并执行“在编辑器区域创建新终端”。
3. 注入对应的 AI 启动命令并自动恢复会话。
4. 所有的动作在几秒钟内并行/序列化完成，为您搭建好完整的 AI 指挥台。

## 📜 许可证

本项目采用 [MIT 许可证](LICENSE)。
