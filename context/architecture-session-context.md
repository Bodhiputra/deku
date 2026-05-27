# Architecture Session Context
*Purpose: host-assistant checkpoint for system architecture work. Not for Jinu/Nagi/Koji task state.*
*Last updated: 2026-05-28 — architecture track complete*

## Status: COMPLETE

Platform-neutral architecture track for Claude Code, Codex, and Cursor is **done**. Remaining items are explicitly deferred (physical `.claude/` rename) or out of scope (`shopify/` theme repo).

## Current Objective (achieved)

Design a platform-neutral core for the agentic AI company system so Jinu, Nagi, Koji, and future agents can operate across Claude Code, Codex, and Cursor without core logic being tied to one platform.

## Decisions Confirmed

- `Jarvis` is only the user's name for the host assistant on each platform. Jarvis is **not** a canonical company agent.
- Canonical company agents: `Jinu` (marketing), `Nagi` (design), `Koji` (operations)
- Agents are independent and capable of parallel operation; hosts may simulate via persona switching or native agent configs
- **Supported hosts:** Claude Code, Codex, Cursor only
- `shopify/` theme repo is external, gitignored — not company architecture; Koji's `shopify-sync` = Shopify Admin platform API
- `context/session-context.md` = agent operational state; this file = architecture checkpoint only
- `core/ARCHITECTURE.md` = canonical architecture source of truth
- `.claude/` = current shared workflow library (historical path; semantic name documented in `core/WORKFLOW-LIBRARY.md`)
- Secrets: `.env` only; committed adapter config is portable

## Progress Completed

1. **Canonical core** — `core/ARCHITECTURE.md`, `core/COMPANY.md`, `core/HOST-ADAPTER-SPEC.md`, `core/WORKFLOW-LIBRARY.md`, `core/adapters/*.yaml`
2. **Entity model** — agents, skills, memory, workflows, contexts, workspaces, platform adapters
3. **Collaboration model** — direct, discussion, handoff, parallel, review
4. **Migration map** — canonical vs shared runtime vs adapters vs workspace vs legacy
5. **Host adapter spec v1.0** — bootstrap contract, chief exposure, MCP parity, conformance checklist
6. **Adapter manifests** — Claude Code, Codex, Cursor; all `conformance.checklist_pass: full`
7. **Config cleanup** — secrets out of committed config; relative MCP paths; legacy hooks removed; `.env.example` + setup.sh sync
8. **Doc dedup** — `core/COMPANY.md` canonical; `CLAUDE.md` / `AGENTS.md` thin adapters
9. **Skill path strategy** — alias model (`.agents/skills/` → `.claude/skills/`); setup.sh validates symlink
10. **Codex chief dedup** — `.codex/agents/*.toml` are thin pointers to `.claude/agents/*.md`
11. **Bootstrap parity** — Koji section added to `.claude/BOOTSTRAP.md`; Cursor rules updated for all three chiefs

## Deferred (by design — not blockers)

| Item | Reason |
|---|---|
| Rename `.claude/` → neutral path (e.g. `runtime/`) | High breakage risk; alias model sufficient; documented in `core/WORKFLOW-LIBRARY.md` |
| Delete `.agents/skills.bak.*` | Archive from symlink fix; user handles cleanup if desired |
| Native parallel chiefs on Cursor | Host limitation; inline persona switching is conformant |

## Architecture Invariants (30-year model)

1. **Canonical core** — chiefs, workflows, memory, contexts, quality gates, onboarding
2. **Shared runtime** — skills, departments, DOD, bootstrap (currently under `.claude/`)
3. **Thin host adapters** — config format, MCP wiring, persona/agent invocation only

No host adapter may become the company.

## Read Order (any host session)

1. `.claude/BOOTSTRAP.md`
2. `core/COMPANY.md`
3. `core/ARCHITECTURE.md`
4. `context/brand-context.md` + `context/session-context.md`
5. Host adapter: `CLAUDE.md` / `AGENTS.md` / `.cursor/rules/`

## Constraints (honored)

- No destructive cleanup of active skill/agent files
- No overloading agent operational checkpoint files
- External `shopify/` repo not folded into core bootstrap
