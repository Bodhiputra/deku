#!/usr/bin/env bash
# Merge a local-state bundle into cloned repos on the TARGET machine (e.g. Windows Git Bash).
#
# Usage (after unzip):
#   ./migrate-local-state-import.sh /path/to/local-state-bundle
#   ./migrate-local-state-import.sh /path/to/local-state-bundle C:/dev
#
# Default base directory is the parent of finecoustic if run from inside Deku:
#   cd finecoustic && ./tools/migrate-local-state-import.sh ~/Downloads/local-state-bundle

set -euo pipefail

BUNDLE="${1:?Usage: migrate-local-state-import.sh BUNDLE_DIR [DEV_ROOT]}"

if [[ -n "${2:-}" ]]; then
  DEV_ROOT="$2"
else
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  if [[ "$(basename "$SCRIPT_DIR")" == "tools" ]]; then
    DEV_ROOT="$(dirname "$SCRIPT_DIR")"
    DEV_ROOT="$(dirname "$DEV_ROOT")"
  else
    DEV_ROOT="$(pwd)"
  fi
fi

DEKU_ROOT="$DEV_ROOT/finecoustic"
SHOPIFY_ROOT="$DEV_ROOT/finecoustic/shopify"
HUB_ROOT="$DEV_ROOT/finecoustic-ops-hub"

echo ""
echo "Deku local-state import"
echo "  Bundle:  $BUNDLE"
echo "  DEV_ROOT: $DEV_ROOT"
echo "  Deku:    $DEKU_ROOT"
echo "  Shopify: $SHOPIFY_ROOT"
echo "  Hub:     $HUB_ROOT"
echo ""

merge_tree() {
  local src="$1"
  local dest_root="$2"
  if [[ ! -e "$src" ]]; then
    echo "  skip (not in bundle): $src"
    return 0
  fi
  mkdir -p "$dest_root"
  if [[ -d "$src" ]]; then
    rsync -a "$src/" "$dest_root/"
  else
    mkdir -p "$(dirname "$dest_root")"
    cp -p "$src" "$dest_root"
  fi
  echo "  merged -> $dest_root"
}

if [[ ! -d "$DEKU_ROOT/.git" ]]; then
  echo "Error: Deku repo not found at $DEKU_ROOT — clone first, then re-run."
  exit 1
fi

echo "Merging Deku..."
merge_tree "$BUNDLE/finecoustic/.env" "$DEKU_ROOT/.env"
merge_tree "$BUNDLE/finecoustic/.claude/settings.local.json" "$DEKU_ROOT/.claude/settings.local.json"
merge_tree "$BUNDLE/finecoustic/.playwright-mcp-config.json" "$DEKU_ROOT/.playwright-mcp-config.json"
merge_tree "$BUNDLE/finecoustic/context" "$DEKU_ROOT/context"
merge_tree "$BUNDLE/finecoustic/knowledge-bank/brands" "$DEKU_ROOT/knowledge-bank/brands"
merge_tree "$BUNDLE/finecoustic/fonts" "$DEKU_ROOT/fonts"

if [[ -d "$SHOPIFY_ROOT/.git" ]]; then
  echo "Merging Shopify..."
  merge_tree "$BUNDLE/shopify/.env" "$SHOPIFY_ROOT/.env"
  merge_tree "$BUNDLE/shopify/.claude/settings.local.json" "$SHOPIFY_ROOT/.claude/settings.local.json"
  merge_tree "$BUNDLE/shopify/.codex/config.toml" "$SHOPIFY_ROOT/.codex/config.toml"
  merge_tree "$BUNDLE/shopify/context" "$SHOPIFY_ROOT/context"
  merge_tree "$BUNDLE/shopify/shopify.theme.toml" "$SHOPIFY_ROOT/shopify.theme.toml"
  merge_tree "$BUNDLE/shopify/.shopify" "$SHOPIFY_ROOT/.shopify"
else
  echo "Shopify repo missing at $SHOPIFY_ROOT — clone shopify, then re-run."
fi

if [[ -d "$HUB_ROOT/.git" ]]; then
  echo "Merging Finehub..."
  merge_tree "$BUNDLE/finecoustic-ops-hub/.env.local" "$HUB_ROOT/.env.local"
  merge_tree "$BUNDLE/finecoustic-ops-hub/.env.production.local" "$HUB_ROOT/.env.production.local"
  merge_tree "$BUNDLE/finecoustic-ops-hub/.env.vercel.production" "$HUB_ROOT/.env.vercel.production"
  merge_tree "$BUNDLE/finecoustic-ops-hub/brands/finecoustic/ops-data.json" "$HUB_ROOT/brands/finecoustic/ops-data.json"
  merge_tree "$BUNDLE/finecoustic-ops-hub/data" "$HUB_ROOT/data"
else
  echo "Finehub repo missing at $HUB_ROOT — clone ops-hub, then re-run."
fi

if [[ -d "$BUNDLE/extra-credentials" ]]; then
  echo ""
  echo "Extra credential files copied to bundle/extra-credentials/"
  echo "Update GOOGLE_APPLICATION_CREDENTIALS in finecoustic/.env to the Windows path, e.g.:"
  echo "  C:/Users/You/.config/gcloud/application_default_credentials.json"
  ls -la "$BUNDLE/extra-credentials/" 2>/dev/null || true
fi

if [[ -f "$BUNDLE/MACHINE_PATHS.txt" ]]; then
  echo ""
  echo "Original machine paths (from export):"
  cat "$BUNDLE/MACHINE_PATHS.txt"
fi

echo ""
echo "Import done. Next:"
echo "  1. Edit finecoustic/.env — fix any Mac paths (especially GA4 credentials)."
echo "  2. Deku: ./setup.sh  (Git Bash on Windows) or copy settings you already merged."
echo "  3. Finehub: npm install && npm run dev"
echo "  4. Shopify: shopify auth login && shopify theme dev"
echo "  5. Cursor: re-auth Notion/Figma MCP OAuth"
