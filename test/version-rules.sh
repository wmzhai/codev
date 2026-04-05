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

quickship_files=(
  "skills/codev-quickship/SKILL.md"
  "skills/codev-quickship/agents/openai.yaml"
  "docs/skills/codev-quickship.md"
)

checkpoint_files=(
  "skills/codev-checkpoint/SKILL.md"
  "skills/codev-checkpoint/agents/openai.yaml"
  "docs/skills/codev-checkpoint.md"
)

for path in "${quickship_files[@]}"; do
  assert_contains "$path" "未显式指定版本"
  assert_contains "$path" "vX.Y.Z"
  assert_contains "$path" "z+1"
  assert_contains "$path" "无 task"
  assert_contains "$path" "CHANGELOG"
done

for path in "${checkpoint_files[@]}"; do
  assert_contains "$path" "不默认升级版本号"
done

assert_contains "README.md" "quickship 默认按 3 位版本号递增补丁位"
assert_contains "README.md" "如果仓库没有 task，也可以按无 task 模式收尾"
assert_contains "README.md" 'checkpoint 不再默认同步根目录 `VERSION` 与 `CHANGELOG`'
assert_contains "docs/workflows.md" "codev-quickship"
assert_contains "docs/workflows.md" "codev-checkpoint"
assert_contains "docs/workflows.md" "如果仓库没有 task，也可按无 task 模式收尾"
assert_contains "AGENTS.md" "quickship 在未显式指定版本时默认把补丁位加一"
assert_contains "AGENTS.md" "如果仓库里没有可定位 task，则 quickship 仍可按无 task 模式收尾"
assert_contains "AGENTS.md" '`codev-checkpoint` 是轻量 `commit/push` fallback，不默认升级版本号'

assert_not_contains "skills/codev-quickship/SKILL.md" "vX.Y.Z.W"
assert_not_contains "docs/skills/codev-quickship.md" "vX.Y.Z.W"
assert_not_contains "skills/codev-quickship/SKILL.md" "四段纯数字"
assert_not_contains "docs/skills/codev-quickship.md" "四段纯数字"
assert_not_contains "skills/codev-checkpoint/SKILL.md" "最后一位加一"
assert_not_contains "docs/skills/codev-checkpoint.md" "最后一位加一"

echo "version rules checks passed"
