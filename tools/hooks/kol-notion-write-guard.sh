#!/usr/bin/env bash
# Block Notion KOL Pool writes when handle already exists (live Notion check).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
input="$(cat)"

result="$(
  HOOK_JSON="$input" ROOT="$ROOT" python3 - <<'PY'
import json, os, subprocess, sys

root = os.environ["ROOT"]
sys.path.insert(0, os.path.join(root, "tools", "hooks"))
from host_output import emit_allow, emit_deny, is_codex, load_input

raw = os.environ.get("HOOK_JSON", "")
try:
    data = json.loads(raw) if raw.strip() else {}
except json.JSONDecodeError:
    data = {}

def pick(*keys):
    for k in keys:
        v = data.get(k)
        if isinstance(v, str) and v.strip():
            return v.strip()
    return ""

tool = pick("tool_name", "toolName", "name", "mcpToolName")
if "notion-create-pages" not in tool.lower():
    if is_codex(data):
        sys.exit(0)
    emit_allow()
    sys.exit(0)

args = data.get("arguments") or data.get("tool_input") or data.get("params") or {}
if isinstance(args, str):
    try:
        args = json.loads(args)
    except json.JSONDecodeError:
        args = {}

handles = []
for page in args.get("pages") or []:
    if not isinstance(page, dict):
        continue
    props = page.get("properties") or {}
    name = props.get("KOL Channel Name") or props.get("title")
    if isinstance(name, str) and name.strip():
        handles.append(name.strip())

if not handles:
    if is_codex(data):
        sys.exit(0)
    emit_allow()
    sys.exit(0)

blocked = []
for handle in handles:
    proc = subprocess.run(
        ["node", os.path.join(root, "tools/sync-kol-list.js"), "--check", handle],
        cwd=root,
        capture_output=True,
        text=True,
    )
    if proc.returncode != 0:
        blocked.append((proc.stderr or proc.stdout).strip())

if blocked:
    msg = (
        "KOL dedup guard blocked Notion write — handle already in KOL Pools:\n"
        + "\n".join(blocked)
        + "\n\nRun: node tools/sync-kol-list.js --check @handle before any write. "
        "Update the existing Notion record instead of creating a new one."
    )
    emit_deny(data, msg)
    sys.exit(2)

if is_codex(data):
    sys.exit(0)
emit_allow()
PY
)"

if [[ -n "$result" ]]; then
  echo "$result"
  if echo "$result" | grep -qE '"permission": "deny"|"permissionDecision": "deny"'; then
    exit 2
  fi
fi

echo '{"permission": "allow"}'
exit 0
