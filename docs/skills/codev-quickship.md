# `$codev-quickship`

Source: `codev`

## Purpose

人工验证通过后统一收口：`codev-checkpoint` 是第一阶段（不含版本 bump 与 tag），`codev-quickship` 承接第二阶段（版本和 tag）。

## Execution（2 阶段模型）

### 阶段 1：执行 `codev-checkpoint` 收口第一阶段

按 `codev-checkpoint` 的流程执行：

- 人工验收结果与任务归档（有 task 时归档到 `tasks/done/`，补齐验收与 AC）；
- 任务相关 `docs` / `memory` / 必要时 `AGENTS.md` 同步；
- `CHANGELOG` 未发布区同步；
- 最小校验；
- 主干提交与 push；
- 映射 issue 存在时 `gh issue comment` 后 `gh issue close`；
- 明确返回“本阶段不做版本 bump 与 tag”。

### 阶段 2：版本与 tag 收口

仅在阶段 1 成功后自动执行（无额外用户确认）：

- 解析版本来源：优先显式版本；否则按仓库规则自动增量（无规则默认三段或四段末位 +1）；
- 更新根 `VERSION` 与本地版本工件（若有）；
- 将本轮未发布变更汇总到版本日志；
- 生成版本提交：提交信息格式 `type: 具体工作摘要 (v<VERSION>)`；
- 检查 tag 冲突并按规则创建 `v<VERSION>`，推送 tag；
- 输出阶段 1 与阶段 2 的汇总结果（含 target 版本与 tag 状态）。

## Stops / Failure Modes

- 阶段 1 被阻塞（权限、`CHANGELOG`、issue 映射、最小校验等）。
- 版本规则无法解析或显式版本不合法。
- `CHANGELOG` 版本归并目标不可定位。
- tag 已存在或推送失败。
