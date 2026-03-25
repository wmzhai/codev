# `$office-hours`

Source: `gstack`

## Purpose

把模糊的产品想法、痛点和目标用户收敛成一份 design doc，为后续 plan review 和 task 化提供上游 source of truth。

## Preconditions

- 需求仍处在探索期，或现有设计文档不够好。
- 用户愿意讨论问题定义、场景、范围和备选方案。

## Inputs / Source Of Truth

- 用户对问题、目标和约束的描述
- 当前 repo 上下文
- 如存在则读取当前分支设计文档、`DESIGN.md` 和历史 handoff

## Produces / Writes

- `~/.gstack/projects/{slug}/{user}-{branch}-design-{datetime}.md`
- 必要时附带草图或方向性说明

## Execution Flow

1. 选择 startup mode 或 builder mode，先逼出真实问题和痛点。
2. 追问需求现实性、用户范围、最小 wedge 和假设条件。
3. 提出推荐方向，并挑战用户最初的功能 framing。
4. 在必要时给出备选方案、线框或交互方向。
5. 把结论写成 design doc，作为后续 review 输入。

## Stops / Failure Modes

- 用户仍停留在非常模糊的探索，无法形成清晰问题定义。
- 必须先确认产品方向或范围，才能继续写 design doc。

## Next Recommended Steps

- `$autoplan`
- `$plan-ceo-review`
- `$plan-eng-review`
