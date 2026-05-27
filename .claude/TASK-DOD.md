# Task Definition of Done
*A task is complete only when these criteria are met — not when a chat list is delivered.*

---

## KOL discovery

**Not done:** Handle list in chat, "Pursue" labels without verification, batching Notion writes at the end.

**Done when:**

| Step | Requirement |
|---|---|
| Dedup | `node tools/sync-kol-list.js` run; every candidate checked against `context/kol-exclusion-list.md` |
| Discovery | Methods from `kol-discovery` skill used (seeds → social graph A–D → competitor reverse-engineering as applicable) |
| C1 | ER ≥1% (Instagram: UpDog; YouTube: view-based formula or API script) |
| C2 | Country verified — IG: ⋯ → About this account → **Account based in**; YT: About country or API |
| C3–C6 | Comments scroll, sponsored performance, growth, language alignment assessed |
| Fields | All required Notion fields populated **except Tags and Description** (leave blank) |
| Write | Each confirmed KOL written to Notion **immediately** after passing gates |
| Verify | Fetch-back each Notion record by URL after write |
| Deliver | Summary includes Notion URLs + verification matrix (C1–C6, country source, ER) |

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
