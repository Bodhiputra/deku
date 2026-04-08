---
name: buyer-signal-extractor
description: Enforces a structured extraction protocol on raw buyer data — identifying recurring language patterns, emotional intensity signals, moment-of-frustration framing, and unmet expectation language — so the output is a verbatim language map the brand can use directly in copy, not a paraphrased summary of what buyers said. Used by Buyer Intelligence Agent (Passes 1 and 2).
---

# Buyer Signal Extractor

Invoke after raw data collection is complete. The difference between useful buyer research and generic buyer research is whether the output contains verbatim buyer language or a paraphrase of it. Paraphrases lose the exact words buyers use — which are the words that make ad copy, positioning statements, and content hooks feel true rather than manufactured.

## When to Invoke

- After raw data collection is complete in Buyer Intelligence Agent Pass 1 (STP research)
- After raw pain point and sentiment data is collected in Buyer Intelligence Agent Pass 2 (Consumer Signals)
- Whenever raw Reddit threads, review excerpts, or comment quotes need to be processed into structured findings

## The Extraction Protocol — Four Steps

**Step 1 — Pattern identification:**
Across all raw quotes collected, identify phrases that appear in 3 or more separate sources (different posts, different subreddits, different reviewers). These recurring phrases are validated buyer language — the community has independently arrived at the same words. Flag them with source count.

**Step 2 — Emotional intensity ranking:**
For each recurring theme, assess the emotional intensity of the language:
- **High:** language expressing anger, strong frustration, regret, or passionate advocacy ("I can't believe," "absolutely love," "worst purchase," "changed everything")
- **Medium:** language expressing mild frustration or moderate satisfaction ("a bit annoying," "pretty good," "could be better")
- **Low:** language expressing neutral observation or mild preference ("I prefer," "it's fine," "works okay")

High intensity themes are the priority inputs for ad copy and positioning. Low intensity themes are awareness inputs only.

**Step 3 — Moment-of-frustration / moment-of-delight framing:**
For negative signals: identify the specific situation or context in which the pain occurs. Not "the battery dies" but "the battery dies right when I'm in the middle of something." The situational context is what makes ad copy feel understood.

For positive signals: identify what the buyer was doing or trying to achieve when they experienced the delight. Not "sounds great" but "the first time I played music through it at a dinner party, everyone asked what it was."

The situational context is more valuable than the general claim.

**Step 4 — Unmet expectation language:**
Identify language that reveals what buyers expected vs. what they got.
- "I thought it would be," "I expected," "I assumed," "I hoped it would" = unmet expectation before purchase
- "I wish it had," "if only it could," "they should add" = unmet expectation after purchase

This is the most precise input for positioning — it shows exactly where the category has failed to deliver on implicit promises.

## Output Format

```
BUYER SIGNAL EXTRACTION — [Category/Product] — [Date]

VERBATIM LANGUAGE MAP

FRUSTRATION SIGNALS (negative):
Theme: [Pain theme name]
Frequency: [Number of sources this appeared in]
Emotional intensity: [High/Medium/Low]
Situation context: [When/where this pain occurs — specific]
Verbatim phrases:
  - "[Exact quote]" — r/[subreddit], [upvotes] upvotes, [date]
  - "[Exact quote]" — Amazon review, [star rating], [date]
  - "[Exact quote]" — YouTube comment, [video URL], [date]
Unmet expectation language: "[What buyers expected instead]"
Brand addressability: [High/Medium/Low — can this brand's product solve it?]
How brand addresses it: [Specific product feature or positioning claim — only if addressability is High/Medium]

[Repeat per theme]

RELIEF SIGNALS (positive):
Theme: [Delight theme name]
Frequency: [Number of sources]
Emotional intensity: [High/Medium/Low]
Situation context: [When/where this delight occurs — specific]
Verbatim phrases:
  - "[Exact quote]" — [source, date]
Brand claim potential: [Can this be a credible positioning claim?]

[Repeat per theme]

MIXED SIGNALS (contested territory):
Theme: [Contested theme]
Split: [What camp A says vs. what camp B says]
Verbatim — Camp A: "[Exact quote]" — [source]
Verbatim — Camp B: "[Exact quote]" — [source]
Strategic note: [What this contested territory means for positioning]
```

## What This Skill Does NOT Do

- Does not paraphrase buyer quotes — output is always verbatim
- Does not interpret what buyers "really mean" — captures what they actually said
- Does not generate language for the brand — it extracts language from buyers
