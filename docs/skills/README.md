# Skill 手册索引

这里收录本仓库当前仍受管的 codev 自定义 skill 说明。想先看整体流程，先回到 `docs/workflows.md`。

## 命名约定

- codev 自定义 skill：使用 `codev-*` 前缀。
- 用户对话里的调用前缀：Codex 用 `$codev-*`，Grok、Claude Code 和 Cursor 用 `/codev-*`。落盘文档同时写四家。

## 1. 仓库初始化与记忆

- [codev-memorize](codev-memorize.md)：初始化或刷新仓库级记忆入口。

## 2. 任务生成

- [codev-issue2task](codev-issue2task.md)：把 issue 或直接需求整理成可执行 task。

## 3. task 分支实现与收口

- [codev-taskdev](codev-taskdev.md)：按已审核 task 在任务分支推进实现，收尾勾选已验证验收项，并自动做一次语义不变精简和默认 build 校验；这是 ship/checkpoint 前唯一由 codev 自动承担的编译校验责任点。
- [codev-ship](codev-ship.md)：人工验证通过后的统一收尾，主流程与 checkpoint 一致，额外做 `VERSION` 同步、附注 tag 与 GitHub Release；提交正文、tag 附注和 Release 说明复用同一份 changelog 版本段。缺少 `VERSION` 或 changelog 时主动创建（首发 `0.0.1`），不补做自动验证。
- [codev-commit](codev-commit.md)：把当前仓库已有改动直接提交并推送当前分支。不改版本、不写 `CHANGELOG`、不归档任务、不跑检查，也不询问确认。适用于小文档这类马上要提交的改动。
- [codev-simplify](codev-simplify.md)：做语义不变的精简，可单独调用。
- [codev-checkpoint](codev-checkpoint.md)：做一次轻量 `commit / push`；主流程与 ship 一致，不升级版本号和 tag，不补做自动验证。

## 4. 开源上游同步

- [codev-syncpatch](codev-syncpatch.md)：同步 upstream 最新代码，并按原意重放本地运行补丁；默认不提交、不 push、不默认创建分支。
