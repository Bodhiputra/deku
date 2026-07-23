#!/usr/bin/env bash
# Try to start Chrome with remote debugging when a Chrome MCP tool is invoked.
set -euo pipefail

if lsof -i :9222 >/dev/null 2>&1; then
  exit 0
fi

open -a 'Google Chrome' --args --remote-debugging-port=9222 --no-first-run --no-default-browser-check 2>/dev/null || true
sleep 4
exit 0
