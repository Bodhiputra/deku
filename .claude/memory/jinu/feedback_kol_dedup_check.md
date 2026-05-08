---
name: feedback_kol_dedup_check
description: KOL Tracker must fetch the full existing KOL Pools database at session start and exclude all existing handles before any discovery begins
type: feedback
---

Before any KOL discovery work begins, the agent must read the full KOL Pools database in Notion and extract every existing handle. Those handles are hard-excluded from the session — they cannot be added again regardless of what the brief says.

**Why:** The brief may only list a subset of known KOLs. The Notion database is the source of truth for what already exists. Relying on the brief alone causes duplicates.

**How to apply:** Step 0 of every KOL Tracker session — fetch the KOL Pools database, collect all existing KOL Channel Name values, add them to the exclusion list. Only then begin discovery. This runs before research-primer and before any profile checking.
