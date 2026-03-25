# Codex DevFlow

`codev` 基于一套基于Codex的自用开发工作流整合库, 默认工作环境是macOS,不支持windows平台.

## 1. 安装

```bash
git clone https://github.com/wmzhai/codev.git ~/codev
cd ~/codev
./setup
```

`./setup` 会自动 clone 或更新 `~/gstack`，执行 `~/gstack/setup --host codex`，然后再安装当前项目的 skills。
它也会自动检测并清理早期版本遗留的旧 codev skill symlink。

## 2. 高层摘要

- 半自动路径：`$office-hours -> $autoplan -> $codev-gstack2task/$codev-issue2task -> 审核 task plan -> $codev-autodev -> 人工确认 -> $codev-automerge`
- 人工路径：`$office-hours -> ... -> $codev-gstack2task/$codev-issue2task -> 审核 task plan -> $codev-taskdev -> $codev-simplify -> ... -> $codev-checktask -> $ship`
- repo 内的 `tasks/` 是 codev 的执行单元；任务文件本身同时承载需求、实现计划与验收基线；`~/.gstack/projects/` 是 gstack 的上游工件目录。

## 3. 详细文档

- [总流程图与总导航](docs/workflows/README.md)
- [旁支流程目录](docs/workflows/)
- [所有 skill 详细手册索引](docs/skills/README.md)

## 4. 受管 codev skills

- `$codev-memorize`
- `$codev-issue2task`
- `$codev-gstack2task`
- `$codev-taskdev`
- `$codev-autodev`
- `$codev-automerge`
- `$codev-checktask`
- `$codev-simplify`
- `$codev-checkpoint`
