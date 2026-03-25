# `$plan-design-review`

Source: `gstack`

## Purpose

在实现前检查 plan 的 UI / UX 决策是否完整，把缺失的层级、状态、交互、响应式和可访问性决策补回 plan。

## Preconditions

- 当前 plan 真的包含 UI scope。
- 如存在 `DESIGN.md`，应一并读取。

## Inputs / Source Of Truth

- 当前 plan 文件
- `DESIGN.md`
- 当前分支 design doc
- 现有 UI 模式和组件习惯

## Produces / Writes

- 修补后的 plan 文件
- 设计评分、review log 与决策记录

## Execution Flow

1. 判断 plan 是否真的有 UI scope；纯后端场景直接标记不适用。
2. 读取设计系统、design doc 与当前 plan。
3. 从信息架构、状态覆盖、交互、AI slop 风险、响应式、可访问性等维度打分。
4. 把明显缺失的设计决策直接补回 plan。
5. 对真实设计分歧停下来询问，再记录最终选择。

## Stops / Failure Modes

- plan 无 UI scope。
- 关键设计取舍必须由用户决定。

## Next Recommended Steps

- `$plan-eng-review`
- plan 稳定后进入 `$codev-gstack2task`
