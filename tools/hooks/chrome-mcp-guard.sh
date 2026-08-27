#!/usr/bin/env bash
# Block Chrome MCP when DevTools is not reachable (Instagram KOL hard stop).
# Reminds on instagram.com navigate: Fantechzoom profile (Profile 16) + @christopherr1999 only; finecoustic_global banned.
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

tool_args="$(
  python3 -c "
import json, sys
raw = sys.stdin.read()
try:
    data = json.loads(raw) if raw.strip() else {}
except json.JSONDecodeError:
    data = {}
args = data.get('arguments') or data.get('params') or data.get('input') or {}
print(json.dumps(args))
" <<< "$input" 2>/dev/null || echo '{}'
)"

if echo "$tool_name" | grep -qi 'chrome'; then
  # Verify Chrome remote debugging is reachable
  chrome_ok=false
  if lsof -i :9222 >/dev/null 2>&1; then
    chrome_ok=true
  elif [[ -f "$HOME/Library/Application Support/Google/Chrome/DevToolsActivePort" ]]; then
    chrome_ok=true
  fi

  if [[ "$chrome_ok" != "true" ]]; then
    MESSAGE='Chrome MCP blocked. Enable remote debugging at chrome://inspect/#remote-debugging on the Fantechzoom profile (Profile 16) before Instagram work. Hard stop — do not substitute Playwright.'
    HOOK_JSON="$input" ROOT="$ROOT" MESSAGE="$MESSAGE" python3 - <<'PY'
import json, os, sys
sys.path.insert(0, os.path.join(os.environ["ROOT"], "tools", "hooks"))
from host_output import emit_deny, load_input
data = load_input()
emit_deny(data, os.environ["MESSAGE"])
PY
    exit 2
  fi

  # Block navigate_page to instagram.com unless it contains a reminder about rules
  nav_url="$(python3 -c "
import json, sys
args = json.loads(sys.argv[1])
print(args.get('url', ''))
" "$tool_args" 2>/dev/null || true)"

  if echo "$nav_url" | grep -qi 'instagram\.com'; then
    # Allow — but inject a reminder message so the rules stay top of mind
    MESSAGE="INSTAGRAM NAVIGATION ACTIVE — enforce rules:
• Profile: Fantechzoom (Profile 16) + @christopherr1999 only — finecoustic_global BANNED for IG
• Dwell ≥45s on this profile before next navigate
• Next wait: pick a random value between 3200–8000ms
• Count this navigation toward the 25/hour limit
• No backtracking. One tab. One direction."
    HOOK_JSON="$input" ROOT="$ROOT" MESSAGE="$MESSAGE" python3 - <<'PY'
import json, os, sys
sys.path.insert(0, os.path.join(os.environ["ROOT"], "tools", "hooks"))
from host_output import emit_agent_message, load_input
data = load_input()
emit_agent_message(data, os.environ["MESSAGE"])
PY
  fi
fi

echo '{"permission": "allow"}'
exit 0
