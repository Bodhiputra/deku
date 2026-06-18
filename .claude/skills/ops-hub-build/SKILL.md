---
name: ops-hub-build
description: Build or extend a local operations dashboard — only when the brand owner requests one. Reads ops data from paths in context/ops-context.md and displays inventory, B2B partners, product catalog, and platform sync data. Brand-agnostic; not required for Koji to function.
disable-model-invocation: true
---

# Ops Hub Build

**Load only when the brand owner asks for a dashboard.** Koji works without any internal website — chat reports are the default.

Requires: `ops-data-standards` (schema), `frontend-design` skill (for any UI work), paths from `context/ops-context.md`.

The hub answers three boss questions in one screen:
- How much stock do we have?
- Who are our B2B customers and how much did they buy?
- How is D2C performing?

## Directory Structure

Layout is brand-defined in ops-context. Example (local JSON + static dashboard):

```
<review-surface-root>/
├── brands/
│   └── <brand-slug>/
│       ├── ops-data.json
│       └── shopify-snapshot.json
└── public/   # or Next.js app — whatever the brand chose
```

## Design Requirements

- **Minimalist** — neutral palette, generous whitespace, single accent color
- **Boss-ready** — KPI cards visible above the fold, no internal jargon in labels
- **Local only** — serve from `review_surface` path in ops-context (e.g. `npx serve <path> -p 3456` for static sites)
- **Useful visualizations** — horizontal stock bars, country table, sortable partner table

## Required Dashboard Views (v1)

| Tab | Contents |
|---|---|
| Overview | Active SKU stock bars, B2B units by country, D2C summary card (if synced) |
| Inventory | Source warehouse vs D2C side by side, discrepancy flags |
| B2B | Partner table — columns: Code, Name, Country, [SKU cols], Last order, Reorders |
| Products | Catalog — SKU, name, price, status |

Additional modules (POs, COGS, returns, multi-currency) added only when the brand owner requests them.

## Data Loading

```js
// app.js
const DEFAULT_BRAND = '<brand-slug>';
fetch(`../brands/${DEFAULT_BRAND}/ops-data.json`)
  .then(r => r.json())
  .then(data => renderHub(data));
```

Fetch paths relative to the review surface root defined in `context/ops-context.md`.

## Onboarding a New Brand

1. Confirm system of record and review surface in `context/ops-context.md`.
2. Seed products, partners, and initial stock with the brand owner.
3. Build dashboard UI only if they requested one.

## Future Migration (document, do not build until requested)

| Phase | Stack |
|---|---|
| Now | JSON + static HTML/CSS/JS |
| Next | SQLite + local API server |
| Later | Supabase/Postgres + Netlify deploy |

## Cross-Agent Access

Hub and JSON files are **readable** by Jinu and Nagi for context. Write access through Koji only.

## References

- Data schema: `ops-data-standards` skill
- UI design patterns: `frontend-design` skill
