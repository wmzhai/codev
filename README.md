# codev DevFlow

`codev` 是一套面向 Codex 的 codev skills 集合。默认工作环境是 macOS；暂不支持 Windows。

## 1. 安装

默认执行 `./setup` 时，会安装到 Codex 的全局目录。`setup` 只安装本仓库当前受管的 skills。

### Codex 全局安装

```bash
git clone https://github.com/wmzhai/codev.git ~/codev
cd ~/codev
./setup
```

当前只支持全局安装到 `~/.codex/skills/`。暂不支持项目内 vendored 安装。

## 2. 升级

### Codex 升级

```bash
cd ~/codev
git pull --ff-only
./setup
```

## 3. 使用流程

1. 先读 [docs/workflows.md](docs/workflows.md)。
2. 新仓库或记忆体系过期时，用 `$codev-memorize`。
3. 需求进入任务流时，用 `$codev-issue2task` 生成 `tasks/` 下的 task plan；在工作区根目录也可以用 `$codev-issue2task optworks#70` 指向当前目录下 `optworks/` 子仓库的 GitHub issue。
4. 人工审核 task plan 后，用 `$codev-taskdev` 在 task 分支推进实现；它会在收尾自动做一次语义不变精简和默认 build / 最小编译校验。
5. 跟踪开源上游但需要保留本地运行补丁时，用 `$codev-syncpatch`；它默认不提交、不 push、不默认创建分支，会先评估本地补丁能否安全重放。
6. 只想做一次轻量 `commit / push` 时，用 `$codev-checkpoint`；其主流程与 `$codev-quickship` 一致，差异是 checkpoint 不升级 `VERSION`、不打 tag。
7. 人工验证通过后，用 `$codev-quickship` 做与 checkpoint 一致的流程，并在其上执行 `VERSION` 同步与 tag 推送；其余动作不额外区分。

## 4. 文档导航

- 总流程：[`docs/workflows.md`](docs/workflows.md)
- skill 索引：[`docs/skills/README.md`](docs/skills/README.md)
- Codex 入口：`AGENTS.md`
- 底层运行规则：`skills/<name>/SKILL.md`
