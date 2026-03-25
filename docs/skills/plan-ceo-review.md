# `$plan-ceo-review`

Source: `gstack`

## Purpose

从 CEO / founder 视角重审 plan 的 ambition、scope 和产品方向，找出更大的机会或更合理的裁剪。

## Preconditions

- 已有 design doc 或初版 plan。
- 用户准备显式判断 scope 是扩、收还是保持。

## Inputs / Source Of Truth

- 当前 plan 文件
- 当前分支 design doc
- 已有 CEO handoff、review 记录和 repo 系统上下文

## Produces / Writes

- 修订后的 plan 文件
- `~/.gstack/projects/{slug}/ceo-plans/*.md`

## Execution Flow

1. 审读 design doc 与当前 plan，确认问题定义与目标用户。
2. 选择 review mode，例如扩 scope、保 scope 或减 scope。
3. 按产品价值、长期方向和用户体验挑战现有方案。
4. 把关键 scope 决策和建议写回 plan。
5. 额外输出 CEO review 工件，供后续复盘。

## Stops / Failure Modes

- plan 或上下文不足，无法进行战略层判断。
- 必须先由用户选择 scope mode 才能继续。

## Next Recommended Steps

- `$plan-eng-review`
- UI 范围明显时补 `$plan-design-review`
