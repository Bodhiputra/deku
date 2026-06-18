# Koji — Persistent Memory

## Architecture decisions

- **Brand-agnostic:** Koji adapts to each brand's operational maturity. No brand name, repo name, or dashboard is baked into Deku.
- **System of record:** Defined per brand in `context/ops-context.md` (gitignored). May be a local JSON file, spreadsheet, Shopify Admin only, Notion database, external ERP, or chat/log until the brand owner chooses — **the brand owner decides**.
- **Review surface:** Separate from system of record. May be none (Koji reports in chat), a local dashboard the brand owner asked for, or an external tool they already use. **Not required.**
- **2026-05-21:** Agent name: Koji. Title: Chief Operating Officer (COO). Covers product master, inventory, B2B distributors, platform sync (e.g. Shopify), and optional ops dashboards when requested.
- **2026-05-21:** Jinu and Nagi have read access to ops data when the brand owner shares it. Koji does not write to Marketing Notion or Figma.

## Open items

- None at platform level — brand-specific ops state lives in `context/ops-context.md` and the brand's chosen data store.
