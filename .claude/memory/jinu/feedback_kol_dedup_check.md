---
name: feedback_kol_dedup_check
description: Mandatory live Notion dedup before every KOL write — sync script --check + Cursor hook
type: feedback
---

Before any KOL discovery work begins, run `node tools/sync-kol-list.js` and read `context/kol-exclusion-list.md`. Every handle listed is hard-excluded from discovery and writes.

**Before every Notion write (mandatory — no exceptions):**

```bash
node tools/sync-kol-list.js --check @handle
```

- Exit 0 → safe to write
- Exit 1 → already in KOL Pools — skip write or update existing record only

Uses live Notion API query (not the stale file alone). Discovery source does not matter — re-finding via search ≠ new to pool.

**Hook enforcement:** `tools/hooks/kol-notion-write-guard.sh` blocks `notion-create-pages` when handle exists (Cursor: `failClosed: true`; Codex: `PreToolUse` deny).

**Why:** Notion MCP search caps at 25 results. Exclusion file alone is insufficient if agent skips per-handle lookup. The June 2026 @techjamo duplicate happened because the agent never ran `--check` before write despite the handle being in the synced list.

**After write:** `node tools/sync-kol-list.js --add @handle` or full sync.
