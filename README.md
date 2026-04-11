# deku
Multi-agent autonomous marketing and design company built on Claude Code.

Jinu (CMO) runs a 9-agent marketing research pipeline. Nagi (CDO) leads a 5-agent design department. Both operate as inline personas — no subagents, no wrappers, just Claude Code with the right instructions.

---

## What's included

**Marketing department (Jinu)**
Full research pipeline: market scoping → industry intelligence → buyer intelligence → market sizing → KOL discovery → retailer B2B → content intelligence → positioning. All findings written to Notion automatically.

**Design department (Nagi)**
Brand identity, visual production, digital design, and design research. All work saved to Figma. Reads marketing findings from Notion directly.

**9 agents, 20+ custom skills, full MCP stack** (Notion, Figma, Reddit, Playwright, Chrome DevTools).

---

## Prerequisites

- [Claude Code CLI](https://claude.ai/code)
- Node.js + npx
- [uv](https://docs.astral.sh/uv/) — for Reddit MCP
- A Notion account + [integration token](https://www.notion.so/my-integrations)
- A Figma account (OAuth via MCP)
- Chrome — for browser automation

---

## Setup

```bash
git clone git@github.com:bodhiputra/deku.git
cd deku
./setup.sh
```

`setup.sh` installs all MCP servers, creates config files, and scaffolds the context files you need. It will tell you exactly what manual steps remain at the end (API key, OAuth, one brand context file to fill in).

---

## First run

After setup, open Claude Code in the project directory:

```bash
claude
```

Then say:

```
Jinu, let's get started
```

Jinu will run the pre-run intake, confirm your brand details, and begin the research pipeline.

---

## Team structure

```
USER
  ├── JINU — Chief Marketing Officer
  │     └── 9 agents: Market Intelligence, Buyer Intelligence,
  │         Market Sizing, KOL Tracker, Retailer B2B,
  │         Content Intelligence, Positioning Analyst, Notion Manager
  │
  └── NAGI — Chief Design Officer
        └── 5 agents: Brand Designer, Visual Production,
            Digital Designer, Design Research Scout
```

Full pipeline documentation is in `CLAUDE.md`.

---

## Two-terminal workflow

You can run marketing and design in separate terminals simultaneously. Jinu writes findings to Notion and `context/session-context.md`. Nagi reads from both. No manual data transfer needed.

---

## What stays private (gitignored)

- `context/brand-context.md` — your brand details
- `context/session-context.md` — rolling research state
- `context/confirmed-markets.md` — market scope per run
- `context/pipeline-state.md` — pipeline run logs
- `.claude/settings.local.json` — API keys
- `proofs/` — screenshots captured during research
