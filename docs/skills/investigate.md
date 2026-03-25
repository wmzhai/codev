# `$investigate`

Source: `gstack`

## Purpose

做根因导向的系统性调试，在没有确认 root cause 之前不进入拍脑袋修复。

## Preconditions

- 用户报告了 bug、异常或不符合预期的行为。
- 允许先花时间调查，而不是立刻改代码。

## Inputs / Source Of Truth

- 报错现象、复现步骤、日志、截图
- 当前代码和相关系统边界

## Produces / Writes

- 根因分析
- 调试路径
- 必要时回流到后续修复 plan

## Execution Flow

1. 收集症状、复现步骤和受影响范围。
2. 沿数据流和调用链调查潜在根因。
3. 验证假设，排除伪线索。
4. 确认 root cause 后，再进入实现修复。

## Stops / Failure Modes

- 复现路径不稳定。
- 证据不足，无法确认 root cause。

## Next Recommended Steps

- 回到正常实现流程修复
- 修复后用 `$qa`、`$review` 或专项测试验证
