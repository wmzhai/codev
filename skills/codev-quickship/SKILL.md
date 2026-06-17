---
name: codev-quickship
description: 先执行 `codev-checkpoint` 的第一阶段，再执行版本 bump、`VERSION` 工件同步与 tag 推送。
---

# QuickShip

## 第一规则：先用中文交流

- skill 一触发，第一句就用中文和用户交流。
- 整个执行过程中的检查、阻塞说明和结果摘要默认都用中文。
- 只有用户明确要求英文或双语时，才切换语言。

## 两阶段执行模型

1. **第一阶段**：执行 `codev-checkpoint` 的收口核心动作，但不提交不 push（无版本 bump 与 tag）。
2. **第二阶段**：在第一阶段通过后，再执行版本 bump、版本工件更新，并在最终收口提交前统一提交。

## Preconditions

- 第一阶段前置条件通过；若已有可信验证证据或用户已确认人工验证通过则直接复用，否则必须能执行最小必要校验补证。
- 可信验证证据包括：本轮 `codev-taskdev` 记录、真实 API/数据库验证、页面验证、用户明确人工验证通过，或最后一次代码改动之后已有成功编译记录。
- 用户触发 `quickship`（或 `$codev-quickship`）即执行两阶段收口，不额外询问是否进入版本阶段。
- `VERSION` 与 tag 规则可解析（若仓库规则不存在，允许默认规则）。
- 本地可判断远端 tag 状态。

## Execution Flow

### 第一阶段：复用 checkpoint 核心

1. 按 `codev-checkpoint` 第一阶段流程执行其核心动作（任务定位、`docs/memory/AGENTS` 同步、`CHANGELOG` 未发布同步、最小校验），但不执行提交与 push。
2. 读取 task 文件、执行记录和本轮对话中的验证证据；若最后一次代码改动之后已有可信验证证据，则记录证据来源并复用，不重复执行 `cargo build --workspace`、`cargo build --bin backend`、`pnpm --dir frontend build` 等耗时 build，也不启动或重启本地服务。
3. 若 task 文件、执行记录和本轮对话没有可用验证证据，或可信验证后又发生代码改动，才按变更范围执行最小必要校验：文档/规则类至少 `git diff --check`，脚本类至少语法检查，代码类选择能覆盖本次改动的最小编译或测试入口。
4. 将 `issue` 映射关系与 close 前置要求先记录在位，等版本阶段完成后再按顺序处理（先 comment 再 close）。
5. 若第一阶段失败，直接停止，不进入版本阶段；否则默认自动进入版本与 tag 阶段。

### 第二阶段：版本与 tag 收口

6. 读取仓库本地版本规则，确认目标版本来源：
   - 若用户显式给版本，先验有效性后采用；
   - 否则按本地规则自动递增；
   - 无本地规则时按三段或四段数字最后一位递增。
7. 执行版本同步与工件更新（默认自动执行）：
   - 更新根 `VERSION`（及本地约定的衍生版本工件）；
   - 将 checkpoint 阶段积累的未发布记录整理入本次版本日志；
   - 按本地规则执行版本工件物化与校验命令（无定义则记录跳过）。
   - 对 `optworks` 版本收尾必须保留必要命令链：`pnpm version:sync`、`cargo metadata --format-version=1 >/dev/null`、`pnpm version:check`。
   - 版本阶段默认只运行版本必要命令，不额外执行 `cargo build --workspace`、`cargo build --bin backend`、`pnpm --dir frontend build`，除非第一阶段判定缺少可信验证证据。
8. 生成版本提交：
   - 将步骤 7 的变更与第一阶段结果合并；
   - 在本阶段一次性进行最终收口提交，使用 `type: 具体工作摘要 (v<目标VERSION>)`；
   - 提交前再次确认工作区和可提交范围。
9. 提交后 issue 处理：
   - 合并阶段完成后按 issue 映射执行 `gh issue comment`；
   - 再执行 `gh issue close`。
10. Tag 与推送：
   - 按规则生成 tag 名（默认 `v<目标VERSION>`）；
   - 推 tag 前确认 tag 与 `VERSION` 一致；
   - 检查本地/远端是否已存在同名 tag，存在则阻塞；
   - 创建 tag 并推送。
11. 返回汇报：
   - 回传第一阶段收口结果与第二阶段版本信息；
   - 输出目标版本、版本工件变更、`CHANGELOG` 版本归并结果、tag 推送结果。

## Stops / Failure Modes

- 第一阶段失败或被阻塞。
- 缺少可信验证证据且最小必要校验失败。
- 版本规则不可解析、仓库未初始化版本体系、或显式版本不符合规则。
- `CHANGELOG` 归并目标无法定位。
- tag 已存在或 tag 推送失败。
