# `$codev-quickship`

Source: `codev`

## Purpose

在用户完成人工验证并确认结果后，完成 task 的统一收尾：归档到 `tasks/done/`、同步任务相关 `docs/` / `memory/` / 必要时 `AGENTS.md`，并对仓库里已存在的版本号文件或 `CHANGELOG` 做最小同步，再把当前工作状态提交、合并并推送到主干；不走 PR、不打 tag，也不接管正式发布流程。

## Preconditions

- 用户显式调用 `$codev-quickship` 本身，就视为已经确认功能经过人工验证并确认结果符合预期；除非同轮明确撤回。
- 能明确定位本次对应的 task。
- 当前仓库允许直接推送 `main/master` 或默认主干。

## Inputs / Source Of Truth

- 当前 git 分支
- 仓库默认主干，或 `main/master`
- 对应的 `tasks/Txx-*.md`

## Produces / Writes

- 主干合并结果
- 主干推送结果
- 归档后的 task 文件
- 与本任务直接相关的 `docs/` / `memory/` / `AGENTS.md` 更新
- 已存在版本号文件或 `CHANGELOG` 的最小同步结果

## Execution Flow

1. 以当前 git 分支为起点，把用户显式调用 `$codev-quickship` 视为已经确认人工验证通过并允许收尾；只有用户同轮明确否定时才停止。
2. 定位对应 task，先同步最终 task 文档与验收结论。
3. 归档 task 到 `tasks/done/`，并最小范围同步任务相关 `docs/` / `memory/` / 必要时 `AGENTS.md`。
4. 检查仓库里是否已经存在版本号文件或 `CHANGELOG`；存在时按仓库既有方式做最小同步，不存在时明确跳过且不新建。
5. 检查工作区与主干权限，必要时先在当前分支做最小提交。
6. 如果当前在分支上，同步远端主干并在本地完成 merge；如果已经在主干上，直接在主干提交这次收尾改动。
7. 直接 push 主干。

## Stops / Failure Modes

- 用户在同轮明确表示尚未人工验证，或明确表示不要 push 主干。
- 主干受保护、权限不足或必须走 PR。
- 合并冲突无法安全收敛。

## Next Recommended Steps

- 收尾完成后继续开发下一个任务
- 如果仓库还需要 tag、正式发布或全局发布文档，改走 gstack 发布链路
