# Task Definition of Done
*A task is complete only when these criteria are met — not when a chat list is delivered.*

---

## KOL discovery

**Not done:** Handle list in chat, "Pursue" labels without verification, batching Notion writes at the end, hardcoded seed lists, browsing before brief confirmed.

**Done when:**

| Step | Requirement |
|---|---|
| Brief | Brand owner brief confirmed per `context/kol-brief-templates.md` (Jinu walks new owners through template) |
| Dedup | `node tools/sync-kol-list.js` run; every candidate checked against `context/kol-exclusion-list.md` |
| Chrome | Connected before any Instagram discovery or IG verification — **if down, stop IG work** (YouTube-only may continue if brief allows) |
| Discovery | Methods from `kol-discovery` skill used (dynamic seeds → social graph A–D → competitor reverse-engineering as applicable) |
| C1 | ER ≥1% (Instagram: UpDog; YouTube: view-based formula or API script) |
| C2 | Country verified — IG: ⋯ → About this account → **Account based in**; YT: About country or API; per brand-context geo rules |
| C5 | Activity — **latest post within 14 days (2 weeks)**; verify newest post date on grid; UpDog 0 posts in last year = fail |
| C6 | Niche — last 15 posts, ≥8/15 on-brief per `brand-context.md` → KOL Discovery Gates |
| Fields | All required Notion fields populated **except Tags and Description** (leave blank) |
| Write | Each confirmed KOL written to Notion **immediately** after passing gates |
| Verify | Fetch-back each Notion record by URL after write |
| Deliver | Summary includes Notion URLs + verification matrix (C1, C2, C5, C6, country source, ER) |
| Session | Jinu Active Thread in `context/session-context.md` overwritten (≤15 lines); pass logs appended to `context/session-context-log.md` only |

---

## Market / buyer / content research

**Done when:**

- Findings written to Notion per `update-notion` skill taxonomy
- Every finding geo-tagged to a country in `context/confirmed-markets.md`
- Source URL on every claim
- Narrative page updated if the skill requires it
- `context/session-context.md` Section 1 updated at session end

---

## Design (Nagi)

**Done when:**

- Brief alignment, brand alignment, and production quality pass `brand-compliance-review`
- Output in Figma (or HTML/CSS pushed via generate workflow when specified)
- Figma file link provided
- No Notion writes

---

## Full research run

**Done when:** All missions in `run-research` skill complete, Notion verified, `session-context.md` updated, confirmed markets written if Phase 0 ran.
