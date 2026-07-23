#!/usr/bin/env bash
# Remind agent to write lean session checkpoint after KOL-heavy sessions.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
input="$(cat)"

transcript="$(
  python3 -c "
import json, sys
raw = sys.stdin.read()
try:
    data = json.loads(raw) if raw.strip() else {}
except json.JSONDecodeError:
    data = {}
for key in ('transcript', 'conversation', 'messages', 'last_user_message', 'last_assistant_message'):
    val = data.get(key)
    if isinstance(val, str) and val.strip():
        print(val[:8000])
        break
" <<< "$input" 2>/dev/null || true
)"

if echo "$transcript" | grep -qiE '(\bKOL\b|KOLs|influencer|kol discovery|kol pool|notion.*kol)'; then
  MESSAGE='KOL session end (hook): Overwrite Jinu Active Thread in context/session-context.md (≤15 lines per kol-brief-templates.md). Append pass logs to context/session-context-log.md only. Do not embed seed handle lists in session-context.'
  HOOK_JSON="$input" ROOT="$ROOT" MESSAGE="$MESSAGE" python3 - <<'PY'
import json, os, sys
sys.path.insert(0, os.path.join(os.environ["ROOT"], "tools", "hooks"))
from host_output import emit_followup, load_input

data = load_input()
emit_followup(data, os.environ["MESSAGE"])
PY
  exit 0
fi

echo '{}'
exit 0
