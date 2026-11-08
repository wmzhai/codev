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

for path in \
  "skills/codev-issue2task/SKILL.md" \
  "skills/codev-taskdev/SKILL.md" \
  "skills/codev-memorize/SKILL.md"
do
  assert_contains "$path" "Grok / Grok Build TUI"
  assert_contains "$path" "Claude Code"
  assert_contains "$path" "/<skill-name>"
  assert_contains "$path" '$<skill-name>'
done

assert_not_contains "skills/codev-issue2task/SKILL.md" '再进入 `$codev-taskdev`'
assert_not_contains "skills/codev-taskdev/SKILL.md" '确认通过后再用 `$codev-ship`'

assert_contains "docs/skills/codev-issue2task.md" "/codev-taskdev"
assert_contains "docs/skills/codev-taskdev.md" "/codev-ship"
assert_contains "docs/skills/codev-memorize.md" 'Claude Code：`/codev-issue2task`'
assert_contains "README.md" 'Grok、Claude Code 与 Cursor 把 `$` 换成 `/`'
assert_contains "docs/workflows.md" 'Grok、Claude Code 与 Cursor 把 `$` 换成 `/`'

assert_contains "AGENTS.md" "本文件只服务 Codex / GPT"
assert_contains ".grok/rules/memory.md" "本文件只服务 Grok / Grok Build TUI"
assert_contains ".claude/rules/memory.md" "本文件只服务 Claude Code"
assert_contains "AGENTS.md" "只遵循 \`memory/\`"
assert_contains ".grok/rules/memory.md" "只遵循 \`memory/\`"
assert_contains ".claude/rules/memory.md" "只遵循 \`memory/\`"
assert_contains "skills/codev-memorize/SKILL.md" "都必须一次写齐 \`memory/\`、\`AGENTS.md\`、\`.grok/rules/memory.md\`、\`.claude/rules/memory.md\` 和 \`.cursor/rules/memory.mdc\`"
assert_contains ".cursor/rules/memory.mdc" "本文件只服务 Cursor"
assert_contains ".cursor/rules/memory.mdc" "只遵循 \`memory/\`"
assert_contains ".cursor/rules/memory.mdc" "/codev-taskdev"
assert_contains "README.md" "codev-commit"
assert_contains "docs/skills/README.md" "codev-commit"
assert_contains "skills/codev-memorize/SKILL.md" "不生成、不更新、不维护 \`CLAUDE.md\`"
if [[ -e "${REPO_ROOT}/CLAUDE.md" ]]; then
  fail "CLAUDE.md should not exist"
fi

echo "skill invocation prefix checks passed"
