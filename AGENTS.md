# Repository Guidelines

## Codex First
- 新任务默认先读 `README.md`，再按问题进入 `memory/`。
- `README.md` 负责对外说明当前仓库有哪些 skills、如何安装、如何调用。
- `memory/` 负责给 Codex 提供检索型入口、约束和维护路径。
- 如果当前仓库同时使用 gstack，先确认任务来源：GitHub issue 或直接需求走 `issue2task`，`~/.gstack/projects/` 下的设计/交接/测试计划工件走 `gstack2task`。
- 维护 skills 时，优先同步 `SKILL.md`、`agents/openai.yaml`、`setup`、`test/setup-smoke.sh` 和 `README.md`。

## 仓库定位
- 本仓库是 Codex skills 的集合，不是应用业务仓库。
- 每个 `skills/<name>/` 目录都是一个独立能力包，目录名必须与 `SKILL.md` 的 `name` 对齐。
- `memorize` 负责为项目建立或刷新 `AGENTS.md` 与 `memory/` 记忆体系，同时保留宿主代理或 gstack 需要继续留在 `CLAUDE.md` 的兼容块。
- `issue2task` 保留 GitHub issue 或直接需求到 `tasks/` 的路径，不消费 gstack 工件。
- `gstack2task` 负责把 `~/.gstack/projects/` 下的 gstack 工件收敛成 `tasks/`。
- `plantask`、`checktask`、`simplify` 围绕 repo 内部任务流工作。
- `checkpoint` 是轻量 `commit/push` fallback；需要 PR、review gate、QA 串联或全局文档同步时，优先使用 gstack `/ship` 与 `/document-release`。

## 维护规则
- 新增或修改 skill 时，先改 `SKILL.md`，再同步 `agents/openai.yaml`，最后回看 `README.md`、`setup` 和 `test/setup-smoke.sh` 是否需要更新。
- `setup` 是真实安装入口；`test/setup-smoke.sh` 是安装行为的最小验证。
- 任何新增受管 skill，都必须同步到 `setup`、`README.md` 和 `test/setup-smoke.sh`。
- 修改任务入口 skill 时，保持 `issue2task` 与 `gstack2task` 的输入边界稳定，不要把两者揉成一个大而全入口。
- 如果仓库存在 `CLAUDE.md`，尤其已经承载 gstack section、浏览器约束或宿主代理说明，`memorize` 只能收敛 repo 事实，不能把这些兼容说明删掉。
- `README.md` 里只放用户需要看到的高层说明，不重复展开各 skill 的全部内部流程。
- 这里不写冗长教程；详细工作流放到各 skill 自己的 `SKILL.md`。
