---
name: shopify-sync
description: Pull read-only product, inventory, and order data from Shopify Admin for D2C ops. Uses Shopify CLI. Load before any Shopify data sync or D2C dashboard update.
---

# Shopify Sync

## Store

Finecoustic: `j5gawi-vu.myshopify.com`

## Rules

- **Read-only** unless user explicitly approves mutations.
- Write output to `ops-hub/brands/<brand>/shopify-snapshot.json`
- Include `synced_at` timestamp in snapshot meta.
- Map Shopify variants to ops `products[].shopify_variant_id`

## Sync Script

From repo root:

```bash
node ops-hub/sync/shopify-pull.mjs finecoustic
```

Requires Shopify CLI authenticated in `shopify/` repo or store credentials.

## Snapshot Schema

```json
{
  "meta": { "store": "", "synced_at": "" },
  "products": [],
  "inventory": [{ "sku": "", "variant_id": "", "available": 0, "location": "" }],
  "orders_recent": [{ "id": "", "date": "", "line_items": [], "total_usd": 0 }]
}
```

## Post-Sync

1. Update hub D2C section from snapshot.
2. Compare Shopify inventory vs Dongguan — do not auto-merge.
3. Report staleness if sync not run in 24h+.

## Failure Handling

If CLI auth fails: stop, tell user to run `shopify auth login` in shopify directory. Do not guess inventory numbers.
