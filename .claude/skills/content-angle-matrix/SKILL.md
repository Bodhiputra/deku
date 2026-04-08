---
name: content-angle-matrix
description: Maps every content idea generated in the ideation phase against two axes — is this angle open territory or competitor-owned, and is this angle aligned with a real buyer pain point — so only ideas that are both open AND pain-aligned advance to the recommendation phase. Used by Content Intelligence Agent (Task 5).
---

# Content Angle Matrix

Invoke after the creative-director-skill ideation pass in Content Intelligence Agent Task 5. Creative ideation generates many ideas, but not all ideas are strategically sound. An idea can be creative and interesting but entirely owned by competitors (useless for differentiation) or in open territory but disconnected from any buyer pain (unlikely to convert).

## When to Invoke

- After the creative-director-skill ideation pass in Content Intelligence Agent Task 5
- Before any content idea advances to the brief stage
- When evaluating whether a content angle is differentiated enough to execute

## The Two Evaluation Axes

**Axis 1 — Territory ownership:**
Is this content angle currently owned by a competitor, or is it genuinely open?
- **Owned:** a competitor has established this angle, posts consistently in this territory, and their audience associates them with it. Running the same angle means competing in their territory.
- **Contested:** multiple brands are trying this angle, none owns it clearly. May be worth entering if the brand can execute it better.
- **Open:** no competitor has established this angle in a meaningful way. This is the whitespace.

Source for territory assessment: Competitor Content Audit output from Task 3 — the category content map (owned vs. open territories).

**Axis 2 — Pain alignment:**
Is this content angle directly connected to a real buyer pain point from the consumer signals database, or is it just interesting?
- **Pain-aligned:** the content angle directly addresses a specific frustration, unmet expectation, or emotional tension identified in the consumer signals database. A buyer encountering this content would feel understood.
- **Tangentially relevant:** the angle is in the right category but doesn't connect to a specific pain — it's informational or aspirational without solving anything.
- **Not aligned:** the angle is creative but has no connection to buyer problems or desires identified in research.

Source for pain assessment: Consumer Signals database from Buyer Intelligence Agent — specifically the negative and mixed sentiment records with verbatim buyer language.

## Scoring and Routing

| Territory | Pain alignment | Decision |
|---|---|---|
| Open | Pain-aligned | ADVANCE — highest priority recommendation |
| Contested | Pain-aligned | ADVANCE with differentiation note — must have clearer execution than competitors |
| Open | Tangentially relevant | HOLD — add to future consideration list |
| Open | Not aligned | REJECT |
| Owned | Pain-aligned | REJECT unless significant reframe is justified — document the reframe rationale explicitly |
| Owned | Not aligned | REJECT immediately |

## Output Format Per Idea

```
CONTENT ANGLE ASSESSMENT

Idea: [One-sentence description of the content angle]
Inspired by: [Which creative-director-skill methodology generated this]

AXIS 1 — TERRITORY:
Status: [Open / Contested / Owned]
Evidence: [Which competitors own it, if any — with specific content examples]
Assessment: [One sentence on territory opportunity]

AXIS 2 — PAIN ALIGNMENT:
Status: [Pain-aligned / Tangentially relevant / Not aligned]
Connected pain point: [Specific pain from consumer signals database — verbatim buyer language]
Evidence: [Source — subreddit, review source, date]
Assessment: [One sentence on pain connection strength]

DECISION: [ADVANCE / ADVANCE WITH NOTE / HOLD / REJECT]
Reasoning: [One sentence]
```

## What This Skill Does NOT Do

- Does not generate content ideas — it evaluates ideas from creative-director-skill
- Does not make creative quality judgments — only strategic fit judgments
- Does not guarantee an idea will perform — it filters for strategic soundness, not execution quality

## Output This Skill Must Produce When Invoked

For every idea from the ideation phase: a completed assessment card with territory status, pain alignment status, decision, and reasoning.

Final output: ideas sorted into ADVANCE, HOLD, and REJECT buckets. The ADVANCE bucket with the most Open + Pain-aligned ideas becomes the recommendation list for Task 5 content briefs.
