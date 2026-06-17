---
name: ops-data-standards
description: Global data standards for the Koji operations system — ops-data.json schema, movement logging rules, warehouse IDs, write verification, and reconciliation formula. Load before any ops data read or write, regardless of brand.
disable-model-invocation: true
---

# Ops Data Standards

Load this skill before reading or writing any ops data file. All other Koji skills depend on these standards.

## File Locations

```
ops-hub/brands/<brand-slug>/ops-data.json         # system of record
ops-hub/brands/<brand-slug>/shopify-snapshot.json # last D2C sync (generated, may be gitignored)
context/ops-context.md                            # brand ops config (warehouses, store URL, SKUs)
ops-hub/public/                                   # hub UI
```

## ops-data.json Schema

```json
{
  "meta": {
    "brand": "",
    "updated_at": "",
    "currency_default": "USD"
  },
  "products": [
    {
      "sku": "",
      "name": "",
      "status": "active|legacy|discontinued",
      "d2c_price_usd": 0,
      "shopify_variant_id": null
    }
  ],
  "warehouses": [
    { "id": "", "name": "", "type": "source|d2c|3pl|fba", "update_mode": "manual|sync" }
  ],
  "initial_stock": [
    { "sku": "", "qty": 0, "warehouse": "", "as_of": "" }
  ],
  "b2b_partners": [
    { "code": "", "name": "", "country": "", "country_code": "", "status": "active|inactive" }
  ],
  "b2b_allocations": [
    { "partner_code": "", "sku": "", "qty": 0, "date": null, "type": "initial|reorder", "notes": "" }
  ],
  "internal_use": [
    { "sku": "", "qty": 0, "reason": "", "assignee": "", "date": null }
  ],
  "movements": [
    { "id": "", "date": "", "sku": "", "qty": 0, "warehouse": "", "direction": "in|out", "reason": "", "reference": "" }
  ],
  "inventory_manual": [
    { "sku": "", "warehouse": "", "qty": 0, "as_of": "", "notes": "" }
  ]
}
```

## Write Rules

1. Update `meta.updated_at` on every save (ISO 8601).
2. Append to `movements[]` for every stock change — never edit history silently.
3. New B2B order → `type: reorder` if the partner already has an `initial` allocation for that SKU.
4. Generate movement `id` as `mov-{YYYYMMDD}-{seq}` (seq resets per day per brand).
5. After bulk write: verify JSON parses cleanly and reconciliation formula balances.

## Reconciliation Formula

For each SKU per warehouse:

```
remaining = initial_stock.qty
  - sum(b2b_allocations.qty for sku)
  - sum(internal_use.qty for sku)
  - sum(movements where direction=out and warehouse=source)
  + sum(movements where direction=in and warehouse=source)
```

Compare to `inventory_manual.qty`. If delta ≠ 0 → surface as **discrepancy**, never hide it.

## Field Standards

| Field | Rule |
|---|---|
| SKU | Uppercase, brand-defined code (e.g. FBS1). Never auto-generate. |
| Partner code | Short uppercase identifier (e.g. FP, EPH). Unique per brand. |
| Warehouse ID | Lowercase slug (e.g. `dongguan`, `shopify`, `singapore-3pl`). Defined in `ops-context.md`. |
| Currency | USD default. Store in `meta.currency_default` if different. |
| Dates | ISO 8601 (`YYYY-MM-DD`). Null is allowed when date is unknown — do not invent. |

## Product Status

| Status | Meaning |
|---|---|
| `active` | Current selling focus |
| `legacy` | In catalog, not launch focus |
| `discontinued` | No longer sold |

## Permission Gates

| Action | Approval needed |
|---|---|
| Single-record append or update | Confirm scope, then auto-proceed |
| Bulk import overwriting existing records | Explicit user confirmation |
| Delete movement or order history | Explicit user confirmation |
| Schema changes to ops-data.json | Explicit user confirmation |
