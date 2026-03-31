# gstack Interoperability

只在仓库同时接入 codev 和 gstack 时读本文。

## 职责分工
- gstack：负责产品探索、计划评审、测试计划、QA、ship、repo 级人类文档同步，以及正式发布链路。
- codev：负责 `tasks/`、任务内实现计划、`codev-taskdev`、`codev-quickship`、`codev-memorize`、`codev-simplify`，以及把外部输入压成 repo 内任务。

## 两条任务入口
- `codev-issue2task`：输入是 GitHub issue 或用户直接需求。
- `codev-gstack2task`：输入是 `~/.gstack/projects/` 下的 design doc、implementation handoff、test plan、CEO handoff 等工件；它读取这些工件目录，但不要求 `~/gstack` 仓库已安装。
- 两者都写入 `tasks/`，但不要让一个 skill 去兼做另一个 skill 的输入解析。

## Source Of Truth
- 上游产品与工程意图：`~/.gstack/projects/<slug>/`
- repo 内执行单元：`tasks/`
- 机器记忆：`AGENTS.md` + `memory/`
- 对外流程导航：`docs/workflows.md`
- 对外 skill 手册：`docs/skills/README.md`
- repo 级人类文档：`README.md`、`CHANGELOG`、`CLAUDE.md`、`CONTRIBUTING.md`、`TODOS`

## 不冲突规则
- `codev-memorize` 可以把 `CLAUDE.md` 里的 repo 事实并入 `AGENTS.md`，但必须保留宿主代理或 gstack 仍然需要的兼容块。
- repo 级文档漂移默认交给 gstack `$document-release`。
- 需要 PR、review gate、覆盖率审计或自动文档同步时，优先 gstack `$ship`。
- `$codev-taskdev` 只负责按已审核 plan 实施代码、同步任务文档并在实现收尾做一次语义不变精简；不要把它扩成验证、QA、部署或发布入口。
- 在 task 分支准备第一次提交或 `codev-checkpoint` 前，可以先用 `codev-simplify` 收窄当前 patch，再把工作区收成 clean tree。
- 只有明确需要轻量 `commit/push` 时，才用 `$codev-checkpoint`。
- `$codev-quickship` 负责人工验证后的收尾：归档 task、同步任务相关 `docs/` / `memory/` / 必要时 `AGENTS.md`，并在每次收尾时递增根目录 `VERSION`、同步 `CHANGELOG`，再提交、合并并推送主干；若 task 明确映射 GitHub issue，则在 push 成功后先补一条该轮工作的评论，再用 `gh` 关闭对应 issue；收尾提交信息应采用 `type: 具体工作摘要 (vX.Y.Z.W)` 形式；不调用 gstack 的正式发布技能。
- 需要 tag、正式发布或全局发布文档时，再进入 gstack 的外部发布流程。

## 推荐组合方式
1. 输入来自 GitHub issue 或直接需求时，用 `codev-issue2task`
2. 输入来自 `~/.gstack/projects/` 工件时，用 `codev-gstack2task`
3. 用户先审核 task 文件中的实现计划
4. 用 `$codev-taskdev` 落成代码，并持续维护任务文档
5. 人工验证功能
6. 人工确认通过后用 `codev-quickship` 做收尾
7. 需要正式发布链路时，再转入外部 gstack 发布流程

## 何时不用 codev-gstack2task
- 需求本来就在 GitHub issue 里，直接用 `codev-issue2task`
- 用户只是想讨论高层方向，还没准备写 `tasks/`
- `~/.gstack/projects/` 里没有与当前仓库或当前分支对应的可验证工件
