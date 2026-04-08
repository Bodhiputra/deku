---
name: platform-youtube-shorts
description: Teaches agents how YouTube Shorts works as a separate discovery and format-trend detection platform — its decoupled algorithm, primary signals, how to scroll for viral signals correctly using incognito mode, view/subscriber ratio as the key viral indicator, and research applications. Used by Content Intelligence Agent (Tasks 1, 2) and Jinu on-demand trend checks.
---

# Platform YouTube Shorts

Invoke before any YouTube Shorts research session. YouTube Shorts and YouTube long-form are fully decoupled as of late 2025. They run on separate recommendation engines with different primary signals. Never conflate the two when evaluating content strategy or KOL potential.

## When to Invoke

- When Content Intelligence Agent is running trend and viral detection (Task 1)
- When Jinu is running an on-demand trend check for short-form format trends
- When KOL Tracker is evaluating a creator's Shorts performance
- When assessing what short-form formats are gaining traction in the brand's category

## Foundational Rule

YouTube Shorts = discovery and awareness tool. Surfaces content to non-subscribers. Rewards instant resonance with cold audiences, not sustained viewer relationships.

## Shorts Algorithm — Primary Signals in Order of Weight

1. **Watch completion rate** — the single most important signal. A Short with 60% completion will outperform one with 30% completion even at 10× the raw views. First frame is critical — swipe-away rate in the first second is an active penalty signal.
2. **Swipe-away rate (inverse of completion)** — if viewers swipe away in the first second, the Short is actively penalised.
3. **Shares** — Shorts shared via DM or to Stories signal genuine social value.
4. **Comments** — Shorts with active comment sections get recommended more.
5. **Subscriber conversion** — Shorts that convert to channel subscribers signal strong audience-content fit. High conversion rate per Short = KOL quality signal.
6. **Likes** — lower signal weight than completion and shares.

## The Critical Research Protocol — Incognito Browsing

Never scroll the YouTube Shorts feed using a logged-in account or a browser with watch history. The personalisation algorithm filters what you see based on historical viewing behaviour.

**Always scroll Shorts in one of these ways:**
- Incognito or private browsing mode (no cookies, no watch history)
- A fresh browser profile with no YouTube history
- A browser tool session initialised without persistent cookies

In incognito mode, the algorithm surfaces what is broadly gaining traction across the platform — not what is personalised to the researcher's history. This gives a much more accurate picture of what is actually viral.

## How to Detect Viral Shorts — Step by Step

**Step 1:** Open YouTube Shorts tab in incognito mode. Scroll slowly. You are looking for two signals, not one.

**Step 2 — Repeating format or theme signal:**
If 3 or more different creators are making Shorts on the same topic, using the same hook structure, or referencing the same trend — the algorithm is surfacing this because it is gaining broad traction. Count occurrences. 3+ = emerging trend. 5+ = confirmed trend. Log: topic, hook structure, format, estimated frequency.

**Step 3 — View/subscriber ratio signal (the most reliable viral indicator):**
Check the view count on a Short vs. the channel's subscriber count. A Short from a 2,000-subscriber channel with 500,000 views is massively overperforming.

Calculate: views ÷ subscribers. If the ratio is 10× or higher (e.g. 500K views / 2K subscribers = 250×), the Short is strongly viral. If the ratio is below 2×, it is performing only for existing subscribers.

This signal works even for small absolute numbers. A Short with 50,000 views from a 500-subscriber channel (100× ratio) is more valuable as a trend signal than a Short with 5,000,000 views from a 10,000,000-subscriber channel (0.5× ratio).

**Step 4:** For each qualifying Short (repeating format OR high view/subscriber ratio), record:
- Topic or theme
- Hook (the exact opening line or first-frame visual)
- Format duration
- View count
- Channel subscriber count
- View/subscriber ratio
- Upload date (age of the Short)
- Source URL

## YouTube Shorts Search for Specific Trend Detection

Type the category keyword into YouTube search → apply the Shorts filter → sort by:
- **Latest** (for on-demand trend checks detecting content under 72 hours)
- **Popularity** (for trend mapping over last 30 days)

Look for Shorts with high view/subscriber ratios in the results.

## Shorts vs. Long-form — The Research Distinction

- **Shorts research:** use for mapping what hooks, formats, and opening-frame strategies are gaining rapid traction with new audiences.
- **Long-form research:** use for buyer language, competitive intelligence, KOL authority, purchase-intent patterns.

These answer different questions. Always run both separately.

## Format Anatomy of Successful Shorts in 2026

- **First frame:** must communicate value proposition visually before any words. Viewers decide to watch or swipe in under 1 second.
- **Hook (0–3 seconds):** pattern interrupts outperform slow builds. Start in the middle of something happening.
- **Loop ending:** ending where it began encourages replay — strong positive signal for the algorithm.
- **Text overlays:** high-contrast, large text that works without sound (50% of viewers watch muted).
- **Duration:** 30–45 seconds often outperforms both very short (under 15s) and longer (60s+).

## Common Pitfalls

- Scrolling Shorts in a logged-in or history-enabled browser — produces a personalised feed, not a viral signal surface
- High Shorts view count alone without checking subscriber count — raw views without the ratio context is meaningless
- Shorts from brand official channels have lower trust signals than creator Shorts
- Treating Shorts as a buyer intelligence source — buyer language lives in long-form comment sections, not Shorts

## Output This Skill Must Produce When Invoked

**Before Shorts research begins:** Confirm using incognito or fresh browser session (state this explicitly). State time window (last 24–72h for on-demand trend checks / last 30 days for trend mapping).

**Flag qualifying Shorts with:** topic/theme, hook (exact opening line or first-frame description), view count, channel subscriber count, view/subscriber ratio, format duration, upload date, source URL, why it qualifies as a trend signal for the brand's category.
