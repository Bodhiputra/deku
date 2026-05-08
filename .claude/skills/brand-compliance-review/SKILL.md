---
name: brand-compliance-review
description: Mandatory quality gate for all design output before it reaches the user. Three levels: brief alignment, brand alignment, production quality. This is a hard block — not a recommendation layer. Output that fails Level 1 or Level 2 does not leave the department until the failing section is corrected. Used by Nagi, Brand Designer, Visual Production, and Digital Designer on every output before surfacing to the user.
---

# Brand Compliance Review

This is not a thinking exercise. It is a mandatory gate.

**Output that fails Level 1 or Level 2 does not reach the user.** The agent re-runs the failing section with a specific named correction. Partial approval is not permitted. The user sees only work that has passed all three levels.

Level 3 failures (production quality issues only) may proceed with documented revision notes — the output is approved with specific fixes required before final delivery.

---

## Level 1 — Brief Alignment

Does this output serve the brief's actual goal?

Ask:
- What was the brief asking for? (State it explicitly before evaluating)
- Does this output solve the brief's stated problem?
- Is the primary goal of this output immediately clear?
- Would someone who read only the brief and then saw this output conclude that the work is on-brief?

**If no:** The output is off-brief. Do not evaluate further. Send back with the specific reason: *"This output does not address [specific brief goal]. The brief asked for [X]. This delivers [Y]. Re-run addressing [specific gap]."*

A beautifully executed wrong answer is still wrong. Level 1 is evaluated first.

---

## Level 2 — Brand Alignment

Does this output belong to this brand?

Read `context/brand-context.md [Design Direction]` before evaluating.

Ask:
- Does the visual language match the established design school?
- Are all colour values from the brand token system? (Zero hardcoded hex values)
- Are all type values from the brand typography system? (Zero hardcoded font names or sizes outside the system)
- Are all spacing values from the brand spacing tokens?
- Does the aesthetic school feel consistent — or does it drift toward a different school?
- Would this output sit comfortably alongside the last 3 approved outputs from this brand?

**Drift detection:** Compare against the last 3 approved outputs noted in `context/session-context.md`. If the brand is reading inconsistently across outputs — flag the drift specifically. "This output reads [School X] but the last three approved outputs read [School Y]. The brand is drifting. Correct before proceeding."

**If no:** Send back with the specific reason: *"[Element] does not match the brand direction. The brand direction is [X]. This output reads as [Y]. Correct [specific element] before resubmitting."*

---

## Level 3 — Production Quality

Is the work finished?

Ask:
- Correct dimensions and specs for the output format and platform?
- All brand token values applied — zero hardcoded colour, type, or spacing?
- Platform-appropriate visual hierarchy (for social: does it work at thumbnail size, not just full screen)?
- No placeholder text, lorem ipsum, or approximated assets?
- Export settings correct for the use case?
- Safe zones respected on all social assets?
- For web/digital: three breakpoints designed (1440px, 768px, 375px)?
- For decks: consistent slide dimensions, no overflowing text?

**If issues found:** Approve with specific revision notes. *"Approved with revisions: [specific list of production issues to fix before final delivery]."*

---

## Decision Protocol — Strict

| Result | Action |
|---|---|
| All three levels pass | **Approved.** Output reaches user / Nagi. |
| Level 1 fails | **Blocked.** Re-run the entire output. Specific reason given. |
| Level 2 fails | **Blocked.** Re-run the failing element. Specific reason given. |
| Level 3 issues only | **Approved with revisions.** Document specific fixes required. |

**Never approve and note concerns.** Either it passes or it goes back. Vague feedback like "make it better" or "clean it up" is not acceptable — always name the specific failure.
