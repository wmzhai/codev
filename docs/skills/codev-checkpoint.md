# `$codev-checkpoint`

Source: `codev`

## Purpose

对当前分支做一次轻量 commit + push，默认同步已有 `CHANGELOG` 的未发布记录，但不更新根目录 `VERSION`、不创建或推送 tag。它只负责轻量提交，不接管更大的发布或审查流程。

## Preconditions

- 当前工作区存在可提交改动，或者 `CHANGELOG` 未发布记录同步可以产生可提交变更。
- 用户明确要做一次轻量 checkpoint。
- 接受它只是 fallback，而不是正式发布入口。
- 如果仓库本地规则要求 checkpoint 必须记录 changelog，则仓库里需要存在可更新的 `CHANGELOG`。

## Inputs / Source Of Truth

- 当前工作区 diff
- 当前分支状态
- 最近提交历史
- 仓库本地 checkpoint / changelog 规则
- 若适用，现有 `CHANGELOG`

## Produces / Writes

- 一次或多次普通 commit
- 当前分支 push 结果
- `CHANGELOG` 未发布记录同步结果

## Execution Flow

1. 检查分支、工作区和最近提交历史。
2. 读取仓库本地规则，默认同步已有 `CHANGELOG` 的未发布记录；如果本地规则要求 changelog 但找不到可更新文件，则停止。
3. 确认本次 checkpoint 没有修改 `VERSION`，没有创建或推送 tag。
4. 若工作区为空，且本次也没有成功产生可提交变更，则明确告知没有可提交内容并停止。
5. 暂存当前改动，生成简洁的 commit message。
6. 用非交互方式创建 commit；如 hook 改了文件，再补一次普通 commit。
7. 推送当前分支。
8. 向用户报告分支名、提交结果、commit hash、`CHANGELOG` 同步结果，并明确说明未升级版本、未创建 tag。

## Stops / Failure Modes

- 工作区为空，且本次也没有成功产生 `CHANGELOG` 变更。
- push 失败或权限不足。
- hook 失败，导致 commit 无法完成。
- 本地规则要求更新 changelog，但仓库缺少可更新的 `CHANGELOG`。

## Next Recommended Steps

- 继续本仓库的人工验证流程
- 需要归档和主干收尾时，进入 `$codev-quickship`
