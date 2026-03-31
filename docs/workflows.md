# 工作流总览

`docs/workflows.md` 是 codev 的唯一工作流导航。默认先读这里，再按需要进入对应的 skill 手册。

## 默认主线

```text
README.md
-> docs/workflows.md
-> docs/skills/README.md
-> 选择任务入口
   - issue / 直接需求 -> $codev-issue2task
   - gstack 工件 -> $codev-gstack2task
-> 人工审核 task plan
-> $codev-taskdev
-> 人工验证
-> $codev-quickship

轻量提交 fallback：$codev-checkpoint
```

## 主流程说明

### 1. 仓库准备

- 默认先读 `README.md`、本文和 `docs/skills/README.md`。
- 需要刷新仓库记忆入口时，用 `$codev-memorize`。
- `setup` 只安装本仓库受管 skills，不负责外部 gstack 安装。

### 2. 任务入口

- GitHub issue 或直接需求：`$codev-issue2task`
- 已有 `~/.gstack/projects/` 工件：`$codev-gstack2task`

两者都会落成 `tasks/` 下可执行的 task 文件，但输入边界不要混用。

### 3. task 审核与实现

- 先人工审核 task 文件中的 `Implementation Plan` / `Validation Plan`。
- 审核通过后，用 `$codev-taskdev` 在 task 分支推进实现。
- `codev-taskdev` 负责代码实现、任务文档同步，以及一次实现收尾精简。

### 4. 验证与收尾

- 功能验证默认由人工完成。
- 人工确认通过后，用 `$codev-quickship` 做 task 归档、相关文档同步与主干收尾。
- 若只需要中途做一次轻量 `commit / push`，用 `$codev-checkpoint`。

## 条件性旁支

### 浏览器与登录态验证

以下场景再进入这条旁支：
- 需要真实浏览器复现、截图或交互验证
- 需要访问登录态页面

常用入口：
- `$browse`
- `$setup-browser-cookies`

### 风险控制、调试与专项审查

以下场景再进入这条旁支：
- 高风险操作前需要额外保护
- 需要先做根因排查
- 需要性能或安全专项审查

常用入口：
- `$careful`
- `$freeze`
- `$guard`
- `$unfreeze`
- `$investigate`
- `$benchmark`
- `$cso`

这些都属于条件性旁支，不是默认每个任务都要跑。

## 与 gstack 的边界

- `codev` 的默认主线是任务生成、task 分支实现、人工验证和收尾。
- 若输入来自 `~/.gstack/projects/` 下的工件，使用 `$codev-gstack2task`。
- 若需要正式发布链路或更完整的外部发布流程，转入 gstack 的外部流程；本文不展开该链路。

## 相关文档

- skill 索引：`docs/skills/README.md`
- codev 与 gstack 的协作边界：`memory/core/gstack-interoperability.md`
- 仓库级事实与维护规则：`AGENTS.md`
