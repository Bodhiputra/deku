---
name: knowledge-bank-query
description: Answers brand owner questions by querying Senku's local knowledge bank first — navigates INDEX and module files, identifies gaps, and triggers domain-research only when the bank cannot answer. Load for explain/teach tasks and before any live research to avoid duplication.
---

# Knowledge Bank Query

Requires: `knowledge-bank-standards`.

Bank-first answering. Research second. Strategy never.

## When to Invoke

- Owner asks "explain X", "what is Y", "how does Z work"
- Before `domain-research` on any topic
- Senku session start when owner has a specific question

## Step 1 — Load Context

1. Read `context/industry-context.md` — if missing, stop → run `industry-onboarding`
2. Read bank root `INDEX.md`
3. Identify module(s) likely to contain the answer

## Step 2 — Navigate Bank (progressive disclosure)

1. Read module INDEX if topic is in a subfolder
2. Read Summary sections first — if sufficient for owner's depth, answer from Summary
3. Read full Content only when owner needs depth or Summary insufficient
4. Follow cross-links before declaring a gap

Do not load entire bank into context — navigate by INDEX like a directory tree.

## Step 3 — Construct Answer

Structure every response:

```
**From knowledge bank:** [industry slug] / [file path]

[Answer at requested depth]

---
**Claim types in this answer:**
- Fact: ...
- Standard: ...
- Practice: ...
- Inference: ... (if any, explicit)
```

If bank content is stale (`freshness: review-due`), say so and offer refresh.

## Step 4 — Gap Handling

If bank cannot answer:

1. State clearly: *"This isn't in your knowledge bank yet."*
2. Offer: live research now (`domain-research`) + optional write (`knowledge-bank-build`)
3. Add topic to INDEX **Gaps** section if owner defers write

## Depth Calibration

| Owner signal | Response depth |
|---|---|
| "Quickly" / "in plain English" | Summary + one mechanism sentence |
| "Explain" | Summary + key Facts with sources cited inline |
| "Deep dive" / "technical" | Full module content + related cross-links |
| "Teach me like I'm new" | Glossary terms first, then layered explanation |

## Boundaries

**In scope:** mechanisms, specs, standards, industry structure, product taxonomy  
**Out of scope — redirect:**
- "Who should buy this?" → **Jinu**
- "How should we design the packaging?" → **Nagi** (Senku can explain material constraints first)
- "How many units in stock?" → **Koji**
- "What should our positioning be?" → **Jinu**

## Quality Check Before Sending

- [ ] Answered from bank when possible (cite path)
- [ ] All Facts traceable to bank Sources table or live research URL
- [ ] No strategy recommendations slipped in
- [ ] Offered bank write if gap was filled via live research
