# Codev Skills

`codev` 是一组给 Codex 用的开发流程 skills，和 `gstack` 配合，覆盖从需求到部署的完整链路。

## 1. 安装

### 先安装 gstack

```bash
git clone https://github.com/garrytan/gstack.git ~/gstack
cd ~/gstack
./setup --host codex
```

### 再安装 codev

```bash
git clone https://github.com/wmzhai/codev.git ~/codev
cd ~/codev
./setup
```

## 2. 完整执行链路图

```
┌──────────────────────────── main/master ────────────────────────────┐
│                                                                     │
│  $memorize                                                          │
│    └─► AGENTS.md + memory/ (repo 内)                                │
│                                                                     │
│  $office-hours                                                      │
│    └─► ~/.gstack/projects/{slug}/*-design-*.md                      │
│         设计文档                                                    │
│                                                                     │
│  $plan-ceo-review   ←── 读 design doc                               │
│    └─► ~/.gstack/projects/{slug}/ceo-plans/*.md                     │
│         CEO 计划                                                    │
│                                                                     │
│  $design-consultation ←── 有 UI 且无 DESIGN.md 时                   │
│    └─► DESIGN.md (repo 根目录)                                      │
│         设计系统：字体 / 色彩 / 间距 / 动效                          │
│                                                                     │
│  $plan-design-review ←── 读 DESIGN.md                               │
│    └─► 设计完整度评分 0-10                                          │
│         修补后的 plan 文件                                           │
│                                                                     │
│  $plan-eng-review   ←── 读 design doc + DESIGN.md                   │
│    └─► 架构图 + ~/.gstack/projects/{slug}/*-test-plan-*.md          │
│                                                                     │
└─────────────────────────────┬───────────────────────────────────────┘
                              │ 此处切入 task 分支
                              ▼
┌──────── task 分支 (每个 task 一条独立分支) ──────────────────────────┐
│                                                                     │
│  $gstack2task 或 $issue2task                                        │
│    └─► tasks/T{nn}-{slug}.md + 新建并切到 task 分支                 │
│                                                                     │
│  $plantask ←── 读 tasks/T{nn}-{slug}.md                             │
│    └─► 可直接实施的详细计划                                         │
│         (不改代码)                                                   │
│                                                                     │
│  实现代码                                                            │
│    │                                                                 │
│    ▼                                                                 │
│  $simplify ─── 语义不变精简，收窄 patch                              │
│    │                                                                 │
│    ▼                                                                 │
│  普通 commit 或 $checkpoint ─── 提交 clean tree                     │
│    │                                                                 │
│    ▼                                                                 │
│  （有 UI 时）$design-review ─── 视觉 QA + 原子 fix commits          │
│    │                                                                 │
│    ▼                                                                 │
│  $review ─── 结构性 code review，可能 auto-fix                      │
│    │ (若改了代码 → 验证 → 必要时补 $simplify → 补 commit)           │
│    ▼                                                                 │
│  $qa ─── 打开真实浏览器测试用户流程                                  │
│    │                                                                 │
│    ▼                                                                 │
│  $checktask ─── 逐项验收 → 归档到 tasks/done/ → 同步 memory/       │
│    │                                                                 │
│    ▼                                                                 │
│  $ship ─── 测试 + 覆盖率 + review + 版本号 + CHANGELOG + PR         │
│                                                                     │
└─────────────────────────────┬───────────────────────────────────────┘
                              │
                              ▼
┌───────── 合并与部署 ─────────────────────────────────────────────────┐
│                                                                     │
│  $land-and-deploy                                                   │
│    ├─► 预合并就绪门禁 (CI 绿 + review approved)                     │
│    ├─► gh pr merge (squash / rebase / merge)                        │
│    ├─► 等 CI + 部署完成                                              │
│    └─► $canary 自动验证生产健康度                                    │
│                                                                     │
│  $document-release (可选，ship 后)                                  │
│    └─► 同步 README / ARCHITECTURE / CONTRIBUTING / CHANGELOG        │
│                                                                     │
│  $retro (可选，每周)                                                │
│    └─► 工程复盘报告 (commit 分析 + 代码质量 + 工作模式)             │
│                                                                     │
└──────────────────────────────────────────────────────────────────────┘
```

> **`$autoplan` 快捷路径：** 如果不想手动依次跑 `$plan-ceo-review` → `$plan-design-review` → `$plan-eng-review`，可以直接用 `$autoplan`。它自动串联 CEO + Design + Eng 三个 review，只在需要品味判断时才停下来问用户，其余中间决策自动处理。

## 3. 阶段详解

### 阶段 1：初始化与规划（在 main/master 上）

| 步骤 | 做什么 | 产出 | 存储位置 |
|------|--------|------|---------|
| `$memorize` | 为项目建立 Codex 记忆体系 | `AGENTS.md` + `memory/` | repo 根目录 |
| `$office-hours` | 问题定义、需求挖掘、前提挑战、方案比选 | 设计文档 | `~/.gstack/projects/{slug}/*-design-*.md` |
| `$plan-ceo-review` | 产品和 scope 聚焦，10x 检查，scope 扩展/收缩选择 | CEO 计划 | `~/.gstack/projects/{slug}/ceo-plans/` |
| `$design-consultation` | 生成完整设计系统（字体、色彩、间距、动效） | `DESIGN.md` | repo 根目录 |
| `$plan-design-review` | 基于 DESIGN.md 做实现前设计审查 | 设计完整度评分 + 修补 plan | plan 文件内 |
| `$plan-eng-review` | 架构图、测试计划、失败模式、边界条件 | 架构图 + 测试计划 | `~/.gstack/projects/{slug}/*-test-plan-*.md` |
| `$autoplan` | 自动串联 CEO + Design + Eng review | 完整 review 报告 | 各 skill 各自的产出位置 |

> 关键依赖：`$plan-ceo-review` 和 `$plan-eng-review` 会自动读取 `$office-hours` 产出的设计文档。`$plan-eng-review` 和 `$plan-design-review` 会自动读取 `DESIGN.md`。如果没有设计文档，它们会主动建议先跑 `$office-hours`。
>
> `$autoplan` 可以替代手动逐个运行 CEO / Design / Eng review，它用 6 条自动决策原则处理中间问题，只为需要品味判断的决策停下来咨询用户。

### 阶段 2：创建任务（切入 task 分支）

| 步骤 | 做什么 | 产出 | 存储位置 |
|------|--------|------|---------|
| `$gstack2task` | 读取 gstack 规划工件 → 压成可执行任务 | 任务文件 + 新分支 | `tasks/T{nn}-{slug}.md` |
| `$issue2task` | 读取 GitHub Issue 或直接需求 → 压成可执行任务 | 任务文件 + 新分支 | `tasks/T{nn}-{slug}.md` |

> 两者只选一个。`$gstack2task` 用于上游已跑过 gstack 的场景；`$issue2task` 用于 GitHub Issue 或用户直接描述的需求。每个 task 自动新建独立分支。

### 阶段 3：规划实施（在 task 分支上）

| 步骤 | 做什么 | 产出 | 存储位置 |
|------|--------|------|---------|
| `$plantask` | 基于任务文件和代码现状，输出可直接实施的计划 | 详细实现方案 | 对话输出（不改代码） |

> `$plantask` 会检查前置任务是否已完成，优先复用现有模式，默认直接收敛实现方向。方案结尾会询问用户：接受后进入实现，还是继续讨论。

### 阶段 4：实现 → 精简 → 提交

| 步骤 | 做什么 | 产出 | 说明 |
|------|--------|------|------|
| 实现 | 按照 `$plantask` 方案编写代码 | 代码变更 | 正常开发 |
| `$simplify` | 语义不变精简当前 diff | 更小的 patch | 不改行为、不改公共 API、不引入新依赖 |
| 普通 commit 或 `$checkpoint` | 提交 clean tree | 提交记录 | `$design-review` 和 `$qa` 要求 clean working tree |

### 阶段 5：审查与测试

| 步骤 | 做什么 | 产出 | 说明 |
|------|--------|------|------|
| `$design-review` | 视觉审查 + 自动修复循环 | 原子 fix commits + 截图 | 只有 UI 变更时才需要 |
| `$review` | 结构性 code review | auto-fix 或建议 | 可能改代码；若改了需验证后再补 commit |
| `$qa` | 打开真实浏览器测试用户流程 | bug 修复 + 回归测试 | 要求 clean working tree |

> ⚠️ `$design-review` 和 `$qa` 都要求 clean working tree，所以提前跑 `$simplify` + commit。如果 `$review` 改了代码，需要验证后必要时再补一次 `$simplify` + commit。

### 阶段 6：验收与发布

| 步骤 | 做什么 | 产出 | 存储位置 |
|------|--------|------|---------|
| `$checktask` | 逐项验收 + 归档 + 同步 memory/ | 通过状态 + 归档 | `tasks/done/` |
| `$ship` | 完整发布流水线 | PR + CHANGELOG + 版本号 | github PR |

> `$checktask` 还会在流程末尾做一次 `$simplify` 式精简，并基于已验证结果更新 `memory/`。`$ship` 包含测试、覆盖率审计、code review、版本号、CHANGELOG、原子 commit、push、创建 PR 等完整流程。

### 阶段 7：合并、部署与发布后

| 步骤 | 做什么 | 产出 | 说明 |
|------|--------|------|------|
| `$land-and-deploy` | 预合并门禁 → merge PR → 等 CI/部署 → 生产验证 | 已合并 PR + 部署确认 | 自动检测部署策略（GitHub Actions / 平台 CLI / auto-deploy），内置 canary 检查 |
| `$canary` | 部署后健康监控：console 错误、性能回归、页面故障 | 截图 + 报警 | `$land-and-deploy` 内部会自动调用，也可独立运行 |
| `$document-release` | ship 后更新 README / ARCHITECTURE / CONTRIBUTING 等 | 更新后的文档 | 确保文档与代码变更一致，润色 CHANGELOG，清理 TODO |
| `$retro` | 周维度工程复盘 | 复盘报告 | 分析 commit 历史 + 代码质量 + 工作模式，团队感知 |

> `$land-and-deploy` 的核心是 **预合并就绪门禁**：CI 必须通过、至少一个 approve、无未解决的 review 评论。合并方式自动检测仓库偏好（squash / rebase / merge）。合并后会等待部署完成并用 `$canary` 验证生产环境。
>
> `$document-release` 主要在 feature release 后使用，不是每次 commit 都要跑。它会根据代码变更自动检测需要更新的文档文件。
>
> `$retro` 是周维度工具，不属于单个 task 的流程，适合每周一次回顾上周的工程表现。

### 按需工具（不在主流程内，需要时单独调用）

| 步骤 | 做什么 | 产出 | 说明 |
|------|--------|------|------|
| `$cso` | 安全审计：OWASP Top 10 / STRIDE 威胁建模 / 依赖漏洞扫描 | 安全态势报告 + 修复计划 | 建议在 ship 前或定期运行 |
| `$investigate` | 系统化 debug：调查 → 分析 → 假设 → 实现 | 根因定位 + 修复 | 含 scope 锁，防止修复蔓延到无关区域 |
| `$browse` | 底层无头浏览器引擎 | 截图 / 快照 / 断言 | 被 `$qa` / `$canary` / `$design-review` 调用，也可独立使用做页面交互 |

## 4. 跨 session 使用指南

所有状态都持久化到磁盘，不依赖 session 内存。**你可以随时关闭终端、新开 session 继续。**

| 状态类型 | 存储位置 | 被谁读取 |
|---------|---------|---------|
| 设计文档 | `~/.gstack/projects/{slug}/*-design-*.md` | `$plan-ceo-review`、`$plan-eng-review` |
| CEO 计划 | `~/.gstack/projects/{slug}/ceo-plans/` | 下游规划 skill |
| 测试计划 | `~/.gstack/projects/{slug}/*-test-plan-*.md` | `$qa`、`$qa-only` |
| 设计系统 | `DESIGN.md`（repo 根目录） | `$plan-eng-review`、`$plan-design-review`、`$design-review` |
| Review 日志 | `~/.gstack/`（via `gstack-review-log`） | `$ship` 的 review 就绪仪表盘 |
| Canary 基线 | `~/.gstack/canary/` | `$canary` 截图对比 |
| 任务文件 | `tasks/T{nn}-{slug}.md` | `$plantask`、`$checktask`、`$simplify` |
| 归档任务 | `tasks/done/` | 编号避让 |
| 记忆体系 | `AGENTS.md` + `memory/` | Codex 新 session |

**典型跨 session 场景：**

```
Session 1:  $memorize + $office-hours         → 设计文档落盘
Session 2:  $plan-ceo-review                  → 读设计文档，写 CEO 计划
Session 3:  $plan-eng-review                  → 读设计文档 + DESIGN.md，写测试计划
           （或用 $autoplan 一次搞定 Session 2-3）
Session 4:  $gstack2task + $plantask          → 创建任务 + 实施方案
Session 5:  实现 + $simplify + commit         → 代码落盘
Session 6:  $review + $qa                     → 审查测试
Session 7:  $checktask + $ship                → 验收 + 创建 PR
Session 8:  $land-and-deploy                  → 合并 PR + 部署 + 生产验证
Session 9:  $document-release                 → 更新文档（可选）
```

也可以把多步合在一个 session 里 — 完全由你决定。

## 5. 大功能拆分策略

当一个功能过大（8+ 文件、1000+ 行），应拆成多个独立 task，每个 task 一条独立分支。

### 5.1 拆分原则

1. `$gstack2task` 默认保守拆分：只有当上游 implementation handoff 或 test plan 已明确划分成可独立交付的子块时，才拆成多个 task
2. `$issue2task` 同理：只有输入源明显过大、无法作为一次可控实现时，才拆
3. 多个 task 使用连续的新整数任务号：`T12`、`T13`、`T14`，不使用字母后缀
4. 每个 task 一条独立分支，分支名默认使用 task 文件名（去掉 `.md`）
5. 多个 task 不能共享同一条分支

### 5.2 拆分后的执行模式（按分支，不按步骤）

```
task/T12-user-model     → $plantask → 实现 → $review → $ship → $land-and-deploy
task/T13-user-api       → $plantask → 实现 → $review → $ship → $land-and-deploy
task/T14-user-dashboard → $plantask → 实现 → $review → $qa → $ship → $land-and-deploy
```

每条分支是一个独立的迷你 sprint：规划 → 实现 → 审查 → ship → deploy。不要在每次 commit 后都跑 `$review` → `$qa` → `$ship`，而是在每条分支完成后跑一次，让它 review 完整的 branch diff。

### 5.3 依赖管理

- 任务文件的 `## Dependencies` 段声明前置依赖
- `$plantask` 会检查前置任务是否已完成，未完成时明确指出并停止
- 推荐先完成被依赖的 task 并 merge 回 main，再从 main 新建下一个 task 的分支

## 6. 重要规则

### 6.1 任务入口分开

- GitHub issue 或直接需求：用 `$issue2task`
- `~/.gstack/projects/` 下的 design doc / handoff / test plan：用 `$gstack2task`
- 两者不要混成一个入口

### 6.2 每个步骤在哪个分支上做

- `$memorize`、`$office-hours`、`$plan-ceo-review`、`$design-consultation`、`$plan-design-review`、`$plan-eng-review`
  - 通常从 `main` 或 `master` 开始即可；这些步骤主要产出规划工件，不是 repo 内实现分支
- `$issue2task`、`$gstack2task`
  - 在当前 `HEAD` 上为每个 task 新建并切到该 task 自己的分支
- `$plantask`
  - 应在目标 task 自己的分支上运行
  - 如果你还停在 `main/master`，它会先切过去再继续
- 实现、`$simplify`、普通 commit、`$checkpoint`、`$design-review`、`$review`、`$qa`、`$checktask`、`$ship`
  - 都在当前 task 自己的分支上完成
- `$land-and-deploy`
  - 在 task 分支上执行，它会自动合并 PR 并切回 main
- `main/master`
  - 只作为 planning 起点和最终 merge 终点
  - 不要在 `main/master` 上直接做实现、`$design-review`、`$qa`、`$ship`

### 6.3 任务号和分支

- 任务号只用纯数字：`T01`、`T02`、`T03`
- 不再使用 `T18a`、`T18b` 这种后缀
- 每个 task 一条独立分支
- 多个 task 不能共享同一条分支

### 6.4 什么时候切分支

- 默认在 `$issue2task` 或 `$gstack2task` 时切分支
- 这两个 skill 会在写入 task 文件前，先切到该 task 自己的分支
- 如果你在 `main` 或 `master` 上执行 `$plantask`，它会先切到目标 task 对应的分支再继续

### 6.5 什么时候需要 `$checkpoint`

- 在第一次实现完成、准备跑 `$design-review` 或 `$qa` 前，推荐先跑一次 `$simplify`，再做普通 commit 或 `$checkpoint`
- 因为 `$design-review` 和 `$qa` 都要求 clean working tree
- 如果 `$review` 改了代码，而你后面还要继续 `$qa`、`$checktask`、`$ship`，先验证；必要时再补一次 `$simplify`，然后做普通 commit 或 `$checkpoint`
- 如果你只是想把当前 task 分支临时推到远端，也可以直接用 `$checkpoint`

### 6.6 什么时候合并回 main

- `$ship` 创建 PR 后，用 `$land-and-deploy` 完成合并和部署验证
- `$land-and-deploy` 会执行预合并就绪门禁（CI 绿 + review approved），然后 `gh pr merge`，等待部署完成，并用 `$canary` 验证生产环境
- 合并完成后，切回 `main`，同步主线，再开始下一轮 task
- 如果不使用 `$land-and-deploy`，也可以手动通过 GitHub PR / merge 流程合回 `main`

### 6.7 `$checktask` 不是第一次提交代码的时机

`$checktask` 是验收和归档，不是第一次提交代码。

更合理的顺序是：

```text
task 分支上实现
→ $simplify
→ 普通 commit 或 $checkpoint
→ $design-review / $review / $qa
→ 如果中间又产生新修改，必要时继续补 $simplify，再补普通 commit 或 $checkpoint
→ $checktask
→ $ship
```

### 6.8 `$design-review` 和 `$qa` 的前提

- 这两个 skill 都要求 clean working tree
- 它们会自己产生原子 fix commits
- 所以在跑它们之前，先把手头改动提交掉或 stash 掉

### 6.9 `$review` 的前提

- `$review` 会基于当前 diff 做结构审查
- 它可能 auto-fix，但默认不会替你自动创建 commit
- 如果它改了代码，先自己验证；必要时再补一次 `$simplify`，然后补普通 commit 或 `$checkpoint`，再继续 `$qa`、`$checktask` 或 `$ship`

## 7. 附录：纯 codev 模式

如果不使用 gstack，只用 codev 本身的轻量任务流：

```text
$memorize
→ $issue2task
→ $plantask
→ 实现 + 项目自己的测试
→ $checktask
→ $checkpoint
```

适合老项目，需求已经明确，不需要完整的 planning / QA / PR gate。
