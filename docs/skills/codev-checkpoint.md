# `$codev-checkpoint`

Source: `codev`

## Purpose

人工验证后的统一收口第一阶段：任务/验收归口、`docs`/`memory`/`AGENTS` 同步、`CHANGELOG` 未发布更新、最小校验、主干提交与 issue 处理。
本阶段不做版本 bump 与 tag。

## Preconditions

- 用户触发 `$checkpoint` / `$codev-checkpoint` 且同轮已人工验证通过。
- 当前允许直接 push 主干，`CHANGELOG` 更新路径可定位。
- task 有可定位性；无 task 时以无 task 模式收口。
- task 映射 issue 时 `gh` 可用且 issue 号可解析。

## Execution（阶段一）

- 按 `codev-checkpoint` 的工作区范围收口根仓库与可见子仓未提交改动。
- 有 task：归档到 `tasks/done/`、补充验收结论与 `Acceptance Criteria`。
- 同步本轮直接相关 `docs`、`memory`；必要时更新 `AGENTS.md`。
- 执行最小校验（有 task 优先复用 `codev-taskdev`），无 task 按改动类型最小化处理。
- 更新 `CHANGELOG` 的未发布记录；不改写历史发布段。
- 提交并推送主干，完成后按 task 映射执行 `gh issue comment` 与 `gh issue close`。
- 明确汇报“阶段一未执行版本 bump 与 tag”。
