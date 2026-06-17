---
name: b2b-accounts
description: B2B distributor account management — logging wholesale orders, managing partner records, tracking allocation history by SKU, identifying reorders vs initial allocations, and generating country rollups. Load before logging B2B orders, reviewing distributor performance, or managing partner records.
disable-model-invocation: true
---

# B2B Accounts

Requires: `ops-data-standards` (schema and write rules).

B2B partners are wholesale distributors who receive stock from the source warehouse — not D2C end customers.

## Terminology

| Term | Meaning |
|---|---|
| Partner / distributor | Wholesale buyer — receives physical stock |
| Allocation | Units assigned or shipped to a partner |
| Initial | First allocation for a given SKU to a given partner |
| Reorder | Any allocation after the first for the same SKU — signals active sell-through |

## Log a New B2B Order

1. Identify partner by code in `b2b_partners[]`, or create new partner record if first order.
2. Confirm: partner code, SKU(s), qty per SKU, date, initial vs reorder.
3. Append to `b2b_allocations[]` with correct `type`.
4. Append to `movements[]` — source warehouse out, qty, reference = partner code.
5. Run reconciliation — confirm source remaining is correct.

**If date is unknown:** set `"date": null` and note it. Do not invent dates.

## New Partner Record

```json
{
  "code": "XX",
  "name": "Distributor name",
  "country": "Country name",
  "country_code": "ISO-2",
  "status": "active"
}
```

Partner code: short uppercase (2–5 chars), unique within the brand.

## Allocation Record

```json
{
  "partner_code": "XX",
  "sku": "SKU1",
  "qty": 100,
  "date": "YYYY-MM-DD",
  "type": "initial",
  "notes": ""
}
```

Set `"type": "reorder"` if partner already has an `initial` record for this SKU.

## B2B Performance View

**Partner table columns:** Code · Name · Country · [SKU1 total] · [SKU2 total] · Last order date · Reorder count

**Country rollup:** Sum units by `country_code` — used for boss dashboard map and territory reporting.

**Reorder rate:** Partners with `reorder` records = active sell-through. Partners with only `initial` = unconfirmed performance.

## Workflow — Review Distributor Performance

1. Read `b2b_allocations[]` grouped by partner code.
2. Calculate: total units per SKU, last order date, reorder count.
3. Flag: partners with no activity in > 90 days (if dates are available).
4. Country rollup: sum all units by country for geographic coverage view.

## References

- Schema and write rules: `ops-data-standards` skill
- Inventory impact of B2B orders: `inventory-management` skill
