---
name: inventory-management
description: Multi-warehouse inventory — stock levels, movements, transfers, reconciliation between Dongguan source warehouse and Shopify D2C. Load before any stock update, audit, or transfer task.
---

# Inventory Management

## Warehouses (Finecoustic)

| ID | Role | Update mode |
|---|---|---|
| dongguan | Source — B2B fulfillment, transfers to Shopify | Manual |
| shopify | D2C fulfillment | Shopify sync |

## Manual Dongguan Update Protocol

1. Confirm SKU and qty with user.
2. Read current `inventory_manual` or calculate remaining.
3. Append `movements[]` record with reason (e.g. `b2b_shipment`, `shopify_transfer`, `adjustment`).
4. Update `inventory_manual[]` with new qty and `as_of` date.
5. Run reconciliation — flag if calculated ≠ manual.

## Transfer: Dongguan → Shopify

Log two movements or one transfer pair:
- `dongguan` out
- `shopify` in (or rely on Shopify sync after physical transfer completes)

Ask user: has stock physically arrived at Shopify fulfillment location?

## Dashboard Signals

| Signal | Threshold |
|---|---|
| Low stock warning | < 20 units active SKU at Dongguan |
| Critical | < 10 units |
| Discrepancy | calculated ≠ manual |

## Output Format

```
SKU: FBS1
Dongguan (manual): 92 — as of 2026-05-21
Calculated remaining: 92
Shopify available: [from sync or "not synced"]
Discrepancy: none
```
