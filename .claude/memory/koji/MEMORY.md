# Koji — Persistent Memory

## Architecture decisions

- **2026-06-07:** Ops hub moved **out of Deku** → `../finecoustic-ops-hub/` (Next.js). GitHub: `git@github.com:Bodhiputra/finecoustic-hub.git`. Deku `ops-hub/` removed.
- **2026-05-21:** Ops system of record is JSON (`finecoustic-ops-hub/brands/<brand>/ops-data.json` or Postgres when deployed), not Notion.
- **2026-05-21:** Agent name: Koji. Title: Chief Operating Officer (COO). Covers product master, inventory, B2B distributors, Shopify D2C sync, and hub builds.
- **2026-05-21:** Finecoustic warehouses: `dongguan` (source, manual updates) and `shopify` (D2C, synced). B2B fulfilled from Dongguan.
- **2026-05-21:** Jinu and Nagi have read access to ops data. Koji does not write to Marketing Notion or Figma.

## Finecoustic seed data

- Initial production stock: FBS1 × 720, FBS2 × 550 (Dongguan)
- 9 B2B distributor allocations seeded 2026-05-21 — see `finecoustic-ops-hub/brands/finecoustic/ops-data.json`
- Internal/sample allocations tracked separately from B2B
- Active launch SKUs: FBS1, FBS2. Legacy: FT20, FT21, WFM1, WFM2

## Open items

- Shopify snapshot not yet run — `shopify-snapshot.json` pending first sync
- B2B order **dates** not provided — allocation qty only
- **2026-05-29:** Enriched allocation list imported. Warehouse balance 574/445. EPH FBS2 54, EHO FBS2 54, GCL FBS2 24. GCL+EPH shipped confirmed.
- **2026-06-05:** Hub redesigned for executives — 3 tabs (Dashboard, Customers, Stock). Customer CRM view: products ordered, shipment, ETA. No wave grouping.
- **2026-06-07:** Warehouse sales report TjiaJune.xlsx imported — 7 customers outbound from Dongguan (396 units). FP + EHO not shipped. Dongguan **available** (physical, inventory operator): FBS1 **58** / FBS2 **7**. System warehouse balance: 574/445.
