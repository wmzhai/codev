# `$gstack`

Source: `gstack`

## Purpose

作为 gstack 浏览器能力的总入口或兼容入口，快速进入真实浏览器验证、截图、交互检查和证据采集。

## Preconditions

- 需要浏览器级验证，而不是纯静态阅读。
- 本机已完成 gstack 安装，浏览器能力可用。

## Inputs / Source Of Truth

- 目标 URL、用户流程或页面状态
- 必要时结合当前 task、QA 目标和 bug 复现步骤

## Produces / Writes

- 浏览器操作结果
- 截图、页面状态、bug 证据

## Execution Flow

1. 明确要打开或验证的页面、流程或部署环境。
2. 启动浏览器能力并导航到目标页面。
3. 做必要的点击、截图、表单、响应式检查或状态断言。
4. 把结果回流到 QA、设计审查、部署验证或 bug 报告。

## Stops / Failure Modes

- 浏览器能力未安装或不可用。
- 需要登录态但尚未导入 cookie。

## Next Recommended Steps

- 直接进入 `$browse`
- 登录态页面前补 `$setup-browser-cookies`
- QA 时进入 `$qa` 或 `$qa-only`
