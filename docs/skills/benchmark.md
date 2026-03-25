# `$benchmark`

Source: `gstack`

## Purpose

建立或比较页面性能基线，关注页面加载、资源体积和 Core Web Vitals。

## Preconditions

- 目标页面可访问。
- 用户关心性能回归、页面速度或资源体积。

## Inputs / Source Of Truth

- 目标 URL
- 当前页面资源和性能指标
- 之前的性能基线（如果存在）

## Produces / Writes

- 性能基线或前后对比结果
- 关键性能指标与回归结论

## Execution Flow

1. 打开目标页面并记录加载、资源与 Web Vitals。
2. 建立 baseline，或与现有 baseline 做 before/after 对比。
3. 标记明显性能回退或资源膨胀。
4. 输出后续是否需要开优化 task 的判断。

## Stops / Failure Modes

- 页面环境不稳定，指标波动过大。
- 缺少对比基线，无法做回归判断。

## Next Recommended Steps

- 性能问题进入 `$investigate`
- 结果回流到 task 验证或发布门禁
