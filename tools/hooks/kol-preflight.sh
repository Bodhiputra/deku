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

if echo "$prompt" | grep -qiE '(\bKOL\b|KOLs|influencer|creator discovery|find creators|find KOL|kol discovery|kol search|kol pool|kol tracking|kol tracker|instagram|search.*instagram|instagram.*search|browse.*instagram|find.*instagram|IG\b)'; then
  MESSAGE='KOL / INSTAGRAM TASK PREFLIGHT (hook) — complete before any browse, MCP browse, or Notion write:

1. Read .claude/skills/kol-discovery/SKILL.md
2. Read context/kol-brief-templates.md — confirm brief with brand owner if any field missing
3. Read context/brand-context.md → KOL Discovery Gates
4. Read .claude/skills/update-notion/SKILL.md (before any Notion write)
5. Load platform skills per brief: platform-instagram and/or platform-youtube (+ shorts if needed)
6. Run `node tools/sync-kol-list.js` — then read `context/kol-exclusion-list.md`
7. **Before every Notion write:** `node tools/sync-kol-list.js --check @handle` — exit 0 only if handle is NOT in pool.
8. Chrome health check — call list_pages. If disconnected: NO Instagram work (hard stop).
9. Announce loaded skills in chat, then execute.

INSTAGRAM HARD RULES (non-negotiable — violating these suspends @christopherr1999):
- Chrome profile (IG only): Fantechzoom (Profile 16) only. Never Finecoustic (Profile 19), never Alex (Profile 17).
- Account: @christopherr1999 only. BANNED: @finecoustic_global — confirm sidebar before any navigation.
- Session warm-up: spend 30-60s on the feed before navigating to any profile.
- Max 25-30 profile navigations per hour. Stop 10+ min at 25.
- Minimum 45 seconds dwell on every profile before navigating away.
- Varied waits between navigations: 3200ms–8000ms. NEVER a fixed interval.
- Max 90 minutes continuous. Then 15 min break.
- One tab. One direction. Never revisit a URL. Never backtrack.
- Pre-screen every handle externally (Socialpruf/Viralist) before opening Chrome.
- Extract handle lists via take_snapshot + grep — never navigate to collect handles.
- No instant scroll. Wait 2-3s after navigate, then scroll slowly with 1-2s pauses.
- No fill on Instagram inputs. Use type_text only.
- On suspension signal (accounts/suspended in URL): stop immediately, switch to web search, wait 30+ min.

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
