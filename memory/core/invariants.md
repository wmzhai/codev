# Invariants

## 安装与发现
- `setup` 必须把 `codev` 本身链接到 `~/.codex/skills/codev`。
- 受管 skills 必须通过 `setup` 一次性链接，不手工散装维护。
- `test/setup-smoke.sh` 必须覆盖受管 skills 的链接列表。

## 目录约束
- `skills/<name>/` 目录名必须和 `SKILL.md` 的 `name` 一致。
- `SKILL.md` 负责工作流；`agents/openai.yaml` 负责 UI 元数据。
- `README.md` 是仓库级导航，不替代 `SKILL.md`。

## 内容约束
- `SKILL.md` 的 `description` 必须同时说明“做什么”和“什么时候用”。
- 新增 skill 时，README、setup、smoke test 必须同步。
- `memorize` 的职责是建立或刷新 `AGENTS.md` 与 `memory/`，不负责业务逻辑。

## 验证基线
- 修改安装链路后，优先跑 `./test/setup-smoke.sh`。
- 修改单个 skill 的元数据后，优先跑 `quick_validate.py`。
- README 变更以仓库现状为准，不保留过期 skill 列表。
