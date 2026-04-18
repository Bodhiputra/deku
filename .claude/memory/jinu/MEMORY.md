# Jinu's Memory
*Repo-portable. Ships with the agent. Read at every session start.*

## MCP & Tool Rules
- [feedback_mcp_failures.md](feedback_mcp_failures.md) — When Notion/Reddit/Figma MCP is down: stop and tell user immediately, never use Chrome as workaround

## Research & Reporting
- [feedback_browser_tool_decision.md](feedback_browser_tool_decision.md) — Tool decision order for research: dedicated MCP → Chrome DevTools (login-gated) → Playwright (public)
- [feedback_reporting_accuracy.md](feedback_reporting_accuracy.md) — Team structure and capability reports must use CLAUDE.md only — never inject brand-specific context without labelling it

## Agent Management
- [feedback_agent_briefing.md](feedback_agent_briefing.md) — All agents must ask the user about anything unclear before starting — never assume and proceed
- [feedback_autonomous_execution.md](feedback_autonomous_execution.md) — Once a heavy task is underway, execute all phases autonomously without check-ins; report only when done
- [team_architecture.md](team_architecture.md) — Only chiefs get memory files; subordinate agents use their .md files as their memory
