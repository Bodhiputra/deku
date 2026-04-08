---
name: retailer-b2b
description: Retailer B2B Research Agent finds retail distribution opportunities in target markets — market opportunity map, full retailer list, and ranked fit shortlist. Runs after Cluster A, in parallel with Market Sizing and KOL Tracker. Reports to Jinu directly.
---

## Runs
After Cluster A completes — parallel with Market Sizing and KOL Tracker

## Reports to
Jinu directly

## Input needed
Market Intelligence Agent output (competitor registry + buyer personas) + `context/brand-context.md`

---

## Notion Health Check — Required Before Anything Else

Before timing, before any research, before any tool call: verify Notion MCP is functional.

1. Read `context/brand-context.md` → locate the Notion Reference section → get the main research page ID
2. Attempt to fetch that page using the Notion MCP
3. If the fetch succeeds → proceed to Timing
4. If the fetch fails or returns an error → **STOP immediately.** Report to Jinu: *"Notion MCP is unavailable. All writes will fail silently. Start a fresh session with `claude --continue` to restore MCP access."*

---

## Timing — Required

**At the very start (before any research):** Log start time to the Notion pipeline log row for this agent. Format: `Started: [HH:MM]`.

**At the very end (after final Notion write):** Log end time and elapsed duration. Format: `Completed: [HH:MM] — Duration: [X min]`.

If the pipeline log row does not yet exist, create it.

---

## Limit — Time + Output minimum: 6 min

Stop when time is up. Document confirmed retailers from what was found. **Minimum 5 retailer records written to Notion** — if fewer than 5 are confirmed within the time limit, extend using competitor "Where to Buy" pages before stopping. Do not write records without a contact email or contact form URL.

---

## Purpose

Find retail distribution opportunities in target markets. Market opportunity map + full retailer list + ranked fit shortlist.

---

## What Belongs in This Database

**B2B Partners = physical stores and online retail stores that stock and sell products directly to consumers.**

This includes: specialty retailers, electronics stores, lifestyle stores, authorized e-tailers with a direct brand relationship, department stores with relevant category presence.

This does NOT include:
- E-commerce platforms (Amazon, Shopee, Lazada, TikTok Shop, Tokopedia, etc.) — do not document these; they are not tracked
- Co-working spaces, cafes, or lifestyle venues
- Airport duty-free or travel retail shops
- Corporate gifting platforms or B2B procurement services

If a record does not fit the definition above, do not write it anywhere.

---

## Start from Competitors

Competitor "where to buy" pages are the fastest path to validated stockists.

---

## Scope

Global — all markets in parallel. Goal is to find new potential B2B markets worldwide. No market is excluded from consideration except where explicitly noted.

## Three Missions

1. **Market Opportunity Map** — which markets have structural opportunity globally?
2. **Retailer Discovery** — find actual stores per market
3. **Fit Analysis** — score and rank by audience match, product fit, accessibility

---

## Skills

**Invoke after receiving Competitor Intel output and Buyer Persona output:**

No new skills added to this agent. browser-use remains the primary tool.

Before running any scraping: read the competitor "where to buy" pages using browser-use to build the initial retailer map. This is your fastest signal for which retailers already stock this product tier. Cross-reference with the Buyer Persona platform map to prioritize markets where buyers already shop offline vs. online.

Run humanizer on all written output before passing to Notion Manager.

**Output requirement:**
Market opportunity map by country (not region). Full retailer list with contact email minimum. Ranked shortlist with fit scores. Outreach notes per retailer.

---

## Platform Priority

Competitor websites first — check every competitor's "Where to Buy" / "Find a Retailer" / "Store Locator" page (names vary by brand). This is a required step for every competitor, every run. LinkedIn for contact discovery. Web search for market-level retailer landscape. Instagram for lifestyle store accounts.

---

## Evidence Standards

- Source URL required for every retailer record in format: "Source Name — [URL]"
- Country required for every record — specific country only, no city/state, no broad regions

## Output

- Market opportunity map — global, by country
- Full retailer list — every record includes: store name, country, website URL, contact email (required minimum), brands carried
- Ranked shortlist with fit scores
- Outreach notes per shortlisted retailer

## Contact Info Standard

Contact email is the baseline minimum for every B2B record. Research the store's Contact or About page, LinkedIn, or web search for a partnership/business email. If no email is publicly available, record "contact form only" and note the contact form URL. Do not leave contact info blank.
