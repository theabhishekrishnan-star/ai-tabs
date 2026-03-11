# ai-tabs (macOS) 🚀

[English](README.md)| [简体中文](README_zh.md)

> **One-click batch launch of multiple AI CLI tools as individual Editor Tabs in VS Code on macOS.**

Different AI CLI tools (OpenCode, Gemini, Iflow, Kilo, etc.) often have their own free tiers or rate limits. This tool lets you open all of them at once so you can use one while another is busy or has hit its quota.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg)

## 🌟 Features

- **Hybrid Discovery Engine**: Automatically scans your system (PATH, Brew, NPM, NVM, etc.) but allows manual overrides via `.env`.
- **Self-Healing Startup**: Attempts to resume your last session; if no history exists, it automatically starts a fresh one.
- **"Editor-as-UI"**: Your terminals live directly as **Editor Tabs**, providing a clean, tabbed workspace.
- **Turbo Core**: Uses AppleScript + Clipboard-Paste bridge for high-speed, reliable setup.
- **Zero Overhead**: Replaces shell processes with `exec`, keeping your workspace clean.

## 🎥 Demo

![ai-tabs Demo](assets/demo.mp4)

## 🛠 Auto-Discovered Tools

The system auto-detects several popular CLIs and applies the following resume logic:

| AI CLI Tool | Resume Strategy |
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

> [!NOTE]
> If a tool fails to resume (e.g., no history), the dashboard automatically falls back to a fresh session.

## 🚀 Quick Start

### 1. Prerequisites (macOS)

None! The latest version (v1.0.0+) uses automated Command Palette discovery, so you don't even need to bind custom shortcuts.

### 2. Simple Deployment

Just download the script to your project root.

```bash
git clone https://github.com/Fu-Jie/ai-tabs.git
cp ai-tabs/ai-tabs.sh your-project/
# Optional:
# cp ai-tabs/.env.example your-project/.env
```

### 3. Usage

Make the script executable and run it:

```bash
chmod +x ai-tabs.sh
./ai-tabs.sh
```

The script will scan your system and build your ai-tabs in seconds.

## ⚙️ How it Works

The script scans standard locations (Brew, NPM, Conda, NVM) and your `PATH`. If a tool is found, it's intelligently added to your ai-tabs with its specific session-resume flag.

## 📜 License

MIT License.
