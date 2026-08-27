---
name: platform-x
description: Teaches agents how X works as a real-time brand intelligence platform — its open-sourced algorithm mechanics, confirmed engagement weights, three methods to find trending and viral content, signal evaluation methodology, and research navigation — so agents distinguish genuine conversation from noise. Used by Content Intelligence Agent (Tasks 1, 2) and Jinu on-demand trend checks.
---

# Platform X

Invoke before any X/Twitter research begins. X is the only major social platform that has released its recommendation algorithm publicly. Engagement weights are confirmed from the source code — X signal evaluation is applied engineering, not interpretation.

## Hard Rules (always apply)

- **Never post, reply, like, repost, or follow** on X — Jinu is read-only on all social platforms. Posting is always the owner's manual job.
- **Use the Finecoustic X account** (`finecoustic_global` or the brand account logged in Chrome) — there is no separate Jinu/research X account. Browse carefully: scroll and search only, never interact.
- If Chrome prompts to engage (reply box, like button, follow), dismiss it and do not proceed.

## When to Invoke

- Before any X/Twitter research begins in Content Intelligence Agent
- When Content Intelligence Agent is running trend and viral detection (Task 1)
- When Jinu is running an on-demand trend check
- When assessing what content is gaining traction on X for the brand's category

## X Is Uniquely Transparent — The Algorithm Is Open-Sourced

X released its recommendation algorithm publicly (2023 and Grok-powered update January 2026). The confirmed engagement weights below come directly from the source code.

## Confirmed Engagement Weights (from open-sourced code, January 2026)

- Repost/Retweet: ×20
- Reply: ×13.5
- Reply + author replies back (conversation): ×150 vs. a like
- Profile click: ×12
- Link click: ×11
- Bookmark: ×10
- Like: ×1

**Critical insight:** A reply is worth 27× more than a like. A back-and-forth conversation is worth 150× more than a like. **Never evaluate X content by like count — it is the least informative signal.**

## Time Decay

A post loses half its potential visibility score approximately every 6 hours. The first 30–60 minutes after posting are decisive. For trend detection and on-demand trend checks: only posts gaining velocity in the last 6 hours are early signals worth flagging.

## What Hurts (Confirmed Suppression)

- **External links:** Non-Premium accounts posting links receive near-zero median engagement since March 2026. The algorithm actively discourages leaving X. When competitor brand content rarely contains links — that is algorithmic strategy, not a content choice.
- **More than 1–2 hashtags:** signals spam. Grok reads semantically — hashtags are irrelevant for distribution.
- **Engagement farming patterns:** recognised and actively suppressed.

## How to Find Trending Content on X — Three Methods

**Method 1 — Explore tab (broad trending view):**
Go to X → Explore tab. Surfaces trending topics, breaking news, and popular conversations. Toggle between For You, Trending topics, News, Sports, Entertainment. Set the location filter to a specific confirmed market if researching regional trends — X trends are location-personalised and the local view is often more relevant than global.

**Method 2 — Search → Latest sort (real-time early signal):**
Type your category keyword into X search → switch to **Latest tab** (not Top). This shows the real-time chronological stream. You are catching conversations in the first 1–6 hours before they peak.

What to measure: repost count and reply count, not like count. Confirmed weights: Repost ×20 and Reply ×13.5 — a conversation gaining repost and reply velocity is far more likely to trend than one accumulating likes.

**Method 3 — Advanced search operator for confirmed viral content:**
In the X search bar, type: `[category keyword] min_retweets:100 -filter:retweets`

This finds original posts (not retweets) in the category that have already achieved 100+ repost distribution — confirmed viral content that passed the community filter. Adjust the number based on category size: niche category may use `min_retweets:20`, broad category may need `min_retweets:500`.

Also useful: `[keyword] min_replies:50` to find posts generating active conversation around a topic.

## What to Record Per X Signal

Topic, discovery method (Explore / Latest / Advanced search), repost count, reply count, account size (follower count), post age at time of discovery, whether the account has X Premium (blue checkmark — these receive 2–4× algorithmic boost, factor this when comparing accounts).

## KOL Discovery on X

### Account session
- **No dedicated research account** — browse as `@finecoustic_` (brand account). Read-only only. Never interact.
- No rate-limit rules like Instagram — X is a public platform; browsing profiles and searching does not trigger suspension.
- Do not follow, like, reply, or repost from the brand account. Ever.

---

### Why X search works differently from Instagram

X native search is **post-first, not people-first.** The People tab matches usernames and bios only — it does not search post content. Multi-word People searches reliably return zero results. The correct approach is to find posts from the right creators, then visit their profiles. Never rely on People tab as a primary method.

---

### Discovery method 1 — Advanced search operators (PRIMARY, most powerful)

X's search bar accepts powerful operators. Use them in the search bar or at `x.com/search-advanced`. Key operators:

| Operator | What it does | Example |
|---|---|---|
| `"exact phrase"` | Match exact phrase | `"desk setup"` |
| `word1 OR word2` | Either term (capitalize OR) | `desksetup OR ガジェット` |
| `-word` | Exclude term | `speaker -sale -deal` |
| `min_faves:N` | At least N likes | `min_faves:50` |
| `min_retweets:N` | At least N reposts | `min_retweets:10` |
| `min_replies:N` | At least N replies | `min_replies:5` |
| `filter:media` | Posts with images or video | `filter:media` |
| `filter:images` | Posts with images only | `filter:images` |
| `-filter:retweets` | Original posts only (no reposts) | `-filter:retweets` |
| `-filter:replies` | Remove reply noise | `-filter:replies` |
| `lang:CODE` | Language filter | `lang:ja` (Japanese), `lang:en` |
| `since:YYYY-MM-DD` | From date | `since:2026-01-01` |
| `until:YYYY-MM-DD` | Before date | `until:2026-08-01` |
| `from:handle` | Posts from a specific account | `from:tatsumo11` |

**Copy-paste queries for Finecoustic KOL discovery:**

```
# Japan desk setup creators with visual content, recent
デスク setup filter:images min_faves:30 lang:ja -filter:retweets since:2026-01-01

# Japan audio/speaker posts with photos
スピーカー デスク filter:images min_faves:20 lang:ja -filter:retweets

# Japanese gadget creators, recent high-engagement originals
ガジェット おすすめ filter:images min_faves:50 lang:ja -filter:retweets

# English desk setup with visual, micro range
"desk setup" filter:images min_faves:100 lang:en -filter:retweets since:2026-01-01

# Competitor reverse-engineering (design-reference brands)
"Edifier" filter:images min_faves:20 -filter:retweets
"CMF by Nothing" speaker filter:images min_faves:30 -filter:retweets
"Loop Earplugs" filter:images min_faves:50 -filter:retweets

# Audio design objects, English
"bookshelf speaker" OR "desktop speaker" filter:images min_faves:50 lang:en -filter:retweets
```

**Workflow:** Run query → Latest tab → scan authors of posts with images/video that have ≥50 likes → click profile → C6 check → sidebar → continue.

Use **Latest tab** (not Top) for recency. Top tab shows all-time; Latest shows what's currently being posted.

---

### Discovery method 2 — X Lists (pre-curated pools, underused)

Someone else may have already curated the exact creator pool you need. Desk setup and gadget lists exist, created by journalists, creators, and brands.

**How to find lists:**

1. **Google search** (more reliable than X's own list search):
   - `site:x.com/i/lists "desk setup"`
   - `site:twitter.com/i/lists "ガジェット"`
   - `site:x.com/i/lists "gadget japan"`
   - Note: tested 2026-08-03 — Google indexing of X lists is sparse for Japanese niche creators; expect low yield. Fallback to profile Lists tab instead.

2. **Profile → Lists tab:** Visit qualified creators' profiles → click Lists tab → see what public lists they've made or been added to. Not all creators maintain lists (LOPYLOG has none). Worth checking larger accounts like `@rshosai` (14.8K workspace creator).

3. **X native:** Left sidebar → Lists → Search (single word only — multi-word fails). Try: `desksetup`, `gadget`, `ガジェット`.

**Practical note (2026-08-03):** For the Japan desk setup niche, advanced search operators (Method 1) are significantly more productive than Lists. Most Japanese micro-creators do not maintain public Lists. Lists method may be more useful for US/English creators.

**How to use lists for discovery:** Subscribe to a relevant public list → open it → browse members without following them. Every account on a curated list is a pre-screened candidate.

---

### Discovery method 3 — Profile sidebar "You might like" (secondary, graph expansion)

When on a qualified creator's profile, X's algorithm clusters similar accounts in the "You might like" sidebar. This is the only reliable People-level discovery surface on X. Use it as expansion from confirmed passes — not as a starting point.

---

### Discovery method 4 — Competitor reverse-engineering (Latest tab, not People)

Search `"[Brand Name]"` → Latest tab → look for individual accounts (not brands, retailers, or deal bots) posting photos/reviews with the brand name. Competitor brands for this: Edifier, CMF by Nothing, Loop Earplugs, Marshall, Urbanista (see `brand-context.md` → Tier 2).

Pattern to skip: accounts with Rakuten/Amazon affiliate link patterns (deal bots), retail store accounts, accounts posting without images.

---

### Discovery method 5 — Social graph from confirmed creators (Following + Replies)

Visit a confirmed qualified creator → check their Following list for similar handles → check reply threads on their posts to find who engages with them (active engagers in the same niche are candidates). Use after methods 1–3 are exhausted.

---

### KOL qualification on X (adapted C1–C6)
- **ER formula:** (total likes + replies + reposts on last 10 posts) ÷ (10 × followers) × 100. Pass: ≥0.5% (lower threshold than IG — X engagement is structurally lower). Note: per confirmed weights, reposts = ×20 and replies = ×13.5 vs likes — weight them accordingly when eyeballing.
- **Follower count** is least reliable — purchasing followers is widespread. Prioritise reply quality and repost velocity over raw count.
- **X Premium (blue checkmark):** 2–4× algorithmic boost — factor when comparing accounts. Grok-verified label = additional credibility signal.
- **Activity (C5):** Post within 14 days. Check pinned post date + recent posts timeline.
- **Niche (C6):** Scroll last 10–15 posts visible in the profile feed. ≥6/10 must be on-brief (desk setup / audio / creative workspace). Caption-only C6 is forbidden — visual post content must match.
- **Market pattern (confirmed 2026-08-03, multiple runs):**
  - **Japan** — strongest X + blog creator culture for desk/gadget/lifestyle niches. Follower counts of 2K–8K can be highly active and well-networked. X is a primary platform for Japanese creators alongside their blogs. **Start here for desk/workspace KOL runs on X.**
  - **US** — desk/workspace creators are IG-first and YouTube-first. X results are dominated by AI/productivity influencers who have a nice desk incidentally (not creators), gaming peripheral community, and Southeast Asian/Indian tech accounts that pass `lang:en`. **Do not spend more than one query set on US X desk setup discovery — redirect to IG/YouTube instead.**
  - **Korea, Taiwan** — not yet tested. May have similar X + blog culture to Japan. Worth one exploratory run.

### Required fields before Notion write (X KOLs)
Same as IG/YouTube required fields, plus:
- **Main Platform:** X (add manually in Notion — schema option may need to be added)
- **Links:** X profile URL (https://x.com/handle)
- **Agent Reason:** must note `Platform: X` + discovery method + post content observed

### What X KOL discovery does NOT replace
- C6v visual doomscroll equivalent: screenshot the profile feed to confirm niche content visually before writing
- Country verification: X "Location" field in bio (not as reliable as IG "About this account") — treat as supporting signal only; verify via language and content context

## Output This Skill Must Produce When Invoked

**Before X research begins:** State which method is being used (Explore / Latest sort / Advanced search operator) and what signal type is being extracted.

**Flag all findings with:** repost count / reply count (not like count), account size, Premium status, post age, and signal classification.
