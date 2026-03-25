# `$unfreeze`

Source: `gstack`

## Purpose

清除 `$freeze` 或 `$guard` 建立的编辑边界，让会话恢复到可编辑所有目录的状态。

## Preconditions

- 当前存在有效的冻结边界。

## Inputs / Source Of Truth

- 当前会话的冻结状态

## Produces / Writes

- 已清除的编辑限制

## Execution Flow

1. 检查当前是否存在 `$freeze` / `$guard` 留下的编辑边界。
2. 清除该边界。
3. 向用户确认现在已恢复全目录编辑。

## Stops / Failure Modes

- 当前并不存在冻结边界。

## Next Recommended Steps

- 继续主流程或扩大修复范围
