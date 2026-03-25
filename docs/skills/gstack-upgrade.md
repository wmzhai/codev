# `$gstack-upgrade`

Source: `gstack`

## Purpose

升级 gstack 到最新版本，并同步全局或 vendored 安装，使浏览器与其他技能保持最新状态。

## Preconditions

- 当前机器已安装 gstack。
- 用户明确要求升级，或当前版本过旧导致技能不可用。

## Inputs / Source Of Truth

- 当前 gstack 安装方式
- 当前版本与最新版本信息

## Produces / Writes

- 更新后的 gstack 安装
- 版本变更摘要

## Execution Flow

1. 识别是全局安装还是 repo 内 vendored 安装。
2. 获取最新版本并执行升级。
3. 在必要时同步生成的 Codex skills。
4. 向用户报告版本变化和后续需要注意的事项。

## Stops / Failure Modes

- 网络或权限不足导致升级失败。
- 当前安装方式异常，无法安全覆盖。

## Next Recommended Steps

- 升级后重新运行 `./setup` 或相关 smoke test
- 再继续使用 `$browse`、`$qa` 或其他 gstack skill
