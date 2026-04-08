---
name: platform-reddit
description: Teaches agents exactly how Reddit works as a buyer intelligence, trend detection, and research platform — its six sort systems, their specific research applications, how Reddit is where trends are born before they reach other platforms, subreddit selection methodology, comment quality signals, and VOC extraction protocol. Used by Market Intelligence Agent, Buyer Intelligence Agent, Content Intelligence Agent, KOL Tracker, and Jinu on-demand trend checks.
---

# Platform Reddit

Invoke before any Reddit MCP research session begins. Reddit is where trends are born before they spread to other platforms. A topic rising on Reddit on Monday becomes a viral thread on X by Wednesday, gets adapted into a creator hook by Friday, and appears as a polished Instagram Reel the following Tuesday. Catching a trend at the Reddit stage means being 4–5 days ahead of the rest of the content cycle.

## When to Invoke

- Before any Reddit MCP research session begins
- When selecting subreddits to research
- When extracting buyer language, pain points, or community sentiment from Reddit
- When Content Intelligence Agent is running trend and viral detection (Task 1) — Reddit Rising is the earliest signal surface
- When Jinu is running an on-demand trend check

## How to Find Trending Content on Reddit — Step by Step

**Step 1 — Reddit search bar trick (fastest signal):**
Tap or click the Reddit search bar without typing anything. Reddit immediately surfaces the most searched topics on the platform in the last few hours. This is Reddit's own real-time trending signal — no sorting or subreddit selection required.

**Step 2 — r/popular for macro picture:**
Check r/popular to see what is getting broad cross-community traction. This shows the big picture before drilling into niche subreddits.

**Step 3 — Rising sort in category subreddits (primary research method):**
Navigate to 3–5 category-relevant subreddits. Sort by **Rising** — not Hot, not Top. Rising shows posts accumulating upvotes faster than the current average — momentum before it hits the Hot page. This gives a 2–6 hour head start on emerging conversations.

**Step 4 — Cross-subreddit signal:**
If the same topic is appearing in 5 or more different subreddits simultaneously, it has broad cross-community appeal — not a niche signal, a broad trend. Flag it as a strong content signal.

## The Six Sorts — Which to Use When

1. **Rising** — real-time momentum. Posts gaining velocity in last 1–6 hours. Use for: trend detection, on-demand trend checks, detecting fresh category conversations. Never use Hot for early detection.
2. **Hot** — validated popularity balanced with recency. Time decay constant ~12.5 hours. Use for: industry landscape (established conversation), competitor brand mentions, category sentiment.
3. **New** — raw chronological. Too noisy for most research. Use only when verifying recency of a specific topic.
4. **Top (30 days / 90 days / All Time)** — highest community-validated content in the period. Use for: pain point research (Top All Time = most resonant complaints), positioning research.
5. **Controversial** — high engagement with split sentiment. Use for: contested positioning territory, competitor claims being challenged.
6. **Best** (comment sort within a thread) — confidence-based comment ranking. Always sort comments by Best within a thread for VOC extraction. Top comment in Best sort = the community's most validated opinion.

## Reddit Algorithm Mechanics

- Upvote velocity in first 2 hours predicts longevity. 50 upvotes in 30 minutes outranks 50 upvotes over 6 hours.
- Logarithmic vote scaling: the difference between 10 and 20 votes has the same impact as between 100 and 200.
- Comment velocity is a separate signal from upvotes. Posts with active discussion stay visible in Hot longer.
- Reddit is now one of the most influential sources for AI-generated answers (ChatGPT, Perplexity, Claude). Authentic Reddit conversations shape how AI systems describe a product category to buyers.

## Subreddit Selection Methodology

- Start with buyer behaviour, not product category. Ask: what problem would someone search when they need what this brand solves?
- Relevance scoring: frequency of topic mentions × recency × topic-word match.
- Avoid utility subreddits (r/tipofmytongue, r/whatisthisthing, r/AskReddit) — they appear in searches but carry no brand-specific signal.
- Category subreddits (r/audiophile, r/headphones, r/malelivingspace) > general interest subreddits for brand research.
- Country/city subreddits (r/singapore, r/Philippines) for geo-specific buyer research. Apply native language queries where relevant.

## Comment Quality Signals

- High upvote count on a comment = community-validated opinion. 200 upvotes on a complaint = validated pain point.
- Top comment in Best sort = the community's consensus answer.
- Reply chains = contested ground — useful for identifying objections.
- Short comments ("this" / "same" / "+1") = engagement signal, not research signal. Skip them.
- Specific product comparisons ("I returned it because X did Y better") = highest-value positioning intelligence.
- Question comments = buyer information gaps that content can fill.

## VOC Extraction Protocol — Four Language Pattern Types

1. **Frustration language**: "I wish," "why doesn't," "I can't believe," "still no," "finally gave up on" — pain point signals
2. **Relief language**: "finally," "exactly what I needed," "the only one that," "never going back" — winning positioning signals
3. **Comparison language**: "vs," "or," "switched from," "used to use" — competitive switching behaviour
4. **Price-sensitivity language**: "worth it at X," "too expensive for what it is," "would buy at Y" — price tolerance mapping

## Navigation Rules

- Reddit MCP is read-only — never post, never comment, never interact
- Search query: category terms + intent terms together ("portable speaker battery life"), not brand names alone
- Always sort comments by Best within a thread, not New
- Cross-posted content appearing in multiple subreddits = unusually broad resonance — flag it
- Never quote deleted comments or [removed] content

## Output This Skill Must Produce When Invoked

**Before research begins:** State which sort and which subreddits will be used with reasoning. State the VOC extraction target (pain/relief/comparison/price language).

**After extraction:** Flag all verbatim quotes with subreddit, upvote count on comment, date, and language pattern type.
