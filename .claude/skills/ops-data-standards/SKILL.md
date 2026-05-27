---
name: ops-data-standards
description: Global data standards for the operations department — ops-data.json schema, movement logging, warehouse IDs, SKU rules, and write verification. Load before any ops data read or write.
---

# Ops Data Standards

Load before reading or writing any ops data file.

---

## File Locations

```
ops-hub/brands/<brand-slug>/ops-data.json      # system of record
ops-hub/brands/<brand-slug>/shopify-snapshot.json  # last Shopify sync (generated)
context/ops-context.md                         # brand ops config (warehouses, store URL)
ops-hub/public/                                # hub UI (reads ops-data via fetch or embedded)
```

---

## ops-data.json Schema

```json
{
  "meta": { "brand": "", "updated_at": "", "currency_default": "USD" },
  "products": [
    { "sku": "FBS1", "name": "", "status": "active|legacy|discontinued", "d2c_price_usd": 0, "shopify_variant_id": null }
  ],
  "warehouses": [
    { "id": "dongguan", "name": "Dongguan", "type": "source", "update_mode": "manual" },
    { "id": "shopify", "name": "Shopify", "type": "d2c", "update_mode": "sync" }
  ],
  "initial_stock": [{ "sku": "", "qty": 0, "warehouse": "dongguan", "as_of": "" }],
  "b2b_partners": [
    { "code": "FP", "name": "", "country": "", "country_code": "", "status": "active" }
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
    { "sku": "", "warehouse": "dongguan", "qty": 0, "as_of": "", "notes": "" }
  ]
}
```

---

## Write Rules

1. Update `meta.updated_at` on every save (ISO 8601).
2. Append to `movements[]` for every stock change — never edit history silently.
3. New B2B order → append to `b2b_allocations[]` with `type: reorder` if partner already has `initial`.
4. Generate movement `id` as `mov-{YYYYMMDD}-{seq}`.
5. After bulk write, verify JSON parses and calculated remaining reconciles.

---

## Reconciliation Formula

For each active SKU at Dongguan:

```
remaining = initial_stock.qty
  - sum(b2b_allocations.qty for sku)
  - sum(internal_use.qty for sku)
  - sum(movements where direction=out and warehouse=dongguan)
  + sum(movements where direction=in and warehouse=dongguan)
```

Compare to `inventory_manual.qty`. If delta ≠ 0, surface in dashboard as **discrepancy**.

---

## Product Status

| Status | Meaning |
|---|---|
| `active` | Current launch / selling focus |
| `legacy` | Still in catalog, not launch focus |
| `discontinued` | No longer sold |

---

## B2B Allocation Types

| Type | Meaning |
|---|---|
| `initial` | First stock allocation to distributor |
| `reorder` | Repeat purchase — "restock" in business terms |

---

## Permission

Single-record edits: auto-approved after scope confirm.
Bulk overwrite or delete: user confirmation required.
