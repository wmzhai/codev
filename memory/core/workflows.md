# Workflows

## 新会话默认动作
1. 读 `AGENTS.md`
2. 读 `memory/core/symptom-routing.md`
3. 按问题进入对应 skill 的 `SKILL.md`
4. 用 `rg` 定位源码或脚本，再开始改动

## 新增 skill
1. 创建 skill 目录和 `SKILL.md`
2. 补 `agents/openai.yaml`
3. 更新 `README.md` 的 Skills 一览和说明
4. 更新 `setup`
5. 更新 `test/setup-smoke.sh`
6. 跑 smoke test

## 修改安装链路
1. 改 `setup`
2. 同步 `test/setup-smoke.sh`
3. 更新 `README.md`
4. 验证干净 HOME、幂等性和冲突处理

## 修改既有 skill
1. 先改对应 `SKILL.md`
2. 必要时同步 `agents/openai.yaml`
3. 如果影响触发、安装或导航，再改 `README.md`、`setup` 或 smoke test

## 维护原则
- 先让记忆系统追上真实代码，再考虑增加解释。
- 发现过期内容直接删，不保留“以后也许有用”的历史负担。
