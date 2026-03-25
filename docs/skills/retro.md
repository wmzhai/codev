# `$retro`

Source: `gstack`

## Purpose

做周期性工程复盘，回看一段时间内的提交、工作模式、测试健康和产出结构。

## Preconditions

- 已经有一段提交历史或一个发布周期。
- 用户要的是复盘，而不是当前任务实现。

## Inputs / Source Of Truth

- git 历史
- 已发布结果
- 测试与代码质量趋势

## Produces / Writes

- 周期性复盘报告
- 团队或个人层面的模式总结

## Execution Flow

1. 汇总最近一个周期的提交、文件变更和交付节奏。
2. 分析测试健康、工作模式和明显的效率/质量信号。
3. 提炼做得好的部分、风险积累和下一周期的改进点。
4. 输出复盘结论，供团队或个人后续调整。

## Stops / Failure Modes

- 历史数据过少，无法形成有效趋势。

## Next Recommended Steps

- 新周期继续主流程
- 针对复盘暴露的问题开新 task 或补专项审查
