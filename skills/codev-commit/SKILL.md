---
name: codev-commit
description: 把当前 git 仓库里已经存在的改动直接提交并推送当前分支，不改 VERSION、不写 CHANGELOG、不归档任务、不跑 build/test/lint，也不询问确认。适用于只改了小文档或小改动、希望马上提交的场景。Codex 用 `$codev-commit`，Grok、Claude Code、Cursor 用 `/codev-commit`。
---

# Commit

## 第一规则：先用中文交流

- skill 一触发，第一句就用中文和用户交流。
- 结果只用中文汇报。
- 只有用户明确要求英文或双语时，才切换语言。

## 作用

对当前工作目录所在 git 仓库里已经存在的改动做一次提交，并推送当前分支。
不做任务归档、文档同步、`CHANGELOG`、`VERSION`、tag、Release、issue、build、test、lint、typecheck，也不询问确认。

需要版本和发版时用 `codev-ship`。需要任务归档和 `CHANGELOG` 时用 `codev-checkpoint`。

## 触发

用户触发 `commit` / `codev-commit`（Codex 为 `$codev-commit`，Grok、Claude Code 与 Cursor 为 `/codev-commit`）后立即执行。

## 执行

1. 只处理当前工作目录所在的 git 仓库。不切换分支，不合并主干，不处理别的仓库。
2. 用 `git status --porcelain=v1 --ignore-submodules=none` 看已有改动。没有可提交内容时说明并停止，不要创建空提交。
3. 子模块目录里有未提交内容时，先进入该子模块，用同样的方式直接提交并推送它的当前分支，再回到父仓。除此之外不进入子模块。
4. 把当前仓库已有改动一次提交。遵守 gitignore。不要改文件内容，不要补文档，不要改 `VERSION` 或 changelog。
5. 提交说明用一行概括这次 diff。用户在指令里已经给了说明时，整段说明就是提交标题，不要再改写。不带版本后缀。
6. 使用普通 `git commit`。不要加 `--no-verify`，除非用户在这次指令里明确要求跳过 hook。hook 失败就停下并原样汇报。
7. 提交成功后推送当前分支。已有上游就 `git push`。没有上游且存在 `origin` 时 `git push -u origin HEAD`。不要 force push，不要开 PR，不要打 tag。
8. 推送失败时保留提交，汇报失败原因后停止。
9. 用中文汇报提交哈希、说明、分支和推送结果，并写明没有做版本、`CHANGELOG`、任务归档和检查。

## 禁止

- 不读任务文件，不归档，不关 issue。
- 不改 `VERSION`、changelog、`docs/`、`memory/` 或宿主入口。
- 不运行 build、test、lint、typecheck 或任何检查脚本。
- 不询问要不要提交或要不要推送。
- 不 amend，不 rebase，不 force push。
