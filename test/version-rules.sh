#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

assert_contains() {
  local path="$1"
  local expected="$2"

  grep -Fq -- "$expected" "${REPO_ROOT}/${path}" || fail "${path} missing: ${expected}"
}

assert_not_contains() {
  local path="$1"
  local unexpected="$2"

  if grep -Fq -- "$unexpected" "${REPO_ROOT}/${path}"; then
    fail "${path} still contains: ${unexpected}"
  fi
}

assert_not_matches() {
  local path="$1"
  local pattern="$2"

  if grep -Eq -- "$pattern" "${REPO_ROOT}/${path}"; then
    fail "${path} still matches regex: ${pattern}"
  fi
}

ship_files=(
  "skills/codev-ship/SKILL.md"
  "skills/codev-ship/agents/openai.yaml"
  "docs/skills/codev-ship.md"
)

ship_rule_files=(
  "skills/codev-ship/SKILL.md"
  "docs/skills/codev-ship.md"
)

checkpoint_files=(
  "skills/codev-checkpoint/SKILL.md"
  "skills/codev-checkpoint/agents/openai.yaml"
  "docs/skills/codev-checkpoint.md"
)

checkpoint_rule_files=(
  "skills/codev-checkpoint/SKILL.md"
  "docs/skills/codev-checkpoint.md"
)

closure_files=(
  "${ship_files[@]}"
  "${checkpoint_files[@]}"
)

version_surface_files=(
  "README.md"
  "AGENTS.md"
  ".grok/rules/memory.md"
  ".claude/rules/memory.md"
  ".cursor/rules/memory.mdc"
  "memory/core/invariants.md"
  "CHANGELOG"
  "${ship_files[@]}"
  "${checkpoint_files[@]}"
)

legacy_digit_label="4""位"
legacy_cn_label="四""位"
legacy_example="x.y.z.""w"
legacy_commit_example="vX.Y.Z.""W"
for path in "${ship_rule_files[@]}"; do
  assert_contains "$path" "显式版本"
  assert_contains "$path" "v<VERSION>"
  assert_contains "$path" "最后一段"
  assert_contains "$path" "三段或四段"
  assert_contains "$path" "无 task"
  assert_contains "$path" "CHANGELOG"
  assert_contains "$path" "tag"
done

for path in "${checkpoint_rule_files[@]}"; do
  assert_contains "$path" "VERSION"
  assert_contains "$path" "CHANGELOG"
  assert_contains "$path" "tag"
done

for path in "${closure_files[@]}"; do
  assert_contains "$path" "用户触发即表示"
  assert_not_contains "$path" "最小校验"
  assert_not_contains "$path" "可信验证证据"
  assert_not_contains "$path" "最小必要校验"
  assert_not_contains "$path" "git diff --check"
  assert_not_contains "$path" "bash -n"
  assert_not_contains "$path" "cargo build"
  assert_not_contains "$path" "pnpm build"
  assert_not_contains "$path" "version:check"
  assert_not_contains "$path" "cargo metadata"
  assert_not_contains "$path" "补跑"
done

assert_contains "README.md" "ship 优先遵守仓库本地版本规则"
assert_contains "README.md" "递增版本号最后一段"
assert_contains "README.md" "如果仓库没有 task，也可以按无 task 模式收尾"
assert_contains "README.md" 'checkpoint 默认同步已有 `CHANGELOG`'
assert_contains "docs/workflows.md" "codev-ship"
assert_contains "docs/workflows.md" "codev-checkpoint"
assert_contains "docs/workflows.md" "如果仓库没有 task，也可按无 task 模式收尾"
assert_contains "docs/workflows.md" '`codev-taskdev` 负责代码实现、任务文档同步，以及一次实现收尾精简和默认 build / 最小编译校验'
assert_contains "memory/core/invariants.md" "递增版本号最后一段"
assert_contains "memory/core/invariants.md" "v<VERSION>"
assert_contains "memory/core/invariants.md" "若仓库里没有可定位 task，则 ship 按无 task 模式收尾"
assert_contains "memory/core/invariants.md" '`codev-taskdev` 负责从 `tasks/` 中选择目标 plan'
assert_contains "memory/core/invariants.md" "默认 build / 最小编译校验"
assert_contains "memory/core/invariants.md" '默认同步已有 `CHANGELOG`'
assert_contains "memory/core/invariants.md" "用户触发 ship/checkpoint 即表示"

for path in "${version_surface_files[@]}"; do
  assert_not_contains "$path" "$legacy_digit_label"
  assert_not_contains "$path" "$legacy_cn_label"
  assert_not_contains "$path" "$legacy_example"
done

assert_not_contains "skills/codev-ship/SKILL.md" "$legacy_commit_example"
assert_not_contains "docs/skills/codev-ship.md" "$legacy_commit_example"
assert_not_contains "CHANGELOG" "$legacy_commit_example"
assert_not_contains "skills/codev-checkpoint/SKILL.md" "最后一位加一"
assert_not_contains "docs/skills/codev-checkpoint.md" "最后一位加一"
assert_not_contains "skills/codev-ship/SKILL.md" "补丁位加一"
assert_not_contains "docs/skills/codev-ship.md" "补丁位加一"

for path in "${ship_rule_files[@]}"; do
  assert_contains "$path" "0.0.1"
  assert_contains "$path" "CHANGELOG.md"
  assert_contains "$path" "缺则创建"
  assert_contains "$path" "附注 tag"
  assert_contains "$path" "gh release create"
  assert_contains "$path" "同一份 changelog 版本段"
  assert_contains "$path" "提交正文"
  assert_contains "$path" "--generate-notes"
done
assert_contains "memory/core/invariants.md" "附注 tag"
assert_contains "memory/core/invariants.md" "gh release create"
assert_contains "memory/core/invariants.md" "同一份 changelog 版本段"
assert_contains "skills/codev-ship/agents/openai.yaml" "git tag -a"
assert_contains "skills/codev-ship/agents/openai.yaml" "gh release create"
assert_contains "skills/codev-ship/SKILL.md" "禁止再递增"
assert_contains "docs/skills/codev-ship.md" "不再递增"
assert_not_contains "skills/codev-ship/SKILL.md" "仓库未初始化版本体系"
assert_contains "memory/core/invariants.md" "首发版本为 \`0.0.1\`"
assert_contains "README.md" "首发版本为 \`0.0.1\`"
assert_contains "docs/workflows.md" "首发版本为 \`0.0.1\`"

echo "version rules checks passed"
