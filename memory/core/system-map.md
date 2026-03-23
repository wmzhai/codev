# System Map

只在仓库边界不清时读本文。

## 分层
- `README.md`：面向用户的总说明、安装方式、调用示例、skills 列表
- `setup`：安装当前仓库到 `~/.codex/skills/`，并链接受管 skills
- `test/setup-smoke.sh`：验证安装、幂等性和冲突处理
- `skills/memorize/`：为项目建立或刷新 Codex 记忆体系
- `skills/issue2task/`：把 issue 收敛成任务文件
- `skills/gstack2task/`：把 `~/.gstack/projects/` 下的 gstack 工件收敛成任务文件
- `skills/plantask/`：围绕任务文件产出实现方案
- `skills/checktask/`：验收任务、同步 `memory/` 与任务相关文档、归档完成项
- `skills/simplify/`：语义不变精简 diff
- `skills/checkpoint/`：轻量提交、推送 fallback
- `memory/core/gstack-interoperability.md`：说明 codev 和 gstack 的职责边界与组合流程

## 外部工件边界
- `~/.gstack/projects/`：gstack 产出的 design doc、implementation handoff、test plan、review state 等上游工件。本仓库不拥有这些文件，只通过 `gstack2task` 消费它们。
- `tasks/`：repo 内可执行工作单元，属于 codev 的主落点。
- `AGENTS.md` 与 `memory/`：repo 内面向 Codex 的长期记忆层。
- repo 级人类文档如 `README.md`、`CHANGELOG`、`CLAUDE.md`、`CONTRIBUTING.md`、`TODOS`：如果项目同时使用 gstack，优先由 gstack `/document-release` 维护。

## 维护边界
- `SKILL.md` 是每个 skill 的主说明和工作流。
- `agents/openai.yaml` 只放 UI 元数据和调用策略。
- `README.md` 只放仓库级说明与技能导航。
- `setup` 和 `test/setup-smoke.sh` 共同定义“哪些 skill 算受管”。
- `issue2task` 与 `gstack2task` 是两个平行入口：前者处理 GitHub issue 或直接需求，后者处理 `~/.gstack/projects/` 工件。

## 常见改动落点
- 新增 skill：新增 `skills/<name>/` 目录，同时同步 `setup`、`test/setup-smoke.sh`、`README.md`
- 修改 skill 触发或行为：改对应 `SKILL.md` 和 `agents/openai.yaml`
- 修改安装链路：改 `setup` 和 `test/setup-smoke.sh`
- 修改外部说明：改 `README.md`
- 修改 codev 与 gstack 的边界：先改 `memory/core/gstack-interoperability.md`，再同步 `AGENTS.md`、`README.md` 和相关 skill 文档
