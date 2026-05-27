# Session Bootstrap
*Read this at the start of every session — Claude Code, Cursor, and Codex.*

**Project:** Deku (AI agentic company). Local clone folder name may differ (e.g. `finecoustic/`).

**Canonical architecture:** `core/ARCHITECTURE.md`  
**Company operating rules:** `core/COMPANY.md`  
**Current shared workflow library:** `.claude/` (agents, memory, departments, skills)  
**Codex skills path:** `.agents/skills/` → symlink to `.claude/skills/`  
**Context (brand state):** `context/`  
**Secrets:** `.env` (see `.env.example`)

Treat `.claude/` as the current shared runtime library, not as proof that the company system is Claude-specific.

## Host parity contract

Regardless of host platform, the company system must resolve to the same:

1. Canonical chiefs: Jinu, Nagi, Koji
2. Shared workflow library: agents, departments, skills, memory, DOD
3. Context model: `context/brand-context.md`, `context/session-context.md`, `context/confirmed-markets.md`
4. Setup flow: clone repo → run `setup.sh` → open host assistant → say `setup Jinu`

Host adapters may differ in wiring, but not in company behavior.

---

## 1. Every session (all tasks)

1. Run `date`
2. Read `core/COMPANY.md` — company operating rules (persona switching, MCP policy, permissions)
3. Read `context/brand-context.md` and `context/session-context.md`
4. Read `.claude/memory/jinu/MEMORY.md` (marketing) or `.claude/memory/nagi/MEMORY.md` (design) or `.claude/memory/koji/MEMORY.md` (ops) — **load every linked `feedback_*.md` file**
5. Chrome test (if browser research needed): list open pages / confirm Chrome DevTools MCP connected
6. Announce which skill(s) you are loading before executing

---

## 2. Marketing / Jinu tasks

1. Complete **§1** above
2. Read `.claude/agents/jinu.md` and `.claude/departments/marketing.md`
3. Match task → read `.claude/skills/<skill-name>/SKILL.md` (do not improvise)
4. Notion writes → load `.claude/skills/update-notion/SKILL.md` first
5. Check definition of done → `.claude/TASK-DOD.md`

---

## 3. Design / Nagi tasks

1. Complete **§1** above
2. Read `.claude/agents/nagi.md` and `.claude/departments/design.md`
3. Confirm `[Design Direction]` exists in `context/brand-context.md`
4. Load design skills per department manual; run `brand-compliance-review` before delivery
5. Never write to Notion — Figma only

---

## 4. Operations / Koji tasks

1. Complete **§1** above (use `.claude/memory/koji/MEMORY.md`)
2. Read `.claude/agents/koji.md` and `.claude/departments/operations.md`
3. Read `context/ops-context.md` and active brand data in `ops-hub/brands/<brand>/ops-data.json`
4. Match task → read `.claude/skills/<skill-name>/SKILL.md` (e.g. `inventory-management`, `shopify-sync`, `ops-data-standards`)
5. Never write to Marketing Notion or Figma; never run Shopify Admin mutations without explicit user approval

---

## 5. KOL discovery (extra gates)

Before any discovery:

1. Run `node tools/sync-kol-list.js`
2. Read `context/kol-exclusion-list.md` into an in-memory exclusion list
3. Load `.claude/skills/kol-discovery/SKILL.md` + `update-notion`
4. Read all KOL feedback files linked from `.claude/memory/jinu/MEMORY.md`:
   - `feedback_instagram_country_verification.md`
   - `feedback_kol_dedup_check.md`
   - `feedback_kol_notion_write_cadence.md`
   - `feedback_kol_description_column.md`
   - `feedback_jinu_kol_role.md`

Task is **not done** until `.claude/TASK-DOD.md` → KOL section passes.

---

## 6. MCP name mapping (Cursor / Codex)

Skills may say `mcp__chrome__*`, `mcp__notion__*`, etc. Use this project's enabled MCP servers:

| Claude Code name | Use |
|---|---|
| `mcp__chrome__*` | Chrome DevTools MCP |
| `mcp__notion__*` | Notion MCP |
| Playwright MCP | Public sites, no login |
| Reddit MCP | Reddit read-only |

**Notion MCP disconnect:** On first `fetch failed` or tool-unavailable error → stop all Notion calls and tell the user to start a fresh session.

**Browser rule:** Login-gated sites → Chrome (never `isolatedContext`). Public sites → Playwright; fallback to Chrome if Playwright fails.

---

## 7. Host adapters

Platform wiring only — not company rules:

| Host | Adapter doc |
|---|---|
| Claude Code | `CLAUDE.md` |
| Codex | `AGENTS.md` |
| Cursor | `.cursor/rules/` |

Company rules live in `core/COMPANY.md`. Architecture in `core/ARCHITECTURE.md`.
