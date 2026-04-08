---
name: platform-instagram
description: Teaches agents exactly how Instagram works as a research and trend detection platform — its 2026 algorithm, signal hierarchy, all eight methods to find trending audio and viral formats before they peak, content anatomy, format performance, and navigation patterns. Used by Market Intelligence Agent, Buyer Intelligence Agent, Content Intelligence Agent, KOL Tracker, and Jinu on-demand trend checks.
---

# Platform Instagram

Invoke before browsing Instagram via Chrome DevTools MCP or any browser tool. Instagram's algorithm and signal hierarchy have shifted significantly in 2026 — agents that evaluate content by like count are drawing wrong conclusions.

## When to Invoke

- Before browsing Instagram via Chrome DevTools MCP
- When finding trending audio or viral Reels formats
- When evaluating any Instagram content for engagement quality or viral potential
- When KOL Tracker is assessing a creator's Instagram account
- When Content Intelligence Agent is running trend and viral detection (Task 1)
- When Jinu is running an on-demand trend check

## Instagram's Five Surfaces (Separate Ranking Systems)

- **Reels feed:** primary discovery engine, surfaces to non-followers, where brands grow
- **Home feed:** ranked mix of accounts followed — relationship strength and past engagement determine order
- **Explore:** interest-based discovery — driven by what similar users engage with
- **Stories:** chronological but ranked — accounts you interact with most appear first
- **Search:** keyword-driven since 2024 — captions and on-screen text indexed, not just hashtags

## Signal Hierarchy — Ranked by Weight in 2026

1. **DM shares** — highest-weighted distribution signal. An estimated 694,000 Reels are shared via DM every minute. Track "Sends" in Insights, not likes.
2. **Saves** — content worth returning to. Educational, reference, and practical posts earn saves. Saves per reach matters more than raw save count.
3. **Comments with depth** — thread conversations and detailed reactions. Short filler comments carry near-zero weight.
4. **Watch completion / Reels retention** — first 3 seconds critical. If viewer scrolls past in under 3 seconds, reach is throttled. Loop completion = strong positive signal.
5. **Likes** — weakest major signal. Never build research judgments primarily on like counts.

## Format Performance in 2026

- **Reels:** 2.35× more reach than static posts. Sweet spot: 30–90 seconds. Trial Reels (shown to non-followers first) = Instagram's testing mechanism.
- **Carousels:** 10.15% average engagement rate vs 6% for Reels. "Second chance" algorithm — may be shown again starting at slide 2. Optimal: 6–10 slides.
- **Static posts:** weakest reach. Brand personality only, not growth.
- **Stories:** strengthen relationship signals with existing followers via polls/quizzes/question stickers.

## Discovery Mechanics

- Keywords in captions, on-screen text, and profile bios now drive discovery — not hashtags.
- **Hashtags:** Instagram capped at 5 per post as of December 2025. They are categorisation tools, not discovery drivers. Users can no longer follow hashtags. **Do not use hashtag search for KOL discovery or trend research** — use keyword search and social graph expansion instead.
- **Collaborations (Collab posts):** content appears on both profiles simultaneously — mutual endorsement signal.

## How to Find Trending Audio and Viral Reels — All Eight Methods

**Method 1 — The rising arrow icon on audio (fastest signal while scrolling):**
When scrolling Reels, look next to the audio track name at the bottom. If there is a small upward arrow (↗) instead of the usual music note icon, Instagram is explicitly signalling it is amplifying videos that use this sound. Tap the audio name to see how many Reels are using it: under 1,000 = early trend, over 100,000 = maturing/near saturation.

**Method 2 — Music library Trending tab (inside the creator tools):**
When creating a Reel or Story, tap the music icon → open the audio library → navigate to the **Trending** tab. Instagram's own official trending audio list, tailored to the account's content style. Updated frequently. Save tracks with the bookmark icon.

**Method 3 — Professional Dashboard → Trending Audio section:**
Profile → Professional Dashboard → Tips and Resources → **Trending Audio**. Dedicated trending audio surface. Note: most detailed version currently limited to US accounts — accounts outside the US should rely on Methods 1 and 2 for audio signals.

**Method 4 — Inspiration tab in Professional Dashboard:**
Profile → Professional Dashboard → Your Tools → **Inspiration tab**. Shows Reels performing well with audiences similar to the brand's followers, popular content in the brand's niche, and what Instagram is suggesting for the account's context. Covers format and topic trends — not just audio.

**Method 5 — Explore page and Search bar for topic and format trends:**
Navigate to the Explore tab. Browse as a researcher, not a passive scroller. Use the Search bar within Explore: type topic keywords relevant to the brand's niche (e.g. "desk setup," "audio review," "speaker") to see what content is being surfaced for those terms. Pay attention to which formats dominate top results.

**Method 6 — Repeating format detection while scrolling Reels:**
Scroll the Reels tab as a researcher. Watch for: the same opening hook line appearing across 3+ different creators, the same transition style being replicated, the same audio appearing in multiple videos across different niches. 3+ creators = emerging trend. 5+ creators = confirmed trending format.

**Method 7 — Follow @creators account:**
Instagram's own @creators account regularly publishes Reels trends carousels. Check their IG Anthems story highlight for curated trending audio.

**Method 8 — Cross-platform early detection:**
Many Instagram Reel trends originate on TikTok or YouTube Shorts before arriving on Instagram. Checking those platforms gives a 3–7 day head start. Search that audio or format on Instagram — if it has the rising arrow or is being replicated by 3+ creators, it is in early momentum on Instagram.

## Navigation for Browser Tool Efficiency

- Profile page: follower count, following, post count, bio, highlights. Post grid for recent content.
- Reel view: shows play count (not reach), likes, comments. Saves not visible externally — infer from content type.
- Meta Ads Library: always use Playwright MCP, never Chrome DevTools. Ad Library tab, All Ads, specific country.
- Engagement rate for KOL evaluation: (likes + comments) / followers × 100. Minimum: 3%+.

## Common Pitfalls

- Do not interpret like count as reach — they are not correlated.
- Reels view count ≠ unique accounts reached. One person rewatching inflates views.
- Watermarked or reposted content is algorithmically penalised — only original platform-native content is prioritised.
- Hashtag search for KOL discovery or trend research is outdated in 2026 — use keyword search, Inspiration tab, and rising audio detection instead.
- Trending audio used with irrelevant or off-brand content will still underperform.

## Output This Skill Must Produce When Invoked

**For trend detection:** Document findings from all relevant methods used —
- Rising arrow audio signals: audio name, upward arrow confirmed Y/N, usage count, how creators are pairing it
- Music library Trending tab: top audio names found, content style they are being used with
- Professional Dashboard Trending Audio: list of audio names flagged
- Inspiration tab: format types and topic angles surfacing
- Explore/Search: dominant formats and topics for category keywords
- Repeating format patterns: hook structure or format type, how many creators using it
- @creators account flags: any relevant trend announcements
- Cross-platform leads: audio or format spotted on TikTok/Shorts now appearing on Instagram

**For content research / KOL evaluation:** State which signal type is being evaluated. Flag qualifying content with: format type, primary signal identified (DM-worthy / Save-worthy / Comments-only / Like-only), why it qualified, recommended action.
