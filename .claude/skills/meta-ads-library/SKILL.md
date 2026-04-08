---
name: meta-ads-library
description: Teaches agents how to navigate the Meta Ads Library correctly and extract structured competitive intelligence — the correct tab, filter sequence, search methodology, and signal interpretation — so every session produces actionable findings about competitor ad strategy. Used by Market Intelligence Agent (Pass 3), KOL Tracker, and Content Intelligence Agent (Task 3).
---

# Meta Ads Library

Invoke before any Meta Ads Library browsing session. Three non-negotiable rules override all other behaviour.

## When to Invoke

- When Market Intelligence Agent is researching competitor ad strategy (Pass 3)
- When KOL Tracker is checking competitor brand ad partnerships
- When Content Intelligence Agent is auditing competitor paid content (Task 3)
- Any time an agent needs to understand a competitor's current ad creative, messaging angle, or spend signal

## Non-Negotiable Rules

**Rule 1 — Always use the Ad Library tab, never the Branded Content tab.**
The Branded Content tab shows influencer paid partnership posts. This team does not use that tab. All competitive intelligence goes through the Ad Library tab at facebook.com/ads/library.

**Rule 2 — Always set Ad Category to "All Ads" before searching.**
The default category is not "All Ads." It must be manually set. Any other setting filters out commercial ads. Confirm this is set before every search.

**Rule 3 — Always set location to a specific country before searching.**
Location must be set to the specific country from the confirmed markets list. Never run a global unfiltered search and treat the results as market-specific intelligence. If researching multiple markets, run a separate search per country.

**Rule 4 — Always use Playwright MCP, never Chrome DevTools MCP.**
Meta Ads Library is fully public — no login required. Always use Playwright MCP (profileless, ephemeral, public sites).

## What the Library Shows Per Ad

- Full creative: image, video, carousel
- Ad copy (primary text), headline, description, CTA button text
- Landing page URL
- Start date (when ad began running)
- Active/inactive status
- All platforms the ad runs on (Facebook, Instagram, Messenger, Audience Network)
- Ad variations (A/B tests — all versions shown under the same page)

## What It Does NOT Show

- Performance metrics (no CTR, conversion rate, ROAS, spend amount outside EU/UK)
- Audience targeting details
- Engagement metrics (likes, comments, shares on the ad)

## The Single Most Important Inference

**Ad duration = proxy for performance.** An ad running 30+ days is almost certainly profitable. An ad running 3+ months is a confirmed winner. Sort by oldest start date to surface long-running winning creatives.

## Step-by-Step Navigation

1. Open facebook.com/ads/library via Playwright MCP (no login)
2. Set location: top-left dropdown → specific country from confirmed markets list
3. Set Ad Category: dropdown → "All Ads" (confirm before proceeding)
4. Search: advertiser name (all active ads from that brand) OR keyword (all ads using that keyword across all advertisers — useful for category mapping)
5. Apply filters: Platform = Instagram, Media type = Video, Started date = more than 30 days ago
6. Extract per-ad: hook type, format, offer structure, CTA, duration running, A/B variants, landing page destination

## Advanced Techniques

- **Keyword search** maps the full competitive landscape for a category — not just one brand
- **Search operators:** exact phrase in quotes ("free shipping"), OR operator with pipe (speaker|speakers|audio)
- **Sort oldest-first** to surface long-running confirmed performers
- **Toggle to Inactive** to find seasonal campaigns and discontinued approaches
- **Multi-country:** run same search with different country filter to compare regional messaging strategies

## Intelligence Card Format Per Competitor

```
COMPETITOR: [Brand name]
COUNTRY: [Location filter used]
DATE RESEARCHED: [Date]
TOTAL ACTIVE ADS: [Count]
LONGEST-RUNNING AD: [Start date] — [Brief description]
DOMINANT FORMAT: [Video/Static/Carousel]
TOP HOOK TYPES: [What they lead with — list 2–3]
OFFERS BEING TESTED: [Current offers visible]
AD COPY LANGUAGE: [Key phrases, tone, vocabulary]
PLATFORMS ACTIVE ON: [Which Meta platforms]
GAPS/OPPORTUNITIES: [What formats, angles, or offers they're NOT using]
NOTABLE OBSERVATIONS: [A/B tests, recent pivots, new campaigns]
```

## Common Pitfalls

- Never assume an active ad is profitable — duration is the proxy, not activity status alone
- Never ignore the country filter — ad strategy varies significantly by market
- Do not treat a new ad (under 7 days) as a strategic signal — it is still in testing phase
- Do not confuse Facebook and Instagram performance — filter by platform to isolate

## Output This Skill Must Produce When Invoked

**Before browsing:** Confirm location is set, Ad Category is "All Ads," using Playwright MCP. State research mode (advertiser search vs. keyword search).

**After research:** One intelligence card per competitor reviewed, plus a cross-competitor synthesis note flagging the most exploitable gap.
