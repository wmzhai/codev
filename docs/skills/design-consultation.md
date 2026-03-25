# `$design-consultation`

Source: `gstack`

## Purpose

为有明显 UI 范围的项目建立完整设计系统，输出 `DESIGN.md` 作为后续计划、实现和设计审查的统一设计源。

## Preconditions

- 项目有明显 UI / 品牌 / 视觉系统需求。
- 当前还没有足够稳定的 `DESIGN.md`，或需要系统性重做。

## Inputs / Source Of Truth

- 产品定位
- 现有视觉上下文
- 当前 UI 结构和页面类型
- 可能已有的设计材料

## Produces / Writes

- repo 根目录 `DESIGN.md`
- 必要时生成字体、色彩或页面预览材料

## Execution Flow

1. 理解产品目标、用户感受和已有视觉约束。
2. 明确字体、色彩、布局、间距、动效和组件语言。
3. 提出有辨识度的设计方向，而不是通用模板式设计。
4. 把设计系统沉淀到 `DESIGN.md`，供后续 plan review 与实现使用。

## Stops / Failure Modes

- 项目几乎无 UI 范围。
- 设计方向完全未定，用户也暂时不想锁设计系统。

## Next Recommended Steps

- `$plan-design-review`
- `$plan-eng-review`
- 实现阶段的 `$design-review`
