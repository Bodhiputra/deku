---
name: brand-direction-onboarding
description: Nagi's structured first-session design direction interview. Reads Marketing research from Notion first, then asks the brand owner seven focused questions one at a time to produce a complete [Design Direction] section in context/brand-context.md. Used by Nagi on first session with any new brand, or when [Design Direction] is missing from brand-context.md.
---

# Brand Direction Onboarding

Run this skill when `context/brand-context.md` has no `[Design Direction]` section, or when Nagi is meeting a brand for the first time.

**Hard rule:** Never ask a single question before completing Step 1. Marketing intelligence informs how every question is framed. Asking about design direction without buyer context produces surface answers.

---

## Step 1 — Read Marketing Research First

Before asking anything, check what Marketing already knows:

1. Read `context/brand-context.md` — load all brand facts, target audience, known competitors, price positioning
2. Check `context/session-context.md` — any Notion references to buyer personas or competitor research
3. If Notion IDs are available, read:
   - Buyer Personas database — who buys this product, what motivates them, what frustrates them
   - Consumer Signals & Pain Points — verbatim buyer language
   - Competitor Registry — who the visual competitors are and how they present

Frame every question in Step 2 against this context. A question about emotional register should be informed by what buyers respond to. A question about visual references should be informed by what competitors are already doing.

If Marketing research does NOT exist, tell the user:
*"Design onboarding is most effective after Marketing has completed their research — I frame every question against what we know about your buyers and competitors. I'd recommend running Jinu's intake first. If you want to proceed without that context, I can still run onboarding — we'll be building design direction without buyer intelligence behind it."*
User decides. Do not block. Continue if the user confirms.

---

## Step 2 — The Interview (one question at a time, never a list)

Ask each question, wait for the answer, then ask the next. Never send multiple questions at once.

**Question 1 — Emotional register:**
*"When someone encounters this brand for the first time — a product page, a social post, a piece of packaging — what should they feel? And what must it never feel like?"*

Push past surface answers. If the owner says "premium and minimal" — ask: *"What does premium mean specifically to you here? Premium like a medical device, premium like a Japanese craft product, or premium like a European fashion house?"* Extract the specific emotional territory, not the label.

**Question 2 — Design school orientation:**
Present the eight schools and ask which resonates — not to copy, but to establish gravitational pull:

*"I want to show you eight design directions. Which feels closest to where this brand belongs — not to copy it, but to give me a direction to work from:*
*1. Classical Minimalism — Swiss grid, objective typography, structured and functional*
*2. Neo-Minimalism — confident serifs, aggressive whitespace, the brand that opts out of visual noise*
*3. Engineered Transparency — revealed function as aesthetic, precision and structure as beauty*
*4. Tech Spec Systematism — industrial iconography, modular grids, the visual language of technical documentation*
*5. Quiet Luxury — material quality as the only signal, what is left out matters as much as what is included*
*6. Conceptual Recontextualization — the familiar made strange, a 3% shift that changes how something reads*
*7. Retro Specificity — precise period references with intention, analogue visual worlds*
*8. Maximalism — controlled chaos, bold colour, layered editorial energy"*

**Question 3 — Visual references:**
*"Are there any brands, products, objects, or spaces you find visually compelling — from any category, not necessarily audio or tech? What specifically appeals to you about them?"*

Do not accept brand names alone. If the owner says "I like Apple" — ask: *"What specifically? Their hardware photography? Their packaging? Their web layout? Their typography? The restraint in their retail environments?"* Extract what specifically appeals, not the brand.

**Question 4 — Photography character:**
*"What should product and lifestyle photography feel like for this brand? For example: clean studio documentation, warm and tactile, editorial and aspirational, raw and authentic, technically precise?"*

If the owner is unsure, offer contrasts: *"Closer to a medical device catalogue or closer to a lifestyle magazine? Closer to a Japanese craft object photographed simply or closer to an editorial fashion shoot?"*

**Question 5 — Typography instinct:**
*"What relationship does the brand want with type? For example: confident and restrained with minimal weights, expressive and personality-forward, systematic and functional, or something handmade and human?"*

**Question 6 — Colour instinct:**
*"Any strong inclinations or aversions on colour? Existing brand colours we must work within, or directions you want to avoid?"*

Note: if `context/brand-context.md` already contains confirmed brand colours, reference them: *"I see [colour] is already established — are we building the full system around this, or is this open for expansion?"*

**Question 7 — Motion character:**
*"If the brand moved — a product video, an animated logo, a social reel — how should it move? For example: precise and mechanical, slow and weighted, sharp and quick, or loose and organic?"*

---

## Step 3 — Direction Summary

Read back a one-paragraph summary of the full direction for the owner to confirm. Do not write anything to `brand-context.md` until the owner confirms.

Format: *"Based on what you've told me: [brand name] should feel [emotional register] — the design sits in [school/direction] territory. Photography is [character]. Typography is [character]. Colour direction is [direction]. Motion is [character]. The visual reference point is [specific extracted element from references]. Does that match your intent?"*

Adjust based on feedback. Confirm again. Only then proceed to Step 4.

---

## Step 4 — Write [Design Direction] to brand-context.md

Append to `context/brand-context.md` under a `## [Design Direction]` section:

```
## [Design Direction]
*Established: [date]*

**Emotional register:** [specific answer — not just "premium"]
**Design school:** [primary school + any secondary influences]
**Photography character:** [specific direction]
**Typography instinct:** [specific direction]
**Colour direction:** [inclinations and aversions]
**Motion character:** [specific direction]
**Visual reference anchors:** [specific elements extracted from owner's references — brand names plus what specifically appealed]
**What it must never feel like:** [from Question 1]

*Direction confirmed by brand owner [date]. All agents read this before any work begins.*
```

---

## Non-Negotiables

- Marketing research read before any question is asked
- One question at a time — never a list
- Push past surface answers — extract the specific, not the label
- Owner confirms the direction summary before anything is written
- Nothing written to brand-context.md until confirmed
