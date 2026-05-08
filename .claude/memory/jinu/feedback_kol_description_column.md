---
name: feedback_kol_description_column
description: Never write to the Description column in KOL database — it is reserved for the user to fill in manually
type: feedback
---

The Description column in the KOL Pools database (and any KOL-related database) must be left blank when creating records. Agents do not write to it.

**Why:** The Description column is the user's manual review/notes field. The user reviews each KOL themselves and writes their own assessment there. Agents pre-filling it overrides the user's process.

**How to apply:** When creating KOL records in Notion, populate all data fields (followers, ER, content type, links, contacts, agent reason, etc.) but always leave Description empty. This rule applies to all KOL database writes.
