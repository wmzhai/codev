# `$codev-commit`

Source: `codev`

## Purpose

把当前 git 仓库里已经存在的改动直接提交，并推送当前分支。
不改 `VERSION`，不写 changelog，不归档任务，不跑 build/test/lint/typecheck，也不询问确认。

适用于只改了小文档或一小处、希望马上提交的场景。需要版本和发版时用 `codev-ship`。需要任务归档和 `CHANGELOG` 时用 `codev-checkpoint`。

Codex：`$codev-commit`。Grok、Claude Code、Cursor：`/codev-commit`。

## Execution

- 只处理当前工作目录所在的 git 仓库，不切换分支，不合并主干。
- 没有可提交改动时停止，不创建空提交。
- 子模块里有未提交内容时，先对那个子模块做同样的直接提交和推送，再把父仓 gitlink 一并提交并推送。
- 提交说明用一行概括 diff。用户在指令里给了说明就直接用，不带版本后缀。
- 使用普通 `git commit` 和 `git push`。已有上游就推送上游；没有上游且存在 `origin` 时 `git push -u origin HEAD`。
- 用户这次没有明确要求时，不加 `--no-verify`。hook 失败就停下并汇报。
- 不 force push，不开 PR，不打 tag。

## Stops / Failure Modes

- 当前目录不是 git 仓库。
- 没有可提交改动。
- `git commit` 或 `git push` 失败。推送失败时保留已经创建的提交。
