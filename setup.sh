#!/bin/bash
# setup.sh — Jinu & Nagi Team Setup
# Run once after cloning. Your Claude Code assistant can run this for you.

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "======================================"
echo "  Jinu & Nagi — Team Setup"
echo "======================================"
echo ""

# ── Prerequisites ──────────────────────────────────────────────────────────────

echo "Checking prerequisites..."
echo ""

MISSING=0

if command -v node >/dev/null 2>&1; then
  echo "  ✓ Node.js"
else
  echo "  ✗ Node.js not found"
  echo "    Install from: https://nodejs.org"
  MISSING=1
fi

if command -v npx >/dev/null 2>&1; then
  echo "  ✓ npx"
else
  echo "  ✗ npx not found (should come with Node.js)"
  MISSING=1
fi

if command -v claude >/dev/null 2>&1; then
  echo "  ✓ Claude Code"
else
  echo "  ✗ Claude Code not found"
  echo "    Install from: https://claude.ai/code"
  MISSING=1
fi

if command -v uvx >/dev/null 2>&1; then
  echo "  ✓ uv (for Reddit research)"
else
  echo "  ! uv not found — Reddit research won't work"
  echo "    Install from: https://docs.astral.sh/uv/"
  echo "    (optional — everything else will still work)"
fi

if [ "$MISSING" -eq 1 ]; then
  echo ""
  echo "  Some required tools are missing. Install them and re-run setup.sh."
  exit 1
fi

echo ""

# ── Config Files ───────────────────────────────────────────────────────────────

echo "Creating config files..."
echo ""

# Playwright browser config
if [ ! -f "$PROJECT_ROOT/.playwright-mcp-config.json" ]; then
  cat > "$PROJECT_ROOT/.playwright-mcp-config.json" << 'EOF'
{
  "browser": {
    "browserName": "chromium",
    "launchOptions": {
      "channel": "chrome"
    }
  }
}
EOF
  echo "  ✓ .playwright-mcp-config.json"
else
  echo "  ~ .playwright-mcp-config.json (already exists)"
fi

# Claude Code local settings — enables all MCPs defined in .mcp.json
if [ ! -f "$PROJECT_ROOT/.claude/settings.local.json" ]; then
  mkdir -p "$PROJECT_ROOT/.claude"
  cat > "$PROJECT_ROOT/.claude/settings.local.json" << EOF
{
  "env": {
    "PROJECT_ROOT": "$PROJECT_ROOT"
  },
  "enableAllProjectMcpServers": true
}
EOF
  echo "  ✓ .claude/settings.local.json"
else
  echo "  ~ .claude/settings.local.json (already exists)"
fi

echo ""

# ── Directories ────────────────────────────────────────────────────────────────

echo "Creating required folders..."
echo ""

mkdir -p "$PROJECT_ROOT/context"
mkdir -p "$PROJECT_ROOT/proofs"
echo "  ✓ context/"
echo "  ✓ proofs/"
echo ""

# ── Context Files ──────────────────────────────────────────────────────────────

echo "Creating context files..."
echo ""

if [ ! -f "$PROJECT_ROOT/context/brand-context.md" ]; then
  cat > "$PROJECT_ROOT/context/brand-context.md" << 'EOF'
# Brand Context
<!-- Filled in by Jinu during onboarding. Do not edit manually. -->

## Brand
- **Name:**
- **Tagline:**
- **Core values:**
- **Brand stage:** <!-- A (no direction) / B (forming) / C (established) / D (scaling) -->

## Business Goals
- 6-month goal:
- 12-month goal:

## Target Audience
<!-- Leave blank — Jinu's team will find this through research -->

## Target Markets
<!-- Countries or regions to prioritize — filled by Jinu at intake or after Phase 0 -->

## Known Competitors
<!-- Leave blank — Jinu's team will find these -->

## Documentation
- **Platform:** <!-- e.g. Notion, Google Docs, None -->
- **Workspace link:** <!-- e.g. https://notion.so/your-page -->

## Run Mode
- **run_mode:** <!-- autonomous or interactive — set at pre-run intake -->

---

## Product Line
<!-- One section per product. Added by Jinu during onboarding or when a new product is introduced. -->
<!-- Never overwrite an existing product section — add new ones below. -->

### Product 1 — [Name]
- **Price:**
- **Key features:**
- **Target use case:**
- **KOL & content directions:** <!-- confirmed at pre-run intake each time this product is run -->
- **Research runs:** <!-- list of dates and scope, e.g. "2026-04-09 — full pipeline, global" -->

<!-- Add Product 2, Product 3 etc. below as needed -->

---

## Run Targets (per-run overrides)
<!-- These are reset at each pre-run intake. Defaults apply unless overridden. -->
<!-- Format: [YYYY-MM-DD] Product name — overrides -->
<!-- Example: [2026-04-09] Hako Nomad L — KOLs: min 20, Retailers: min 10 -->
EOF
  echo "  ✓ context/brand-context.md"
else
  echo "  ~ context/brand-context.md (already exists)"
fi

if [ ! -f "$PROJECT_ROOT/context/session-context.md" ]; then
  cat > "$PROJECT_ROOT/context/session-context.md" << 'EOF'
# Session Context
*Format: two-section. Section 1 fully rewritten each session. Section 2 append-only.*

---

## Section 1 — Current State
*Rewritten after every session by Notion Manager.*

- **Status:** Fresh setup — no research runs completed yet
- **Recommended next action:** Say "Jinu, let's get started" to begin onboarding

---

## Section 2 — Decision Log
*Append-only. Never overwritten.*

<!-- Format: [YYYY-MM-DD] Description -->
EOF
  echo "  ✓ context/session-context.md"
else
  echo "  ~ context/session-context.md (already exists)"
fi

if [ ! -f "$PROJECT_ROOT/context/confirmed-markets.md" ]; then
  cat > "$PROJECT_ROOT/context/confirmed-markets.md" << 'EOF'
# Confirmed Markets
<!-- Written by Jinu after Phase 0 (Market Scoping). Do not edit manually. -->
<!-- All downstream agents use this file to geo-tag findings. -->
<!-- Every finding must be tagged to a country listed here. -->

## Status
Not yet scoped — Phase 0 has not run for this brand.

## Tier 1 — Primary Markets
<!-- Highest opportunity markets. All agents prioritise these. -->

## Tier 2 — Secondary Markets
<!-- Valid but lower priority. Agents cover these after Tier 1 is complete. -->

## Excluded Markets
<!-- Markets explicitly out of scope for this brand. -->

## Scoping Notes
<!-- Why these markets were selected. Written by Jinu after Phase 0. -->
EOF
  echo "  ✓ context/confirmed-markets.md"
else
  echo "  ~ context/confirmed-markets.md (already exists)"
fi

echo ""

# ── Done ───────────────────────────────────────────────────────────────────────

echo "======================================"
echo "  Setup complete. 3 steps remaining."
echo "======================================"
echo ""
echo "─────────────────────────────────────"
echo "  STEP 1 — Enable Chrome debugging"
echo "─────────────────────────────────────"
echo ""
echo "  Jinu uses Chrome to browse websites on your behalf — competitor pages,"
echo "  Instagram, product listings, and more. This requires one toggle in Chrome."
echo ""
echo "  1. Open Chrome on your computer"
echo "  2. In the address bar, type exactly and press Enter:"
echo ""
echo "       chrome://inspect/#remote-debugging"
echo ""
echo "  3. A page will open. Find the toggle:"
echo "       'Allow remote debugging for this browser instance'"
echo "  4. Turn it ON."
echo "  5. Leave Chrome open as normal — you're done."
echo ""
echo "  Why this matters: without this, Jinu cannot browse any platform that"
echo "  requires a login (Instagram, TikTok, etc). Research quality depends on it."
echo ""
echo "  You only need to do this once. Chrome will remember it."
echo ""
echo "─────────────────────────────────────"
echo "  STEP 2 — Connect Notion and Figma"
echo "─────────────────────────────────────"
echo ""
echo "  Jinu's team writes all research findings to Notion automatically."
echo "  Nagi saves all design work to Figma."
echo ""
echo "  Both need a one-time connection approval from you."
echo "  Your Claude Code assistant will trigger this during setup —"
echo "  a browser window will open, you log in and click Allow."
echo ""
echo "  Notion account (free): https://notion.so"
echo "  Figma account (free):  https://figma.com"
echo ""
echo "  If you only need marketing research (no design work),"
echo "  Figma can be connected later when you first call Nagi."
echo ""
echo "─────────────────────────────────────"
echo "  STEP 3 — Start"
echo "─────────────────────────────────────"
echo ""
echo "  Open Claude Code in this folder:"
echo ""
echo "       cd $(basename $PROJECT_ROOT)"
echo "       claude"
echo ""
echo "  Then say:"
echo ""
echo "       Jinu, let's get started"
echo ""
echo "  Jinu will introduce himself and guide you through everything."
echo ""
echo "======================================"
echo ""
