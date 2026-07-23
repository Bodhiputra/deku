#!/bin/bash
# setup.sh — Deku setup
# Run once after cloning. Your host assistant can run this for you.

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "======================================"
echo "  Deku Setup"
echo "======================================"
echo ""

# ── Prerequisites ──────────────────────────────────────────────────────────────

echo "Checking prerequisites..."
echo ""

MISSING=0
HOST_FOUND=0

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
  HOST_FOUND=1
fi

if command -v codex >/dev/null 2>&1; then
  echo "  ✓ Codex"
  HOST_FOUND=1
fi

if [ "$HOST_FOUND" -eq 0 ]; then
  echo "  ! No supported CLI host assistant detected"
  echo "    First-class supported hosts in this repo: Claude Code, Codex, Cursor"
  echo "    Cursor can still be used even though it is not detected via CLI here."
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

# Claude local settings — enables all MCPs defined in .mcp.json
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

# ── Local secrets (.env) ───────────────────────────────────────────────────────

echo ""
echo "Setting up local secrets (gitignored)..."
echo ""

read_env_value() {
  local file="$1" key="$2"
  [ -f "$file" ] || return 0
  grep -E "^${key}=" "$file" 2>/dev/null | head -1 | cut -d= -f2- | sed 's/^["'\'' ]*//;s/["'\'' ]*$//'
}

NOTION_KEY="$(read_env_value "$PROJECT_ROOT/.env" NOTION_API_KEY)"
if [ -z "$NOTION_KEY" ] && command -v jq >/dev/null 2>&1 && [ -f "$PROJECT_ROOT/.claude/settings.local.json" ]; then
  NOTION_KEY="$(jq -r '.env.NOTION_API_KEY // empty' "$PROJECT_ROOT/.claude/settings.local.json" 2>/dev/null)"
fi

if [ ! -f "$PROJECT_ROOT/.env" ]; then
  cat > "$PROJECT_ROOT/.env" << EOF
# Local secrets — never commit
PROJECT_ROOT=$PROJECT_ROOT
NOTION_API_KEY=$NOTION_KEY
EOF
  echo "  ✓ .env (from .env.example template)"
else
  echo "  ~ .env (already exists)"
fi

# Claude: sync PROJECT_ROOT from .env; optional NOTION passthrough for host subprocesses
if command -v jq >/dev/null 2>&1; then
  ENV_NOTION="$(read_env_value "$PROJECT_ROOT/.env" NOTION_API_KEY)"
  mkdir -p "$PROJECT_ROOT/.claude"
  if [ ! -f "$PROJECT_ROOT/.claude/settings.local.json" ]; then
    echo '{"env":{"PROJECT_ROOT":"'"$PROJECT_ROOT"'"},"enableAllProjectMcpServers":true}' > "$PROJECT_ROOT/.claude/settings.local.json"
  fi
  tmp="$(mktemp)"
  jq --arg root "$PROJECT_ROOT" --arg notion "$ENV_NOTION" \
    '.env.PROJECT_ROOT = $root | (if ($notion | length) > 0 then .env.NOTION_API_KEY = $notion else . end)' \
    "$PROJECT_ROOT/.claude/settings.local.json" > "$tmp" && mv "$tmp" "$PROJECT_ROOT/.claude/settings.local.json"
  echo "  ✓ .claude/settings.local.json (synced from .env)"
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
- **KOL Pools database ID:** <!-- Notion database UUID — required for KOL dedup sync if using Notion -->

## Product Line
<!-- One section per product. Added by Jinu during onboarding or when a new product is introduced. -->
<!-- Never overwrite an existing product section — add new ones below. -->

### Product 1 — [Name]
- **Price:**
- **Key features:**
- **Target use case:**
- **Research runs:** <!-- list of dates and scope, e.g. "2026-05-08 — KOL discovery, US/Canada" -->

<!-- Add Product 2, Product 3 etc. below as needed -->

## Instagram KOL Session (optional)

Fill in when the brand runs Instagram KOL discovery. Jinu confirms at session start.

- **Dedicated IG account:** <!-- @handle or "use brand owner's personal IG" -->
- **Chrome profile:** <!-- profile name in Chrome — must be active window for IG browse -->
- **Session rule:** Confirm logged-in username before any IG profile navigation
EOF
  echo "  ✓ context/brand-context.md"
else
  echo "  ~ context/brand-context.md (already exists)"
fi

if [ ! -f "$PROJECT_ROOT/context/session-context.md" ]; then
  cat > "$PROJECT_ROOT/context/session-context.md" << 'EOF'
# Session Context — Deku Canonical Agents
*For Jinu, Nagi, Koji, and future Deku agents only — not the host assistant.*
*Format: one section per agent. Each agent overwrites their own section at end of session.*

---

## Jinu — Last Session Checkpoint
*Overwrite this section at end of each Jinu session.*

- **Status:** Fresh setup — no research runs completed yet
- **Recommended next action:** Say "Jinu, let's get started" to begin onboarding

---

## Nagi — Last Session Checkpoint
*Overwrite this section at end of each Nagi session.*

- **Status:** No design work completed yet

---

## Koji — Last Session Checkpoint
*Overwrite this section at end of each Koji session.*

- **Status:** No ops work completed yet

---
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

if [ ! -f "$PROJECT_ROOT/context/ops-context.md" ]; then
  cat > "$PROJECT_ROOT/context/ops-context.md" << 'EOF'
# Operations Context
<!-- Brand-specific ops configuration. Koji reads this at session start. Gitignored — not committed. -->

## Brand

- **Slug:**
- **System of record:** <!-- json | spreadsheet | shopify-only | notion | other | TBD -->
- **Data path:** <!-- file path, sheet URL, store URL, or TBD -->
- **Review surface:** <!-- none (chat only) | existing tool URL | local dashboard path — optional -->

---

## Warehouses

<!-- ID | Name | Type | Update mode (manual | sync) -->

---

## Integrations

<!-- e.g. Shopify store URL — only what this brand actually uses -->

---

## Notes

<!-- Koji documents operational model here during ops onboarding -->
EOF
  echo "  ✓ context/ops-context.md"
else
  echo "  ~ context/ops-context.md (already exists)"
fi

if [ ! -f "$PROJECT_ROOT/context/kol-exclusion-list.md" ]; then
  cat > "$PROJECT_ROOT/context/kol-exclusion-list.md" << 'EOF'
# KOL Exclusion List
<!-- Populated by `node tools/sync-kol-list.js` before KOL discovery (requires Notion KOL DB ID). -->
<!-- Jinu hard-excludes every @handle listed here during KOL sessions. -->

## All Handles

<!-- one @handle per line after sync -->
EOF
  echo "  ✓ context/kol-exclusion-list.md"
else
  echo "  ~ context/kol-exclusion-list.md (already exists)"
fi

echo ""

# ── Cross-platform skill symlink (Codex) ─────────────────────────────────────

echo "Linking and verifying Codex skills alias..."
echo ""

AGENTS_SKILLS="$PROJECT_ROOT/.agents/skills"
CLAUDE_SKILLS="$PROJECT_ROOT/.claude/skills"
SAMPLE_SKILL="kol-discovery/SKILL.md"

mkdir -p "$PROJECT_ROOT/.agents"

if [ ! -d "$CLAUDE_SKILLS" ]; then
  echo "  ✗ .claude/skills not found — shared workflow library missing"
  exit 1
fi

if [ -L "$AGENTS_SKILLS" ]; then
  LINK_TARGET="$(readlink "$AGENTS_SKILLS")"
  if [ "$LINK_TARGET" != "../.claude/skills" ]; then
    rm "$AGENTS_SKILLS"
    ln -s "../.claude/skills" "$AGENTS_SKILLS"
    echo "  ✓ .agents/skills (symlink corrected → .claude/skills)"
  else
    echo "  ~ .agents/skills (symlink OK)"
  fi
elif [ -e "$AGENTS_SKILLS" ]; then
  if [ -d "$AGENTS_SKILLS" ] && [ "$(ls -A "$AGENTS_SKILLS" 2>/dev/null | wc -l)" -gt 0 ]; then
    BACKUP="$PROJECT_ROOT/.agents/skills.bak.$(date +%Y%m%d%H%M%S)"
    mv "$AGENTS_SKILLS" "$BACKUP"
    echo "  ! Moved duplicate .agents/skills → $(basename "$BACKUP")"
  else
    rm -rf "$AGENTS_SKILLS"
  fi
  ln -s "../.claude/skills" "$AGENTS_SKILLS"
  echo "  ✓ .agents/skills → .claude/skills"
else
  ln -s "../.claude/skills" "$AGENTS_SKILLS"
  echo "  ✓ .agents/skills → .claude/skills"
fi

if [ ! -f "$AGENTS_SKILLS/$SAMPLE_SKILL" ] || [ ! -f "$CLAUDE_SKILLS/$SAMPLE_SKILL" ]; then
  echo "  ✗ Skills verify failed — $SAMPLE_SKILL not reachable via alias and canonical path"
  exit 1
fi

# Detect circular symlinks: .claude/skills/* must not point back into .agents/
BAD_LINKS=0
while IFS= read -r -d '' link; do
  target="$(readlink "$link")"
  case "$target" in
    *".agents/skills"*|*".agents/"*)
      echo "  ✗ Circular skill symlink: $link → $target"
      BAD_LINKS=1
      ;;
  esac
done < <(find "$CLAUDE_SKILLS" -mindepth 1 -maxdepth 1 -type l -print0 2>/dev/null)

if [ "$BAD_LINKS" -eq 1 ]; then
  echo "  ✗ Fix: restore real skill dirs under .claude/skills/ (see core/WORKFLOW-LIBRARY.md)"
  exit 1
fi

echo "  ✓ skills library verified ($SAMPLE_SKILL reachable)"

echo ""

# ── Done ───────────────────────────────────────────────────────────────────────

echo "======================================"
echo "  Setup complete."
echo "======================================"
echo ""
echo "  Supported first-class hosts:"
echo "    Claude Code:  claude"
echo "    Codex:        codex"
echo "    Cursor:       open this folder in Cursor (rules in .cursor/rules/)"
echo ""
echo "  Codex uses AGENTS.md + .agents/skills/ (symlinked)"
echo ""
echo "  Local secrets (gitignored): .env — copy from .env.example if missing"
echo "  Claude also reads .claude/settings.local.json (synced from .env by setup.sh)"
echo ""
echo "  First time — say:  setup Deku"
echo ""
echo "  Every session — the company bootstrap is:  .claude/BOOTSTRAP.md"
echo ""
echo "======================================"
echo ""
