# `$setup-browser-cookies`

Source: `gstack`

## Purpose

把真实 Chromium 浏览器中的 cookie 导入 headless 会话，为登录态页面的 QA 或浏览器验证做准备。

## Preconditions

- 本机存在可读取的 Chromium 浏览器会话。
- 目标站点需要登录态。

## Inputs / Source Of Truth

- 本机真实浏览器中的 cookie
- 用户选择导入的域名

## Produces / Writes

- headless 浏览器可复用的登录态会话

## Execution Flow

1. 打开 cookie 导入选择器。
2. 让用户选择需要导入的域名。
3. 把所选 cookie 写入 headless 浏览器会话。
4. 用后续 `$browse`、`$qa`、`$qa-only` 验证登录态页面。

## Stops / Failure Modes

- 本机没有可读 cookie。
- 目标域名未在导入列表中。

## Next Recommended Steps

- `$browse`
- `$qa`
- `$qa-only`
