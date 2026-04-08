---
name: kol-discovery
description: Structured multi-method KOL discovery methodology — starting from a high-quality seed KOL, then systematically hunting additional KOLs from their social graph, comment sections, competitor partnerships, keyword search, YouTube comments, and Reddit communities. Produces a genuine shortlist of vetted, audience-fit creators. Used by KOL Tracker.
---

# KOL Discovery

Invoke at the start of every KOL Tracker session. Provides the discovery methodology that produces a genuine shortlist — not a list of obvious names found by basic search.

## When to Invoke

- Whenever KOL Tracker begins a discovery session
- When starting KOL research for a new market or platform
- When an existing KOL shortlist needs to be expanded
- When the user asks to "find more KOLs like X"

## Core Principles

- Always start from a high-quality seed KOL, not a search bar
- Hunt additional KOLs from the seed's social graph, comment sections, and proximity surfaces
- Quality compounds: high-quality KOLs cluster around other high-quality KOLs
- Hashtag search is outdated in 2026 — do not use as a primary discovery method
- Instagram keyword search (natural language, not hashtags) is the correct search method

## Five Discovery Methods in Priority Order

**Method 1 — Seed KOL → Social Graph Expansion (primary):**
Start from one confirmed high-quality seed KOL. Run four expansion passes:

- **Pass A (Mutuals):** Scan 50–100 accounts from seed's Following list — same-niche creators follow each other. Check follower count and engagement threshold.
- **Pass B (Comment section):** Open seed's last 10–15 posts. Look for creators leaving substantive comments (not emoji), accounts seed KOL replies to (reciprocal engagement = real relationship), recurring commenters across multiple posts. Navigate to each qualifying commenter's profile.
- **Pass C (Tagged content):** Check seed's tagged posts. Creators who collab-post or tag the seed have already demonstrated collaboration willingness.
- **Pass D (Suggested accounts):** Instagram's "Similar Accounts" feature on seed's profile — pre-filtered by Instagram's own interest clustering. Review first 10–20 suggestions.

**Method 2 — Competitor KOL reverse-engineering:**
From competitor registry — identify KOLs competitors have used (from meta-ads-library research). If they fit the buyer persona but don't overlap with the brand's positioning territory, they're candidates. Run Method 1 from each qualifying one.

**Method 3 — Keyword-based profile search (Instagram):**
Use natural language keyword phrases in Instagram search — not hashtags. Use: content niche terms ("audio setup," "desk setup"), lifestyle terms matching buyer persona, location + niche combinations for market-specific discovery ("Singapore tech," "Manila lifestyle"). Filter results: ignore brand accounts and media accounts, focus on individual creator accounts in nano/micro range.

**Method 4 — YouTube comment section mining:**
Go to the most-viewed competitor product review videos or category comparison videos. Look for: commenters who reference their own content ("I did a video on this too"), small channels leaving detailed knowledgeable comments, accounts with linked channels showing genuine category expertise. Navigate to their channels and assess.

**Method 5 — Reddit community mining:**
Relevant category subreddits. Look for: users who reference their own content ("I reviewed it on my channel"), users whose Reddit profile links to YouTube or Instagram, frequent high-upvote contributors with community trust already built. These are creators with authentic expertise who are rarely approached by brands.

## KOL Quality Assessment — Applied to Every Candidate

**Tier 1 — Engagement rate minimum:**
Instagram 3%+ / YouTube 2%+. For nano KOLs under 10K, rates of 8–15% are normal and desirable.

**Tier 2 — Comment quality:**
Read 20–30 comments across 3–5 recent posts. Quality signals: comments are specific to content, creator replies to multiple comments, commenters are real people with genuine account histories, no sudden engagement spikes on one post while others are flat, no wave of new comments from accounts with no bio or posts.

**Tier 3 — Content-brand fit:**
Creator's content genuinely intersects with the brand's positioning territory, tone and aesthetic match buyer persona, authentic interest in the category (not trend-chasing).

**Tier 4 — Audience location proxy:**
Caption language, comment language and slang, story location tags, creator's stated location in bio. Cannot guarantee accuracy without third-party tool — always flag as proxy estimate.

**Tier 5 — Brand collaboration history:**
Has the creator done branded content before? Does their execution feel authentic or transactional? Check for #ad, #sponsored, #gifted labels on past posts.

## KOL Record Format

```
KOL RECORD
Handle: [platform handle]
Platform(s): [Instagram / YouTube]
Followers: [count per platform]
Tier: [Nano <10K / Micro 10K–100K]
Engagement Rate: [% per platform — calculated]
Country/Location: [confirmed or estimated]
Audience Location Proxy: [caption language, comment language, location tags]
Content Niche: [1–2 sentence description]
Brand Fit Score: [High/Medium — with reasoning]
Comment Quality: [Authentic/Mixed — with example quote]
Past Brand Collaborations: [Yes/No — examples if yes]
Discovery Method: [Which method surfaced this KOL]
Seed Source: [Which seed KOL or source led here]
Meta Ads Library Checked: [Yes/No]
Creative Brief: [populated by kol-brief-generator]
Source URL: [Direct link to their platform profile — own channel URL only, no third-party articles]
Date Added: [Date]
```

## What This Skill Does NOT Do

- Does not reach out or contact any KOL — read-only only
- Does not use hashtag search as a primary discovery method — outdated in 2026
- Does not guarantee audience location accuracy without a third-party analytics tool

## Output This Skill Must Produce When Invoked

**Before starting:** Confirm seed KOL, target market (country), and tier (nano/micro).

**After each Method pass:** Candidate list with engagement rate and fit reasoning before moving to next Method.

**Final output:** Qualified KOL shortlist with full KOL Records, ranked by brand fit score + engagement rate combined.
