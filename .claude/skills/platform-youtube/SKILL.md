---
name: platform-youtube
description: Teaches agents how YouTube works as both a purchase-intent research platform and a trend detection surface — its five separate recommendation systems, confirmed ranking signals, how to find trending topics using Google Trends with the YouTube Search filter, comment intelligence methodology, and navigation patterns. Used by Content Intelligence Agent (Tasks 1, 2) and KOL Tracker.
---

# Platform YouTube

Invoke before browsing YouTube via Playwright MCP or any browser tool. YouTube is the purchase-intent platform — a viewer watching a "portable speaker comparison" video is in the consideration or decision phase. Comment sections are the richest source of pre-purchase buyer language available anywhere.

## When to Invoke

- Before browsing YouTube via Playwright MCP or any browser tool
- When Content Intelligence Agent is running trend and viral detection (Task 1)
- When Buyer Intelligence Agent or Content Intelligence Agent is mining YouTube comments for buyer language
- When KOL Tracker is evaluating a YouTube creator's channel
- When Content Intelligence Agent is mapping YouTube content patterns

## YouTube Is the Purchase-Intent Platform

70% of YouTube views come from algorithm recommendations. Understanding the algorithm means understanding what content reaches buyers.

## YouTube's Five Separate Recommendation Systems

1. **Home feed** — personalised based on watch history. Two biggest signals: CTR and video velocity after posting. Evergreen content resurfaces here years later if signals remain strong.
2. **Search** — semantic NLP-based. Exact keyword matches matter less than topical alignment. Intent satisfaction is key: if a viewer searches, clicks, and watches most of it, that signals strong intent match.
3. **Suggested videos** — the largest traffic driver. "Videos watched together" clusters. Strong engagement ranks higher in Suggested even when keyword optimisation is less precise.
4. **Subscriptions feed** — if a subscriber hasn't watched the last five videos from a channel, YouTube stops pushing notifications to them.
5. **Shorts feed** — fully decoupled from long-form since late 2025. Separate algorithm. Covered in platform-youtube-shorts skill.

## Confirmed Ranking Signals in 2026 (in Order of Weight)

1. **Average view duration / satisfaction** — YouTube shifted from raw watch time to valued watch time. 100% completion of 8 minutes beats 40% completion of 25 minutes. Post-watch surveys and repeat viewing are tracked.
2. **CTR** — Target 4–10%. Below 2% signals algorithm to reduce impressions.
3. **Engagement** — 4%+ like rate and 0.5%+ comment rate. NLP reads comment tone as a ranking factor.
4. **Session watch time** — does the viewer keep watching YouTube after your video?
5. **Negative signals** — "Not Interested" and "Don't Recommend Channel" carry significant negative weight.

## How to Find Trending Topics on YouTube — Three Tools, All Required

**Tool 1 — YouTube Studio Trends Tab (most underused, most accurate):**
YouTube's own built-in trend surface inside YouTube Studio. Shows what the brand's specific audience is searching for.

Step by step:
1. Sign in to YouTube Studio
2. Left menu → Analytics
3. Click the **Trends tab**
4. Look specifically at the **Content Gaps section** — tap "Show more Content gaps"
5. A content gap = topic people are actively searching for on YouTube but cannot find enough quality videos on. Three types: no results exist, no exact match exists, or results are old or low quality.
6. Content gaps = proven demand + low competition = highest-value content opportunity.
7. Save promising search terms using the bookmark icon

**Tool 2 — Google Trends with YouTube Search filter:**
Most people use Google Trends incorrectly for YouTube research — the default filter is "Web Search," showing what's trending on Google, not YouTube. Always switch the filter.

Step by step:
1. Go to trends.google.com
2. Type a category keyword
3. Change filter from "Web Search" to **"YouTube Search"** — critical step
4. Change time range to **"Last 7 days"** for current momentum
5. Look at Related queries → **Rising tab** (not Top)
6. Any query labelled **"Breakout"** = 5,000%+ growth in the past week
7. Set region to match confirmed markets — do not use global if the brand's markets are specific countries

**Tool 3 — YouTube Trending tab (country-filtered):**
YouTube → Explore → Trending → change country filter to specific confirmed market. A topic appearing in a local Trending tab while invisible globally is a market-specific opportunity competitors using only global data will miss.

## Comment Intelligence — The Richest Buyer Language Source

Always sort comments by **Top Comments**, not Most Recent. YouTube comment sections on independent reviewer channels (not brand official channels) are the richest source of pre-purchase buyer language available anywhere.

- **Purchase decision comments:** "Just ordered one," "Convinced me to buy" — which video types and angles drive actual purchases?
- **Comparison comments:** "I had X before, this is better/worse at Y" — competitive switching reasons in the buyer's own words
- **Objection comments:** "Would have bought this but [reason]" — purchase barriers the brand can address in content
- **Question comments:** "Does it work with Z?" — buyer information gaps that content can fill
- **Experience comments:** "I've had this for 6 months and..." — post-purchase validation or regret language
- **Creator credibility comments:** "Been following for 3 years" — KOL authority signal for KOL assessment

## Navigation Patterns

- Search: category keywords + intent modifiers ("portable speaker review," "desk speaker comparison," "best speaker under $200")
- After search: filter by Upload date (last month for trends, last 6 months for content patterns). Use "Prioritize" menu → "Popularity" to surface highest-performing recent content.
- Channel page: subscriber count, upload frequency, playlist structure, comment section quality
- Trending: youtube.com/trending — always filter by specific country and category

## KOL Evaluation

- Subscriber count is meaningful — harder to inflate than Instagram likes
- Minimum: 2%+ engagement (likes/views × 100)
- Mixed channel (long-form + Shorts) > Shorts-only for purchase-intent authority
- Comment section quality: are people asking the creator for advice?

## Common Pitfalls

- Using Google Trends without switching to YouTube Search filter — produces completely wrong data
- View count includes re-watches and embeds — engagement rate matters more than raw views
- YouTube comment sections on brand official channels = fan engagement, not buyer research. Use independent reviewer channels instead.
- Tags have minimal impact in 2026 — title, description, spoken content, and thumbnail matter more

## Output This Skill Must Produce When Invoked

**For trend detection:**
- YouTube Studio Trends Tab: list of content gaps (topic, search volume level, gap type — no results / no match / low quality)
- Google Trends (YouTube Search filter, last 7 days): rising query terms with growth labels (Breakout/%), country filter used
- YouTube Trending tab: country-filtered trending topics with category
- YouTube search bar autocomplete: top autocomplete suggestions for category keywords

**For buyer language research:** State research type (trend mapping / buyer language / competitive intelligence / KOL evaluation). Flag comment findings with: video type, view count, engagement rate, upload date, comment type (purchase decision / comparison / objection / question / experience), verbatim quote with context and source URL.
