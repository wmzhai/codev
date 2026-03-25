# `$codev-automerge`

Source: `codev`

## Purpose

在用户确认分支部署结果后，负责主干合并、版本号、正式发布与任务归档。

## Preconditions

- 用户已经明确确认功能与部署结果符合预期。
- 目标 task 已经处于“已部署待人工确认”状态。
- 主干、CI、review gate 与发布路径满足进入正式收尾的条件。

## Inputs / Source Of Truth

- 已更新的 `tasks/Txx-*.md`
- 当前 task 分支
- 当前仓库的发布方式
- 如兼容则读取 gstack 的 ship / deploy / 文档发布配置

## Produces / Writes

- `tasks/done/` 中的归档任务文件
- 主干合并结果
- 版本号、tag、正式发布结果
- 必要时由 gstack 更新的 repo 级文档

## Execution Flow

1. 定位目标任务与分支，确认用户确认已经存在。
2. 再同步一次 task 文档，把实现、验证、部署与确认状态写到最终版。
3. 准备把任务文件归档到 `tasks/done/`。
4. 进入正式发布路径，优先复用 `$ship`、`$land-and-deploy`、`$document-release`。
5. 在收尾阶段处理版本号、tag 和正式部署。
6. 确认主干、部署与归档都完成，再向用户报告结果。

## Stops / Failure Modes

- 用户没有明确确认。
- 主干保护、CI、review gate 或发布 gate 不满足。
- 当前分支与任务文件状态不一致。

## Next Recommended Steps

- 正式发布后继续 `$canary`
- 周期性总结时使用 `$retro`
