# `$freeze`

Source: `gstack`

## Purpose

把本次会话的文件编辑范围锁定到指定目录，避免在调试或窄范围修复时顺手改到别处。

## Preconditions

- 你已经知道本次只应编辑某个目录或模块。

## Inputs / Source Of Truth

- 允许编辑的目录路径

## Produces / Writes

- 会话级编辑边界

## Execution Flow

1. 接收或推断本次允许编辑的目录。
2. 启用写入边界，阻止范围外的 Edit / Write。
3. 在问题解决后由 `$unfreeze` 解除。

## Stops / Failure Modes

- 允许目录不明确，无法设定边界。

## Next Recommended Steps

- 继续实施窄范围修复
- 完成后用 `$unfreeze` 清除限制
