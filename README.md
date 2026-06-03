# Dice & Camps

Dice & Camps is a single-page WebGL prototype that blends board-game dice movement with light RPG adventure and camp-building systems.<br/>**《骰子与营地》是一个单页 WebGL 原型，融合了大富翁式掷骰移动、轻量 RPG 冒险和营地建设系统。**

The current version is an all-in-one static HTML game built with Three.js r128 and Tween.js from CDN links.<br/>**当前版本是一个单文件静态 HTML 游戏，通过 CDN 引入 Three.js r128 和 Tween.js。**

## Features

- Four-player board loop with one human player and simple AI turns.<br/>**四名角色在环形棋盘上行动，其中一名为人类玩家，其余为简单 AI。**
- 3D dice roll animation, character jump movement, camera follow, and drag panning.<br/>**包含 3D 掷骰动画、角色跳跃移动、镜头跟随和拖拽平移。**
- RPG stats, JRPG-style battle commands, passive AI battle choices, gold, experience, and leveling.<br/>**包含 RPG 属性、JRPG 式战斗指令、AI 被动战斗自动决策、金币、经验和升级。**
- Two-step camp building around the current node, with traps, guard posts, gold mines, healing camps, training camps, upgrades, demolition, and guard recruitment.<br/>**支持围绕当前节点进行二段式营地建造，可建陷阱、守卫哨站、金矿、治疗营地和训练营，并支持升级、拆毁和招募守军。**

## Run Locally

No package install is required for the current static prototype.<br/>**当前静态原型不需要安装 npm 依赖。**

Double-click `StartLocalTest.cmd`, or run:<br/>**可以双击 `StartLocalTest.cmd`，或运行：**

```powershell
.\StartLocalTest.cmd
```

The launcher starts a local static server with Python, chooses an available port, and opens the browser at `http://127.0.0.1:<port>/`.<br/>**启动器会使用 Python 启动本地静态服务器，自动选择可用端口，并在浏览器中打开 `http://127.0.0.1:<port>/`。**

For a dry run without opening a browser:<br/>**如需只检查命令而不打开浏览器：**

```powershell
.\StartLocalTest.cmd -DryRun
```

## Online Preview

The GitHub Pages URL is expected to be:<br/>**GitHub Pages 预览地址预计为：**

[https://onovich.github.io/DiceAndCamps/](https://onovich.github.io/DiceAndCamps/)

After the first push, enable GitHub Pages with `Settings -> Pages -> Source -> GitHub Actions` if the repository has not already been configured that way.<br/>**首次推送后，如果仓库尚未配置 Pages，请在 `Settings -> Pages -> Source -> GitHub Actions` 中启用。**

Open the configured online preview with:<br/>**可用以下命令打开线上预览：**

```powershell
.\OpenOnlineTest.cmd
```

## Repository Layout

- `index.html` contains the playable static prototype.<br/>**`index.html` 包含可游玩的静态原型。**
- `design.md` keeps the original handoff and refactor notes from the prototype export.<br/>**`design.md` 保留原型导出的交接说明和后续重构建议。**
- `.github/workflows/deploy.yml` deploys the static site to GitHub Pages using official Pages actions.<br/>**`.github/workflows/deploy.yml` 使用官方 Pages Actions 将静态站点部署到 GitHub Pages。**
- `scripts/` contains local and online test launcher implementation scripts.<br/>**`scripts/` 存放本地和线上测试启动器的实现脚本。**

## Development Notes

This repository currently preserves the prototype as a static single-file game. The next maintainability step is to split game data, rendering, input, UI, and turn/event logic into modules after the current gameplay pass stabilizes.<br/>**本仓库目前保留静态单文件游戏原型。下一步可维护性工作是在当前玩法扩展稳定后，将游戏数据、渲染、输入、UI、回合与事件逻辑拆分为模块。**
