---
name: kol-brief-generator
description: Takes a qualified KOL's profile, the brand positioning, and the most relevant buyer persona, and outputs a platform-native creative brief the brand can hand directly to a creator — turning a sourced KOL into an activatable one. Invoke for every KOL that passes the engagement threshold and audience fit check. Never add a KOL to the shortlist without running this first.
---

# KOL Brief Generator

Invoke for every KOL that passes the engagement threshold and audience fit check in kol-discovery. A list of handles with engagement rates is a sourcing output. A list of handles with engagement rates AND a platform-native brief for each creator is an activation output.

## When to Invoke

- For every KOL that passes the engagement threshold and audience fit check in kol-discovery
- Do not add any KOL to the shortlist without running this skill first
- The creative brief output goes into the KOL's Notion record alongside their metrics

## Input Required to Run This Skill

- KOL's platform and content style (from observation during kol-discovery)
- KOL's audience profile (engagement rate, estimated location, content niche)
- Brand positioning statement (from brand-context.md)
- Most relevant buyer persona (from Buyer Intelligence Agent output)
- Primary pain point for that persona (from Consumer Signals database — verbatim)
- Any known brand collaboration constraints (from brand-context.md)

## What a Good KOL Brief Contains

**1. The story arc:**
What narrative should this creator tell? Not a product feature list — a story that begins with a moment or problem the creator's audience recognises, moves through the creator's genuine experience or perspective, and arrives at the brand's product as a natural resolution. The story must be credible in the creator's voice, not the brand's.

**2. The pain point to surface:**
From the consumer signals database — which specific negative signal is most relevant to this creator's audience profile? The brief specifies the pain in buyer language (verbatim from the language map), not marketing language.

**3. The platform-native format:**
What format matches this creator's existing content style? A creator who posts 60-second Reels shouldn't be briefed on a 10-minute YouTube review. The brief specifies format, duration, and structural approach that fits how this creator already communicates with their audience.

**4. The CTA approach:**
What action should the creator encourage — and how? Direct "buy now" CTAs in creator content are the fastest way to break trust. The brief specifies an approach that feels native: a link in bio mention, a "I'll leave details below" reference, or a discount code that feels like a genuine gift to the creator's audience rather than an ad call-out.

**5. What NOT to include:**
Explicit brand claims that sound like advertising copy. Competitor comparisons. Price-leading messaging. Features the buyer persona doesn't care about. The brief specifies what the creator should avoid as clearly as what they should include.

## Output Format

```
KOL CREATIVE BRIEF — [Handle] — [Platform]

STORY ARC:
[2–3 sentences describing the narrative arc the creator should follow —
beginning (relatable moment/problem), middle (creator's experience), end (brand as resolution)]

PAIN POINT TO SURFACE:
[Verbatim buyer language from consumer signals — exactly how the target persona describes this pain]

RECOMMENDED FORMAT:
Platform: [Instagram Reel / YouTube long-form / YouTube Short]
Duration: [X seconds / X minutes]
Structure: [Hook approach → body structure → resolution]

CTA APPROACH:
[Specific, platform-native CTA — how to reference the brand without breaking trust]

DO NOT INCLUDE:
[List of specific language, claims, or approaches to avoid]

TONE AND VOICE NOTE:
[One sentence on how this specific creator's voice should be preserved — not overridden by brand voice]
```
