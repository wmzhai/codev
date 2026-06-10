# `$codev-checkpoint`

Source: `codev`

## Purpose

对当前分支做一次轻量 commit + push。默认同步已有 `CHANGELOG` 的未发布记录，若能定位到当前任务则先同步任务状态并归档到 `tasks/done/`。它只负责轻量提交，不接管更大的发布或审查流程，不升级 `VERSION`，不创建或推送 tag。

## Preconditions

- 当前工作区存在可提交改动，或者 `CHANGELOG` 未发布记录同步可以产生可提交变更。
- 用户明确要做一次轻量 checkpoint。
- 接受它只是 fallback，而不是正式发布入口。
- 如果仓库本地规则要求 checkpoint 必须记录 changelog，则仓库里需要存在可更新的 `CHANGELOG`。
- 如果仓库存在 task 文件且可定位到当前任务，任务归档是本次 checkpoint 的可选前置步骤；仓库若无 task 则可跳过。

## Inputs / Source Of Truth

- 当前工作区 diff
- 当前分支状态
- 最近提交历史
- 仓库本地 checkpoint / changelog 规则
- 若适用，现有 `CHANGELOG`
- 可定位的当前 `tasks/Txx-*.md`

## Produces / Writes

- 一次或多次普通 commit
- 当前分支 push 结果
- `CHANGELOG` 未发布记录同步结果
- 当前 task（如存在）更新与归档结果

## Execution Flow

1. 检查分支、工作区和最近提交历史。
2. 读取仓库本地规则，默认同步已有 `CHANGELOG` 的未发布记录；如果本地规则要求 changelog 但找不到可更新文件，则停止。
3. 尝试定位当前任务并归档（有则执行）：
   - 优先读取用户显式指定的 task；没有显式指定时，优先匹配与当前分支同名的 `tasks/Txx-*.md`。
   - 找到任务后补齐任务最终记录（如人工验收结论、风险与未决项）并标记任务完成项。
   - 将任务文件通过 `git mv` 移入 `tasks/done/`；如目录不存在先创建。
   - 若当前仓库没有可定位任务，则记录“checkpoint 无 task 路径”，仅执行未发布 changelog 同步。
4. 确认本次 checkpoint 没有修改 `VERSION`，没有创建或推送 tag。
5. 若工作区为空，且本次也没有成功产生可提交变更，则明确告知没有可提交内容并停止。
6. 暂存当前改动，生成简洁的 commit message。
7. 用非交互方式创建 commit；如 hook 改了文件，再补一次普通 commit。
8. 推送当前分支。
9. 向用户报告分支名、提交结果、commit hash、任务处理结果与 `CHANGELOG` 同步结果，并明确说明未升级版本、未创建 tag。

## Stops / Failure Modes

- 工作区为空，且本次也没有成功产生 `CHANGELOG` 变更。
- push 失败或权限不足。
- hook 失败，导致 commit 无法完成。
- 本地规则要求更新 changelog，但仓库缺少可更新的 `CHANGELOG`。
- 任务文件可定位但无权限或 `git mv` 失败。

## Next Recommended Steps

- 继续本仓库的人工验证流程
- 需要归档和主干收尾时，进入 `$codev-quickship`
