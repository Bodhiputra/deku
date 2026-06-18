---
name: inventory-management
description: Multi-warehouse inventory management for ops — stock level snapshots, manual stock updates with movement logging, warehouse-to-warehouse transfers, and reconciliation between source warehouse and D2C. Load before any stock update, audit, transfer, or discrepancy investigation task.
disable-model-invocation: true
---

# Inventory Management

Requires: `ops-data-standards` (schema and reconciliation formula).

Brand warehouse config lives in `context/ops-context.md`. Read it first — never assume warehouse IDs.

## Stock Snapshot

Read the brand's ops-data file at the path in `context/ops-context.md` and calculate:

```
For each active SKU:
  source_remaining = initial_stock - b2b_allocations - internal_use - outbound movements + inbound movements
  d2c_available    = from inventory_manual (shopify) or shopify-snapshot.json if synced
```

Output format:

```
SKU: [sku]   [name]
  Source warehouse:  [qty] — manual as of [date]   Calculated: [qty]   Discrepancy: none | Δ[n]
  D2C warehouse:     [qty] — synced [date] | not synced
```

Flag discrepancy inline. Do not suppress it.

## Manual Stock Update Protocol

Use when the source warehouse operator reports a count change.

1. Confirm SKU, new qty, and reason with user.
2. Append to `movements[]`:
   - `direction`: `out` for shipments/allocations, `in` for receipts/adjustments
   - `reason`: one of `b2b_shipment`, `shopify_transfer`, `adjustment`, `return`, `damaged`, `sample`
   - `reference`: order ID, transfer ID, or free-text note
3. Update `inventory_manual[]` with new qty and today's date.
4. Run reconciliation — if delta ≠ 0, flag before saving.

## Transfer: Source → D2C

A physical transfer requires two movement records:

```json
{ "direction": "out", "warehouse": "<source-id>", "reason": "shopify_transfer", "reference": "TRF-YYYYMMDD-01" }
{ "direction": "in",  "warehouse": "<d2c-id>",    "reason": "shopify_transfer", "reference": "TRF-YYYYMMDD-01" }
```

Ask user: has stock physically arrived at the D2C location yet? If no, log source-out only and note pending arrival.

## Dashboard Thresholds (defaults — override in ops-context.md)

| Signal | Default threshold |
|---|---|
| Low stock warning | < 20 units at source warehouse |
| Critical | < 10 units |
| Discrepancy | calculated ≠ manual count |
| D2C sync staleness | > 24h = warn, > 7 days = critical |

## Supported Warehouses

Any warehouse defined in `ops-data.json warehouses[]` is valid. Common types:

| Type | Update mode |
|---|---|
| `source` | Manual — warehouse operator confirms counts |
| `d2c` | Sync — pulled from Shopify or 3PL API |
| `3pl` | Manual or API depending on integration |
| `fba` | Sync via Seller Central (future) |

## References

- Schema and write rules: `ops-data-standards` skill
- Shopify D2C sync: `shopify-sync` skill
