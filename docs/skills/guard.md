# `$guard`

Source: `gstack`

## Purpose

组合启用 `$careful` 和 `$freeze`，同时对破坏性命令给出警告，并限制编辑目录。

## Preconditions

- 当前操作既有高风险命令，又需要限制编辑范围。

## Inputs / Source Of Truth

- 计划执行的命令
- 允许编辑的目录

## Produces / Writes

- 命令级安全警告
- 会话级编辑边界

## Execution Flow

1. 启用破坏性命令警告。
2. 启用目录级编辑限制。
3. 在整个高风险操作期间维持双重保护。
4. 完成后由 `$unfreeze` 或退出保护模式收尾。

## Stops / Failure Modes

- 编辑范围不明确，无法安全冻结。

## Next Recommended Steps

- 继续高风险操作
- 完成后执行 `$unfreeze`
