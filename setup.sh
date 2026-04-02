#!/bin/bash
# setup.sh — Jinu's Marketing Team
# Run once after cloning to configure your environment.

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"

echo "======================================"
echo " Jinu's Marketing Team — Setup"
echo "======================================"
echo "Project root: $PROJECT_ROOT"
echo ""

# ── Prerequisites ──────────────────────────────────────────────────────────────

echo "Checking prerequisites..."

command -v node >/dev/null 2>&1 \
  && echo "  ✓ node" \
  || { echo "  ✗ node not found — install from https://nodejs.org"; exit 1; }

command -v npx >/dev/null 2>&1 \
  && echo "  ✓ npx" \
  || { echo "  ✗ npx not found (should come with node)"; exit 1; }

command -v claude >/dev/null 2>&1 \
  && echo "  ✓ claude" \
  || { echo "  ✗ Claude Code CLI not found — install from https://claude.ai/code"; exit 1; }

command -v uvx >/dev/null 2>&1 \
  && echo "  ✓ uvx" \
  || echo "  ! uvx not found — Reddit MCP won't work. Install uv: https://docs.astral.sh/uv/"

echo ""

# ── MCP Servers ────────────────────────────────────────────────────────────────

echo "Adding MCP servers..."

# Notion — HTTP, user scope (available across all your projects)
claude mcp add --transport http notion https://mcp.notion.com/mcp -s user 2>/dev/null \
  && echo "  ✓ notion" || echo "  ~ notion (already configured)"

# Figma — HTTP, local scope
claude mcp add --transport http figma https://mcp.figma.com/mcp -s local 2>/dev/null \
  && echo "  ✓ figma" || echo "  ~ figma (already configured)"

# Playwright — stdio, local scope
claude mcp add playwright -- npx @playwright/mcp@latest \
  --config "$PROJECT_ROOT/.playwright-mcp-config.json" 2>/dev/null \
  && echo "  ✓ playwright" || echo "  ~ playwright (already configured)"

# Reddit and Chrome are defined in .mcp.json — auto-loaded by Claude Code
echo "  ~ reddit  (auto-loaded from .mcp.json)"
echo "  ~ chrome  (auto-loaded from .mcp.json)"

echo ""

# ── Config Files ───────────────────────────────────────────────────────────────

echo "Creating config files..."

# .playwright-mcp-config.json
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

# .claude/settings.local.json
if [ ! -f "$PROJECT_ROOT/.claude/settings.local.json" ]; then
  cat > "$PROJECT_ROOT/.claude/settings.local.json" << EOF
{
  "env": {
    "NOTION_API_KEY": "YOUR_NOTION_API_KEY_HERE",
    "PROJECT_ROOT": "$PROJECT_ROOT"
  },
  "enableAllProjectMcpServers": true,
  "enabledMcpjsonServers": ["reddit", "notion", "figma", "playwright", "chrome"]
}
EOF
  echo "  ✓ .claude/settings.local.json"
else
  echo "  ~ .claude/settings.local.json (already exists)"
fi

echo ""

# ── Directories ────────────────────────────────────────────────────────────────

echo "Creating required directories..."
mkdir -p "$PROJECT_ROOT/context"
mkdir -p "$PROJECT_ROOT/proofs"
echo "  ✓ context/"
echo "  ✓ proofs/"
echo ""

# ── Manual Steps ───────────────────────────────────────────────────────────────

echo "======================================"
echo " Manual steps required"
echo "======================================"
echo ""
echo "1. Add your Notion API key to .claude/settings.local.json"
echo "   Get it from: https://www.notion.so/my-integrations"
echo ""
echo "2. Authenticate MCPs — open Claude Code and follow OAuth prompts for:"
echo "   → Notion"
echo "   → Figma"
echo ""
echo "3. Brief Jinu to start:"
echo "   → 'Jinu, let's get started'"
echo "   → Jinu will onboard you and set up context/brand-context.md"
echo ""
echo "Done."
