---
name: kol-brief-generator
description: Takes a KOL profile, brand positioning, and buyer persona and outputs a platform-native creative brief ready to hand directly to a creator. Use after a KOL passes the engagement threshold and audience fit check. Never add a KOL to the shortlist without running this first.
---

# KOL Brief Generator

When this skill is invoked, produce a platform-native creative brief for the specified KOL.

## Inputs Required

You must have the following before running:

- **KOL platform** (YouTube / Instagram / TikTok)
- **KOL content style** — how they communicate, their tone, their format patterns (from your direct observation of their channel/profile)
- **KOL audience profile** — who watches/follows them, their audience's demographics and interests
- **Brand positioning** — from `context/brand-context.md` (positioning statement, key differentiators, what the brand is NOT)
- **Target buyer persona** — the most relevant persona from Buyer Persona output
- **Primary pain point** — the single most relevant pain point that persona holds (from Pain Point Miner output)

If any of these inputs are missing, do not proceed. State what is missing and stop.

## Brief Structure

Produce a brief with exactly these sections:

### 1. Story Arc
The narrative the KOL should tell — in one paragraph, written as a story, not a bullet list. The arc must:
- Open with the buyer persona's pain point in the buyer's own language (not brand language)
- Move through discovery of the product as the solution
- Land on a specific, credible outcome — not a generic claim
- Fit the KOL's existing content style (a tech reviewer's arc ≠ a lifestyle creator's arc)

### 2. Pain Point to Surface
The single pain point to lead with. Must be:
- Verbatim buyer language from the Pain Point Miner language map — not paraphrased
- Specific to the buyer persona, not generic to the category
- Something the brand can credibly resolve at its price tier

### 3. Format Recommendation
The content format that fits this creator's existing style. Be specific:
- Video length / carousel length / post type
- Hook structure for this platform (TikTok first-second hook ≠ YouTube cold open ≠ Instagram caption hook)
- Whether B-roll, screen recording, or product demo fits their production style
- Placement of brand mention (upfront, mid-video, end-card — based on what performs for this creator's tier and platform)

### 4. CTA Approach
The call-to-action that fits both the platform and the creator's audience trust level:
- Nano creators: soft CTA — "check it out if you're curious" performs better than hard sell
- Micro creators: benefit-led CTA — tie the CTA to the specific pain point resolved
- Never use generic CTAs ("link in bio," "use code X") without connecting them to the pain point resolved

### 5. What NOT to Do
Two or three specific things this creator should not do — based on what would feel off-brand for them or would underperform for their audience. Be direct. This section protects against generic content that reads as sponsored rather than authentic.

## Output Format

Output the brief as a clean document the brand can send directly to the creator. No internal commentary. No "as per the research" language. Write as if a human partnership manager wrote it.

After the brief, append one internal note (clearly marked [INTERNAL — DO NOT SEND]) summarising:
- Why this creator passed the audience fit check
- Which pain point was selected and why
- Confidence level (High / Medium / Low) with one-sentence reasoning
