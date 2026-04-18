---
name: platform-shopee
description: Teaches research agents how to use Shopee as a market intelligence platform for Southeast Asia — Best Sellers and Mall navigation, sold count and rating as real sales signal, review mining for buyer language in SG, PH, and MY, pricing and flash sale intelligence, and how Shopee's social commerce features (live, video) signal emerging product demand. Used by Market Intelligence Agent, Buyer Intelligence Agent, Retailer B2B Agent, and KOL Tracker for SEA-market research.
---

# Platform Shopee

Invoke before any Shopee research session begins. Shopee is the dominant e-commerce platform in Southeast Asia — 46.9% market share across the region in 2025. For Finecoustic's Tier 2 markets (SG, PH, MY), Shopee is the primary purchase channel and the most reliable signal for what is actually selling, at what price, and what real buyers in these markets say about it.

Shopee is not the same as Amazon. It is social commerce first — live streams, video reviews, flash sales, and seller chat are core to how buyers discover and evaluate products. Market research on Shopee requires reading these signals alongside traditional rank and review data.

## When to Invoke

- Before researching competitor products, pricing, or market traction in SG, PH, or MY
- When validating which brands and price points are actually winning in SEA at a given category
- When mining buyer language, pain points, and satisfaction signals from Shopee reviews
- When checking flash sale pricing and promotional behaviour of competitors
- When identifying Shopee Mall vs. third-party seller presence for a brand
- When Retailer B2B Agent is researching distribution opportunities in SEA

## Geographic Variants

| Market | Domain | Language |
|---|---|---|
| Singapore | shopee.sg | English (primary) |
| Philippines | shopee.ph | English + Filipino |
| Malaysia | shopee.com.my | English + Malay |

Research each market separately — pricing, top sellers, and consumer sentiment differ significantly by country even within SEA. SG buyers are more price-insensitive and design-sensitive. PH buyers are highly price-sensitive and respond strongly to bundle deals. MY buyers sit in between with strong Malay-language community signals.

## Navigation Approach — No Login Required for Basic Research

Shopee's product pages, search results, and seller profiles are publicly accessible without login for basic research. However, some features (flash sale prices, full review text on older reviews) may prompt a login modal. If a login prompt appears: screenshot the page content visible before the modal, record what was accessible, and continue with data already collected.

Use **Playwright MCP** for Shopee — it is a fully public site requiring no login. If Playwright hits a CAPTCHA or blank page (Shopee has aggressive bot detection on some regions), fall back immediately to Chrome DevTools MCP, which uses the user's existing Chrome session and handles Shopee's SPA rendering more reliably.

## How to Navigate — Step by Step

**Step 1 — Navigate to the category page:**
Go to the relevant domain and navigate via the category tree in the left sidebar — Electronics → Audio → Portable Speakers (or Bookshelf Speakers). Do not use the search bar for category-level research.

**Step 2 — Sort by Top Sales:**
On any category or search results page, sort by "Top Sales" — not "Relevance" or "Latest." Top Sales = actual transaction volume. This is the equivalent of Amazon's BSR.

**Step 3 — Read the top 20 products:**
Extract for each: product name, brand, price, sold count (shown as "X sold" below the price), rating, review count, and whether it carries the "Shopee Mall" badge.

**Step 4 — Check Shopee Mall vs. third-party:**
Shopee Mall = brand-operated or officially authorised sellers. These are the most reliable competitive intelligence targets — pricing, product copy, and images reflect the brand's own positioning. Third-party sellers may have different pricing, bundle configurations, and older inventory.

**Step 5 — Navigate into top products:**
Click each product. Extract: sold count (total lifetime), rating, review count, current price, original price (if discounted), flash sale price (if active), variants available, and shipping options.

**Step 6 — Mine reviews:**
Filter by "With Media" first — reviews with photos or videos show real product use contexts. Then filter by star level — 1-star and 2-star for pain points, 4-star and 5-star for satisfaction language. Shopee reviews are often shorter than Amazon reviews but more emotionally direct.

## What Each Signal Means

| Signal | What it tells you |
|---|---|
| **"X sold" count (1,000+)** | Established market traction in SEA at this price tier |
| **"X sold" count (100–500)** | Early traction — product is being tried but not yet dominant |
| **Shopee Mall badge** | Brand has official presence — the price and product are authoritative |
| **High sold count + low review count** | Buyers are buying but not reviewing — neutral satisfaction or low engagement |
| **Flash sale pricing** | How aggressively the brand discounts — tells you the real floor price |
| **Bundle deals** | Common in PH and MY — "buy 2 get X" signals price-sensitive market behaviour |
| **4.8–5.0 stars with high volume** | Community favourite — read the reviews to understand exactly why |
| **Below 4.5 stars with high volume** | High sales despite quality issues — price is overriding satisfaction concerns |

## Pricing Intelligence

- **Original price vs. current price:** Shopee almost always shows a crossed-out "original price" alongside the deal price. Treat the crossed-out price with scepticism — it is often inflated to make the discount appear larger.
- **Flash sale price:** Time-limited deep discounts. Note the flash price separately — it is not the street price.
- **Street price standard:** The standard (non-flash) current price is the working street price for competitor profiles.
- **Cross-market price comparison:** The same product often prices differently across SG, PH, and MY. Always check all three domains for a complete SEA pricing picture.
- **Currency reference:** SG = SGD, PH = PHP, MY = MYR. Always note the currency and convert to USD for cross-market comparison when documenting in Notion.

## Review Mining Protocol — SEA-Specific Language Patterns

SEA buyers write reviews differently from US/UK buyers. Key patterns:

1. **Value framing:** "sulit" (Filipino — value for money), "berbaloi" (Malay — worth it) — these are satisfaction signals even when mixed with minor complaints. A buyer who says "sulit, good quality for this price" is a satisfied customer.
2. **Comparison to expectation:** "better than expected," "as described," "exactly like the photo" — SEA buyers frequently mention whether the product matched the listing. Mismatch = negative review trigger.
3. **Shipping and packaging mentions:** SEA reviews frequently mention packaging quality and delivery speed alongside product quality. Separate product signal from logistics signal.
4. **Sound quality language in English:** "makulog" (Filipino — loud), "malinaw" (Filipino — clear), "bass malakas" (Filipino — strong bass) — useful for audio product research in PH. Fall back to English reviews if language barrier limits extraction.
5. **Social proof references:** "nakita sa live" (Filipino — saw it on live stream), "recommended by" — Shopee live streams drive purchase decisions in PH and MY. If a product has high sold count and many reviews mentioning a live stream, it has active social commerce momentum.

## Shopee Live and Video Reviews

Shopee Live and product video reviews are signals that Amazon does not have equivalents for. Products with active Shopee Live sessions have real marketing momentum in the SEA market. When navigating a product page:

- Check if there is a "Watch" or live stream section — active live = brand is investing in SEA social commerce
- Video reviews (short clips submitted by buyers) show real product use in real SEA home environments — more authentic than written reviews for lifestyle context
- High video review count = engaged buyer community — these buyers are advocates

## Shopee Mall — B2B Signal

For Retailer B2B Agent: Shopee Mall presence confirms a brand has an official SEA e-commerce operation. Cross-reference every competitor found on Shopee against the B2B Partners database. A brand operating Shopee Mall is already invested in SEA distribution — this tells you the competitive distribution landscape in the region.

If a brand is NOT on Shopee Mall but appears through third-party sellers: the brand has SEA market presence via grey market or resellers but no direct DTC commitment. This is a distribution gap signal — the market wants the product but the brand hasn't formalised its SEA channel.

## Bot-Detection and Navigation Rules

- Use Playwright MCP as primary — Shopee is public, no login required
- If Playwright returns a blank page or CAPTCHA: switch immediately to Chrome DevTools MCP, do not retry Playwright
- Never use isolatedContext with Chrome DevTools MCP — it strips the session
- Navigate one page at a time, allow full load before extracting
- If a login modal appears on any feature: record visible data, screenshot, and note what was and wasn't accessible. Do not attempt to bypass

## Navigation Rules

- Shopee is fully public for product page browsing — no login required for basic research
- Always note the domain (shopee.sg / shopee.ph / shopee.com.my) on every finding
- Geo-tag every finding to a specific country — not "SEA" broadly
- All Notion documentation in English regardless of source language
- Source URL format: `Shopee [Market] — [full product URL]`
- Sold counts are lifetime totals — they do not reset. A product with 5,000 sold that launched 3 years ago has different momentum than one with 5,000 sold that launched 3 months ago. Check the listing date when possible.

## Output This Skill Must Produce When Invoked

**Before research begins:** State which Shopee domain(s) will be used, which category sort (Top Sales), and which signal is the primary target (BSR equivalent, review mining, pricing, Mall presence).

**After extraction:** For each product profiled — brand, product name, sold count, rating, review count, current price, original price (if discounted), Shopee Mall status (yes/no), market (SG/PH/MY), and at least 2 verbatim review quotes (one frustration, one satisfaction) with star rating. Source URL format: `Shopee [SG/PH/MY] — [URL]`
