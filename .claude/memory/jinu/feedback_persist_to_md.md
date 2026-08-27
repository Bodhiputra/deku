---
name: feedback_persist_to_md
description: Strategic decisions and methodology changes must be written to canonical MD files — chat is not memory for the agentic system
type: feedback
---

**Rule:** Anything new or changed that future sessions or agents must honor → write to the correct canonical file in the same session. Do not leave it in chat only.

**Where things live (single source of truth — no duplicate lists):**

| Type | File |
|------|------|
| Permanent brand facts, competitor tiers, KOL gates | `context/brand-context.md` |
| KOL brief + seed order | `context/kol-brief-templates.md` |
| KOL methodology (brand-agnostic) | `.claude/skills/kol-discovery/SKILL.md` |
| Rolling session state (≤15 lines Active Thread) | `context/session-context.md` |
| Competitor records (full intel) | Notion Competitor Registry |
| Operational feedback for Jinu | `.claude/memory/jinu/feedback_*.md` |

**Avoid bloat:** Update the right section in place; use pointers instead of copying the same list into multiple files. "Don't bloat" means no redundant copies — not "don't document."

**When owner corrects strategy mid-chat** (e.g. Soundcore is not our shelf, design-first competitor list): update `brand-context.md` immediately, then confirm in chat with the file path.
