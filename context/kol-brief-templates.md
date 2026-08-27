# KOL Brief Templates — Deku (brand-agnostic structure)
*Load at every KOL discovery session. Brand-specific gates and competitors live in `context/brand-context.md` → KOL Discovery Gates. New users: see `context/jinu-user-guide.md` Part 5 (KOL step-by-step).*

Jinu walks brand owners through this template before any KOL search begins. If the brief is incomplete, Jinu fills gaps by asking — never assumes.

---

## Fixed gates (never optional)

These apply to every KOL run on every platform:

| Gate | Rule |
|---|---|
| **C1** | ER — **record in Notion** (UpDog / YT script). **Pass/fail gate suspended** (owner 2026-08-24); do not skip on ER alone |
| **C2** | Country verified — IG: ⋯ → About this account → **Account based in**; YT: About or API |
| **C5** | Active — **latest post within 14 days (2 weeks)**; verify newest post date on profile grid; UpDog 0 posts in last year = fail |
| **C6** | Niche majority — last 15 posts (IG) or last 10 videos/12mo (YT); threshold defined by **C6 preset** below |
| **Dedup** | `node tools/sync-kol-list.js` then read `context/kol-exclusion-list.md` |
| **Notion** | All required fields populated; **Tags and Description always blank** (brand owner curates) |
| **Write cadence** | Write each confirmed KOL immediately; fetch-back verify after each write |
| **Chrome** | If Chrome MCP disconnected → **no Instagram discovery or IG verification** (hard stop) |

**Never write on ER alone (when gate is active). Never pad to hit quota — report low yield honestly.**

---

## Brief template (variables — fill per run)

Copy or confirm these fields with the brand owner before browsing:

```
Product:           [product name(s) from brand-context]
Campaign goal:     [preorder trust / exposure / launch hype / Studio aesthetic / etc.]
Creator type:      [reviewer | lifestyle | cinematic | interior | desk setup | music/vinyl | mixed]
Platforms:         [Instagram | YouTube | both]
Markets:           [countries — ranked if priority matters]
Tier:              [Nano | Micro | range e.g. 1K–100K]
Gender:            [if relevant — or "any"]
Target count:      [N verified — agent reports honestly if fewer]
C6 preset:         [REVIEWER | LIFESTYLE | CINEMATIC | INTERIOR | DESK SETUP | MUSIC — see below]
Competitors:       [flat list to mine — Tier 2 design-reference from brand-context + any extras; no default priority]
Seeds:             [user seed sources REQUIRED — handles, links, accounts to mine; see seed rules]
Explicitly NOT:    [e.g. desk setup | reviewer | inactive | audiophile | paid-only macro]
```

### Minimum viable brief (experienced brand owner)

> *"Jinu, KOL brief: [product], [creator type], [C6 preset], both platforms, [markets], [tier], [N] verified, competitors [list]."*

Jinu confirms the rest or proceeds if unambiguous.

---

## C6 presets (pick one per brief)

C6 is **not removed** — the preset changes what counts as on-brief.

| Preset | On-brief (≥8 of last 15 posts / or YT equivalent) |
|---|---|
| **REVIEWER** | Review, unbox, compare, hands-on test — consumer products; audio/tech/gadget preferred |
| **LIFESTYLE** | Intentional daily-life content; music, sound, or tech appears naturally in their world |
| **CINEMATIC** | Moody/editorial visual work; consistent grade and composition |
| **INTERIOR** | Room/space/product styling — not family-primary, pet-primary, or nature-hiking-primary |
| **DESK SETUP** | Workspace/desk builds; audio gear visible or clearly part of setup context |
| **MUSIC** | Vinyl, listening culture, music production — audio credibility without spec reviews |

**Hard rejects (all presets):** retail/deal hunters, meme accounts, wrong single-niche vs brief, dormant accounts.

Apply **Brand Equity — Agent Rules** from `brand-context.md` on top of C6.

---

## Seeds — dynamic discovery (never hardcoded)

**Seeds are not a fixed list of handles.** GYMCADDY, `@jaysstraightupreviews`, or any single account are *examples* of good shape — not defaults for every reviewer run.

### Seed order (every run)

1. **User seed sources (required)** — brand owner provides handles, links, or accounts to mine **before** browsing. Evaluate first (even off-brief ones define aesthetic benchmark). If none given, Jinu asks explicitly — do not assume "discover dynamically."
2. **Notion Qualified / Stored pool** — KOL Pools matching **this brief's creator type + platform + market**. Tags/Description = taste training data. Pool = taste anchor; graph expansion finds net-new small creators.
3. **Competitor reverse-engineering (Method 2)** — who tagged/reviewed brands in the brief + `brand-context.md` → **Competitive taxonomy** Tier 2 (design-reference). **Not** Tier 3 anti-reference (e.g. Soundcore). Flat list per run — no default priority.
4. **Social graph expansion (Method 1)** — Pass A–D from seeds **confirmed in this run only**: Following (A), comments (B), tagged (C), similar accounts (D). Never mix graphs across creator types (reviewer seeds ≠ desk setup seeds).

**Discovery flow:** brief + dedup → user seeds → pool → competitor tagged → graph → gates → write → repeat from new qualified KOLs.

### Seed rules

- Do **not** embed seed handle lists in `session-context.md` — they go stale and poison resume logic.
- Do **not** reuse exhausted pass logs unless the brand owner says *"resume Pass B on @handle"*.
- **Exclusion list** always wins — `kol-exclusion-list.md` after sync script.

---

## Platform notes

- **Both platforms** are valid for any product unless the brief restricts one.
- **Creator type** drives method priority — not product name alone.
- **YouTube reviewers:** API script when `YOUTUBE_API_KEY` in `.env`; browser still needed for content-quality C6.
- **Instagram lifestyle/cinematic/interior:** Chrome required — no workaround when disconnected.
- **Instagram session config:** Dedicated IG account and Chrome profile (if any) live in `context/brand-context.md` → **Instagram KOL Session** — Jinu fills this during onboarding when Instagram is in scope.

---

## KOL platform strategy (Finecoustic)

*Load for KOL discovery and content tasks. Brand-specific — not portable.*

**Platform pillar table:**

| Platform | Content Pillar | KOL Role |
|---|---|---|
| Instagram | Exposure | Aesthetic, setup, lifestyle, interior, portable use — brand discovery |
| X | Exposure + Retention | Community conversation, word-of-mouth amplification |
| Reddit | Retention | Community validators in audio and adjacent communities |
| YouTube | Conversion | Review-driven purchase intent |
| YouTube Shorts | Exposure | Short-form algorithm-driven discovery |

**Creator segments (all in scope):**

| Segment | What they create | Why they fit |
|---|---|---|
| Aesthetic / setup creators | Interior design, desk setup, lifestyle — products as intentional visual objects | The speaker as a visible object in a curated environment |
| Audio / tech reviewers | Spec reviews, comparisons, honest assessments | Conversion — spec validation and purchase intent |
| Creatives and music people | Music production, creative work environments, listening culture | Experiential — how the product fits into a creative life |
| Lifestyle / portable | Outdoor, travel, camping, on-the-go audio use | Portability and real-world use scenarios |

**Visual quality filter:** Lighting, color grading, and composition are primary filters alongside ER. A nano creator with consistently high-quality intentional content outweighs a micro creator with one viral post surrounded by low-effort content. Quality is the filter; follower count is the tier label only.

**Meta Ads Library:** Not a primary KOL discovery source. Competitors in this category run zero KOL-linked paid social. MAL is useful for competitor paid creative analysis only — not required for KOL discovery.

---

## Market-specific notes

**Philippines:**
- Audio/tech KOLs on Instagram are rare — niche product IG yield is very low per hour. Exhaust web search before opening Chrome.
- Content creation is YouTube-first, TikTok-second, Instagram-third for tech/lifestyle categories.
- Audio hashtags (#audiophileph, #battlestationph etc.) are dominated by retail store accounts. Abandon after 2 consecutive store posts.
- Major audio brand-tagged pages (JBL, Sony) are restricted — cannot be used for KOL discovery.
- ER threshold ≥1% (global standard applies here too).

---

## Jinu → brand owner (first KOL request)

When a brand owner asks to find KOLs for the first time (or brief is vague), Jinu explains in plain language:

*"Before I search, I use a brief template so we don't waste time in the wrong direction. I need: which product, what kind of creator (reviewer vs lifestyle vs cinematic etc.), which platforms and countries, size tier, and how many you want verified — not just a list in chat. There are fixed quality gates — country, engagement, activity, content fit — and you keep Tags and Description in Notion; I fill metrics and Agent Reason only. I'll walk you through the template — takes two minutes."*

Then Jinu reads this file and confirms each field before browsing.

---

## Session checkpoint (after KOL run)

Jinu overwrites **only** the Active Thread block in `context/session-context.md` (≤15 lines). Pass logs and reject encyclopedias go to `context/session-context-log.md`.

Brand owner can say *"Jinu, close session"* — Jinu writes the lean checkpoint. No manual file editing required.
