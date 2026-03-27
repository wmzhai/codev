# System Map

只在仓库边界不清时读本文。

## 分层
- `README.md`：面向用户的总说明、安装方式、调用示例、skills 列表
- `docs/workflows/README.md`：从开始到结束的总流程图与总导航
- `docs/workflows/*.md`：只有总流程中不适合用一段覆盖的旁支流程
- `docs/skills/*.md`：每个 skill 的详细手册
- `setup`：安装当前仓库到 `~/.codex/skills/`，并链接受管 skills
- `test/setup-smoke.sh`：验证安装、幂等性和冲突处理
- `skills/codev-memorize/`：为项目建立或刷新 Codex 记忆体系
- `skills/codev-issue2task/`：把 issue 收敛成带实现计划的任务文件
- `skills/codev-gstack2task/`：把 `~/.gstack/projects/` 下的 gstack 工件收敛成带实现计划的任务文件
- `skills/codev-taskdev/`：按已审核 task plan 选择目标任务、实施代码、同步任务文档，并在实现收尾自动做一次语义不变精简
- `skills/codev-quickship/`：在用户完成人工验证后归档 task、同步任务相关 `docs/` / `memory/` / 必要时 `AGENTS.md`，并把根目录 `VERSION` 递增一位、同步 `CHANGELOG`，然后提交、合并、推送主干；若 task 明确映射 GitHub issue，则在 push 成功后先补评论再用 `gh` 关闭对应 issue；收尾提交信息应带 task 标识和最新版本号
- `skills/codev-simplify/`：语义不变精简 diff
- `skills/codev-checkpoint/`：轻量提交、推送 fallback
- `memory/core/gstack-interoperability.md`：说明 codev 和 gstack 的职责边界与组合流程
- `VERSION` / `CHANGELOG`：仓库的版本工件，供 `codev-checkpoint` 与 `codev-quickship` 读取和最小同步

## 外部工件边界
- `~/.gstack/projects/`：gstack 产出的 design doc、implementation handoff、test plan、review state 等上游工件。本仓库不拥有这些文件，只通过 `codev-gstack2task` 消费它们。
- `tasks/`：repo 内可执行工作单元，属于 codev 的主落点。
- `AGENTS.md` 与 `memory/`：repo 内面向 Codex 的长期记忆层。
- `VERSION` 与 `CHANGELOG`：repo 内的版本工件，属于受管事实，不自动新建多个并行版本源。
- repo 级人类文档如 `README.md`、`CHANGELOG`、`CLAUDE.md`、`CONTRIBUTING.md`、`TODOS`：如果项目同时使用 gstack，优先由 gstack `$document-release` 维护。

## 维护边界
- `SKILL.md` 是每个 skill 的主说明和工作流。
- `agents/openai.yaml` 只放 UI 元数据和调用策略。
- `README.md` 只放仓库级说明与技能导航。
- `docs/workflows/README.md` 保留唯一总流程图。
- `docs/skills/<skill>.md` 是对外的 skill 详细手册。
- `setup` 和 `test/setup-smoke.sh` 共同定义“哪些 skill 算受管”。
- `codev-issue2task` 与 `codev-gstack2task` 是两个平行入口：前者处理 GitHub issue 或直接需求，后者处理 `~/.gstack/projects/` 工件；两者都直接产出可执行 task plan。
- `codev-taskdev` 是 task 分支实现层；`codev-quickship` 负责人工验证后的收尾，并在必要时先给关联 issue 追加工作评论再关闭，同时把收尾提交信息写得足够具体并持续递增版本号；tag、正式发布和全局发布文档仍由 gstack 发布链路处理。

## 常见改动落点
- 新增 skill：新增 `skills/<name>/` 目录，同时同步 `setup`、`test/setup-smoke.sh`、`README.md`
- 新增 skill 文档：同步新增 `docs/skills/<name>.md`
- 修改 skill 触发或行为：改对应 `SKILL.md` 和 `agents/openai.yaml`
- 修改安装链路：改 `setup` 和 `test/setup-smoke.sh`
- 修改外部说明：改 `README.md`、`docs/workflows/README.md`、`docs/skills/*.md`
- 修改 codev 与 gstack 的边界：先改 `memory/core/gstack-interoperability.md`，再同步 `AGENTS.md`、`README.md` 和相关 skill 文档
