# Claude Code Adapter
*Version 8.0 — 2026-05-28*

This file is the **Claude Code host adapter** for **Deku**. It is not the company definition.

## Mandatory read order

1. [`.claude/BOOTSTRAP.md`](.claude/BOOTSTRAP.md) — session checklist
2. [`core/COMPANY.md`](core/COMPANY.md) — company operating rules (persona switching, MCP, permissions)
3. [`core/ARCHITECTURE.md`](core/ARCHITECTURE.md) — architecture reference
4. `context/brand-context.md` + `context/session-context.md`

Task completion: [`.claude/TASK-DOD.md`](.claude/TASK-DOD.md)

---

## How to start

Run `claude` from the repo root. No wrapper script.

**Setup Deku:** When the user says "setup Deku" (legacy: "setup Jinu"), read [`MANUAL.md`](MANUAL.md) and run the full setup sequence (`./setup.sh`, Chrome tutorial, Notion/Figma OAuth, then hand off to the team — recommend `Jinu, let's get started` for new brands).

---

## Claude Code specifics

| Item | Location |
|---|---|
| MCP servers | `.mcp.json` |
| Local settings | `.claude/settings.local.json` (gitignored; synced from `.env` by setup.sh) |
| Skills | `.claude/skills/` |
| Hooks | `.claude/settings.json` |
| Secrets | `.env` only |

**Context CLI:** `/clear` between major unrelated tasks (user-only command — never ask mid-pipeline). `/compact` only within a single long agent run if context pressure builds.

**Notion MCP disconnect:** Tell user to start fresh with `claude --continue` or `claude --resume`.

**Persona switching:** Inline. On switch to Jinu/Nagi/Koji, load that chief's agent file + memory per [`core/COMPANY.md`](core/COMPANY.md).

**Codex parity note:** Codex uses [`AGENTS.md`](AGENTS.md) + `.codex/agents/*.toml` for the same company system.
