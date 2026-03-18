---
name: issue2task
description: 分析当前仓库的 GitHub Issues，结合现有代码理解需求，并生成 tasks/ 下的任务文件。适用于用户要先梳理需求、澄清范围、建立依赖顺序，再进入实现阶段的场景；默认应自行收敛范围，只有阻塞性歧义才中途提问。
---

# Issue2Task

把 issue 先理解清楚，再落成可以执行的任务文件。

这个 skill 聚焦需求梳理和任务拆解，不负责代码实现方案。

## Inputs

从用户请求推断范围：

- 如果用户指定了单个 issue，如 `42` 或 `#42`，只处理该 issue。
- 如果用户带了 `gh issue list` 可接受的过滤条件，如 `--label`、`--milestone`、`--assignee`，按这些条件取 issue。
- 如果用户没有给过滤条件，默认处理当前仓库所有 open issues。

## Workflow

1. 确认当前目录是 git 仓库且 `gh` 可用；缺少任一前提时明确报告阻塞并停止。
2. 读取 issue：
   - 单个 issue 用 `gh issue view`。
   - 多个 issue 用 `gh issue list --state open --json number,title,body,labels,comments,milestone,assignees --limit 200`。
3. 仔细阅读 issue 的标题、正文、标签、里程碑和评论，然后大量阅读相关代码建立上下文：
   - 当前行为是什么。
   - 涉及哪些模块、文件和调用关系。
   - 有哪些 issue 没写清但代码里真实存在的约束。
   - 影响范围可能扩展到哪里。
4. 基于 issue 和代码现状先自行收敛需求理解，并把关键判断写进任务文件：
   - 明确功能边界和 out-of-scope。
   - 补全关键用户场景。
   - 标出边界条件、异常流、权限和空状态。
   - 把验收标准写成可验证的表述。
   - 只有在歧义会显著改变任务拆分或让验收标准失真、且无法从代码或 issue 上下文推断时，才中途向用户提一个最小问题。
5. 任务拆分默认保守处理：
   - 默认一个 issue 对应一个任务，不主动过度拆分。
   - 只有在 issue 明显过大、无法作为一次可控实现时，才拆成多个可独立落地的任务。
   - 只有在多个小 issue 高度耦合、拆开会制造无意义边界时，才合并为一个任务。
6. 创建或复用仓库根目录的 `tasks/`。
7. 保留已有任务为默认行为：
   - 查找 `tasks/` 和 `tasks/done/` 中现有最大任务号并继续编号。
   - 只有用户明确要求 regenerate 或 overwrite 时才覆盖已有任务文件。
8. 为每个任务写入 `tasks/T{nn}-{slug}.md`，模板如下：

```markdown
# T{nn}: {任务标题}

## Source Issues

- #123 Issue 标题

## Task Description

{整理后的完整需求，反映 issue、代码现状与用户已明确提供的信息所收敛出的范围和目标}

## Acceptance Criteria

- [ ] 标准 1
- [ ] 标准 2

## Related Code

- `path/to/file.ts` - 当前行为、关联模块或约束说明

## Dependencies

{任务编号列表或 "None"}

## Notes

{可选：评论中的技术约束、需求细节、取舍说明}
```

9. 生成或刷新 `tasks/README.md`，用紧凑表格列出任务编号、标题、来源 issue 和依赖关系。
10. 输出简短摘要，包含分析了多少 issue、创建了多少任务，以及结果依赖链。

## Rules

- 先做需求澄清，再写任务文件；不要把 issue 原文直接机械搬运成任务。
- 重点保留会影响实现的技术细节、约束和用户已明确提供的信息。
- 任务文件应足够让 `plantask` 直接接手，而不是重新从零理解问题。
- 默认直接产出任务文件，不把“等待用户二次确认”当成标准中间步骤；无法安全假设时才提问。
- 不要提交代码。文件创建就是这个 skill 的最终副作用。
