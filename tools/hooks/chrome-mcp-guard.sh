#!/usr/bin/env bash
# Block Chrome MCP when DevTools is not reachable (Instagram KOL hard stop).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
input="$(cat)"

tool_name="$(
  python3 -c "
import json, sys
raw = sys.stdin.read()
try:
    data = json.loads(raw) if raw.strip() else {}
except json.JSONDecodeError:
    data = {}
for key in ('tool_name', 'toolName', 'name', 'mcpToolName', 'server', 'mcp_server'):
    val = data.get(key)
    if isinstance(val, str) and val.strip():
        print(val)
        break
" <<< "$input" 2>/dev/null || true
)"

if echo "$tool_name" | grep -qi 'chrome'; then
  chrome_ok=false
  if lsof -i :9222 >/dev/null 2>&1; then
    chrome_ok=true
  elif [[ -f "$HOME/Library/Application Support/Google/Chrome/DevToolsActivePort" ]]; then
    chrome_ok=true
  fi

  if [[ "$chrome_ok" != "true" ]]; then
    MESSAGE='Chrome MCP blocked by project hook. Open Chrome and enable remote debugging at chrome://inspect/#remote-debugging before Instagram KOL work. Do not use Playwright or web search as a substitute for Instagram profile verification. Stop IG KOL work until Chrome connects.'
    HOOK_JSON="$input" ROOT="$ROOT" MESSAGE="$MESSAGE" python3 - <<'PY'
import json, os, sys
sys.path.insert(0, os.path.join(os.environ["ROOT"], "tools", "hooks"))
from host_output import emit_deny, load_input

data = load_input()
emit_deny(data, os.environ["MESSAGE"])
PY
    exit 2
  fi
fi

echo '{"permission": "allow"}'
exit 0
