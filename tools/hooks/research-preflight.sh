#!/usr/bin/env bash
# Research task preflight — market/buyer/content tasks.
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

if echo "$prompt" | grep -qiE '(market research|buyer research|research (the )?market|research (our )?buyers|content strategy|competitor research|find retailers|positioning strategy)'; then
  if echo "$prompt" | grep -qiE '(\bKOL\b|influencer|find creators)'; then
    echo '{}'
    exit 0
  fi
  MESSAGE='RESEARCH TASK PREFLIGHT (hook) — load skills before execution:

- Market/competitor: market-research, research-primer, platform-amazon, platform-reddit
- Buyer: buyer-research, buyer-signal-extractor, platform-amazon, platform-reddit
- Content strategy: content-research, content-angle-matrix, platform skills per brief
- Positioning: positioning, marketing-psychology, copywriting
- Notion writes: update-notion/SKILL.md first

Read context/brand-context.md. Announce loaded skills before browsing.'

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
