---
name: codev-checkpoint
description: 轻量提交当前仓库变更并推送当前分支。适用于用户明确要做一次 codev-checkpoint 提交；默认同步已有 `CHANGELOG` 的未发布记录，但不升级 `VERSION`、不打 tag。
---

# Checkpoint

安全地提交当前工作区变更并推送。

如果仓库同时使用 gstack，默认发布入口应是 gstack `$ship`。`codev-checkpoint` 只保留为轻量 fallback：做 `CHANGELOG` 未发布记录、commit、push，但不处理根目录 `VERSION`、不打 tag、不接管 PR、review gate、QA 串联或 repo 级文档同步。

## 第一规则：先用中文交流

- skill 一触发，第一句就用中文和用户交流。
- 整个执行过程中的状态说明、阻塞说明和结果摘要默认都用中文。
- 只有用户明确要求英文或双语时，才切换语言。

## Inputs

从用户请求推断发布模式：

- 默认执行已有 `CHANGELOG` 同步 + commit + push。
- 默认不修改根目录 `VERSION`，不创建 tag，也不推送 tag。
- 如果仓库本地规则要求 checkpoint 必须记录在指定 changelog 位置，优先遵守本地规则。
- 如果仓库没有已有 `CHANGELOG`，且本地规则没有要求必须更新 changelog，则只做 commit + push；不要自动新建 `CHANGELOG`。

## Workflow

1. 用非交互式 git 命令检查仓库状态，例如：
   - `git status --short --branch`
   - `git log --oneline -5`
2. 读取仓库本地规则：
   - 优先查看根 `AGENTS.md`、`README.md`、已有 `CHANGELOG` 的版本/收尾说明。
   - 如果本地规则和本 skill 冲突，以本地规则为准，但 checkpoint 仍不得升级 `VERSION`、不得创建或推送 tag。
3. 同步已有 `CHANGELOG`：
   - 优先定位根目录 `CHANGELOG.md`；如果本地规则指定其它文件，则按本地规则执行。
   - 基于本次实际 diff，对 `CHANGELOG` 做最小同步，记录这次 checkpoint 的改动摘要，通常写入 `[未发布]` / `Unreleased` 区域。
   - 不新建 `CHANGELOG`，除非用户同轮明确要求。
   - 如果本地规则要求必须更新 changelog 但找不到可更新文件，立即停止并说明原因。
   - 不要把 checkpoint 记录改写成正式发布说明。
4. 确认没有修改 `VERSION`，没有创建 tag；如果误改了版本或 tag，必须先纠正再继续。
5. 如果工作区干净，且本次也没有产生可提交变更，明确告知没有可提交内容并停止。
6. 使用 `git add -A` 暂存所有变更，不做选择性过滤。
7. 根据 staged diff 生成简洁的 conventional commit message。
8. 用非交互方式创建 commit：
   - 不使用 `--amend`
   - 不使用 `--no-verify`
   - 不依赖交互式编辑器
9. 如果 hooks 在 commit 过程中修改了文件，重新暂存这些变更并创建第二个普通 commit，不改写刚才的提交历史。
10. 推送当前分支。
11. 返回简洁摘要，包含当前分支、结果 commit hash、`CHANGELOG` 同步结果，并明确说明未升级版本、未创建 tag。

## Rules

- 把 codev-checkpoint 视为有副作用的显式操作；不能假装完成。
- 除非用户明确要求，不要排除任何已改动文件。
- 不要重写历史。
- 如果前置条件失败，立即停止并明确说明原因。
- 不运行 CI；codev-checkpoint 只根据当前现状做一次提交和推送。
- 不做版本管理；不改 `VERSION`。
- checkpoint 默认同步已有 `CHANGELOG` 的未发布记录；不新建 `CHANGELOG`，除非用户同轮明确要求。
- checkpoint 不打 tag、不推送 tag、也不进入 release 管理。
- 如果用户要求 checkpoint 升级版本或打 tag，要说明这属于 quickship/release 类动作，不属于 checkpoint。
- 不要创建 PR、补 review gate、同步 repo 级文档；这些属于 gstack `$ship` 与 `$document-release` 的职责。
