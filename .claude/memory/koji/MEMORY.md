# Koji — Persistent Memory

## Architecture decisions

- **2026-05-21:** Ops system of record is local JSON (`ops-hub/brands/<brand>/ops-data.json`), not Notion. Hub is static site in `ops-hub/public/`. Cloud/Netlify is future phase.
- **2026-05-21:** Agent name: Koji. Title: Chief Operating Officer (COO). Covers product master, inventory, B2B distributors, Shopify D2C sync, and hub builds.
- **2026-05-21:** Finecoustic warehouses: `dongguan` (source, manual updates) and `shopify` (D2C, synced). B2B fulfilled from Dongguan.
- **2026-05-21:** Jinu and Nagi have read access to ops data. Koji does not write to Marketing Notion or Figma.

## Finecoustic seed data

- Initial production stock: FBS1 × 720, FBS2 × 550 (Dongguan)
- 9 B2B distributor allocations seeded 2026-05-21 — see `ops-hub/brands/finecoustic/ops-data.json`
- Internal/sample allocations tracked separately from B2B
- Active launch SKUs: FBS1, FBS2. Legacy: FT20, FT21, WFM1, WFM2

## Open items

- Shopify snapshot not yet run — `shopify-snapshot.json` pending first sync
- B2B order **dates** not provided at seed — allocation qty only; dates to be added per partner
- Dongguan manual count vs calculated remaining should be reconciled with warehouse operator
