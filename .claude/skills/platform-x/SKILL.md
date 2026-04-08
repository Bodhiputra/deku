---
name: platform-x
description: Teaches agents how X works as a real-time brand intelligence platform — its open-sourced algorithm mechanics, confirmed engagement weights, three methods to find trending and viral content, signal evaluation methodology, and research navigation — so agents distinguish genuine conversation from noise. Used by Content Intelligence Agent (Tasks 1, 2) and Jinu on-demand trend checks.
---

# Platform X

Invoke before any X/Twitter research begins. X is the only major social platform that has released its recommendation algorithm publicly. Engagement weights are confirmed from the source code — X signal evaluation is applied engineering, not interpretation.

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

## KOL Evaluation on X

- Follower count is least reliable metric — purchasing followers is widespread
- Engagement rate: (total engagement on last 10 posts) / (10 × follower count) × 100. Below 0.5% = low engagement
- X Premium (blue checkmark): accounts receive 2–4× algorithmic boost — factor this when comparing creator performance
- Quality signal: genuine reply threads with real conversations, not only one-liners

## Output This Skill Must Produce When Invoked

**Before X research begins:** State which method is being used (Explore / Latest sort / Advanced search operator) and what signal type is being extracted.

**Flag all findings with:** repost count / reply count (not like count), account size, Premium status, post age, and signal classification.
