# GA4 Report Recipes

Copy-ready argument sets for `run_report`, `run_realtime_report`, and `run_funnel_report`.  
Adjust `property_id` and date ranges per task. Field names are **snake_case** (protobuf format).

Standard dimensions/metrics: [GA4 API schema](https://developers.google.com/analytics/devguides/reporting/data/v1/api-schema).

---

## Date range helpers

**Last 7 days vs prior 7:**

```json
"date_ranges": [
  { "start_date": "7daysAgo", "end_date": "yesterday", "name": "current" },
  { "start_date": "14daysAgo", "end_date": "8daysAgo", "name": "prior" }
]
```

**Last 28 days vs prior 28:**

```json
"date_ranges": [
  { "start_date": "28daysAgo", "end_date": "yesterday", "name": "current" },
  { "start_date": "56daysAgo", "end_date": "29daysAgo", "name": "prior" }
]
```

---

## weekly-overview

`run_report`

```json
{
  "property_id": "PROPERTIES_ID",
  "date_ranges": [
    { "start_date": "7daysAgo", "end_date": "yesterday" },
    { "start_date": "14daysAgo", "end_date": "8daysAgo" }
  ],
  "dimensions": ["date"],
  "metrics": [
    "activeUsers",
    "sessions",
    "engagementRate",
    "conversions",
    "totalRevenue"
  ],
  "order_bys": [{ "metric": { "metric_name": "date" }, "desc": false }]
}
```

Summarize totals per period; compute % change.

---

## acquisition-channels

`run_report`

```json
{
  "property_id": "PROPERTIES_ID",
  "date_ranges": [{ "start_date": "28daysAgo", "end_date": "yesterday" }],
  "dimensions": ["sessionDefaultChannelGroup"],
  "metrics": ["sessions", "activeUsers", "conversions", "totalRevenue"],
  "order_bys": [{ "metric": { "metric_name": "sessions" }, "desc": true }],
  "limit": 15
}
```

---

## top-landing-pages

`run_report`

```json
{
  "property_id": "PROPERTIES_ID",
  "date_ranges": [{ "start_date": "28daysAgo", "end_date": "yesterday" }],
  "dimensions": ["landingPage"],
  "metrics": ["sessions", "bounceRate", "conversions", "totalRevenue"],
  "order_bys": [{ "metric": { "metric_name": "sessions" }, "desc": true }],
  "limit": 25
}
```

---

## top-products

Requires enhanced e-commerce events. Confirm with `get_custom_dimensions_and_metrics` if empty.

`run_report`

```json
{
  "property_id": "PROPERTIES_ID",
  "date_ranges": [{ "start_date": "28daysAgo", "end_date": "yesterday" }],
  "dimensions": ["itemName"],
  "metrics": [
    "itemsViewed",
    "itemsAddedToCart",
    "itemsPurchased",
    "itemRevenue"
  ],
  "order_bys": [{ "metric": { "metric_name": "itemRevenue" }, "desc": true }],
  "limit": 20
}
```

---

## geo-markets

Filter to confirmed markets in analysis (post-query or `dimension_filter`).

`run_report`

```json
{
  "property_id": "PROPERTIES_ID",
  "date_ranges": [{ "start_date": "28daysAgo", "end_date": "yesterday" }],
  "dimensions": ["country"],
  "metrics": ["activeUsers", "sessions", "conversions", "totalRevenue"],
  "order_bys": [{ "metric": { "metric_name": "activeUsers" }, "desc": true }],
  "limit": 30
}
```

---

## device-split

`run_report`

```json
{
  "property_id": "PROPERTIES_ID",
  "date_ranges": [{ "start_date": "28daysAgo", "end_date": "yesterday" }],
  "dimensions": ["deviceCategory"],
  "metrics": ["sessions", "conversions", "totalRevenue", "purchaseToViewRate"]
}
```

---

## top-events

`run_report`

```json
{
  "property_id": "PROPERTIES_ID",
  "date_ranges": [{ "start_date": "30daysAgo", "end_date": "yesterday" }],
  "dimensions": ["eventName"],
  "metrics": ["eventCount"],
  "order_bys": [{ "metric": { "metric_name": "eventCount" }, "desc": true }],
  "limit": 30
}
```

---

## realtime-snapshot

`run_realtime_report`

```json
{
  "property_id": "PROPERTIES_ID",
  "dimensions": ["unifiedScreenName"],
  "metrics": ["activeUsers"],
  "order_bys": [{ "metric": { "metric_name": "activeUsers" }, "desc": true }],
  "limit": 10
}
```

Pair with `eventName` dimension for live event mix if needed.

---

## ecommerce-funnel

`run_funnel_report` — Shopify / GA4 enhanced e-commerce event names. Adjust if your property uses different event names.

```json
{
  "property_id": "PROPERTIES_ID",
  "date_ranges": [{ "start_date": "28daysAgo", "end_date": "yesterday" }],
  "funnel_steps": [
    { "name": "View item", "event": "view_item" },
    { "name": "Add to cart", "event": "add_to_cart" },
    { "name": "Begin checkout", "event": "begin_checkout" },
    { "name": "Purchase", "event": "purchase" }
  ],
  "funnel_breakdown": { "breakdown_dimension": "deviceCategory" }
}
```

If steps fail, call `get_custom_dimensions_and_metrics` and verify event names in **top-events** first.
