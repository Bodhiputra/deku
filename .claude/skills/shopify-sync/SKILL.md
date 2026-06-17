---
name: shopify-sync
description: Pull read-only product, inventory, and order data from Shopify Admin for D2C ops dashboards. Writes output to a local snapshot file. Load before any Shopify data sync, D2C dashboard update, or Shopify variant ID mapping task.
disable-model-invocation: true
---

# Shopify Sync

Read-only by default. Mutations require explicit user approval.

Brand store URL lives in `context/ops-context.md`. Read it first — never hard-code a store URL in this skill.

## Sync Script

From repo root:

```bash
node ops-hub/sync/shopify-pull.mjs <brand-slug>
```

Requires Shopify CLI authenticated in the `shopify/` directory or valid store credentials.

**If CLI auth fails:** stop. Tell user to run `shopify auth login` in the shopify directory. Do not guess or estimate inventory numbers.

## Snapshot Output

Write to `ops-hub/brands/<brand>/shopify-snapshot.json`:

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

1. Map Shopify `variant_id` → `products[].shopify_variant_id` in ops-data.json.
2. Update hub D2C section from snapshot data.
3. Compare Shopify inventory vs source warehouse — do not auto-merge; surface differences for user to review.
4. Report staleness state: synced just now / last synced [date].

## Staleness Rules

| State | Threshold | Hub display |
|---|---|---|
| Fresh | < 24h | No indicator |
| Stale | 24h–7 days | Warning |
| Critical | > 7 days | Red indicator |

## Mutation Gate

Any write to Shopify Admin (price changes, inventory adjustments, product updates) requires explicit user approval before execution. State the mutation and wait for confirmation.

## References

- Snapshot mapped back to ops data: `ops-data-standards` skill
- D2C inventory reconciliation: `inventory-management` skill
