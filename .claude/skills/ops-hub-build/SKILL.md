---
name: ops-hub-build
description: Build or extend a local operations hub — static site with dashboards for inventory, B2B, products, and Shopify D2C. Brand-agnostic; scales from simple JSON dashboards to multi-module ops portals. Load before creating or modifying ops-hub UI.
---

# Ops Hub Build

## Philosophy

Build the **minimum hub that answers boss questions** in one screen:
- How much stock do we have?
- Who are our B2B customers and how much did they buy?
- How is D2C doing?

Complex brands get additional modules (POs, COGS, returns). Simple brands get 4 tabs.

## Default Structure

```
ops-hub/
├── README.md
├── brands/
│   ├── finecoustic/ops-data.json
│   └── _template/ops-data.json
├── sync/
│   └── shopify-pull.mjs
└── public/
    ├── index.html
    ├── css/style.css
    └── js/
        ├── app.js
        └── data-loader.js
```

## Design Requirements

Load `frontend-design` skill for UI work.

- **Minimalist** — neutral palette, generous whitespace, one accent color
- **Boss-ready** — KPI cards above fold, no jargon in labels
- **Useful viz** — horizontal stock bars, country breakdown table, partner sort table
- **Local only** — works via `npx serve ops-hub/public -p 3456`
- **No build step required** for v1 — vanilla HTML/CSS/JS

## Data Loading

Fetch `../brands/<brand>/ops-data.json` when served from ops-hub root.
Fallback: embed brand slug in `app.js` config (`DEFAULT_BRAND = 'finecoustic'`).

## Brand Onboarding (new brand)

1. Copy `brands/_template/ops-data.json` → `brands/<slug>/ops-data.json`
2. Write `context/ops-context.md` — warehouses, store URL, active SKUs
3. Customize hub brand label in `public/js/app.js`
4. Seed products, partners, initial stock with brand owner

## Future Migration (document only)

| Phase | Stack |
|---|---|
| Now | JSON + static site |
| Next | SQLite + local API |
| Later | Supabase/Postgres + Netlify deploy |

Do not implement cloud until user requests.

## Cross-Agent Access

Hub and JSON files are readable by Jinu/Nagi for context. Write access through Koji only.
