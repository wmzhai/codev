# `$setup-deploy`

Source: `gstack`

## Purpose

为 `$land-and-deploy` 预配置部署平台、生产 URL、健康检查和部署状态命令。

## Preconditions

- 仓库存在明确部署平台或脚本。
- 用户准备把发布流程接到 `$land-and-deploy`。

## Inputs / Source Of Truth

- 部署平台配置
- 生产 URL
- 健康检查入口
- 部署状态命令或脚本

## Produces / Writes

- 写入 `CLAUDE.md` 或等价配置中的部署说明
- 后续 `$land-and-deploy` 可复用的部署元数据

## Execution Flow

1. 识别当前部署平台与生产入口。
2. 检查健康检查 URL、CI 状态命令和部署完成判定方式。
3. 把这些信息沉淀到宿主代理可复用的位置。
4. 确认后续 `$land-and-deploy` 可以无人工重新发现这些信息。

## Stops / Failure Modes

- 仓库部署方式不明确。
- 生产 URL 或健康检查入口缺失。

## Next Recommended Steps

- `$ship`
- `$land-and-deploy`
