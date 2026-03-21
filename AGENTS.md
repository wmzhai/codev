# Repository Guidelines

## Codex First
- 新任务默认先读 `README.md`，再按问题进入 `memory/`。
- `README.md` 负责对外说明当前仓库有哪些 skills、如何安装、如何调用。
- `memory/` 负责给 Codex 提供检索型入口、约束和维护路径。
- 维护 skills 时，优先同步 `SKILL.md`、`agents/openai.yaml`、`setup`、`test/setup-smoke.sh` 和 `README.md`。

## 仓库定位
- 本仓库是 Codex skills 的集合，不是应用业务仓库。
- 每个 `skills/<name>/` 目录都是一个独立能力包，目录名必须与 `SKILL.md` 的 `name` 对齐。
- `memorize` 负责为项目建立或刷新 `AGENTS.md` 与 `memory/` 记忆体系。
- `issue2task`、`plantask`、`checktask`、`simplify`、`ships` 是围绕任务流、精简和发版的配套 skills。

## 维护规则
- 新增或修改 skill 时，先改 `SKILL.md`，再同步 `agents/openai.yaml`，最后回看 `README.md`、`setup` 和 `test/setup-smoke.sh` 是否需要更新。
- `setup` 是真实安装入口；`test/setup-smoke.sh` 是安装行为的最小验证。
- 任何新增受管 skill，都必须同步到 `setup`、`README.md` 和 `test/setup-smoke.sh`。
- `README.md` 里只放用户需要看到的高层说明，不重复展开各 skill 的全部内部流程。
- 这里不写冗长教程；详细工作流放到各 skill 自己的 `SKILL.md`。
