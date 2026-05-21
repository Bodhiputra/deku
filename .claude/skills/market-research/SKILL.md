---
name: market-research
description: Full market research methodology — Phase 0 (market scoping and confirmed-markets output), Pass 1 (industry landscape), Pass 2 (market hierarchy and competitive axes), Pass 3 (competitor intelligence with direct product comparison template and KOL candidate spotting). Load before any market research task begins.
---

# Market Research

Load at the start of every market research task. Provides the full execution methodology across four phases — market scoping, industry landscape, market hierarchy, and competitor intelligence.

---

## Phase 0 — Market Scoping

**Purpose:** Identify and rank the correct countries and markets before any other research begins. All downstream research is scoped to these confirmed markets. Output is written to `context/confirmed-markets.md` before any other pass runs.

**Time limit: 10 minutes.** Stop when time is up. Document confirmed markets from what was found. Move on.

**Three research streams (run all three):**

**Stream 1 — Industry-level markets:**
Which countries have the largest market size, strongest growth rate, and most active buyer base for this product category? Sources: industry reports, SEC EDGAR, IPO prospectuses, Google Scholar, Statista, trade publications. Source URL required for every market claim.

**Stream 2 — Product-level markets:**
Which countries show the strongest demand specifically for this product type at this price tier and use case? A country may be a large industry market but have no appetite for this specific product format. Use: Amazon category performance by market, Similarweb competitor traffic by geography, Reddit community geography signals, Google Trends by country.

**Stream 3 — Competitor market signals:**
Where are established brands actually selling, distributing, and spending on marketing? Their geographic footprint is validated demand data. Use: competitor "where to buy" pages, their geo-tagged content, their e-commerce market presence.

**Output — write to Notion and `context/confirmed-markets.md`:**

```
CONFIRMED RESEARCH MARKETS — [Category] — [Date]

TIER 1 — PRIMARY MARKETS (deepest research):
1. [Country] — Industry rank: X | Product demand: High | Competitor presence: Strong
   Strategic rationale: [Two sentences on why this market is Tier 1]

TIER 2 — SECONDARY MARKETS (lighter research):
1. [Country] — Industry rank: X | Product demand: Medium | Competitor presence: Moderate
   Strategic rationale: [Two sentences on why this market is Tier 2]

EXCLUDED MARKETS (and why):
[Country] — [Reason]
```

---

## Pass 1 — Industry Landscape

**Purpose:** Map macro industry trends, emerging niches, category dynamics, and active platform conversations.

**Time limit: 8 minutes. Source cap: 5 primary sources.**

**Research approach:**
- Category overview: what is growing, declining, stable, and emerging right now
- Platform activity map: where is the conversation happening
- Trend signals: Google Trends direction, rising topics in niche communities, new product categories gaining momentum in the last 30–90 days
- Rising terminology: new words and phrases in community conversation signalling shifting buyer priorities

**Platform priority:** Reddit first → web search → Google Trends → YouTube

**Skills to invoke:**
- `/research-primer` — run before anything else. Establishes what is current and what gaps this session must fill.
- `/platform-reddit` — apply Hot sort for established conversation, Rising for fresh momentum.

**Evidence:** Source URL + date for every signal. Flag anything older than 30 days with `[>30 days]`. Geo-tag with specific confirmed market countries.

**Output:** Industry snapshot (4–6 sentences), top emerging trends with evidence and dates, platform activity map, rising terminology, category dynamics.

---

## Pass 2 — Market Hierarchy

**Purpose:** Establish where the brand sits in the market before competitor research begins. Build a proxy-based market map. Produce the competitor shortlist that Pass 3 will research.

**Time limit: 8 minutes. Source cap: 5 primary sources.**

**Research approach:**
- Price tier mapping: organise all brands by price point and feature set using buyer language for tier names
- Community tier descriptions: how do buyers in Reddit and review sites naturally cluster brands?
- Brand placement: where does this brand sit? State confidence level and reasoning.
- Competitive axes: the 2–4 dimensions that define competition at this tier — psychologically grounded

**Skills to invoke:**
- `/marketing-psychology` — after hierarchy map is drafted. Apply anchoring analysis and loss aversion framing. Sharpens axes from descriptive to psychologically grounded.
- `/platform-reddit` — use Reddit community language as the primary tier signal.

**Output:** Market hierarchy map, brand placement with confidence level and reasoning, competitor shortlist for Pass 3, key competitive axes.

---

## Pass 3 — Competitor Intelligence

**Purpose:** Deep competitive intelligence on brands at the brand's exact tier. Build the competitor registry. Flag all KOL candidates spotted during research.

**Output completeness standard. Top 5 competitors only** (prioritised by closest price and product proximity). Every record must have all fields complete. An incomplete record is not written to Notion.

**Five-step research approach:**

**Step 1 — Website and product analysis:**
Headline positioning, tagline, product claims, key features, price points, visual identity, tone of voice.

**Step 2 — Digital presence:**
Similarweb for traffic and channel breakdown. LinkedIn for company size and recent hires. Google News for funding, launches, PR.

**Step 3 — Community perception:**
Reddit (brand and product name searches), X (replies and quote tweets for real-time sentiment), Amazon (listing and review patterns — see Amazon URL rule below), YouTube (how products are reviewed and discussed).

**YouTube competitor channel stats:** use the API script instead of browser navigation:
```
node tools/youtube-kol-data.js @CompetitorChannel
```
API key is in `.env`. Use browser only for observing content quality and format.

**Amazon URL rule:** Never use the Amazon search bar. Use web search to find the direct product listing URL, then navigate directly to that URL.

**Step 4 — Strategic synthesis:**
Per competitor: core strategy, strengths, vulnerabilities, market position.
Cross-competitor: which position is crowded, which is open, most exploitable gap.

**Step 5 — Direct product comparison vs. brand's product:**
Required for every competitor. Goes into the Competitor Registry record.

```
DIRECT COMPARISON — [Competitor Product] vs. [Brand Product]

SPECS:
  [Spec name]       [Competitor value]   [Brand value]   [Who wins + why]
  Price             $XX                  $XX
  [Key specs relevant to this category]

POSITIONING:
  What they claim:  [Their headline/tagline/key message]
  What we claim:    [Brand's positioning for this product]

BRAND STRENGTHS VS. US:
  [What this competitor does better — be honest]

OUR ADVANTAGES OVER THEM:
  [Where the brand's product wins]

WHY A BUYER WOULD CHOOSE THEM:
  [One sentence — honest assessment]

WHY A BUYER WOULD CHOOSE US:
  [One sentence — grounded in actual spec/price/feature difference]
```

**Regional research:** For each confirmed market — identify local brands dominant there, note regional distribution strength of global brands, capture local pricing in target market currency.

**Skills to invoke:**
- `/platform-reddit` — for community perception pass. Apply VOC extraction protocol.

**KOL Candidates Spotted — required output from Pass 3:**
During competitor research, flag every creator found reviewing, featuring, or discussing competitors. This is not optional.

For each creator spotted:
```
KOL CANDIDATE SPOTTED
Handle/Channel: [name and platform URL]
Platform: [YouTube / Instagram / X / Reddit]
Found via: [which competitor's content/community]
Context: [what they were doing]
Follower/subscriber count: [if visible]
Content quality impression: [High / Medium / Low — one sentence]
Why relevant: [one sentence connecting to brand's content directions]
```

Compile this list at the end of Pass 3. These become the warm-lead starting point for any KOL discovery task — start here before independent discovery begins.

**Evidence:** Source URL for every claim. "Source Name — [URL]" format. Website URL required for every competitor record. Country tagged per competitor — specific country, never region.

**Output:**
1. Competitor registry (every record includes website URL + direct product comparison)
2. Per-competitor cards
3. Competitive landscape summary and most exploitable gap
4. KOL Candidates list — named, with platform URLs
