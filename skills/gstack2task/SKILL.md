---
name: gstack2task
description: 从 `~/.gstack/projects/` 下与当前仓库相关的 gstack 工件读取设计、交接和测试计划，并生成 `tasks/` 下的任务文件。适用于上游已经跑过 gstack `/office-hours`、`/plan-*`，现在需要把这些工件压成 repo 内可执行任务的场景。
---

# Gstack2Task

把 gstack 在 `~/.gstack/projects/` 里产出的上游工件，收敛成 repo 内可执行的任务文件。

这个 skill 聚焦“把上游规划压成 task”。它不查询 GitHub issue，也不重复做一轮高层产品讨论。

## Inputs

从用户请求推断目标工件：

- 如果用户直接给了 `~/.gstack/projects/...` 下的文件路径，优先使用这个文件，并补读同项目、同分支下相关的最新工件。
- 如果用户给了 gstack project slug，如 `wyckoff`，使用 `~/.gstack/projects/<slug>/`。
- 如果用户没有给参数，先根据当前 git 仓库推断 project slug，并优先找当前分支对应的最新工件。

## Supported Artifacts

优先级从高到低：

1. `*-implementation-plan-*.md` 或其它 implementation handoff
2. `*-test-plan-*.md`
3. `*-design-*.md`
4. `*-ceo-handoff-*.md`、`ceo-plans/*.md`

当多个工件同时存在时，应把高优先级工件视为执行边界来源，低优先级工件视为补充上下文。

## Workflow

1. 确认当前目录是 git 仓库，并确认 `~/.gstack/projects/` 存在。缺少任一前提时明确报告阻塞并停止。
2. 定位 gstack project 目录：
   - 直接文件路径模式：从该文件反推 project 目录。
   - slug 模式：使用 `~/.gstack/projects/<slug>/`。
   - 无参数模式：优先根据当前仓库 remote slug 或仓库目录名匹配同名 project 目录；如果结果不唯一，明确指出候选项并停止。
3. 读取当前分支对应的最新工件；如果当前分支没有工件，再回退到该 project 目录下最新的同类型工件。
4. 综合这些工件，提取真正应该进入 repo 的执行信息：
   - 功能边界与 out-of-scope
   - 非协商约束
   - 关键用户场景与交互状态
   - 测试计划里的关键路径与边界条件
   - 明确的阶段拆分或可独立落地的子任务
5. 默认保守拆分：
   - 默认生成一个任务。
   - 只有当 implementation handoff 或 test plan 已经清楚划分成可独立交付的子块时，才拆成多个任务。
   - 如果拆成多个任务，共用同一个基础任务号，并按 `a` / `b` / `c` 后缀排序。
6. 创建或复用仓库根目录的 `tasks/`。
7. 分配编号规则与 `issue2task` 保持一致：
   - 扫描 `tasks/` 和 `tasks/done/` 中已有任务文件名的基础整数部分，取最大值顺延；如果还没有任务，从 `T01` 开始。
   - 多任务场景共用一个新基础任务号，并按 `a` / `b` / `c` 后缀。
8. 在写入任何 task 文件之前，先新建一个分支，并切到这个新分支：
   - 默认分支名使用本次将创建的第一个 task 文件去掉 `.md` 后的文件名。
   - 如果同名分支已存在，为保证“新建一个 branch”，应改用带短后缀的新分支名，并在结果摘要里说明。
9. 为每个任务写入 `tasks/T{nn}{suffix?}-{slug}.md`，模板如下：

```markdown
# T{nn}{suffix?}: {任务标题}

Source: gstack project artifacts

## Source Artifacts

- `~/.gstack/projects/.../foo-implementation-plan-....md`
- `~/.gstack/projects/.../foo-test-plan-....md`

## Source Context

- {从 design / handoff / test plan 提取的关键背景}

## Task Description

{整理后的完整需求，反映 gstack 工件已经确认的范围、约束与交付目标}

## Acceptance Criteria

- [ ] 标准 1
- [ ] 标准 2

## Related Code

- `path/to/file.ts` - 当前行为、关联模块或约束说明

## Dependencies

{任务编号列表或 "None"}

## Notes

{可选：保留对实现有影响的非协商约束、测试重点或阶段说明}
```

10. 输出简短摘要，包含使用了哪些 gstack 工件、创建了多少任务、新分支名，以及任务依赖关系。

## Rules

- 不要查询 GitHub issue；那是 `issue2task` 的职责。
- 不要把 gstack 的高层产品叙事整段搬进任务文件；只保留会影响实现和验收的事实。
- implementation handoff 与 test plan 的约束优先于 design doc 的宽泛表述；冲突时，在任务文件里按已读取工件显式收敛。
- 只写已经在工件里明确确认的范围和限制；没有依据时不要脑补产品方向。
- 写入 task 文件前必须先新建并切换到新分支；不要把新 task 文件直接写在原分支上。
- 默认直接产出任务文件，不把“等待用户二次确认”当成标准中间步骤；只有 project slug 无法确定或工件冲突严重且无法自行收敛时才提问。
- 不要提交代码。文件创建就是这个 skill 的最终副作用。
