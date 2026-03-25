# `$autoplan`

Source: `gstack`

## Purpose

自动串联 CEO、Design、Eng 三类 planning review，把能自动决策的部分直接处理掉，只把真正需要人工拍板的问题暴露出来。

## Preconditions

- 已有可 review 的 plan 或 design doc。
- 用户希望一次性跑完整个 planning review gauntlet。

## Inputs / Source Of Truth

- 当前 plan 文件
- 当前分支 design doc
- repo 当前上下文
- CEO / Design / Eng review 的规则与历史记录

## Produces / Writes

- 修补后的 plan 文件
- CEO / Design / Eng review 对应的工件和日志

## Execution Flow

1. 读取 design doc、plan 文件和相关 review 规则。
2. 依次执行 `$plan-ceo-review`、`$plan-design-review`、`$plan-eng-review` 的核心检查。
3. 按自身决策原则自动处理明显答案的问题。
4. 遇到 taste、scope、tradeoff 分歧时，把问题集中暴露给用户。
5. 将最终计划与 review 产物写回既有位置。

## Stops / Failure Modes

- 缺少基础 plan 或 design doc。
- 出现必须人工判断的核心方向分歧。
- 当前计划质量太差，无法直接进入自动串联。

## Next Recommended Steps

- `$codev-gstack2task`
- `$codev-issue2task`
- 或在特定 task 前补跑单独的 planning review
