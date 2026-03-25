# `$document-release`

Source: `gstack`

## Purpose

在代码或 PR 已经成型后，同步 repo 级人类文档，确保 README、ARCHITECTURE、CONTRIBUTING、CHANGELOG、CLAUDE 等内容与已交付事实一致。

## Preconditions

- 已有明确 diff、已 merge 结果，或至少已经 ready to ship。
- 用户想做 repo 级文档收口，而不是任务级局部说明。

## Inputs / Source Of Truth

- 当前 diff 或已 merge 结果
- README、CHANGELOG、ARCHITECTURE、CONTRIBUTING、CLAUDE、TODOS

## Produces / Writes

- 更新后的 repo 级文档
- 统一后的发布说明和变更摘要

## Execution Flow

1. 读取当前 diff 与主要文档，找出已交付事实与文档表述的差异。
2. 按 repo 级文档职责更新 README、CHANGELOG、贡献说明和宿主代理说明。
3. 清理与已交付内容不一致的 TODO 或过期指引。
4. 输出同步结果与仍需人工决定的文案点。

## Stops / Failure Modes

- 当前变更尚未稳定，文档事实还会继续漂移。
- 需要先确认版本号、合并结果或正式发布状态。

## Next Recommended Steps

- `$land-and-deploy` 前后都可使用
- 文档收口后继续 `$canary` 或 `$retro`
