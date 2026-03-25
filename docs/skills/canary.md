# `$canary`

Source: `gstack`

## Purpose

在部署后持续观察生产健康度，捕捉 console error、页面失败、性能回退和截图异常。

## Preconditions

- 已有可访问的生产环境。
- 最好已经完成 merge 和部署。

## Inputs / Source Of Truth

- 生产 URL
- 基线截图、性能基线或近期发布上下文

## Produces / Writes

- 部署后监控结论
- 异常截图、错误和性能回退记录

## Execution Flow

1. 打开生产页面并做基础可用性检查。
2. 观察 console、网络错误和关键页面状态。
3. 对比基线截图或性能指标，识别异常。
4. 输出是否需要回滚、继续观察或开新 task 的判断。

## Stops / Failure Modes

- 生产 URL 不可访问。
- 缺少必要的健康检查入口。

## Next Recommended Steps

- 出现异常时进入 `$investigate`
- 无异常时进入 `$retro` 或关闭发布任务
