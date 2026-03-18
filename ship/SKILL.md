---
name: ship
description: 提交当前仓库变更并推送当前分支；如果用户提供版本号，则额外创建并推送 release tag。适用于用户要走受控的提交、推送、发版流程时使用。
---

# Ship

安全地提交当前工作区变更并推送。用户提供版本号时，再创建并推送对应 tag。

## Inputs

从用户请求推断发布模式：

- 没有版本号时，执行 commit + push。
- 版本号匹配 `vX.Y.Z` 或 `vX.Y.Z-rcN` 时，执行 commit + push + tag + push tag。

## Workflow

1. 用非交互式 git 命令检查仓库状态，例如：
   - `git status --short --branch`
   - `git log --oneline -5`
2. 如果工作区干净且未请求版本号，明确告知没有可提交变更并停止。
3. 判断本地 CI 是否存在：
   - 优先检查项目包管理配置中的 `ci` script。
   - 无版本号时，在提交前运行本地 CI。
   - 有版本号时，在创建 tag 前运行本地 CI。
   - 如果没有 CI 脚本，明确跳过，不自行发明命令。
4. 使用 `git add -A` 暂存所有变更，不做选择性过滤。
5. 根据 staged diff 生成简洁的 conventional commit message。
6. 用非交互方式创建 commit：
   - 不使用 `--amend`
   - 不使用 `--no-verify`
   - 不依赖交互式编辑器
7. 如果 hooks 在 commit 过程中修改了文件，重新暂存这些变更并创建第二个普通 commit，不改写刚才的提交历史。
8. 推送当前分支。
9. 如果用户请求了版本号：
   - 校验版本号匹配 `^v[0-9]+\\.[0-9]+\\.[0-9]+(?:-rc[0-9]+)?$`
   - 检查该 tag 尚不存在
   - 在分支 push 成功后创建 tag
   - 将 tag 推送到 `origin`
10. 返回简洁摘要，包含当前分支、结果 commit hash、是否创建 tag，以及执行过的 CI 命令。

## Rules

- 把 ship 视为有副作用的显式操作；不能假装完成。
- 除非用户明确要求，不要排除任何已改动文件。
- 不要重写历史。
- 如果前置条件失败，立即停止并明确说明原因。
- 版本号流程必须在 CI 成功且分支 push 成功后再打 tag，避免推出坏 tag。
