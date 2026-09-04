#!/usr/bin/env bash
# Block Chrome MCP when DevTools is not reachable (Instagram KOL hard stop).
# Hard block: instagram.com profile navigations until ig-session-verify.sh --confirm.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
input="$(cat)"
VERIFY_FILE="$ROOT/.tmp-ig-session-verified.json"

result="$(
  HOOK_JSON="$input" ROOT="$ROOT" VERIFY_FILE="$VERIFY_FILE" python3 - <<'PY'
import json, os, re, sys
from datetime import datetime, timezone
from urllib.parse import urlparse

root = os.environ["ROOT"]
verify_file = os.environ["VERIFY_FILE"]
sys.path.insert(0, os.path.join(root, "tools", "hooks"))
from host_output import emit_agent_message, emit_deny, emit_allow, load_input

data = load_input()

def pick(*keys):
    for k in keys:
        v = data.get(k)
        if isinstance(v, str) and v.strip():
            return v.strip()
    return ""

tool = pick("tool_name", "toolName", "name", "mcpToolName")
tool_lower = tool.lower()

args = data.get("arguments") or data.get("params") or data.get("input") or {}
if isinstance(args, str):
    try:
        args = json.loads(args)
    except json.JSONDecodeError:
        args = {}

nav_type = args.get("type", "")
url = (args.get("url") or "").strip()

is_chrome_mcp = "chrome" in tool_lower
is_nav_tool = any(x in tool_lower for x in ("navigate_page", "new_page"))
is_instagram_nav = is_nav_tool and bool(url) and "instagram.com" in url.lower()

if not is_chrome_mcp and not is_instagram_nav:
    emit_allow()
    sys.exit(0)

if is_instagram_nav and not is_chrome_mcp:
    # Cursor/Codex may pass bare tool names — still gate instagram.com navigations.
    pass
elif not is_chrome_mcp:
    emit_allow()
    sys.exit(0)

# Chrome remote debugging reachable?
chrome_ok = False
try:
    import subprocess
    if subprocess.run(["lsof", "-i", ":9222"], capture_output=True).returncode == 0:
        chrome_ok = True
except Exception:
    pass
devtools = os.path.expanduser("~/Library/Application Support/Google/Chrome/DevToolsActivePort")
if not chrome_ok and os.path.isfile(devtools):
    chrome_ok = True

if not chrome_ok:
    msg = (
        "Chrome MCP blocked. Enable remote debugging at chrome://inspect/#remote-debugging "
        "on the Fantechzoom profile (Profile 16) before Instagram work. "
        "Hard stop — do not substitute Playwright."
    )
    emit_deny(data, msg)
    sys.exit(2)

if nav_type and nav_type != "url":
    emit_allow()
    sys.exit(0)

if not is_instagram_nav:
    emit_allow()
    sys.exit(0)

path = urlparse(url).path.strip("/")
segments = [s for s in path.split("/") if s]

ALLOWED_PREVERIFY = {"", "explore", "reels", "direct", "accounts", "stories"}
REQUIRED_USER = "christopherr1999"
BANNED_USERS = {"finecoustic_global", "finecoustic_"}

def is_prewarm_allowed(segs):
    if not segs:
        return True
    if segs[0].lower() in ALLOWED_PREVERIFY:
        return True
    if segs[0].lower() == REQUIRED_USER:
        return True
    return False

def session_verified():
    if not os.path.isfile(verify_file):
        return False, "missing"
    try:
        with open(verify_file, encoding="utf-8") as f:
            payload = json.load(f)
    except (json.JSONDecodeError, OSError):
        return False, "invalid"
    username = (payload.get("username") or "").lower().lstrip("@")
    if username in BANNED_USERS or username != REQUIRED_USER:
        return False, f"wrong_user:{username}"
    expires_raw = payload.get("expires_at")
    if not expires_raw:
        return False, "no_expiry"
    expires = datetime.fromisoformat(expires_raw)
    if expires.tzinfo is None:
        expires = expires.replace(tzinfo=timezone.utc)
    if datetime.now(timezone.utc) >= expires:
        return False, "expired"
    return True, username

if is_prewarm_allowed(segments):
    msg = (
        "INSTAGRAM PRE-VERIFY NAVIGATION — before any KOL profile:\n"
        "1. Confirm Fantechzoom (Profile 16) is the active Chrome profile\n"
        "2. take_snapshot — sidebar must show @christopherr1999 (NOT finecoustic_global)\n"
        "3. Run: tools/ig-session-verify.sh --confirm\n"
        "4. Only then navigate to KOL profiles\n"
        "Dwell ≥45s per profile · varied 3200–8000ms waits · max 25 navigations/hour"
    )
    emit_agent_message(data, msg)
    emit_allow()
    sys.exit(0)

ok, reason = session_verified()
if ok:
    msg = (
        "INSTAGRAM NAVIGATION (verified @christopherr1999) — enforce rate limits:\n"
        "• Dwell ≥45s on this profile before next navigate\n"
        "• Next wait: random 3200–8000ms\n"
        "• Count toward 25/hour limit · one tab · no backtracking"
    )
    emit_agent_message(data, msg)
    emit_allow()
    sys.exit(0)

if reason == "expired":
    detail = "Verification expired — re-run pre-verify flow."
elif reason.startswith("wrong_user"):
    detail = f"Verified as banned/wrong account ({reason.split(':',1)[-1]}). Run tools/ig-session-verify.sh --clear after switching."
else:
    detail = "No valid IG session verification on file."

target = segments[0] if segments else path
msg = (
    f"Chrome MCP blocked: instagram.com/{target}/ requires verified @christopherr1999 session.\n"
    f"{detail}\n\n"
    "Required order:\n"
    "1. Owner confirms Fantechzoom (Profile 16) + @christopherr1999\n"
    "2. navigate_page → https://www.instagram.com/christopherr1999/ (or home feed)\n"
    "3. take_snapshot — confirm sidebar username\n"
    "4. Shell: tools/ig-session-verify.sh --confirm\n"
    "5. Retry this navigation\n\n"
    "Banned: @finecoustic_global · Finecoustic profile (19) · Alex profile (17)"
)
emit_deny(data, msg)
sys.exit(2)
PY
)" || true

if [[ -n "$result" ]]; then
  echo "$result"
  if echo "$result" | grep -qE '"permission": "deny"|"permissionDecision": "deny"'; then
    exit 2
  fi
fi

echo '{"permission": "allow"}'
exit 0
