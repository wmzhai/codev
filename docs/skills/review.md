# `$review`

Source: `gstack`

## Purpose

在 landing 之前对当前 diff 做结构性代码审查，重点找出会漏过普通测试但可能在生产爆炸的问题。

## Preconditions

- 当前分支有明确 diff。
- 最好已经完成一轮本地验证或实现收口。

## Inputs / Source Of Truth

- 当前 diff
- 基线分支
- 变更涉及的代码、测试和配置

## Produces / Writes

- 审查结论
- 结构性 findings
- 某些明显问题的自动修复或补丁建议

## Execution Flow

1. 读取当前 diff 和受影响文件，按风险面排序。
2. 重点检查 SQL/注入、条件副作用、LLM 信任边界、遗漏分支和结构风险。
3. 对明显可修的低风险问题直接修复，或给出明确 finding。
4. 汇总 pass/fail 风险，并指出还需要补什么验证。

## Stops / Failure Modes

- 当前没有可审查的 diff。
- 变更面过于散乱，需要先通过 `$codev-simplify` 收口 patch。

## Next Recommended Steps

- `$qa`
- `$ship`
- 如发现根因不明的问题，切到 `$investigate`
