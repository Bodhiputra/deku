# Codex Adapter
*Version 8.0 — 2026-05-28*

This file is the **Codex host adapter** for **Deku**. It is not the company definition.

## Mandatory read order

1. [`.claude/BOOTSTRAP.md`](.claude/BOOTSTRAP.md) — session checklist
2. [`core/COMPANY.md`](core/COMPANY.md) — company operating rules (persona switching, MCP, permissions)
3. [`core/ARCHITECTURE.md`](core/ARCHITECTURE.md) — architecture reference
4. `context/brand-context.md` + `context/session-context.md`

Task completion: [`.claude/TASK-DOD.md`](.claude/TASK-DOD.md)

---

## How to start

Run `codex` from the repo root. No wrapper script.

**Setup Deku:** When the user says "setup Deku" (legacy: "setup Jinu"), read [`MANUAL.md`](MANUAL.md) and run the full setup sequence (`./setup.sh`, Chrome tutorial, Notion/Figma OAuth, then hand off to the team — recommend `Jinu, let's get started` for new brands).

---

## Codex specifics

| Item | Location |
|---|---|
| MCP servers | `.codex/config.toml` |
| Native chief configs | `.codex/agents/*.toml` — thin pointers; canonical defs in `.claude/agents/` |
| Skills (symlink) | `.agents/skills/` → `.claude/skills/` |
| Hooks | `.codex/hooks.json` |
| Secrets | `.env` only |

**Context CLI:** `/clear` between major unrelated tasks (user-only command — never ask mid-pipeline).

**Notion MCP disconnect:** Tell user to start a fresh Codex session.

**Chief exposure:** Mixed — native agent configs exist; inline persona switching also supported. Both must load canonical files from `.claude/agents/` + memory per [`core/COMPANY.md`](core/COMPANY.md).

**Claude parity note:** Claude Code uses [`CLAUDE.md`](CLAUDE.md) + `.mcp.json` for the same company system.
