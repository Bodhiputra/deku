---
name: ops-hub-build
description: Build or extend a local operations hub — a static HTML/CSS/JS dashboard that reads ops-data.json and displays inventory, B2B partner accounts, product catalog, and D2C Shopify data. Brand-agnostic; scales from a minimal 4-tab dashboard to multi-module ops portals. Load before creating, modifying, or extending any ops-hub UI file.
disable-model-invocation: true
---

# Ops Hub Build

Requires: `ops-data-standards` (schema), `frontend-design` skill (for any UI work).

The hub answers three boss questions in one screen:
- How much stock do we have?
- Who are our B2B customers and how much did they buy?
- How is D2C performing?

## Directory Structure

```
ops-hub/
├── README.md
├── brands/
│   ├── <brand-slug>/
│   │   ├── ops-data.json          # system of record
│   │   └── shopify-snapshot.json  # generated, may be gitignored
│   └── _template/
│       └── ops-data.json          # blank template for new brands
├── sync/
│   └── shopify-pull.mjs           # Shopify read-only sync script
└── public/
    ├── index.html
    ├── css/style.css
    └── js/
        ├── app.js                 # brand config, tab routing
        └── data-loader.js         # fetches and parses ops-data.json
```

## Design Requirements

- **Minimalist** — neutral palette, generous whitespace, single accent color
- **Boss-ready** — KPI cards visible above the fold, no internal jargon in labels
- **Local only** — no build step; serve with `npx serve ops-hub/public -p 3456`
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

Fetch relative to `ops-hub/public/` when served from hub root.

## Onboarding a New Brand

1. Copy `brands/_template/ops-data.json` → `brands/<slug>/ops-data.json`.
2. Write `context/ops-context.md` — warehouses, store URL, active SKU list.
3. Set `DEFAULT_BRAND` in `public/js/app.js`.
4. Seed products, partners, and initial stock with the brand owner.

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
