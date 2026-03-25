# `$design-review`

Source: `gstack`

## Purpose

对真实页面做设计质量审查，发现视觉不一致、层级问题、交互迟缓或 AI slop，并在必要时直接修复。

## Preconditions

- 当前功能已有可运行页面或部署环境。
- 最好已有稳定的 UI 代码状态或 clean tree。

## Inputs / Source Of Truth

- 当前页面或部署 URL
- 现有 UI 代码
- 如存在则读取 `DESIGN.md`、design doc 和相关截图

## Produces / Writes

- 设计问题清单
- 必要时直接修复的代码改动
- before / after 截图与验证结果

## Execution Flow

1. 用真实浏览器审查页面层级、间距、视觉语言和交互节奏。
2. 对照设计系统或已有设计方向，识别明显偏差。
3. 将问题按重要性排序，优先处理影响观感或可用性的项。
4. 修复代码后重新截图、重测并确认变化成立。

## Stops / Failure Modes

- 页面尚未稳定到可审查状态。
- 设计方向本身未定，需要先回到 `$plan-design-review` 或 `$design-consultation`。

## Next Recommended Steps

- `$review`
- `$qa`
- task 验收前再次快速目测
