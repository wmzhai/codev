---
name: codev-syncpatch
description: 在开源仓库长期保留本地运行补丁并需要从 upstream 同步最新代码时使用；适用于 dirty worktree、未提交本地修改、需要先判断本地补丁能否按原意重放的场景。
---

# Syncpatch

把当前仓库更新到 upstream 最新代码，同时把需要保留的修改转成“脏工作区状态”。

默认在当前主干或当前分支工作区执行：不提交、不 push、不默认创建分支。目标状态是：
- `HEAD` 对齐到 upstream 最新提交
- 本地需要保留的改动以未提交的工作区修改存在
- 不把本地补丁保留为额外提交

核心要求是先判断能不能高置信度按原意补回本地修改；如果不能，先和用户确认，不要继续做高风险同步。

## 第一规则：先用中文交流

- skill 一触发，第一句就用中文和用户交流。
- 整个执行过程中的判断说明、风险说明、阻塞说明和结果摘要默认都用中文。
- 只有用户明确要求英文或双语时，才切换语言。

## 适用场景

- 跟踪开源项目，同时维护本地运行补丁。
- 本地有未提交改动，需要先同步 upstream 最新提交。
- 本地补丁可能不是简单文本冲突，需要按行为意图重放到新代码上。

不适用于正式发布、提交、推送、PR、版本同步或 task 收尾；这些分别属于其他 codev/gstack 流程。

## 硬性约束

- 不创建 commit，不 push，不默认创建分支。
- 不使用 `git reset --hard`、`git checkout -- .`、`git clean -fd`。
- 不在备份本地 diff 前执行 `git pull`、`git merge` 或 `git rebase`。
- 不把 stash 当成唯一备份；必须同时保存 patch 证据到 `.git/codev-syncpatch/<timestamp>/`。
- 不用简单的 `ours` / `theirs` 策略处理复杂冲突；必须按本地修改意图重新补。
- 如果不能高置信度判断可以完整补回本地逻辑，必须先停下和用户确认。
- 如果存在本地提交，但用户目标是“最终只保留脏工作区、不要额外本地提交”，允许把本地提交吸收到工作区修改里；不要把这种场景误判成必须改用 `rebase` / `merge`。

## 同步前风险评估

先做只读或不改工作区的检查：

1. 检查仓库状态：
   - `git status --short --branch`
   - `git diff --stat`
   - `git diff`
   - `git diff --cached`
   - `git ls-files --others --exclude-standard`
2. 如果存在 merge/rebase/cherry-pick 状态，立即停止，说明当前不是安全同步起点。
3. 先把当前 diff 备份到 `.git/codev-syncpatch/<timestamp>/`：
   - `status.txt`
   - `unstaged.patch`
   - `staged.patch`
   - `untracked-files.txt`
   - 如有未跟踪文件，保存 `untracked.tar`。
4. 执行 `git fetch --prune`，只更新远端引用，不改工作区。
5. 检查 upstream 与相关文件变化，例如：
   - `git rev-parse --abbrev-ref --symbolic-full-name @{u}`
   - `git rev-list --left-right --count HEAD...@{u}`
   - `git diff --name-status HEAD...@{u}`
6. 用自然语言归纳本地补丁意图，并评估是否能高置信度重放。
7. 如果 `git rev-list --left-right --count HEAD...@{u}` 显示本地领先提交数大于 0，先判断用户目标：
   - 如果目标是“保留本地提交历史”，停止并改用 `rebase` / `merge` 方案
   - 如果目标是“最终不要本地提交，只保留脏工作区”，继续走“把本地提交吸收到工作区”的流程

风险判断：

- 低风险：本地补丁集中、upstream 未明显重写相关接口、验证路径明确。
- 中风险：upstream 也改了相关文件，但仍能明确说明本地意图如何迁移。
- 高风险：本地补丁依赖已变化的接口、跨模块行为不确定、测试路径不清楚、或无法说明等价重放方式。

只有在能明确说明“本地意图是什么、会如何补到最新代码、用什么验证”的情况下继续。否则先问用户是否退出、只保留备份、分阶段手工处理，或改变同步策略。

## Workflow

1. 完成同步前风险评估；不确定就先停下问用户。
2. 把当前 diff 备份到 `.git/codev-syncpatch/<timestamp>/`，并额外记录本地提交范围：
   - `status.txt`
   - `unstaged.patch`
   - `staged.patch`
   - `untracked-files.txt`
   - `commits.log`：`git log --oneline @{u}..HEAD`
   - `commits.patch`：`git diff @{u}..HEAD`
   - 如有未跟踪文件，保存 `untracked.tar`
3. 用 `git stash push -u -m "codev-syncpatch:<timestamp>"` 保存 tracked 和 untracked 改动。
4. 按分支状态分流：
   - 如果 `git rev-list --left-right --count HEAD...@{u}` 的本地领先数为 0，执行 `git pull --ff-only`，把 `HEAD` 直接推进到 upstream 最新提交
   - 如果本地领先数大于 0，且用户目标是“最终不要本地提交，只保留脏工作区”，跳过 `pull`，直接执行 `git reset --soft @{u}`，把分支头移到 upstream 最新提交
5. 若执行了 `git reset --soft @{u}`，再执行 `git restore --staged .`，把由本地提交带来的 staged 变化转成工作区修改
6. 用 `git stash apply` 恢复本地补丁；不要用 `pop`。
7. 如果自动应用成功，仍要阅读新 diff，确认本地意图在最新代码里仍成立。
8. 如果出现冲突，按备份 patch、本地意图和最新代码重新实现等价逻辑。
9. 如果发现 upstream 已经实现等价能力，删除或收窄对应本地补丁，并说明该部分已被上游吸收。
10. 运行与本地补丁相关的最小验证。
11. 输出当前分支、同步结果、本地保留改动、验证结果、stash 与 `.git/codev-syncpatch/` 备份位置。

## 无法完美合并时

一旦不能确认补丁能完整、正确地重放，立即停下，不要继续猜测。向用户说明：

- 已经完成的安全步骤和当前仓库状态。
- 本地补丁原始意图。
- 哪些部分能确定补回，哪些部分不能确定。
- 建议选项：退出并保留备份、只应用确定部分、逐个冲突点人工确认、或放弃某部分本地补丁。

如果用户选择退出，保持可恢复状态：stash 不删除，`.git/codev-syncpatch/<timestamp>/` 不删除，工作区状态说明清楚。

## 验证与输出

验证优先级：

1. 脚本和配置补丁：语法检查，例如 `bash -n`。
2. 后端代码补丁：相关单元测试或最小 pytest。
3. 前端代码补丁：相关 typecheck/test。
4. 无测试路径时，明确说明未验证的剩余风险。

最终摘要必须说明：

- 是否已经同步到 upstream 最新提交。
- 本地补丁是否完整补回。
- 当前工作区是否仍有未提交修改。
- stash 是否保留，以及备份目录路径。
- 没有创建 commit、push 或默认分支。
