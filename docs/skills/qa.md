# `$qa`

Source: `gstack`

## Purpose

系统性测试真实用户流程，发现 bug，必要时直接修复，再重新验证到可交付状态。

## Preconditions

- 存在可运行页面、部署环境或本地启动方式。
- 最好已有 test plan；如无，也能基于实际流程生成测试路线。

## Inputs / Source Of Truth

- 当前部署 URL、本地运行环境或目标页面
- 如存在则读取 eng review test plan
- 当前 diff、task 文档与用户流程描述

## Produces / Writes

- QA 报告
- 发现并修复的 bug
- before / after 健康度、截图与回归验证结果

## Execution Flow

1. 读取 test plan 或自行建立关键用户流程清单。
2. 在真实浏览器中逐条走流程，记录异常、错误和视觉/交互问题。
3. 按优先级修复 critical/high bug，并为每个修复做回归验证。
4. 输出健康度、剩余风险和是否 ready to ship 的结论。

## Stops / Failure Modes

- 无法启动目标环境。
- 需要登录态但未准备 cookie。
- 问题根因不明，修复前需要先 `$investigate`。

## Next Recommended Steps

- 人工验证通过后进入 `$codev-quickship`
- `$ship`
- 只想报告不修时使用 `$qa-only`
