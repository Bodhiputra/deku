#!/usr/bin/env bash
# Pack gitignored local state from Deku + Shopify + Finehub for machine migration.
# Run on the SOURCE machine (e.g. Mac mini) from the Deku repo root.
#
# Usage:
#   ./tools/migrate-local-state-export.sh
#   ./tools/migrate-local-state-export.sh /path/to/output-folder
#
# Then encrypt and transfer:
#   zip -er ~/Desktop/deku-local-state.zip /path/to/output-folder

set -euo pipefail

DEKU_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SHOPIFY_ROOT="${SHOPIFY_ROOT:-$DEKU_ROOT/shopify}"
HUB_ROOT="${HUB_ROOT:-$(dirname "$DEKU_ROOT")/finecoustic-ops-hub}"

STAMP="$(date +%Y%m%d)"
OUT="${1:-$HOME/Desktop/laptop-local-state-$STAMP}"
BUNDLE="$OUT/local-state-bundle"

echo ""
echo "Deku local-state export"
echo "  Deku:    $DEKU_ROOT"
echo "  Shopify: $SHOPIFY_ROOT"
echo "  Hub:     $HUB_ROOT"
echo "  Output:  $BUNDLE"
echo ""

mkdir -p "$BUNDLE"

copy_if_exists() {
  local src="$1"
  local dest="$2"
  if [[ -e "$src" ]]; then
    mkdir -p "$(dirname "$dest")"
    if [[ -d "$src" ]]; then
      rsync -a "$src/" "$dest/"
    else
      cp -p "$src" "$dest"
    fi
    echo "  + $src"
    return 0
  fi
  echo "  - (missing) $src"
  return 1
}

MISSING=0

echo "Deku (finecoustic)..."
DEKU_DEST="$BUNDLE/finecoustic"
copy_if_exists "$DEKU_ROOT/.env" "$DEKU_DEST/.env" || MISSING=$((MISSING + 1))
copy_if_exists "$DEKU_ROOT/.claude/settings.local.json" "$DEKU_DEST/.claude/settings.local.json" || true
copy_if_exists "$DEKU_ROOT/.playwright-mcp-config.json" "$DEKU_DEST/.playwright-mcp-config.json" || true
copy_if_exists "$DEKU_ROOT/context" "$DEKU_DEST/context" || MISSING=$((MISSING + 1))
copy_if_exists "$DEKU_ROOT/knowledge-bank/brands" "$DEKU_DEST/knowledge-bank/brands" || true
copy_if_exists "$DEKU_ROOT/fonts" "$DEKU_DEST/fonts" || true

echo ""
echo "Shopify..."
SHOPIFY_DEST="$BUNDLE/shopify"
if [[ -d "$SHOPIFY_ROOT" ]]; then
  copy_if_exists "$SHOPIFY_ROOT/.env" "$SHOPIFY_DEST/.env" || true
  copy_if_exists "$SHOPIFY_ROOT/.claude/settings.local.json" "$SHOPIFY_DEST/.claude/settings.local.json" || true
  copy_if_exists "$SHOPIFY_ROOT/.codex/config.toml" "$SHOPIFY_DEST/.codex/config.toml" || true
  copy_if_exists "$SHOPIFY_ROOT/context" "$SHOPIFY_DEST/context" || true
  copy_if_exists "$SHOPIFY_ROOT/shopify.theme.toml" "$SHOPIFY_DEST/shopify.theme.toml" || true
  copy_if_exists "$SHOPIFY_ROOT/.shopify" "$SHOPIFY_DEST/.shopify" || true
else
  echo "  ! Shopify repo not found at $SHOPIFY_ROOT (set SHOPIFY_ROOT=...)"
  MISSING=$((MISSING + 1))
fi

echo ""
echo "Finehub (ops-hub)..."
HUB_DEST="$BUNDLE/finecoustic-ops-hub"
if [[ -d "$HUB_ROOT" ]]; then
  copy_if_exists "$HUB_ROOT/.env.local" "$HUB_DEST/.env.local" || true
  copy_if_exists "$HUB_ROOT/.env.production.local" "$HUB_DEST/.env.production.local" || true
  copy_if_exists "$HUB_ROOT/.env.vercel.production" "$HUB_DEST/.env.vercel.production" || true
  copy_if_exists "$HUB_ROOT/brands/finecoustic/ops-data.json" "$HUB_DEST/brands/finecoustic/ops-data.json" || true
  copy_if_exists "$HUB_ROOT/data" "$HUB_DEST/data" || true
else
  echo "  ! Hub repo not found at $HUB_ROOT (set HUB_ROOT=...)"
  MISSING=$((MISSING + 1))
fi

echo ""
echo "GA4 / gcloud credential files (from Deku .env)..."
ADC_EXTRA=""
if [[ -f "$DEKU_ROOT/.env" ]]; then
  # shellcheck disable=SC1090
  set -a
  # shellcheck source=/dev/null
  source "$DEKU_ROOT/.env" 2>/dev/null || true
  set +a
  if [[ -n "${GOOGLE_APPLICATION_CREDENTIALS:-}" && -f "${GOOGLE_APPLICATION_CREDENTIALS}" ]]; then
    ADC_EXTRA="$GOOGLE_APPLICATION_CREDENTIALS"
    copy_if_exists "$ADC_EXTRA" "$BUNDLE/extra-credentials/$(basename "$ADC_EXTRA")" || true
    echo "GOOGLE_APPLICATION_CREDENTIALS=$ADC_EXTRA" >> "$BUNDLE/MACHINE_PATHS.txt"
  fi
fi

# Import script for the laptop (same version as in repo)
copy_if_exists "$DEKU_ROOT/tools/migrate-local-state-import.sh" "$BUNDLE/migrate-local-state-import.sh" || true
copy_if_exists "$DEKU_ROOT/tools/MIGRATE-LOCAL-STATE.md" "$BUNDLE/MIGRATE-LOCAL-STATE.md" || true

{
  echo "Export created: $(date -Iseconds)"
  echo "Deku root: $DEKU_ROOT"
  echo "Shopify root: $SHOPIFY_ROOT"
  echo "Hub root: $HUB_ROOT"
  echo ""
  echo "File listing (paths only):"
  find "$BUNDLE" -type f ! -name 'MANIFEST.txt' | sed "s|^$BUNDLE/||" | sort
} > "$BUNDLE/MANIFEST.txt"

echo ""
du -sh "$BUNDLE" 2>/dev/null || true
echo ""
echo "Done. Bundle: $BUNDLE"
echo ""
echo "Next on this machine:"
echo "  zip -er \"$HOME/Desktop/deku-local-state-$STAMP.zip\" \"$BUNDLE\""
echo "  Transfer the .zip via USB / AirDrop (do not email)."
echo ""
echo "On the laptop: clone repos, unzip, run migrate-local-state-import.sh (see MIGRATE-LOCAL-STATE.md)."
if [[ "$MISSING" -gt 0 ]]; then
  echo ""
  echo "Warning: some expected paths were missing ($MISSING). Check output above."
fi
