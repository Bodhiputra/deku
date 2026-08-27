# Koji — Persistent Memory

## Architecture decisions

 - **Brand-agnostic:** Koji adapts to each brand's operational maturity. No brand name, repo name, or dashboard is baked into Deku.
- **System of record:** Defined per brand in `context/ops-context.md` (gitignored). May be a local JSON file, spreadsheet, Shopify Admin only, Notion database, external ERP, or chat/log until the brand owner chooses — **the brand owner decides**.
- **Review surface:** Separate from system of record. May be none (Koji reports in chat), a local dashboard the brand owner asked for, or an external tool they already use. **Not required.**
- **2026-05-21:** Agent name: Koji. Title: Chief Operating Officer (COO). Covers product master, inventory, B2B distributors, platform sync (e.g. Shopify), and optional ops dashboards when requested.
- **2026-05-21:** Jinu and Nagi have read access to ops data when the brand owner shares it. Koji does not write to Marketing Notion or Figma.

## Carriers / Shipping Profiles

### Finecoustic — Yanwen Logistics (燕文物流)

- **File:** 广州燕文报价单20260413版.xlsx
- **Carrier:** Yanwen Logistics, Guangzhou (燕文物流)
- **Rate card date:** 2026-04-13 (rates effective 2026-03-30)
- **Currency:** RMB; no fuel surcharge
- **Source:** Shared by brand owner 2026-06-30

**Recommended products (特别推荐):**

| Product # | Name | Type | Special cargo |
|---|---|---|---|
| 481 | 燕文专线追踪-普货 | Standard tracked | No |
| 484 | 燕文专线追踪-特货 | Standard tracked | Yes — built-in battery (内置电池) |
| 995 | 燕文专线惠选-普货 | Standard tracked | No |
| 1557 | 燕文大货专线追踪-普货 | Standard tracked | No (bulk) |
| 1703 | 燕文专线追踪-纯电 | Standard tracked | Yes — pure battery (纯电) |
| 1704 | 燕文专线追踪-敏感货 | Standard tracked | Yes — cosmetics etc. |

**Key routes — Express (快递快线):**

| Product # | Name | Transit | Special cargo | Notes |
|---|---|---|---|---|
| 1034 | 燕文美国快线-普货 | 7–10 days | No | Standard US express |
| 1035 | 燕文美国快线-特货 | 7–11 days | Yes — built-in battery ≤100Wh | **Relevant: Hako Nomad has built-in battery** |
| 518 | 燕文英国RM快线-普货 | — | No | UK Royal Mail |
| 799 | 燕文英国RM快线-特货 | — | Yes | UK Royal Mail, battery |
| 32 | 燕文英国YODEL快线-普货 | — | No | UK YODEL |
| 1730 | 燕文英国Evri快线-普货 | — | No | UK Evri |
| 810 | 燕文德国快线-普货 | — | No | Germany |
| 779 | 燕文法国快线-普货 | — | No | France |
| 842 | 燕文澳洲快线-普货 | — | No | Australia |
| 1255 | 燕文澳洲快线-特货 | — | Yes — built-in battery | Australia, battery |
| 440 | 燕文专线快递-普货 | — | No | General express |
| 557 | 燕文专线快递-特货 | — | Yes | General express, special |
| 1920 | 燕文日本快线-普货 | — | No | Japan |
| 979 | 燕文Aramex快递-普货 | — | No | Middle East / Africa |

**Rate detail — US Express普货 (#1034), max 30kg, min billing 30g:**

| Weight (kg) | Rate (¥/kg) | Handling (¥/pc) |
|---|---|---|
| 0.001–0.11 | 130 | 25 |
| 0.111–0.22 | 120 | 25 |
| 0.221–0.34 | 120 | 27 |
| 0.341–0.45 | 120 | 30 |
| 0.451–30 | 115 | 45 |

**Rate detail — US Express特货/battery (#1035), max 30kg:**

| Weight (kg) | Rate (¥/kg) | Handling (¥/pc) |
|---|---|---|
| 0.001–0.11 | 140 | 25 |
| 0.111–0.22 | 130 | 25 |
| 0.221–0.34 | 130 | 27 |
| 0.341–0.45 | 130 | 30 |
| 0.451–30 | 125 | 45 |

**Notes:**
- Hako Nomad products contain built-in batteries → must use 特货/battery variants for US (#1035), AU (#1255), UK (#799)
- Full rate sheets for UK, AU, DE, FR, JP, Middle East not yet extracted — on file in source xlsx

---

## Open items

- None at platform level — brand-specific ops state lives in `context/ops-context.md` and the brand's chosen data store.
