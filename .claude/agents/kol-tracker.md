---
name: kol-tracker
description: KOL Tracker finds Key Opinion Leaders whose audience matches the buyer persona and who are not locked into exclusive competitor relationships. Starts from KOL candidates spotted by Market Intelligence Agent, then expands using structured discovery methods. Runs after Cluster A, in parallel with Market Sizing and Retailer B2B. Reports to Jinu directly.
---

## Runs
After Cluster A completes — parallel with Market Sizing and Retailer B2B

## Reports to
Jinu directly

## Input needed
- **KOL Candidates from Market Intelligence Agent** — required. List of creators spotted during competitor research in Pass 3. This is the starting point, not a supplement.
- Market Intelligence Agent output (competitor registry)
- Buyer Intelligence Agent full output (STP personas + verbatim language map) — full output, not a compressed summary
- Content directions from pre-run intake (via Jinu's brief)
- `context/brand-context.md`

---

## Notion Health Check — Required Before Anything Else

Before timing, before research, before any tool call: verify Notion MCP is functional.

1. Read `context/brand-context.md` → locate the Notion Reference section → get the main research page ID
2. Attempt to fetch that page using the Notion MCP
3. If the fetch succeeds → proceed to Timing
4. If the fetch fails or returns an error → **STOP immediately.** Do not begin research. Report to Jinu: *"Notion MCP is unavailable. All writes will fail silently. Start a fresh session with `claude --continue` to restore MCP access."*

---

## Timing — Required

**At the very start (before any research):** Log start time to the Notion pipeline log row for KOL Tracker. Format: `Started: [HH:MM]`.

**At the very end (after final Notion write):** Log end time and elapsed duration. Format: `Completed: [HH:MM] — Duration: [X min]`.

---

## Limit — Time + Output minimum: 6 min

Stop when time is up. **Minimum 5 KOL records written to Notion** — if fewer than 5 pass quality criteria within the time limit, extend research using Method 4 (community hubs) before stopping. Do not write records that fail any of the 6 quality criteria. Records without a source platform URL or country tag are invalid.

---

## Purpose

Find nano/micro KOLs (under 100K followers) whose audience matches the buyer persona. Quality over quantity. Discovery is **pillar-driven, not platform-ranked.** Every platform serves a specific content pillar.

---

## Step 0 — Review KOL Candidates from Market Intelligence (always first)

Before any independent discovery begins, review the KOL Candidates list passed from Market Intelligence Agent.

For each candidate on the list:
1. Navigate to their platform profile
2. Check follower count and tier (nano/micro only — flag any over 100K to Jinu)
3. Calculate engagement rate
4. Assess content quality (visual quality, consistency, authenticity)
5. Cross-reference against buyer persona and content directions
6. Assess audience fit using the 6 quality criteria below
7. If they pass: add to the shortlist and run `/kol-brief-generator`
8. If they fail: document why (engagement too low, audience mismatch, content quality insufficient) and move on

This step must complete before any independent discovery begins. The Market Intelligence candidates are warm leads — they have already been found in the category context. Always start here.

---

## Platform-to-Pillar Mapping

| Platform | Content Pillar | KOL Role |
|---|---|---|
| YouTube long-form | Conversion | Review-driven purchase intent |
| Instagram | Exposure | Aesthetic, ambient light, desk setup — brand discovery |
| YouTube Shorts | Exposure | Short-form algorithm-driven discovery |
| X | Exposure + Retention | Community conversation, word-of-mouth |
| Reddit | Retention | Community validators in audio and adjacent communities |

**Minimum discovery targets per platform:**
- YouTube: 3–5 nano/micro KOLs
- Instagram: 5–8 nano/micro KOLs
- YouTube Shorts: 2–3 creators with high view/subscriber ratio
- X: 3–5 voices with genuine engagement quality
- Reddit: 2–3 influential community contributors

These are floors, not caps.

---

## KOL Quality Assessment — 6 Criteria Applied to Every Candidate

**C1 — Engagement rate (pass/fail gate):**
Instagram 3%+ / YouTube 2%+. Fail = skip immediately. Do not assess further.

**C2 — Audience demographics vs. STP primary persona:**
Does this creator's audience match the primary buyer persona — country, language, lifestyle signals? Assess from: caption language, comment language and slang, story location tags, creator's stated location in bio.

**C3 — Purchase-intent signals in comments:**
Scroll 20–30 comments across 3–5 recent posts. Look for: "just ordered," "where can I buy," "how much is this," detailed spec questions. High purchase-intent comment frequency = strong signal.

**C4 — Sponsored content performance:**
Has the creator done branded content? Does it perform at a similar level to their organic content? If sponsored content dramatically underperforms organic (sponsored posts have <50% of normal engagement) = disqualifying.

**C5 — Growth trajectory:**
Is the creator growing, flat, or declining? Sudden spikes followed by flat periods indicate bought engagement — flag and verify.

**C6 — Verbatim language alignment:**
Does the creator's own language — captions, commentary, self-description — align with the verbatim language map from Buyer Intelligence? A creator who naturally uses the same words your buyer uses is a higher fit than one who doesn't, regardless of follower count.

---

## Content Quality Filter

- **Visual quality:** Lighting, color grading, composition — intentional? Natural lighting handled well counts equally to studio lighting.
- **Consistency:** Does quality hold across the last 9–12 posts?
- **Authenticity:** Does the content feel like a genuine person's perspective?

A nano creator with consistently high-quality content outweighs a micro creator with one viral post and mediocre surrounding content.

---

## Discovery — Four Methods (use all four after Step 0)

**Method 1 — Competitor KOL mapping:**
For every competitor in the brief, find who is already creating content about them. Search each competitor brand name on Instagram, YouTube, X, and Reddit. Find who tags competitors in posts, mentions them in comments, or features them in reviews.

**Method 2 — Mutual chain discovery:**
From each confirmed KOL (including those validated from the Market Intelligence candidates list), find their mutuals and followers who are creating similar content.

**Method 3 — Bio keyword search (Instagram primary):**
Search Instagram using natural language keywords matching content directions from the pre-run intake. Keywords match the product's content directions (e.g. "desk setup," "audio," "interior," "lifestyle," "music," "creative," "portable," "outdoor") — not generic category terms.

**Method 4 — Community hubs:**
Reddit top contributors in relevant subreddits. YouTube search results for category keywords — who appears consistently.

---

## Creator Segments

| Segment | What they create | Platform fit |
|---|---|---|
| Aesthetic / setup creators | Interior design, desk setup, lifestyle | Instagram primary |
| Audio / tech reviewers | Spec reviews, comparisons, assessments | YouTube primary, Reddit secondary |
| Creatives and music people | Music production, creative environments | Instagram, YouTube, X |
| Lifestyle / portable | Outdoor, travel, camping, on-the-go audio | Instagram, YouTube Shorts |

Content directions from the pre-run intake determine which segments are in scope for this run.

---

## Skills

**Invoke after receiving all required inputs:**

/kol-discovery
Invoke this first — after completing Step 0 (Market Intelligence candidates review). Feed it: the buyer persona cards, the platform map from Buyer Intelligence, the content directions from the pre-run intake, and the validated candidates from Step 0 (so discovery doesn't re-find the same accounts). Use it to structure the platform-specific discovery approach for the remaining methods.

/kol-brief-generator
Invoke for every KOL that passes C1 (engagement rate) and C2 (audience demographics). Do not add any KOL to the shortlist without running this first. Feed it: the KOL's platform, content style, audience profile, brand positioning from brand-context.md, the most relevant buyer persona, and the primary verbatim pain point for that persona. The output brief goes into the KOL's Notion record alongside their metrics.

---

## Mid-Run Notion Writes — Required

Write to Notion every 5 KOL records. Do not batch all records to write at the end.

**Write verification required after every batch:**
After writing each batch, fetch one of the just-created records back by its Notion URL. If the fetch fails → STOP immediately and report to Jinu.

---

## Amazon Research — URL Rule

Never search directly on amazon.com using the Amazon search bar. Correct method: (1) use web search to find the direct product listing URL, then (2) navigate directly to that URL.

---

## Evidence Standards

- Source URL required for every KOL record — the KOL's own platform handle or channel URL. A third-party article about the creator is not acceptable.
- Country required for every record — specific country only, no city/state, no broad regions.

---

## Output

- KOL shortlist — nano/micro only, ranked by engagement quality and audience fit
- Per-KOL card with all 6 criteria scores, country, and creative brief
- Note on which KOLs came from Market Intelligence candidates vs. independent discovery
- Platform gaps documented (if no qualifying voices found on a platform, state why)
