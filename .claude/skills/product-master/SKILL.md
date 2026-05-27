---
name: product-master
description: Product catalog management for operations — SKUs, names, prices, status (active/legacy), Shopify variant mapping. Load before adding or updating products in ops data.
---

# Product Master

## Scope

Maintain the product catalog in `ops-hub/brands/<brand>/ops-data.json`.

## Workflow

1. Read existing `products[]` — never duplicate SKU.
2. Cross-check `context/brand-context.md` for D2C prices and product names.
3. For Shopify-linked products, map `shopify_variant_id` after sync.
4. Set `status`: `active` for launch focus, `legacy` for older lines.

## Required Fields Per Product

| Field | Required |
|---|---|
| sku | Yes — internal code (e.g. FBS1) |
| name | Yes — consumer-facing name |
| status | Yes |
| d2c_price_usd | Yes for D2C SKUs |

## Finecoustic Active SKUs

- FBS1 — Hako Nomad — $48.80
- FBS2 — Hako Nomad L — $94.80

## Finecoustic Legacy SKUs

- FT20 — Groove ANC
- FT21 — Groove OWS
- WFM1 — RESONO
- WFM2 — Sonara

## Output

After update: confirm SKU list, status, prices. Refresh hub products view if hub exists.
