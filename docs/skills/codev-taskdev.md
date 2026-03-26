# `$codev-taskdev`

Source: `codev`

## Purpose

按已审核的 task plan 在 task 分支上落代码，持续同步实现记录与待人工验证项，并在实现收尾自动做一次语义不变精简。

## Preconditions

- `tasks/` 中存在待办任务，或用户明确指定 task。
- 前置依赖任务已完成。
- 工作区可安全切换到目标 task 分支。

## Inputs / Source Of Truth

- `tasks/Txx-*.md`
- 当前代码
- task 分支
- task 中已有的 `Implementation Plan` 与 `Validation Plan`

## Produces / Writes

- 工作区代码改动
- 更新后的 `tasks/Txx-*.md`
- task 文档中的执行记录、实现说明、待人工验证项说明
- 一次内置的 `codev-simplify` 式语义不变精简结果

## Execution Flow

1. 选择目标任务，默认取最小编号待办任务。
2. 切到对应 task 分支；如不存在，则基于当前 `HEAD` 新建。
3. 读取 task 文件并检查依赖任务、目标、验收标准和相关代码。
4. 在编码前先校准 `Implementation Plan` 与 `Validation Plan`，避免 plan 已经漂移。
5. 分阶段实现代码，优先做容易收敛的小步修改。
6. 持续把实际采用路径、待执行人工验证和剩余缺口同步回 task 文档，不主动启动服务或运行验证。
7. 在实现收尾自动做一次语义不变精简，再把精简结果和当前状态同步回 task 文档。

## Stops / Failure Modes

- task 依赖未完成。
- 当前工作区无法安全切换分支。
- plan 与代码现状冲突严重，已经不是“轻微校准”能解决。
- 实现过程中暴露出必须人工判断的高影响路径选择。

## Next Recommended Steps

- 人工验证功能
- 验证通过后进入 `$codev-quickship`
