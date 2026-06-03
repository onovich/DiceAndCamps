《骰子与营地》项目交接文档

0. 项目命名

中文名称: 骰子与营地

英文代号: Dice & Camps (简称 D&C)

当前版本: 原型版 (V 0.1)

1. 需求设计文档 (PRD/GDD 摘要)

1.1 产品概述

一款融合了“大富翁掷骰走步”与“JRPG探险”的单页面 WebGL 3D 游戏。

背景: 西式魔幻地牢探险。

模式: 单机单局模式 (1名人类玩家 + 3名简单AI)。

核心体验: 将传统大富翁的单纯“买地收租”转变为“掷骰移动、打怪升级、建立小型功能营地、触发丰富事件”。

1.2 核心系统与玩法

地图设计: “数字8”大回环结构，主路 (Node) 用于移动，副地块 (Slot) 用于扎营/野怪。

移动系统: 3D物理骰子随机判定，角色沿主路连跳（带物理形变）。

异步事件队列 (关键设计): 停留后依次结算：踩中陷阱 -> 遭遇守卫(回合制战斗) -> 获取己方增益 -> 进行营地互动。

RPG 养成: 包含 HP, ATK, Gold, Exp, Level。战斗胜利获 Exp 和 Gold，满 Exp 升级（恢复HP，提升ATK和MaxHP）。

营地系统 (二段操作):

选地: 高亮停留节点周围的可用副地块。

操作: 弹出菜单，消耗金币建造 陷阱 (扣血)、守卫哨站 (强制战斗拦截)、金矿 (路过收益)。

2. 技术文档

2.1 技术栈

核心环境: HTML5 Canvas

3D 渲染引擎: Three.js (r128 版本，通过 CDN 引入)

动画补间库: Tween.js (18.6.4 版本，通过 CDN 引入)

前端 UI: 纯 HTML/CSS/DOM (绝对定位覆盖在 Canvas 之上)

架构形态: 单文件 (All-in-One index.html)

2.2 核心模块解析 (Game 对象)

当前所有逻辑均封装在全局单例对象 Game 中。

initEngine(): 初始化 Three.js 场景、正交相机 (OrthographicCamera)、WebGL 渲染器及卡通光照 (DirectionalLight)。

buildMap(): 构建地图数据结构。定义了 pathCoords 数组来生成主路 (nodes)，并依附生成副地块 (slots)。

initPlayers(): 初始化 4 名玩家（1 人类 + 3 AI）的数据属性及 3D 模型（球体 + 背面膨胀描边）。

initEvents(): 绑定 UI 按钮事件、Canvas 触控/鼠标拖拽事件 (用于相机平移) 及射线检测 (Raycaster) 点击事件 (用于二段式营地选地)。

rollDice() -> moveCharacter(): 包含实体骰子的生成、随机抛物线翻滚动画，以及角色跳跃前进的递归动画逻辑 (Squash & Stretch)。

handleLanding() (核心业务流): 处理到达终点后的异步事件队列。使用 async/await 按序触发 triggerTrap, triggerCombat。

enterBuildPhase() -> handleSlotClick() -> buildFacility(): 二段式营地交互的 UI 控制和模型生成逻辑。

animate(): 核心渲染循环。处理 TWEEN 更新、相机的阻尼跟随运算 (lerp)、以及 AI 的待机呼吸动画。

3. 技术架构重构方向与设计

目前的“单文件面条代码”适合快速验证原型，但不具备可维护性和扩展性。接手后首要任务是进行模块化重构。

3.1 建议的重构架构 (ES6 Modules / Webpack / Vite)

推荐拆分为以下模块：

Core / Engine (核心引擎层):

Renderer.js: 封装 Three.js 的初始化、场景、灯光、渲染循环。

CameraManager.js: 专注处理正交相机的阻尼跟随、拖拽限制等逻辑。

InputManager.js: 统一管理鼠标、触摸、Raycaster 射线检测。

Logic / Data (数据逻辑层):

GameManager.js: 掌控游戏整体状态机 (State: Init, PlayerTurn, Roll, Move, Event, Build, EndTurn)。

MapData.js: 地图生成器，管理 Node 和 Slot 的拓扑关系。

Player.js: 玩家实体类，管理属性 (HP, ATK, Gold...)、增减益逻辑。

CombatSystem.js: 独立抽出回合制战斗的数值计算和结算逻辑。

Entity / View (3D表现层):

CharacterView.js: 负责角色模型的加载/创建、跳跃动画、受伤特效。

FacilityView.js: 负责营地建筑模型的创建和特效。

DiceBox.js: 封装物理骰子的抛掷逻辑和结果判定。

UI (界面层):

UIManager.js: 负责 HTML DOM 元素的更新，解耦 3D 逻辑和 2D UI 渲染。可以使用 React 或 Vue 替换目前的纯原生 DOM 操作。

3.2 重点解决的技术债

硬编码 (Hardcode): 地图坐标、建筑数值、伤害公式目前是硬编码的，需要抽离为 JSON 配置文件。

回调地狱与动画同步: 目前角色移动、战斗等待依赖 setTimeout 和 TWEEN 回调，容易产生时序 Bug。建议引入更健壮的 Promise/async 动画队列系统。

模型替换: 目前全是程序化生成的几何体 (Box, Sphere)。需搭建统一的 GLTF 模型加载器 (GLTFLoader)，以便后续替换为正式美术资产。

4. 美术约束文档 (Technical Art Guidelines)

接手的美术或 AI 在生成/替换资产时，必须遵守以下规范：

4.1 渲染风格 (NPR - 三渲二)

材质要求: 游戏内统一使用卡通材质 (在 Three.js 中对应 MeshToonMaterial)。避免使用基于物理的渲染 (PBR / MeshStandardMaterial)。

描边工艺:

当前代码使用的是 背面膨胀法 (BackSide Outline)。

导入的自定义模型尽量在建模软件 (如 Blender) 中提前处理好法线，或者通过 Three.js 脚本动态生成背面纯黑扩大的 Mesh 作为描边。

色彩倾向: 明亮、高饱和度，尽量使用平滑的渐变色阶，避免复杂的真实感贴图纹理。

4.2 相机与视角约束

相机类型: 绝对禁止改用透视相机 (PerspectiveCamera)，必须保持 正交相机 (OrthographicCamera)。

固定视角: 典型的等距视角视角 (X:20, Y:20, Z:20 lookAt 中心)。美术在制作模型和贴图时，只需确保从该倾斜俯视角看过去效果良好即可 (可以节省背面/底面不必要的细节)。

4.3 渲染层级与 UI

3D 置顶: 类似“骰子”、“飘字”这种元素，必须确保在深度测试中位于顶层 (例如设置 material.depthTest = false 或调整 renderOrder)。

UI 隔离: 2D 交互 UI (属性面板、建造菜单) 必须脱离 WebGL 画布，作为独立的 DOM 层覆盖在上面。

5. 项目启动与开发指南

5.1 运行当前原型

新建一个文件夹。

将提供的 index.html 代码保存到该文件夹中。

直接双击 index.html 在现代浏览器 (Chrome/Edge/Safari) 中打开即可运行测试。
(注意：由于当前未涉及外部贴图或模型加载，无需配置本地 Web Server 也能直接运行)

5.2 给接手 AI 的 Prompt 建议

如果您打算用 Cursor、Claude 或其他代码 AI 接手，建议使用以下 Prompt 起手：

"你现在是《骰子与营地》的主程。我已经附上了当前版本的 index.html（作为原型基线）以及 handover_doc.md（项目交接文档）。

我们现在的首要目标是进行代码的模块化重构。请仔细阅读交接文档中的【3.1 建议的重构架构】，然后以 ES6 Modules 的标准，帮我将当前的单文件拆分为 Engine、Logic、View、UI 等独立的文件结构。在此过程中，请保持原有的 NPR 渲染风格和正交相机逻辑不变。请给出重构后的目录结构和核心骨架代码。"