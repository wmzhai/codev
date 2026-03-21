# System Map

只在仓库边界不清时读本文。

## 分层
- `README.md`：面向用户的总说明、安装方式、调用示例、skills 列表
- `setup`：安装当前仓库到 `~/.codex/skills/`，并链接受管 skills
- `test/setup-smoke.sh`：验证安装、幂等性和冲突处理
- `skills/memorize/`：为项目建立或刷新 Codex 记忆体系
- `skills/issue2task/`：把 issue 收敛成任务文件
- `skills/plantask/`：围绕任务文件产出实现方案
- `skills/checktask/`：验收任务、同步文档、归档完成项
- `skills/simplify/`：语义不变精简 diff
- `skills/ships/`：提交、推送、发版

## 维护边界
- `SKILL.md` 是每个 skill 的主说明和工作流。
- `agents/openai.yaml` 只放 UI 元数据和调用策略。
- `README.md` 只放仓库级说明与技能导航。
- `setup` 和 `test/setup-smoke.sh` 共同定义“哪些 skill 算受管”。

## 常见改动落点
- 新增 skill：新增 `skills/<name>/` 目录，同时同步 `setup`、`test/setup-smoke.sh`、`README.md`
- 修改 skill 触发或行为：改对应 `SKILL.md` 和 `agents/openai.yaml`
- 修改安装链路：改 `setup` 和 `test/setup-smoke.sh`
- 修改外部说明：改 `README.md`
