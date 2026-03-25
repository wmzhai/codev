# `$browse`

Source: `gstack`

## Purpose

直接使用真实 Chromium 浏览器进行页面导航、交互、截图、表单和状态断言。

## Preconditions

- 需要浏览器级验证。
- 目标页面可访问。

## Inputs / Source Of Truth

- 目标 URL
- 用户流程、断言目标或截图需求

## Produces / Writes

- 截图
- 页面状态、交互结果与 bug 证据

## Execution Flow

1. 打开目标 URL。
2. 执行点击、输入、表单、响应式检查或状态断言。
3. 记录截图、前后状态和异常现象。
4. 把结果回流到 QA、设计审查或发布验证。

## Stops / Failure Modes

- 页面打不开或浏览器能力不可用。
- 登录态缺失。

## Next Recommended Steps

- 需要登录时先 `$setup-browser-cookies`
- 流程测试时进入 `$qa` / `$qa-only`
