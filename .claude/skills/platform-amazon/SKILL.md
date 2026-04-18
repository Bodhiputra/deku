---
name: platform-amazon
description: Teaches research agents how to use Amazon as a market intelligence platform for consumer electronics and audio products — Best Sellers navigation, review mining for buyer language, rank and review volume as real sales signal, pricing extraction, purchase behavior patterns, and geographic variants across US, UK, CA, AU, DE, FR. Used by Market Intelligence Agent, Buyer Intelligence Agent, and Content Intelligence Agent.
---

# Platform Amazon

Invoke before any Amazon research session begins. Amazon is the most reliable real-world sales signal available without paid data access. A product's Best Sellers Rank (BSR) combined with review volume is a direct proxy for market traction — not press coverage, not marketing claims, not community opinion. What is selling and what buyers actually say about it.

## When to Invoke

- Before researching competitor products, pricing, or market positioning on Amazon
- When validating which brands and products are actually winning at a given price tier
- When mining buyer language, pain points, and satisfaction signals from reviews
- When checking what's trending (Movers and Shakers) or aspirationally desired (Most Wished For)
- When verifying street prices vs. launch prices for competitor profiles

## The Core Rule — Never Use the Amazon Search Bar

Amazon's search bar triggers bot detection and returns personalised, algorithm-manipulated results. Always navigate via direct category URLs. The URLs below are stable, publicly accessible, and return consistent results for research purposes.

## Category URL Structure — Audio

### Bluetooth Speakers
- **Best Sellers (US):** https://www.amazon.com/Best-Sellers-Electronics-Portable-Bluetooth-Speakers/zgbs/electronics/7073960011
- **New Releases (US):** https://www.amazon.com/gp/new-releases/electronics/7073960011
- **Most Wished For (US):** https://www.amazon.com/gp/most-wished-for/electronics/7073960011
- **Movers and Shakers (US):** https://www.amazon.com/gp/movers-and-shakers/electronics/7073960011

### Bookshelf Speakers
- **Best Sellers (US):** https://www.amazon.com/Best-Sellers-Electronics-Bookshelf-Speakers/zgbs/electronics/3241721
- **New Releases (US):** https://www.amazon.com/gp/new-releases/electronics/3241721
- **Most Wished For (US):** https://www.amazon.com/gp/most-wished-for/electronics/3241721

### Consumer Electronics (broad)
- **Best Sellers (US):** https://www.amazon.com/Best-Sellers-Electronics/zgbs/electronics

## Geographic Variants

Swap the domain for the target market. Category node IDs may differ slightly — navigate from the electronics Best Sellers page of each domain to confirm the correct node for audio.

| Market | Domain | Best Sellers Entry |
|---|---|---|
| US | amazon.com | /Best-Sellers-Electronics/zgbs/electronics |
| UK | amazon.co.uk | /Best-Sellers-Electronics/zgbs/electronics |
| CA | amazon.ca | /Best-Sellers-Electronics/zgbs/electronics |
| AU | amazon.com.au | /Best-Sellers-Electronics/zgbs/electronics |
| DE | amazon.de | /Best-Sellers-Elektronik/zgbs/electronics |
| FR | amazon.fr | /Best-Sellers-High-Tech/zgbs/electronics |

For UK and AU specifically: navigate to the electronics home page first, then find Speakers in the left-hand category tree. These domains have slightly different node structures than amazon.com.

## How to Navigate — Step by Step

**Step 1 — Load the Best Sellers page via direct URL:**
Navigate to the category URL above using Playwright MCP. Do not use the search bar. Wait for the page to fully load before extracting data.

**Step 2 — Read the top 20 BSR list:**
Extract for each product: rank, product name, brand, price, rating (stars), review count. This is the real-time market map — who is winning right now at this category.

**Step 3 — Click into the top 5–10 products:**
Navigate to each product page. Extract: BSR (shown under "Product information" or "Additional information"), review count, average rating, price, deal price if active, and any "Best Seller" or "Amazon's Choice" badge.

**Step 4 — Read the review distribution:**
Below the average rating, Amazon shows the percentage breakdown by star level (5★ / 4★ / 3★ / 2★ / 1★). This tells the satisfaction story faster than reading individual reviews. A product with 4.3 stars and 30% 1-star reviews has a serious pain point. A product with 4.5 stars and 5% 1-star reviews is broadly satisfying.

**Step 5 — Mine reviews for buyer language:**
Filter reviews by star level — start with 1-star and 2-star for pain points, then 4-star and 5-star for satisfaction signals and purchase drivers. Use the "Filter by" dropdown to sort by Most Recent within each star level.

**Step 6 — Check Most Wished For and Movers and Shakers:**
Most Wished For = aspirational demand. Products here are wanted but not yet bought — signals desire before conversion. Movers and Shakers = fastest rank-climbing products in the last 24 hours. A product jumping from #85 to #12 in 24 hours is a real signal worth investigating.

## What Each Signal Means

| Signal | What it tells you |
|---|---|
| **BSR #1–5** | Dominant volume sellers at this tier — the default recommendations |
| **BSR #10–50** | Active mid-tier competitors with real traction |
| **BSR #50–100** | Challenger brands with a foothold — watch for design, price, or feature differentiation |
| **Review volume (1,000+)** | Established market presence — buyers are finding and choosing this product |
| **Review volume (50–200)** | Early traction — product is real but not yet a market force |
| **4.0–4.3 stars with high volume** | Competent but has known weaknesses — read 3-star reviews to find the gap |
| **4.5–4.8 stars with high volume** | Category leader — understand exactly why buyers love it |
| **Most Wished For** | Aspirational demand — often reveals what buyers want but can't afford or haven't committed to |
| **Movers and Shakers** | Real-time momentum — often triggered by a viral review, price drop, or press mention |
| **"Amazon's Choice" badge** | Amazon's algorithm recommendation for the keyword — high conversion signal |

## Review Mining Protocol — Four Language Pattern Types

1. **Frustration language (1–2 star):** "stopped working after," "not worth," "returned because," "disappointed" — hardware failures, unmet expectations, connectivity issues, build quality complaints
2. **Satisfaction language (4–5 star):** "exactly what I needed," "sounds better than," "surprised by," "best I've owned" — genuine delight signals and purchase justification language
3. **Comparison language (any star):** "compared to X," "switched from," "better than Y," "not as good as" — competitive switching behaviour and price-tier navigation
4. **Use-case language:** "use it at my desk," "bring it camping," "in the kitchen," "at the office" — real-world use contexts the product is being deployed in

Always extract verbatim quotes. The buyer's exact words are more valuable than a paraphrase. Note the star rating, helpful vote count, and date of each quoted review.

## Pricing Intelligence

- **List price vs. current price:** Amazon shows both when a discount is active. The crossed-out price is the "list price" — often inflated. The current price is the real market price.
- **Deal price:** "Limited-time deal" or "Coupon" tags show promotional pricing. Note both the deal price and the standard price — the gap indicates how aggressively a brand discounts.
- **Price history check:** Navigate to camelcamelcamel.com with the product ASIN appended (e.g., camelcamelcamel.com/product/[ASIN]) for a full price history. This reveals whether the current price is standard or promotional.
- **Street price standard:** Always record the current non-deal price as the street price for competitor profiles. Launch prices become outdated within 6–12 months for most consumer electronics.

## "Customers Also Bought" and "Customers Also Viewed"

- **Also Bought** = actual co-purchase behaviour. Products here are bought together or in sequence — reveals the real purchase context (e.g., a Bluetooth speaker bought alongside a phone stand and desk mat = desk setup buyer)
- **Also Viewed** = consideration set. Products here competed for the same sale — these are the real alternatives buyers evaluated before choosing

Both sections are the most honest competitive intelligence Amazon provides. They are not editorially curated — they are algorithmic patterns from real transactions.

## Bot-Detection Avoidance

- Use Playwright MCP for all Amazon navigation — never direct HTTP requests
- Navigate to one page, allow it to fully load, extract data, then move to the next
- Do not make rapid successive requests — wait for each page to reach network idle before proceeding
- If a CAPTCHA appears: stop, screenshot, report to Jinu. Do not attempt to bypass. Shift to another geographic variant or continue with data already collected
- Navigate via direct category URLs only. Never construct search URLs

## Navigation Rules

- Amazon is fully public — no login required or available for research purposes
- Always record the ASIN (10-character alphanumeric ID in the product URL) for every product profiled — it is the stable identifier across all Amazon domains
- Never use Amazon as a KOL or creator discovery source — it has no creator profiles
- Product page URLs can be shortened to amazon.com/dp/[ASIN] — use this format for source citations
- Date-stamp all BSR and pricing data — Amazon ranks update hourly and prices change daily

## Output This Skill Must Produce When Invoked

**Before research begins:** State which category URL will be used, which geographic variant, and which signals are the primary target (BSR list, review mining, Most Wished For, or Movers and Shakers).

**After extraction:** For each product profiled — ASIN, brand, product name, BSR, review count, average rating, star distribution (if notable), current price, deal price (if active), and at least 2 verbatim review quotes (one frustration, one satisfaction) with star rating and helpful vote count. Source URL format: `Amazon — https://www.amazon.com/dp/[ASIN]`
