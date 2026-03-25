# `$codev-checkpoint`

Source: `codev`

## Purpose

对当前分支做一次轻量 commit + push，不接管 PR、review gate、QA 串联或 repo 级文档同步。

## Preconditions

- 当前工作区存在可提交改动。
- 用户明确要做一次轻量 checkpoint。
- 接受它只是 fallback，而不是正式发布入口。

## Inputs / Source Of Truth

- 当前工作区 diff
- 当前分支状态
- 最近提交历史

## Produces / Writes

- 一次或多次普通 commit
- 当前分支 push 结果

## Execution Flow

1. 检查分支、工作区和最近提交历史。
2. 若工作区为空，则明确告知没有可提交内容并停止。
3. 暂存当前改动，生成简洁的 commit message。
4. 用非交互方式创建 commit；如 hook 改了文件，再补一次普通 commit。
5. 推送当前分支。
6. 向用户报告分支名、提交结果与 commit hash。

## Stops / Failure Modes

- 工作区为空。
- push 失败或权限不足。
- hook 失败，导致 commit 无法完成。

## Next Recommended Steps

- 继续 `$design-review`、`$review`、`$qa`
- 正式发布仍应进入 `$ship`
