# `$plan-eng-review`

Source: `gstack`

## Purpose

在实现前锁定架构、失败模式、数据流、测试计划和覆盖边界，让 plan 具备可执行的工程骨架。

## Preconditions

- 当前存在可 review 的 plan。
- 最好已经有 design doc；没有时通常先跑 `$office-hours`。

## Inputs / Source Of Truth

- 当前 plan 文件
- 当前分支 design doc
- `DESIGN.md`
- repo 当前架构、测试基础设施和关键代码路径

## Produces / Writes

- 修订后的 plan 文件
- `~/.gstack/projects/{slug}/*-eng-review-test-plan-*.md`
- 架构图、数据流图、覆盖矩阵或等价工件

## Execution Flow

1. 对当前系统做工程审计，识别关键模块、复杂度与风险点。
2. 审查架构分层、同步/异步边界、失败模式和恢复路径。
3. 补齐测试覆盖、关键场景、边界条件和性能关注点。
4. 通过图示或结构化说明把关键 engineering 决策写回 plan。
5. 产出正式 test plan，供后续 `$qa` 或 `$qa-only` 使用。

## Stops / Failure Modes

- plan 或基础上下文不足。
- 架构风险过大，必须先做 scope 或设计层调整。

## Next Recommended Steps

- `$codev-gstack2task`
- 特定 task 前的局部 engineering review
