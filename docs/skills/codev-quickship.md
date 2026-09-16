# `$codev-quickship`

Source: `codev`

## Purpose

人工验证通过后统一收口：`codev-checkpoint` 是第一阶段（不含版本 bump 与 tag），`codev-quickship` 承接第二阶段（版本和 tag）。
用户触发即表示 `codev-taskdev` 收尾编译责任与人工功能验证已经完成；无 task 模式也表示用户已在外部完成确认。quickship 不负责补做 build/test/lint/typecheck 或脚本验证。

目标仓库缺少 `VERSION` 或 changelog 时，quickship 必须主动创建并写入本轮内容，不得因文件缺失而停止。首发版本是 `0.0.1`。

## Execution（2 阶段模型）

进入阶段 1 的 `CHANGELOG` 同步之前，先做版本工件初始化。

### 版本工件初始化（缺则创建）

- changelog 定位顺序：`CHANGELOG.md`、`CHANGELOG`、`changelog.md`。找到任一则沿用，不另建。
- 都没有则创建根目录 `CHANGELOG.md`：写入 `# Changelog`、`## Unreleased`，以及本轮改动摘要。禁止只建空文件。
- 没有 `VERSION`，且 changelog 也没有已发布版本段：创建 `VERSION`，内容为 `0.0.1`。这就是本轮目标版本，不再递增。
- 没有 `VERSION`，但 changelog 已有发布段：取最新发布版本为当前版本，再按规则递增并补写 `VERSION`。
- 已有 `VERSION`：按既有规则在阶段 2 递增。
- 用户显式给出合法版本时，以用户版本为准。

### 阶段 1：执行 `codev-checkpoint` 收口第一阶段

按 `codev-checkpoint` 的流程执行：

- 人工验收结果与任务归档（有 task 时归档到 `tasks/done/`，补齐验收与 AC）；
- 任务相关 `docs` / `memory` / 必要时宿主入口同步；
- `CHANGELOG` 未发布区同步；
- 收口范围从当前工作目录解析，与 `codev-checkpoint` 相同，不使用其他项目路径；
- 收口范围与阻塞条件确认，不运行自动验证；
- 本阶段先不提交，不 push，issue 在第二阶段在收口提交后再处理；
- 明确返回“本阶段不做版本 bump 与 tag”。

### 阶段 2：版本与 tag 收口（含最终提交）

仅在阶段 1 成功后自动执行（无额外用户确认）：

- 解析版本来源：优先显式版本；本轮新建且首发时用 `0.0.1` 且不再递增；否则按仓库规则自动增量（无规则默认三段或四段数字最后一段 +1）；
- 更新根 `VERSION` 与本地版本工件（若有）；
- 将本轮未发布变更汇总到版本日志，写入 `## <目标版本> - YYYY-MM-DD`；新建的 `CHANGELOG.md` 同样必须有具体条目；
- 生成最终收口提交：提交信息格式 `type: 具体工作摘要 (v<VERSION>)`（先把第一阶段变更与版本变更一起提交）；
- 检查 tag 冲突并按规则创建 `v<VERSION>`，推送 tag；
- 若存在映射 issue，在提交与 tag push 后执行 `gh issue comment` 再 `gh issue close`；
- 输出阶段 1 与阶段 2 的汇总结果（含 target 版本、是否新建 `VERSION` / `CHANGELOG.md`、与 tag 状态）。

## Stops / Failure Modes

- 阶段 1 被阻塞（权限、`CHANGELOG` 写入失败、issue 映射等）。
- 版本规则无法解析或显式版本不合法。
- 无法创建或写入 `VERSION` / changelog。
- `CHANGELOG` 版本归并目标不可定位。
- tag 已存在或推送失败。
