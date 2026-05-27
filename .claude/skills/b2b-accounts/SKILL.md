---
name: b2b-accounts
description: B2B distributor account management — partner records, allocation history, units sold by SKU, reorder/restock tracking, country rollup. Load before logging B2B orders or reviewing distributor performance.
---

# B2B Accounts

## Terminology

- **B2B partner / distributor** — wholesale customer who buys Finecoustic stock from Dongguan (not D2C Shopify buyer).
- **Allocation** — units assigned/shipped to a partner (may be initial or reorder).
- **Restock / reorder** — a partner's **second or later** purchase of the same SKU after their initial allocation. Used to identify active sell-through vs one-time buyers.

## Partner Record

```json
{
  "code": "FP",
  "name": "Indonesia distributor",
  "country": "Indonesia",
  "country_code": "ID",
  "status": "active"
}
```

## Allocation Record

```json
{
  "partner_code": "FP",
  "sku": "FBS1",
  "qty": 312,
  "date": "2026-01-15",
  "type": "initial",
  "notes": ""
}
```

When partner orders again: append with `"type": "reorder"`.

## Workflow — Log New B2B Order

1. Identify partner by code or create new partner record.
2. Confirm SKU(s), qty, date, initial vs reorder.
3. Append to `b2b_allocations[]`.
4. Append `movements[]` — dongguan out, qty, reference partner code.
5. Recalculate Dongguan remaining.

## Reporting

**Partner table columns:** Code, Name, Country, FBS1 total, FBS2 total, Last order date, Reorder count

**Country rollup:** Sum units by country for boss dashboard map/chart.

## Finecoustic Seed Partners (2026-05-21)

FP (Indonesia), EPH (Philippines), EHO (Thailand), NBD (Bangladesh), GCL (Chile), GRS (Serbia), MCJO (Jordan), MKH (Cambodia), RRL (Nepal — LOKESH BANSAL)

Dates not provided at seed — qty-only. Prompt user for dates when available.
