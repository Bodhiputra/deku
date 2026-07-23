#!/usr/bin/env bash
# KOL task preflight — inject mandatory skill-read order before agent acts.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
input="$(cat)"

prompt="$(
  python3 -c "
import json, sys
raw = sys.stdin.read()
try:
    data = json.loads(raw) if raw.strip() else {}
except json.JSONDecodeError:
    data = {}
for key in ('prompt', 'user_message', 'text', 'message'):
    val = data.get(key)
    if isinstance(val, str) and val.strip():
        print(val)
        break
" <<< "$input" 2>/dev/null || true
)"

if [[ -z "$prompt" ]]; then
  echo '{}'
  exit 0
fi

if echo "$prompt" | grep -qiE '(\bKOL\b|KOLs|influencer|creator discovery|find creators|find KOL|kol discovery|kol search|kol pool|kol tracking|kol tracker)'; then
  MESSAGE='KOL TASK PREFLIGHT (hook) — complete before any browse, MCP browse, or Notion write:

1. Read .claude/skills/kol-discovery/SKILL.md
2. Read context/kol-brief-templates.md — confirm brief with brand owner if any field missing
3. Read context/brand-context.md → KOL Discovery Gates
4. Read .claude/skills/update-notion/SKILL.md (before any Notion write)
5. Load platform skills per brief: platform-instagram and/or platform-youtube (+ shorts if needed)
6. Run `node tools/sync-kol-list.js` — then read `context/kol-exclusion-list.md`
7. **Before every Notion write:** `node tools/sync-kol-list.js --check @handle` — exit 0 only if handle is NOT in pool. If blocked, skip write or update existing record (never create duplicate).
8. Chrome health check — if disconnected: NO Instagram discovery or IG verification (hard stop)
9. Announce loaded skills in chat, then execute

Seeds are dynamic per kol-brief-templates.md — never use hardcoded handle lists.'

  HOOK_JSON="$input" ROOT="$ROOT" MESSAGE="$MESSAGE" python3 - <<'PY'
import json, os, sys
sys.path.insert(0, os.path.join(os.environ["ROOT"], "tools", "hooks"))
from host_output import emit_agent_message, load_input

data = load_input()
emit_agent_message(data, os.environ["MESSAGE"])
PY
  exit 0
fi

echo '{}'
exit 0
