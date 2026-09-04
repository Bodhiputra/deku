#!/usr/bin/env bash
# Instagram session verification gate for Jinu Chrome MCP work.
#
# After take_snapshot confirms @christopherr1999 on Fantechzoom (Profile 16):
#   tools/ig-session-verify.sh --confirm
#
# Check status:
#   tools/ig-session-verify.sh --status
#
# Clear (session end / wrong account):
#   tools/ig-session-verify.sh --clear
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VERIFY_FILE="$ROOT/.tmp-ig-session-verified.json"
REQUIRED_USER="christopherr1999"
BANNED_USERS=("finecoustic_global" "finecoustic_")
SESSION_HOURS=4

usage() {
  cat <<EOF
Usage: tools/ig-session-verify.sh --confirm [--username christopherr1999]
       tools/ig-session-verify.sh --status
       tools/ig-session-verify.sh --clear

Marks IG session verified for chrome-mcp-guard.sh after sidebar shows @christopherr1999.
EOF
}

normalize_user() {
  echo "${1#@}" | tr '[:upper:]' '[:lower:]'
}

write_verify() {
  local username="$1"
  python3 - "$VERIFY_FILE" "$username" "$SESSION_HOURS" <<'PY'
import json, sys
from datetime import datetime, timedelta, timezone

path, username, hours = sys.argv[1], sys.argv[2], int(sys.argv[3])
now = datetime.now(timezone.utc)
payload = {
    "username": username,
    "verified_at": now.isoformat(),
    "expires_at": (now + timedelta(hours=hours)).isoformat(),
    "chrome_profile": "Fantechzoom (Profile 16)",
    "verified_by": "tools/ig-session-verify.sh",
}
with open(path, "w", encoding="utf-8") as f:
    json.dump(payload, f, indent=2)
    f.write("\n")
print(f"IG session verified: @{username} (valid {hours}h)")
PY
}

cmd="${1:-}"
shift || true

case "$cmd" in
  --confirm)
    username="$(normalize_user "${1:-$REQUIRED_USER}")"
    for banned in "${BANNED_USERS[@]}"; do
      if [[ "$username" == "$(normalize_user "$banned")" ]]; then
        echo "ERROR: @$username is banned for agent IG work. Switch to @$REQUIRED_USER on Fantechzoom (Profile 16)." >&2
        exit 1
      fi
    done
    if [[ "$username" != "$REQUIRED_USER" ]]; then
      echo "ERROR: Expected @$REQUIRED_USER, got @$username. Hard stop — switch Chrome profile/account." >&2
      exit 1
    fi
    write_verify "$username"
    ;;
  --status)
    if [[ ! -f "$VERIFY_FILE" ]]; then
      echo "NOT_VERIFIED"
      exit 1
    fi
    python3 - "$VERIFY_FILE" <<'PY'
import json, sys
from datetime import datetime, timezone

path = sys.argv[1]
with open(path, encoding="utf-8") as f:
    data = json.load(f)
expires = datetime.fromisoformat(data["expires_at"])
if expires.tzinfo is None:
    expires = expires.replace(tzinfo=timezone.utc)
if datetime.now(timezone.utc) >= expires:
    print("EXPIRED")
    sys.exit(1)
print(json.dumps(data, indent=2))
PY
    ;;
  --clear)
    rm -f "$VERIFY_FILE"
    echo "IG session verification cleared."
    ;;
  -h|--help|"")
    usage
    [[ -n "$cmd" ]] || exit 1
    ;;
  *)
    echo "Unknown command: $cmd" >&2
    usage >&2
    exit 1
    ;;
esac
