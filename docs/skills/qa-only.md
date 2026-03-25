# `$qa-only`

Source: `gstack`

## Purpose

只做 QA 报告，不修代码，适合先要一份 bug 清单、复现路径和风险评级的场景。

## Preconditions

- 目标环境可访问。
- 用户明确要求“只报告，不修复”。

## Inputs / Source Of Truth

- 当前部署 URL、本地运行环境或目标页面
- 如存在则读取 test plan、task 文档和已知问题

## Produces / Writes

- 结构化 bug 报告
- 健康度、截图、复现步骤与优先级

## Execution Flow

1. 建立测试范围和关键用户流程。
2. 在真实浏览器中走流程并记录发现。
3. 归类问题的严重度、复现条件和影响范围。
4. 输出只读 QA 报告，不进入修复。

## Stops / Failure Modes

- 目标环境不可访问。
- 需要登录态但未导入 cookie。

## Next Recommended Steps

- 转入 `$qa` 做修复闭环
- 或把 findings 回流到 task / 发布门禁
