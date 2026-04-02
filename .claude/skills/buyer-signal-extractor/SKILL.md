---
name: buyer-signal-extractor
description: Enforces structured VOC (Voice of Customer) extraction from raw Reddit threads, Amazon reviews, and social comments. Identifies recurring language patterns, emotional intensity signals, moment-of-frustration framing, and unmet expectation language. Outputs verbatim buyer language the brand can use directly in copy and positioning. Used by Buyer Persona and Pain Point Miner.
---

# Buyer Signal Extractor

When this skill is invoked, run the following structured extraction protocol against all raw source material provided.

## What "Raw Source Material" Means

You must be fed actual content — Reddit thread excerpts, Amazon review text, YouTube comment captures, or social comment grabs. Do not run this skill on summaries or paraphrases. The inputs must be verbatim text from the source.

If you receive summaries instead of raw text, stop and state: "buyer-signal-extractor requires verbatim source text, not summaries. Re-run with raw material."

## Extraction Protocol — Run All Four Steps

### Step 1 — Recurring Language Patterns

Scan all source material for phrases that appear in 3 or more distinct sources. A "distinct source" means a different Reddit thread, a different Amazon review, or a different comment section — not the same post multiple times.

Output format:
- **Phrase:** [exact verbatim phrase]
- **Frequency:** [number of distinct sources]
- **Context:** [one sentence on what situation triggers this phrase]
- **Usable in copy:** Yes / No (No if it contains a competitor brand name or is too context-specific to lift)

### Step 2 — Emotional Intensity Signals

Identify language that signals high emotional charge — frustration, relief, pride, fear, regret, or delight. These are the highest-value signals for ad copy and positioning because they indicate a decision moment, not just an opinion.

Classify each signal:
- **High intensity:** Language with expletives (clean for documentation), caps lock, exclamation marks, or explicit emotional statements ("I was so frustrated," "this actually changed everything")
- **Medium intensity:** Comparative language ("finally," "at least," "way better than"), repetition for emphasis
- **Low intensity:** Matter-of-fact complaints or compliments with no emotional charge

Output as a table: Signal | Verbatim quote | Intensity level | Emotional trigger (what caused it)

### Step 3 — Moment-of-Frustration Framing

Extract the specific situation in which the pain hit — not just what the pain is, but when and where it happened. This is the most underused signal in buyer research. The situation frames the ad creative.

Examples of moment-of-frustration language:
- "I was in the middle of [situation] and..."
- "Every time I [action], the [problem] happens"
- "I specifically bought it for [use case] and..."

Output: Situation | What they expected | What happened instead | Verbatim quote

### Step 4 — Unmet Expectation Language

Identify language where buyers describe what they wished for but didn't get — the gap between promise and reality. This is your positioning whitespace map.

Pattern indicators: "I wish it had...", "would be perfect if...", "just needs...", "the only thing missing is...", "why doesn't it..."

Output: Unmet expectation (verbatim) | Category (feature / quality / price / service / availability) | Addressable by this brand (Yes / No / Partially)

## Final Output — Language Map

After running all four steps, compile a Language Map:

**Verbatim phrases cleared for copy use:** [list only phrases marked "Usable in copy: Yes" from Step 1]

**Highest-intensity emotional triggers:** [top 5 from Step 2, with the verbatim quote]

**Key frustration moments for creative direction:** [top 3 situations from Step 3]

**Unmet expectations the brand can address:** [from Step 4, Addressable = Yes or Partially only]

## Quality Check

Before handing off, verify:
- Every item in the Language Map is verbatim text, not a paraphrase
- No item is attributed to a single source (recurring signals only)
- The Unmet Expectations list does not include items marked Addressable = No

If any of these checks fail, go back and fix before outputting.
