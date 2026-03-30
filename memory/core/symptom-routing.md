# Symptom Routing

默认只读本文和一个相关 skill 文档；不要先通读整个仓库。

## 想知道这个仓库是干什么的
- `README.md`
- `AGENTS.md`
- `docs/workflows/README.md`

## 想知道 codev 和 gstack 怎么配合
- `memory/core/gstack-interoperability.md`
- `README.md`
- `AGENTS.md`

## 想新增或修改一个 skill
- 对应 skill 的 `SKILL.md`
- `docs/skills/<skill>.md`
- `agents/openai.yaml`
- `README.md`
- `setup`
- `test/setup-smoke.sh`

## 想确认安装是否正确
- `setup`
- `test/setup-smoke.sh`

## 想知道该用哪个 skill
- 先看 `docs/workflows/README.md`
- 再看 `docs/skills/README.md`
- 最后看对应 skill 的 `SKILL.md`

## 想给项目建立 AGENTS / CLAUDE 记忆入口
- `docs/skills/codev-memorize.md`
- `skills/codev-memorize/SKILL.md`
- 当前仓库的 `README.md`
- 根目录 `AGENTS.md`
- 根目录 `CLAUDE.md`

## 想把 gstack 工件落成 task
- `docs/skills/codev-gstack2task.md`
- `skills/codev-gstack2task/SKILL.md`
- `memory/core/gstack-interoperability.md`

## 想走任务流
- `docs/workflows/README.md`
- `docs/skills/codev-issue2task.md`
- `docs/skills/codev-gstack2task.md`
- `docs/skills/codev-taskdev.md`
- `docs/skills/codev-quickship.md`

## 想做提交或发版
- `docs/skills/codev-checkpoint.md`
- `docs/skills/ship.md`
- `skills/codev-checkpoint/SKILL.md`
- `memory/core/gstack-interoperability.md`

## 想做语义不变精简
- `docs/skills/codev-simplify.md`
- `skills/codev-simplify/SKILL.md`
