# `$ship`

Source: `gstack`

## Purpose

在正式合并前完成主干同步、测试、版本号、CHANGELOG、提交、push 和 PR 创建，把分支送到 ready-to-land 状态。

## Preconditions

- 当前分支已经过基本实现和验证。
- 仓库允许通过 PR 进入主干。
- 用户准备进入正式发布流程。

## Inputs / Source Of Truth

- 当前分支与 diff
- 测试入口、版本号文件、CHANGELOG
- repo 的 PR 与分支策略

## Produces / Writes

- 更新后的版本号或 CHANGELOG
- commit / push 结果
- 新建 PR

## Execution Flow

1. 同步基线分支并确认当前 diff 是否 ready to ship。
2. 运行必要测试与覆盖率检查。
3. 审查版本号、CHANGELOG 和发布说明是否需要更新。
4. 创建提交并 push 当前分支。
5. 打开或更新 PR，把分支送到可 land 状态。

## Stops / Failure Modes

- 测试未通过。
- diff 还未过 review/QA 门禁。
- PR 或 push 权限不足。

## Next Recommended Steps

- `$land-and-deploy`
- 如文档仍漂移，补 `$document-release`
