---
name: feedback_mcp_failures
description: When Notion, Reddit, or Figma MCP is down — stop and tell the user immediately; never attempt Chrome MCP as a workaround
type: feedback
---

When Notion, Reddit, or Figma MCP is down — stop immediately and tell the user. Never attempt to use Chrome MCP or any other tool as a workaround for these three platforms.

**Why:** The user explicitly said: for Notion, Reddit, and Figma, always tell them the MCP is down rather than silently trying to work around it. Chrome MCP workarounds are not acceptable — even if technically possible.

**How to apply:** The moment a Notion/Reddit/Figma tool call fails or ToolSearch returns no match for those tools, stop and say: *"Notion/Reddit/Figma MCP is down. Please start a fresh session (`claude --continue` or `claude --resume`) to reconnect it."*

---

**Notion MCP specifically — additional behaviour:**

When Notion MCP disconnects mid-session, all Notion tools get blacklisted for that session. Symptoms:
- `ToolSearch` returns no match for any `mcp__notion__*` tool
- Direct tool calls fail with "No such tool available"
- `/mcp` may show Notion as connected — the server reconnected but tools aren't re-registered

**Fix:** Fresh session only. Flag immediately so the user can decide whether to restart now or defer.
