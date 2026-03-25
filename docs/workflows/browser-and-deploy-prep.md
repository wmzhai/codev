# 浏览器与部署准备

这份文档覆盖总流程中的环境准备旁支：什么时候需要先把浏览器、认证会话和部署配置打通，再进入 QA 或发布。

## 何时进入这条旁支

- 需要真实浏览器验证交互、截图或带证据的 bug 复现。
- 需要访问登录态页面。
- 仓库准备接入 `$land-and-deploy`，但部署平台和健康检查还没配置好。

## 典型链路

```text
$gstack / $browse
-> $setup-browser-cookies   （需要登录态时）
-> $qa / $qa-only / $design-review

$setup-deploy
-> $ship
-> $land-and-deploy
-> $canary
```

## 工具分工

- `$gstack`
  - 浏览器能力总入口/兼容入口。
  - 在 codev 文档里把它视作“浏览器工具箱入口”，不当作单独主流程阶段。
- `$browse`
  - 直接进行页面打开、点击、截图、表单、响应式检查与状态断言。
- `$setup-browser-cookies`
  - 把真实 Chromium 浏览器中的 cookie 导入 headless 会话。
- `$setup-deploy`
  - 预配置部署平台、生产 URL、健康检查和部署状态命令。
- `$canary`
  - 发布后持续观察生产健康度，不替代 merge 之前的 QA。

## 使用规则

- 有登录态页面的 QA，优先先跑 `$setup-browser-cookies`。
- 仓库第一次使用 `$land-and-deploy` 前，优先先跑 `$setup-deploy`。
- `$browse` 可以单独使用，也可以被 `$qa`、`$design-review`、`$canary` 间接调用。
