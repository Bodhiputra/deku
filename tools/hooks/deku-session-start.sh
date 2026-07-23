#!/usr/bin/env bash
# Deku workspace session reminder — bootstrap read order for finecoustic repo.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
input="$(cat)"

cwd="$(
  python3 -c "
import json, sys
raw = sys.stdin.read()
try:
    data = json.loads(raw) if raw.strip() else {}
except json.JSONDecodeError:
    data = {}
print(data.get('cwd', data.get('workspace_roots', '')))
" <<< "$input" 2>/dev/null || true
)"

if echo "$cwd" | grep -q 'finecoustic'; then
  MESSAGE='Deku session (hook): Mandatory read order — .claude/BOOTSTRAP.md, core/COMPANY.md, context/brand-context.md, context/session-context.md. KOL tasks also require context/kol-brief-templates.md + kol-discovery skill before browse.'
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
