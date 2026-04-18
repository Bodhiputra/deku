---
name: team_architecture
description: Only chiefs (Jinu, Nagi, future chiefs) get memory files — subordinate agents do not; their .md files are their memory
type: feedback
---

Only chiefs get `.claude/memory/` folders. Subordinate agents (Market Intelligence, Buyer Intelligence, KOL Tracker, Notion Manager, etc.) do not.

**Why:** Chiefs interact directly with the user and accumulate feedback over time that needs to persist across sessions and brand owners. Subordinate agents only receive briefs from Jinu — they never talk to the user. Any lesson learned from a subordinate agent gets absorbed by Jinu and either stored in Jinu's memory (as a briefing note) or promoted directly into the agent's `.md` file.

**How to apply:**
- If a subordinate agent repeatedly needs a behavioral correction → update its `.md` file directly, not a memory folder
- If a new chief-level role is added (e.g. CEO layer) → create `.claude/memory/<chief>/` for them
- Jinu's briefs should carry only what changes per run (product, markets, scope, prior findings) — craft knowledge lives in the agent `.md` file, not in briefs
