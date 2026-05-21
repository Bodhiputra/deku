---
name: update-notion
description: Notion documentation standards for the marketing team — database taxonomy (which records go to which database), global data standards, write verification rules, and workspace structure. Load before writing any research findings to Notion.
---

# Update Notion

Load before writing any research findings to Notion. Provides the database taxonomy, data standards, write rules, and workspace structure.

---

## Global Data Standards

These apply to every write, every database, every task.

- **Source URL format:** "Source Name — [URL]" — every claim needs a named source and URL. A finding without a source URL is invalid and must not be written to Notion.
- **No screenshots as proof:** Include the source URL and navigation directions instead.
- **Geo columns:** Use specific countries only — never broad regions. Country-level only.
- **Country/Region consistency:** Always verify Country and Region fields agree. A mismatch is a data error — catch it before writing.
- **Untagged records:** Any record without a confirmed market country tag is invalid. Do not write it. Flag back to the task owner.
- **Brand registry check:** Any brand name appearing in a Content Recommendations record must exist in the Competitor Registry. If it does not — flag it, add it to the registry first, then reference it. Never reference an unregistered brand.
- **Verbatim quotes:** Stay raw. Never paraphrase buyer language in signal records.

---

## Database Taxonomy

Every record type has one correct home. Writing to the wrong database is a data error.

- **Industry Signals** — macro market signals, category trends, emerging niches, platform activity. Not competitor-specific.
- **Competitor Registry** — one record per competitor. Every record must include: website URL, product specs, pricing, positioning, and a direct product comparison vs. the brand's product (spec-by-spec, advantages, why a buyer would choose each). All brands referenced in any downstream output must have a record here.
- **Buyer Personas** — STP persona sub-pages. One page per persona.
- **Consumer Signals & Pain Points** — all buyer sentiment: positive, negative, mixed. Verbatim quotes, source URLs, geo-tags, sentiment labels. One unified database with Sentiment field — never split into separate databases.
- **Market Sizing** — TAM/SAM/SOM with full formulas. One record per model run.
- **KOL Registry** — individual creators only. No brands, no agencies, no media outlets. Nano/micro only (<100K followers).
- **Potential B2B Partners** — physical stores and online retailers that stock and sell products directly to consumers. No e-commerce platforms (no Amazon, Shopee, Lazada, TikTok Shop, Tokopedia, etc.).
- **Content Intelligence** — platform content analysis findings, competitor content audit findings, funnel gap analysis. Labelled by task.
- **Viral Signals** — trend and viral detection findings from trend detection tasks and on-demand trend checks.
- **Content Recommendations** — final content briefs. Every record must reference a buyer verbatim, a persona, a pillar type, and a platform.

---

## Write Verification — Required After Every Batch

After writing each batch of records, immediately fetch one of the just-created records back by its Notion URL. If the fetch returns the record correctly → confirmed, continue. If the fetch fails or returns empty:
- **Stop immediately.** Do not write more records.
- Report: *"Notion write verification failed after record [N]. MCP may have dropped. Stopping to prevent data loss."*

---

## Permission Rules

**Auto-approved (no confirmation needed):**
- Read any page, database, or record
- Write or update any record
- Create new records in existing databases
- Create new pages within existing structure

**Always requires explicit user confirmation:**
- Deleting any page, database, or record
- Moving records in a way that alters schema
- Overwriting existing research records (triggers versioning decision)

---

## Workspace Structure

```
Marketing Intelligence Hub (master dashboard)
├── Phase 0 Narrative (Market Scoping Report)
├── Industry Signals (database)
├── Cluster A Narrative (Market and Buyer Intelligence Report)
├── Competitor Registry (database)
├── Buyer Personas (database — sub-pages)
├── Consumer Signals & Pain Points (database)
├── Cluster B Narrative (Market Sizing, KOL, and Distribution Report)
├── Market Sizing (database)
├── KOL Registry (database)
├── Potential B2B Partners (database)
├── Cluster C Narrative (Content Intelligence Report)
├── Content Intelligence (database)
├── Viral Signals (database)
├── Content Recommendations (database)
└── Final Narrative (Positioning and Action Plan)
```

All databases and narratives are readable by all departments. Design reads Marketing's Notion — never writes to it.

**Template workspace:** `33b38ff78ba48081a88cc931c54e9df3` — reference structure for new full-brand research workspaces.

---

## Narrative Pages

After completing any major research area, write a narrative page summarising the findings. The databases are the reference layer — the narrative is the comprehension layer. Format: professional prose as if a senior marketing analyst is briefing the team. No bullet dumps. No raw data lists. Findings interpreted, connected, and presented as a coherent assessment.

Run `/humanizer` on every narrative page before writing to Notion. Also run on any prose fields in database records (strategic interpretation, opportunity notes, rationale fields). Structured fields — metrics, URLs, verbatim quotes, formulas — stay as-is.

---

## session-context.md Format

**Section 1 — Current State** (fully rewritten every session):
- What research areas are complete
- Narrative pages written: Y/N per area
- Competitor registry summary (count + key names)
- Persona summary (segment names, primary vs. secondary)
- Positioning hypothesis (current approved statement)
- Content status (recommendations count, platforms covered)
- What is pending (next task or next action)
- Recommended next action for the next session

**Section 2 — Decision Log** (append-only — never overwritten or removed):
- One line per significant decision, exclusion, conflict resolution, or deliberate skip
- Format: `[YYYY-MM-DD] Description — reason`
