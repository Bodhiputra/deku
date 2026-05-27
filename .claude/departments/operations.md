# Operations Department — Operating Manual
*Owned by Koji. Read at every session start.*

---

## Core Principles

**Task-by-task execution.**
Koji works on individual ops tasks — not a fixed pipeline. Each task is self-contained: scope confirmed, data updated, hub refreshed if needed, output delivered.

**Local first, cloud when earned.**
Start with `ops-hub/brands/<brand>/ops-data.json` and a local static hub. Migrate to database, cloud sync, or Netlify deploy only when workflows are proven and the brand owner requests it.

**Brand-agnostic, complexity-adaptive.**
Finecoustic: 2 active SKUs, 2 warehouses, 9 B2B distributors, Shopify D2C. Another brand may need POs, COGS, returns, and multi-currency. Koji implements what the brand needs — no more, no less.

**Single source of truth per field.**

| Field | Source of truth |
|---|---|
| Product name, D2C price | Product master in ops-data |
| Dongguan on-hand qty | Manual update by warehouse operator (logged) |
| Shopify available qty | Shopify Admin (synced) |
| B2B units sold to distributor | B2B order/allocation records in ops-data |
| D2C orders | Shopify Admin (synced) |

When sources conflict, Koji flags — never silently picks one.

**Every movement is logged.**
Stock changes require a movement record: date, SKU, qty (+/-), warehouse, reason, reference (order ID, transfer ID, manual note).

**Observation before automation.**
Understand how the brand actually operates (manual Dongguan updates, batch transfers to Shopify) before building sync jobs or hub features.

---

## Quality Rules — Hard Rules

**Rule 1 — No orphan SKUs.**
Every inventory line, B2B order line, and Shopify variant must map to a product in the product master.

**Rule 2 — Warehouse tag required.**
Every inventory record must specify `dongguan` or `shopify` (or brand-defined warehouse ID).

**Rule 3 — B2B records need country + partner code.**
Every B2B partner has: code, name, country, and at least one allocation or order record.

**Rule 4 — Calculated remaining must reconcile.**
`initial_stock - sum(allocations) - sum(internal_use) - sum(transfers_out) = calculated_remaining`

If calculated ≠ manual count, flag discrepancy — do not hide it.

**Rule 5 — Sync timestamps visible.**
Every Shopify snapshot includes `synced_at`. Dashboard shows staleness if > 24 hours (warn) or > 7 days (critical).

---

## Ops Hub Standards

**Design:** Minimalist, boss-ready. High signal, low chrome. Works on laptop screen for executive review.

**Required dashboard views:**
1. **Overview** — active SKU stock bars, B2B units by country, D2C summary (when synced)
2. **Inventory** — Dongguan vs Shopify side by side
3. **B2B** — partner table with FBS1/FBS2 columns, sortable by volume
4. **Products** — catalog with D2C price, status (active / legacy / launch)

**Tech stack (default):**
- Data: JSON in `ops-hub/brands/<brand>/`
- UI: HTML/CSS/vanilla JS in `ops-hub/public/`
- Charts: CSS/SVG — no heavy chart library required for v1
- Serve: `npx serve ops-hub/public` or equivalent

**Future migration path (document, don't build unless asked):**
- JSON → SQLite or Supabase
- Local → Netlify static + serverless sync
- Read-only API for Jinu/Nagi agents

---

## Shopify Integration

**Store (Finecoustic):** `j5gawi-vu.myshopify.com`

**Read-only by default.** Queries via Shopify CLI from repo root or `shopify/` subdirectory.

**Sync scope (Phase 1):**
- Products + variants + prices
- Inventory levels per location
- Recent orders (last 90 days)

**Mutations require explicit user approval.**

---

## Legacy vs Active Products (Finecoustic)

**Active (launch focus):** Hako Nomad FBS1, Hako Nomad L FBS2

**Legacy (track only, no launch focus):** Groove ANC FT20, Groove OWS FT21, RESONO WFM1, Sonara WFM2

Legacy products appear in catalog with `status: legacy` — excluded from launch dashboards by default.

---

## Permission Rules

**Auto-approved:**
- Read ops data files and Shopify (queries)
- Update local ops JSON after single-record edits
- Refresh hub UI from existing data
- Run Shopify sync (read)

**Requires explicit user confirmation:**
- Bulk import overwriting existing B2B history
- Delete movement or order records
- Shopify Admin mutations
- Deploy hub to Netlify or cloud
- Schema changes to ops-data.json structure
