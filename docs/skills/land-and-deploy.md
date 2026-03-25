# `$land-and-deploy`

Source: `gstack`

## Purpose

承接 `$ship` 产出的 PR，完成合并、等待 CI / 部署，并验证生产健康度。

## Preconditions

- PR 已创建，且基本 ready。
- 部署平台与健康检查方式已知；第一次接入前最好先跑 `$setup-deploy`。

## Inputs / Source Of Truth

- 当前 PR
- CI 状态
- 部署平台和健康检查配置

## Produces / Writes

- 主干合并结果
- 部署结果
- 健康度验证结果

## Execution Flow

1. 检查 PR、review、CI 和分支保护是否满足合并条件。
2. 执行 merge，并等待 CI 与部署完成。
3. 按配置的生产 URL 和健康检查验证站点状态。
4. 必要时借助 `$canary` 继续观察上线后表现。

## Stops / Failure Modes

- PR 未 ready。
- CI / 部署失败。
- 缺少部署配置或生产健康检查信息。

## Next Recommended Steps

- `$canary`
- `$document-release`
- 周期复盘时进入 `$retro`
