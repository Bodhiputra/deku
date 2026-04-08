---
name: market-sizing-model
description: Structured quantitative framework for calculating TAM, SAM, and SOM using both top-down and bottom-up methodologies. Enforces full formula transparency, source citation, assumption documentation, and reconciliation between the two models. Used by the Market Sizing Agent in marketing research runs.
---

# Market Sizing Model

Invoke at the start of every Market Sizing Agent session, before building any numbers. This skill provides the full modeling framework — top-down and bottom-up — that must both run independently before reconciliation. Numbers without formulas are not acceptable output.

---

## Core Rule

Every number in the output must show its full calculation path. Final figures without step-by-step formulas are rejected. Every input data point requires: source name, source URL, data year, and any assumption applied to derive the figure used.

---

## Model 1 — Top-Down

Start from the broadest credible industry figure and apply filters sequentially until you reach the brand-addressable slice. Each filter step must be documented with its own source and reasoning.

**Step 1 — Total industry revenue (TAM base):**
Find the most recent total market size figure for the product category. Acceptable sources (in priority order):
- SEC EDGAR S-1 filings from public companies in the category — market size claims in the "Industry" or "Market Opportunity" section are cited from third-party research and include methodology
- IPO prospectuses — same as above
- Industry association annual reports (e.g., Consumer Electronics Association, Audio Engineering Society)
- Google Scholar — academic market studies with methodology section
- Statista — use only when primary sources are unavailable; note the date and underlying research firm

Record: figure, source name, source URL, data year, original currency.

**Step 2 — Geography filter (TAM → addressable geography):**
Apply the confirmed market list from Pass 0. For each country, find its share of the global or regional market. Sources:
- Statista country-level breakdowns
- Euromonitor / Grand View Research regional splits
- Competitor "where to buy" pages as a proxy (if a brand sells in 8 countries, those 8 represent validated demand geography)

Formula: `Global TAM × [Country A share %] + [Country B share %] + ... = Geographic TAM`

State each country's share as a sourced figure or a reasoned estimate with confidence level.

**Step 3 — Product format / price tier filter (Geographic TAM → relevant segment):**
The full category market includes price tiers, product formats, and use cases the brand does not compete in. Filter to the brand's specific segment.

Example: total headphone market → wireless only → under $150 price tier → consumer (not professional)

Each filter requires: the % applied, the source or reasoning for that %, and confidence level (High / Medium / Low).

Formula: `Geographic TAM × [Format filter %] × [Price tier filter %] × [Use case filter %] = SAM`

**Step 4 — Brand-addressable slice (SAM → brand SAM):**
If the brand has distribution constraints (e-commerce only, specific channels, limited countries), apply a final distribution filter.

Formula: `SAM × [Distribution reach %] = Brand-addressable SAM`

Document the distribution reach assumption explicitly — where is it pulled from (brand-context.md, competitor comparison, industry standard)?

---

## Model 2 — Bottom-Up

Count real buyers independently of the top-down figure. Three validation proxies — use all three and average or triangulate.

**Proxy 1 — Amazon review velocity:**
Amazon reviews represent approximately 1–3% of total buyers (Amazon's own published estimate: ~1–2%). Use the most credible estimate with stated confidence.

Method:
1. Find the best-selling product in the category on Amazon for each confirmed market
2. Count total reviews and the product's launch date → calculate reviews per month
3. Apply the inverse review rate: `Monthly reviews ÷ review rate % = Monthly buyers`
4. Scale to annual: `Monthly buyers × 12 = Annual buyers (Amazon channel)`
5. Apply Amazon's market share for the category and geography → gross up to full market

Formula: `(Amazon monthly reviews ÷ 0.02) × 12 ÷ [Amazon channel share %] = Annual addressable buyers`

State the review rate assumption and Amazon channel share figure with their sources.

**Proxy 2 — Similarweb competitor traffic:**
Use Similarweb to get monthly unique visitors for the top 2–3 competitors' websites.

Method:
1. Pull monthly visits for each competitor (Similarweb free tier shows rounded figures — note this limitation)
2. Estimate site-to-purchase conversion rate for e-commerce in this category (industry standard: 1–3%; use 1.5% as conservative default unless a better source exists)
3. Calculate implied monthly buyers per competitor
4. Sum across competitors, then apply a market coverage factor (the top 3 competitors' combined share of the total market — estimated from their relative traffic)

Formula: `[Competitor 1 monthly visits × conversion rate] + [Competitor 2 × rate] + ... ÷ [top-3 market share %] = Market-wide monthly buyers`

Annual: `Monthly buyers × 12`

**Proxy 3 — Meta Audience Insights:**
Use Meta Audience Insights (or Ads Manager audience size tool) to estimate the addressable audience that matches the buyer persona in the confirmed markets.

Method:
1. In Ads Manager → Audiences → Create Audience → Detailed Targeting
2. Enter: confirmed market countries, age range from buyer persona, interest categories matching the product (e.g. "headphones", "audio equipment", "music production")
3. Record the estimated audience size Meta returns
4. Apply a purchase intent filter: not all people interested in a category are active buyers. Use 5–10% as the annual active buyer estimate (conservative) — state this assumption explicitly

Formula: `Meta audience size × [purchase intent rate %] = Estimated annual addressable buyers`

**Bottom-up buyer count synthesis:**
Average the three proxy estimates or weight them by confidence. Document why each was weighted as it was. Multiply by average selling price for the brand's tier.

Formula: `Weighted average annual buyers × [Average selling price] = Bottom-up revenue estimate`

---

## Reconciliation

Run both models independently before comparing. Never let one model's output influence the other's inputs.

**Reconciliation table format:**
```
MODEL              | FIGURE      | CONFIDENCE
Top-down TAM       | $X          | [Source quality]
Top-down SAM       | $X          | [Filter confidence]
Bottom-up estimate | $X          | [Proxy quality]
Delta              | [%]         | [Explanation]
```

**How to interpret the delta:**
- Delta < 20%: models are converging — the figure is credible. Use the average.
- Delta 20–50%: meaningful gap — investigate which filter or proxy is the likely outlier. State which model you weight more and why.
- Delta > 50%: one model has a structural problem — identify it. Common causes: top-down filter too aggressive (SAM too narrow), bottom-up proxy source is unrepresentative (one competitor is atypical), or review rate assumption is wrong for this category.

The reconciliation note is a required output section. An unexplained delta is a finding, not an error to hide.

---

## SOM — Realistic Capture Rate

New entrant benchmarks by category and channel (use the closest comparable):

| Brand stage | Channel | Year 1 SOM | Year 2 SOM |
|---|---|---|---|
| Pre-launch, e-commerce only | Direct-to-consumer | 0.01–0.05% of SAM | 0.05–0.2% of SAM |
| Early traction (<$1M ARR) | E-commerce + 1–2 retail partners | 0.05–0.2% | 0.2–0.5% |
| Growing brand ($1M–$5M ARR) | Multi-channel | 0.2–0.5% | 0.5–1.5% |

Source for benchmarks: state which comparable brand or public filing informed each benchmark. Do not use these ranges without naming a real comparable.

**SOM formula:**
`SAM × [capture rate %] = SOM`

State: which comparable brand informed the capture rate, what would need to be true for the upside scenario, what would need to be true for the downside scenario.

---

## Evidence Standards

Every figure in the output must have all four fields populated:

| Field | Requirement |
|---|---|
| Source name | Full name of the publication, report, or platform |
| Source URL | Direct URL — "Source Name — [URL]" format |
| Data year | The year the underlying data was collected (not the publication year) |
| Assumption | Any calculation applied to transform the raw figure into the one used |

A figure with a missing URL is invalid and must be flagged. Do not present a number as sourced unless the URL is confirmed working.

---

## Output Format

Every Market Sizing output must follow this structure:

```
MARKET SIZING — [Category] — [Date]

TOP-DOWN MODEL
  TAM: $[X] — [Source — URL] — [Data year]
    Formula: [Industry figure] = $[X]
  
  Geographic SAM: $[X]
    Formula: $[TAM] × [Country A %] + [Country B %] = $[X]
    Filter sources: [source per country]
  
  Segment SAM: $[X]
    Formula: $[Geo SAM] × [format %] × [price tier %] = $[X]
    Filter sources: [source + confidence per filter]
  
  Brand SAM: $[X]
    Formula: $[Segment SAM] × [distribution %] = $[X]
    Distribution assumption: [stated]

BOTTOM-UP MODEL
  Proxy 1 — Amazon review velocity:
    Formula: ([reviews/month] ÷ [rate]) × 12 ÷ [channel share] = [buyers/year]
    Annual revenue: [buyers] × $[ASP] = $[X]
    Source: [Amazon listing URL] — [date pulled]
  
  Proxy 2 — Similarweb traffic:
    Formula: ([visits] × [conversion]) + ... ÷ [market share] × 12 = [buyers/year]
    Annual revenue: [buyers] × $[ASP] = $[X]
    Source: Similarweb — [competitor URLs] — [date pulled]
  
  Proxy 3 — Meta Audience Insights:
    Formula: [audience size] × [intent rate] × $[ASP] = $[X]
    Source: Meta Ads Manager — [audience parameters stated] — [date pulled]
  
  Bottom-up synthesis: $[X] (weighted average, weights stated)

RECONCILIATION
  Top-down SAM: $[X]
  Bottom-up estimate: $[X]
  Delta: [%] — [explanation]
  Accepted figure: $[X] — [reasoning]

SOM
  Year 1: $[X] ([capture rate %] of SAM)
  Year 2: $[X] ([capture rate %] of SAM)
  Comparable used: [brand name — source URL]
  Upside condition: [what would need to be true]
  Downside condition: [what would need to be true]
  Confidence: High / Medium / Low

STRATEGIC INTERPRETATION
  Is this market big enough? [One paragraph — minimum viable share for brand profitability]
  Year 1 revenue implication: [SOM translated to revenue]
  Year 2 revenue implication: [SOM translated to revenue]
```

Run `/humanizer` on the Strategic Interpretation section only. All formulas, figures, and tables stay as-is.
