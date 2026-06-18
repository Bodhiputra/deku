---
name: product-master
description: Product catalog management for ops — adding SKUs, updating prices and status, mapping Shopify variant IDs, and maintaining the authoritative product list in ops-data.json. Load before adding or updating any product in ops data.
disable-model-invocation: true
---

# Product Master

Requires: `ops-data-standards` (schema and write rules).

The product catalog in the brand's system of record (`products[]` in ops-data at the path defined in `context/ops-context.md`) is the ops source for SKUs, names, prices, and status.

**Brand-specific product names and prices come from `context/brand-context.md`.** Read it before adding or updating any product — never hard-code brand data in this skill.

## Add or Update a Product

1. Read existing `products[]` — never create a duplicate SKU.
2. Confirm product details with the user or read from `brand-context.md`:
   - SKU code
   - Consumer-facing name
   - D2C price (USD or brand currency)
   - Status (`active`, `legacy`, or `discontinued`)
3. For Shopify-linked products: populate `shopify_variant_id` after a Shopify sync.
4. Save and confirm updated SKU list.

## Required Fields

| Field | Required | Notes |
|---|---|---|
| `sku` | Yes | Uppercase, brand-defined. Never auto-generate. |
| `name` | Yes | Consumer-facing product name |
| `status` | Yes | `active`, `legacy`, or `discontinued` |
| `d2c_price_usd` | Yes for D2C products | Omit for B2B-only or unlaunched SKUs |
| `shopify_variant_id` | No — populate after sync | Null until mapped |

## Status Guide

| Status | When to use |
|---|---|
| `active` | Currently selling; show in launch dashboards |
| `legacy` | In catalog but not primary focus; track in ops, hide from launch views |
| `discontinued` | No longer sold; archive only |

## Output After Update

Confirm and display:
- Full SKU list with name, status, D2C price
- Any `shopify_variant_id` mappings added
- Prompt: refresh hub products view if hub exists

## References

- Schema: `ops-data-standards` skill
- Shopify variant mapping: `shopify-sync` skill
