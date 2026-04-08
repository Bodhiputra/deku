#!/bin/bash
# run-pipeline.sh
# ─────────────────────────────────────────────────────────────────────────────
# Marketing pipeline runner with auto-continuation.
#
# Agents write to context/.needs-continuation to request a new session.
# This script detects that file after each session ends and auto-resumes.
#
# ONLY fires continuation when an agent explicitly requested it.
# If you /exit manually without an agent writing the sentinel → nothing happens.
# Press Ctrl+C during the countdown to abort any auto-continuation.
#
# Usage:
#   ./run-pipeline.sh              — start fresh session
#   ./run-pipeline.sh --continue   — resume last session manually
# ─────────────────────────────────────────────────────────────────────────────

SENTINEL="context/.needs-continuation"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# ── Chrome remote debugging setup ────────────────────────────────────────────
if lsof -i :9222 &>/dev/null; then
  echo "Chrome ready on port 9222."
else
  echo "Chrome not running with remote debugging. Launching..."
  open -a "Google Chrome" --args \
    --remote-debugging-port=9222 \
    --profile-directory="Profile 17" \
    --no-first-run \
    --no-default-browser-check
  sleep 4
  if lsof -i :9222 &>/dev/null; then
    echo "Chrome ready on port 9222."
  else
    echo "Warning: Chrome port 9222 not confirmed. Proceeding anyway."
  fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Chrome is running with remote debugging on port 9222."
echo "  If Chrome showed a 'remote debugging' dialog,"
echo "  dismiss it now before continuing."
echo ""
read -rp "  Press Enter when ready to start the session... "
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ── Clear stale sentinel (older than 10 minutes = leftover from a prior run) ─
if [ -f "$SENTINEL" ]; then
  FILE_AGE=$(( $(date +%s) - $(stat -f %m "$SENTINEL") ))
  if [ "$FILE_AGE" -gt 600 ]; then
    echo "Clearing stale continuation request (${FILE_AGE}s old)."
    rm -f "$SENTINEL"
  fi
fi

# ── First session ─────────────────────────────────────────────────────────────
if [ "$1" = "--continue" ]; then
  echo "Resuming last session..."
  claude --continue
else
  claude
fi

# ── Auto-continuation loop ────────────────────────────────────────────────────
# Only runs if an agent wrote the sentinel file during the session above.
# Manual /exit without a sentinel = loop never runs.

while [ -f "$SENTINEL" ]; do
  STATUS=$(cat "$SENTINEL" 2>/dev/null || echo "continuation requested")
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  Agent requested continuation: $STATUS"
  echo "  Starting new session in 10 seconds."
  echo "  Press Ctrl+C to abort."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  sleep 10 || { echo ""; echo "Continuation aborted."; exit 0; }
  rm -f "$SENTINEL"
  echo "Resuming pipeline..."
  echo ""
  claude --continue
done

echo ""
echo "Session ended. No continuation was requested."
