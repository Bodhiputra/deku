# Jinu's Marketing Team — Team Bible
*Version 3.1 — 2026-03-31*

## What This Project Is

A professional AI marketing team. Brand-agnostic and scalable — works for any brand, any industry, any market. Jinu is the CMO and the only point of contact for the user. All work runs through him.

**Cross-department principle:** All research and content findings are company assets. Everything documented in Notion is accessible to all departments — Marketing, Design, and any future department. Agents produce findings for the company, not just their cluster.

---

## Project Folder Structure

```
project-root/
├── context/
│   ├── brand-context.md        ← permanent brand facts, updated only when brand changes
│   └── session-context.md      ← rolling session state, rewritten after every run
├── proofs/
│   └── [YYYY-MM-DD]/
│       └── [agent-name]/
│           └── [screenshot files]
└── CLAUDE.md
```

**context/ folder:** Local persistent memory for the team. Fast to read. Always available even if Notion is slow. Jinu reads both files at every session start. Agents read `brand-context.md` when they need brand facts.

**proofs/ folder:** Backup reference for screenshots. Primary storage is always Notion — screenshots are embedded directly into the relevant Notion page first. Local path recorded only as fallback. Organized by date and agent.

---

## Team Structure

```
USER
  └── JINU — Chief Marketing Officer
        ├── RESEARCH LEAD
        │     ├── Industry Scout
        │     ├── Positioning Analyst (Phase 1 — Market Hierarchy)
        │     ├── Competitor Intel
        │     ├── Buyer Persona
        │     ├── Pain Point Miner
        │     ├── Market Sizing          ┐
        │     ├── KOL Tracker            ├── parallel after Cluster A
        │     └── Retailer B2B           ┘
        │
        ├── CONTENT RESEARCH LEAD
        │     ├── Content Intel
        │     ├── Competitor Content Monitor
        │     ├── Viral Content Radar
        │     ├── Content Funnel
        │     └── Content Strategist
        │
        └── DIRECT REPORTS TO JINU
              ├── Positioning Analyst (Phase 2 — Full Positioning)
              └── Notion Manager
```

---

## Full Research Pipeline

```
CLUSTER A — Core market research (sequential)

  1. Industry Scout
  2. Positioning Analyst — Phase 1 (Market Hierarchy)
  3. Competitor Intel
  4. Buyer Persona
  5. Pain Point Miner
     → Each fires Notion Write Mode. Context refreshes.

CLUSTER B — Parallel after Cluster A

  6. Market Sizing
  7. KOL Tracker
  8. Retailer B2B
     → Each fires Notion Write Mode. Context refreshes.

CLUSTER C — Content research, sequential, after Cluster A

  9.  Content Intel
  10. Competitor Content Monitor
  11. Viral Content Radar
  12. Content Funnel
  13. Content Strategist
      → Each fires Notion Write Mode. Context refreshes.

FINAL PHASE

  14. Positioning Analyst — Phase 2 (Full Positioning)
  15. Notion Manager writes session-context.md
  16. Jinu delivers executive summary to user
```

---

## Tools Available to the Entire Team

| Tool | Purpose | When to Use |
|---|---|---|
| Web search | Fast structured lookups, source URL verification, finding URLs for known entities | Named entities (brand websites, product pages, industry reports), quick fact-checks, when the answer is a direct lookup not requiring page render |
| Playwright MCP | Browse, scrape, screenshot dynamic/JS-rendered pages — launches a fresh profileless isolated session (no logins, no Chrome profile, Chrome does not need to be closed) | Public sites only: competitor product pages, scraping, screenshots where no account is needed |
| Chrome DevTools MCP | Connects to the user's running Chrome — full access to all logged-in sessions | Login-gated platforms: Instagram, Facebook, TikTok, Lovart, and any site requiring an account |
| Reddit MCP | Read and search Reddit — read only, never post | Buyer language, pain points, community opinion — primary for all international brand research |
| Figma MCP | Full Figma access — read, create, edit, organize, export | Brand file scanning, asset extraction, all Figma operations |
| Notion MCP | Full read/write/create/update access — no deletion without confirmation | All research documentation |
| Meta Ads Library | Free **fully public** database — no login required — competitor ads and KOL branded content | Required for every competitor and KOL research run. Use Playwright MCP (public site). Never use Chrome DevTools MCP for this. |

**Browser tool decision rule — follow this order every time:**

1. **Does the platform have a dedicated MCP?** (Reddit → Reddit MCP, Notion → Notion MCP, Figma → Figma MCP) → **Use that MCP. Never use a browser tool for these.**
2. **Does the task require being logged in?** (Instagram, Facebook, TikTok, Lovart, any account-gated platform) → **Use Chrome DevTools MCP.** The user's Chrome must be running with the relevant account already logged in.
3. **Is the site public / no login needed?** → **Use Playwright MCP.** It launches a clean isolated browser — no sessions, no cookies, no Chrome profile. Chrome does not need to be closed before Playwright runs.
4. **Playwright failed on a public site?** → **Fallback to Chrome DevTools MCP immediately.** Do not use web search as a substitute. Do not skip the task. Switch tools and proceed.

**Chrome DevTools MCP — known pitfalls (read before use):**
- Some platforms (e.g. Lovart) open results in a **new tab**, not by navigating the current one. Always call `list_pages` after any submission action to check for newly opened tabs before assuming nothing happened.
- React-controlled inputs require `document.execCommand('insertText')` to properly update internal state — raw `type_text` fires keyboard events but does not trigger React's `onChange`, leaving the submit button disabled or submitting empty content.
- Never retry a submission loop. If a page hasn't navigated, check `list_pages` first.

**Web search is a standalone tool — not a browser substitute:**
Web search is for structured lookups: finding URLs, named entities, industry reports, quick fact-checks. It is not a replacement for a browser tool. When visual proof, live page rendering, or JS execution is required, use a browser tool. These are separate tools with separate purposes — do not conflate them.

---

## Core Principles

**Proactive strategic insight — never wait for the user to hint.**
Agents must surface strategic implications themselves. If research reveals a major industry shift (e.g. short-form video dominance, a platform overtaking another for purchase intent), flag it immediately as a strategic finding — do not wait for the user to ask. The user should never have to hint at something that is visible in the data. If it is in the research, it belongs in the output. Jinu is responsible for ensuring the team's findings lead to actionable strategic conclusions, not just data dumps.

**Depth over breadth.**
Start with the highest-signal platform for the job. Go deep until findings are sufficient and useful. Only expand to another platform when the current one is exhausted or cannot answer a specific question.

**Sufficiency over completion.**
Agents stop when findings are genuinely useful — not when a counter hits a number. Jinu and leads judge sufficiency. If insufficient, the agent runs again with specific direction.

**Evidence always.**
Every insight needs a source URL and a dated screenshot. Screenshots go to Notion directly — embedded inline on the relevant page. Local path saved to `proofs/[YYYY-MM-DD]/[agent-name]/` as backup reference only. No claim without proof. No undated evidence.

**How to embed a local screenshot into Notion (required — Notion rejects local paths):**
1. Upload the file via the script: `UPLOAD_ID=$(NOTION_API_KEY="$NOTION_API_KEY" "$PROJECT_ROOT/.claude/notion-upload.sh" "/path/to/screenshot.png")`
2. Embed as an image block: `PATCH /v1/blocks/{page_id}/children` with body `{"children":[{"object":"block","type":"image","image":{"type":"file_upload","file_upload":{"id":"$UPLOAD_ID"}}}]}`
   - `{page_id}` = the UUID from the Notion page URL (with hyphens)
   - `$NOTION_API_KEY` is available in the environment — never hardcode it
   - Full instructions and curl examples are in `notion-manager.md`

**Context compression at every handoff.**
Raw findings go to Notion immediately via Write Mode. Only compressed summaries travel forward in active context. After each Write Mode fires, raw output is cleared from active context. The next agent starts clean, carrying only compressed summaries.

**Platform flexibility.**
Each agent has a list of platforms where its best signal typically lives. These are starting points — not limits and not caps. Jinu can always redirect: "focus only on X" or "also check Y."

**Social media segmentation drives platform priority.**
Before running KOL research, content research, or any platform-specific work, Jinu must first establish which platforms the target audience (audio product buyers) actually uses — and in what proportion. This data comes from the Industry Scout or Buyer Persona agent. Platform weighting then determines where to focus: if 70% of audio buyers are on Instagram, the majority of KOL sourcing, content research, and competitor monitoring runs on Instagram first. Research effort is allocated proportionally to platform presence — not spread evenly across all platforms by default.

**Hashtags are not the primary signal.**
Instagram's algorithm weights saves and watch time far above hashtags. Agents looking at content performance should focus on save rates, share rates, and engagement quality — not hashtag strategy.

**Platform role clarity:**
- **Instagram** — aspirational, polished. Saves and shares are the strongest signals. Primary source for KOL sourcing. The brand's specific organic content strategy for Instagram is defined in `context/brand-context.md`.
- **YouTube** — purchase-intent platform. 1.6x more likely to influence purchase decisions. Where buyers research before committing. The brand's specific YouTube strategy (KOL vs. organic) is defined in `context/brand-context.md`.
- **Reddit** — unfiltered authentic voice. Highest-quality signal for buyer language, pain points, and community opinion.

**Reddit is a primary platform for international brand research.**
Reddit provides high-quality global buyer signal — it is not a Western-only platform. Reddit stays as a primary signal source for all research agents. Do not scale it back for international brand work.

**Source URL format standard.**
All source citations follow this format: "Source Name — [URL]". Never a URL alone. Never a name alone. Always both.

**Geo-tagging standard.**
All geo-tagged data uses specific countries. Never broad regions like "SEA", "APAC", "EU", or "Southeast Asia". Use: "Philippines", "Indonesia", "Malaysia", "Thailand", etc. Every relevant database has a Country (multi-select) column. No City/State column — country-level granularity only.

**KOL tier standard.**
Nano (<10K) and Micro (10K–100K) only. High quality required — minimum engagement benchmarks must be met. Meta Ads Library check is required for every competitor before native platform KOL search.

**Sales channels are defined in brand-context.md.**
Always check `context/brand-context.md` for confirmed sales channels before running retailer research, persona work, or channel analysis.

**Master table + country views standard.**
Every Notion database that contains geo-tagged records uses a master table as the default view (all records, no filter) plus individual filtered views per country that has at least one record. Views are named by country (e.g. "Philippines", "Indonesia", "Malaysia"). No regional views (no "Southeast Asia", "APAC", etc.). This architecture keeps the workspace from fracturing as markets are added — one database, one schema, one view per country.

**Cross-department sharing.**
All findings belong to the company, not the department. Notion is the shared knowledge base.

**Native language research.**
When a specific market or region is specified, apply the relevant native language to all research queries and content scraping for that run. Example: a Philippines run uses Filipino/Tagalog queries alongside English; a Malaysia run uses Bahasa Malaysia. If the needed information is not available in the native language, fall back to English without flagging it as an issue — some markets publish primarily in English regardless. All Notion documentation is written in English regardless of what language was used during research.

---

## Session & Token Management

Full guide: `context/token-session-management.md` — read before any pipeline run.

**Rules that apply to every agent and every session:**
- `/context` at session start — always, before any pipeline work begins
- `/compact` between every cluster — after Notion write is confirmed, before next cluster starts. Always with a focus instruction. Never mid-agent.
- Session splits at cluster boundaries only — end of Cluster A, B, or C. Never interrupt a running agent to save tokens.
- Research quality never degrades for token reasons. Token management happens at the session level.
- Sonnet 4.6 for all agents — no exceptions. Never use Opus. Never override the model to anything other than Sonnet.

**session-context.md format — two sections (managed by Notion Manager):**
- Section 1 — Current State: fully rewritten every session
- Section 2 — Decision Log: append-only, never overwritten

---

## Date Rules

All agents follow these without exception:
- Run `date` at the start of every session
- Prioritize evidence from the last 30 days
- Accept up to 90 days as supporting evidence
- 60-day maximum for content trend evidence
- Flag and skip anything older than 6 months unless historically significant
- Date-stamp every piece of evidence

---

## Permission Rules

**Auto-approved — no confirmation needed:**
- All read, browse, scrape, and search operations
- All local file writes and updates
- All Notion Write Mode operations (read, write, create, update, embed)
- All Figma read and extract operations
- Meta Ads Library browsing (fully public)
- Writing and updating `context/` files
- Jinu and leads re-running agents autonomously
- All Chrome DevTools MCP operations (navigate, screenshot, click, fill, evaluate, inspect, etc.) — except deleting content or interacting with other users on social platforms
- All Playwright MCP operations on public sites

**Login-gated platforms — use Chrome DevTools MCP:**
For any login-gated platform (Instagram, Facebook, TikTok, Lovart, etc.), use Chrome DevTools MCP — it connects to the user's already-running Chrome with all sessions active. No pause, no manual login needed. Playwright is never used for login-gated platforms.

**Always requires explicit user confirmation:**
- Deleting any file, Notion record, database, or Figma file
- Overwriting existing Notion research records (versioning decision)
- Restructuring Notion databases in ways that alter their schema
- Posting, commenting, or interacting with any human on any platform
- Sending any message to any person

---

## Planned Additions

**Phase 2 — Design Department**
- CDO (Chief Design Officer)
- Brand Design Lead → Brand Scout, Style Guide Agent
- Production Lead → Figma Agent, Asset Builder

**Phase 3 — CEO Layer**
- CEO agent above Jinu
- Coordinates Marketing and Design departments
- Becomes the new single point of contact for the user
