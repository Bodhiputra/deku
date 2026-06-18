---
name: shopify-sync
description: Pull read-only product, inventory, and order data from Shopify Admin when configured in context/ops-context.md. Writes output to the brand's snapshot path. Load before any Shopify sync or variant ID mapping task — not required for brands without Shopify.
disable-model-invocation: true
---

# Shopify Sync

Read-only by default. Mutations require explicit user approval.

Read `context/ops-context.md` first — store URL, sync script path (if any), and `snapshot_path`. Never hard-code a store URL or output path.

**If Shopify is not in ops-context:** stop. Tell the user Shopify sync is not configured for this brand.

## Sync

Use the sync method documented in ops-context (CLI script path, Admin API, or manual export). Store URL from ops-context integrations table.

**If CLI auth fails:** stop. Tell user to authenticate Shopify CLI in their theme/app directory. Do not guess or estimate inventory numbers.

## Snapshot Output

Write to `snapshot_path` from ops-context (or `{data_path directory}/shopify-snapshot.json` if not set):

```json
{
  "meta": { "store": "", "synced_at": "" },
  "products": [
    { "id": "", "title": "", "variants": [{ "id": "", "sku": "", "price": "" }] }
  ],
  "inventory": [
    { "sku": "", "variant_id": "", "available": 0, "location": "" }
  ],
  "orders_recent": [
    { "id": "", "date": "", "line_items": [], "total_usd": 0 }
  ]
}
```

Always include `synced_at` in meta.

## Post-Sync Checklist

1. Map Shopify `variant_id` → `products[].shopify_variant_id` in ops-data (at `data_path`).
2. Update dashboard D2C section from snapshot **only if** brand uses a review surface.
3. Compare Shopify inventory vs source warehouse — do not auto-merge; surface differences for user to review.
4. Report staleness state: synced just now / last synced [date].

## Staleness Rules

| State | Threshold | Display |
|---|---|---|
| Fresh | < 24h | No indicator |
| Stale | 24h–7 days | Warning |
| Critical | > 7 days | Red indicator |

## Mutation Gate

Any write to Shopify Admin requires explicit user approval before execution. State the mutation and wait for confirmation.

## References

- Snapshot mapped back to ops data: `ops-data-standards` skill
- D2C inventory reconciliation: `inventory-management` skill
