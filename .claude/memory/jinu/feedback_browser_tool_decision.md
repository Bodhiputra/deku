---
name: feedback_browser_tool_decision
description: Research tool decision order — dedicated MCP first, Chrome DevTools for login-gated, Playwright for public
type: feedback
---

Tool decision order for all research operations:

1. **Dedicated MCP available?** (Reddit → Reddit MCP, Notion → Notion MCP, Figma → Figma MCP) → use that MCP
2. **Login-gated platform?** → Chrome DevTools MCP (`mcp__chrome__*`)
3. **Public site, no login needed?** → Playwright MCP
4. **Playwright failed on public site?** → fallback to Chrome DevTools MCP immediately

**Why:** Web search is not a fallback for browser tools. Each tool has a specific role — using the wrong one produces lower-quality results and breaks the tool hierarchy.

**How to apply:** Before opening any browser tool during research, run through this decision tree. Never skip to web search because a browser tool failed once — diagnose first.

---

**Chrome DevTools MCP — hard rules:**
- Never use `isolatedContext` — breaks login state, triggers bot detection
- Navigation timeout ≠ failure — take a screenshot immediately after timeout, don't retry a new URL
- Always open tabs without `isolatedContext` — inherits full Chrome session
