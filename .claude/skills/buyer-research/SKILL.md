---
name: buyer-research
description: Full buyer research methodology using the STP framework — Pass 1 builds evidence-backed buyer personas (segmentation, targeting, positioning input), Pass 2 maps consumer signals across positive, negative, and mixed sentiment. Load before any buyer research task begins.
---

# Buyer Research

Load at the start of every buyer research task. Provides the full STP methodology for persona building and the consumer signals framework for mapping buyer sentiment.

---

## Pass 1 — Buyer Personas (STP Framework)

**Purpose:** Build evidence-backed buyer profiles using the full STP framework. Real people with motivations, vocabulary, frustrations, and decision triggers — not demographic summaries.

**Output completeness standard. Minimum 3 buyer personas**, each with all STP sections complete. Cap at 5 sources per persona. An incomplete persona is not written to Notion.

**STP methodology — applied in three steps:**

### Segmentation

Divide the total market into distinct buyer groups based on four dimensions:

- **Demographics:** who they are (age, career, gender, income, life stage)
- **Geography:** where they are (confirmed markets from confirmed-markets.md, specific countries)
- **Behavioral:** how they buy (research process, platforms used in what order, decision triggers, purchase frequency, what they compare before buying)
- **Psychographic:** what drives them (values, lifestyle, identity, aspirations, what owning this product means to them)

Segments must be: measurable (size can be estimated), accessible (brand can reach them), substantial (large enough to be profitable), and actionable (brand can create a competitive advantage within the segment).

### Targeting

Evaluate each segment against three criteria:
- **Size:** is this segment large enough to generate meaningful revenue?
- **Profitability:** does CLV and conversion potential justify acquisition cost?
- **Accessibility:** can the brand realistically reach and serve this segment with current resources?

Select the primary target segment and rank secondary segments explicitly. State why each was selected and why others were deprioritised. Targeting everyone is targeting no one.

### Positioning Input

For each target segment, identify:
- What unique value proposition would resonate with this specific group
- Why this group would choose this brand over the specific alternatives they consider
- What messaging frame maps to their psychographic profile and purchase triggers

This feeds the positioning task — it is the raw segment-level insight that makes precise positioning possible, not the final positioning itself.

---

**Platform research priority:**
Reddit first (authentic self-description, primary for all markets). Amazon 3–4 star verified reviews (purchase-moment language — not 1-star which is extreme regret, not 5-star which is pure praise). YouTube comment sections (pre-purchase research behaviour). Competitor social comments (self-descriptions from real buyers in their own language).

**Amazon URL rule:** Never use the Amazon search bar. Use web search to find the direct product listing URL, then navigate directly to that URL.

**Native language research:** When scoped to a specific market, apply the relevant native language to search queries and scraping. Fall back to English silently if needed. All Notion documentation in English.

**Skills to invoke:**
- `/research-primer` — run at the very start before any platform research. Checks what buyer research already exists in Notion. Prevents duplicating prior work.
- `/customer-research` — invoke before any platform research begins. Feed it: brand category, buyer tier (price point + product type), competitor registry. Use it to generate the Reddit mining approach — subreddits to target, query patterns, review sources to hit. Ensures mining for segmentation, targeting, and positioning signals — not just complaints.
- `/platform-reddit` — primary extraction platform. Apply: correct subreddit selection methodology (category subreddits > general interest subreddits, country/city subreddits for geo-specific research), Best comment sort within threads, full VOC extraction protocol. Top sort (last 30 days) for highest-validated sentiment.
- `/buyer-signal-extractor` — invoke after raw data collection from all platforms. Structured extraction protocol: recurring language patterns (phrases appearing in 3+ sources), emotional intensity signals, moment-of-frustration framing, unmet expectation language. Output: verbatim language map — actual phrases the brand can use in copy, not paraphrases.

**Evidence:** Source URL for every persona claim. "Source Name — [URL]" format. Geo-tag personas with specific countries only — never regions, never city/state. Language map stays verbatim — do not paraphrase buyer quotes.

**Output:** Segment map, primary persona (full STP detail, country tags), secondary personas (full STP detail, country tags), verbatim language map, platform map (where each persona spends time and in what context).

---

## Pass 2 — Consumer Signals

**Purpose:** Build the consumer signals database — positive, negative, and mixed sentiment — that feeds positioning, content strategy, and ad copy.

**Output completeness standard. Minimum 15 consumer signal records, at least 5 per sentiment type** (positive / negative / mixed). Cap at 3 subreddits for Reddit research. All records must have source URL, verbatim quote, and country tag — incomplete records are not written to Notion.

**Three sentiment types:**

### Negative Signals (pain points + brand solution mapping)

Specific frustrations, unmet needs, deal-breakers, and regret statements. For each signal capture: exact complaint in buyer's own words, frequency (how many people express this across sources), emotional intensity (high/medium/low based on language strength), addressability (can this brand's product solve it — and specifically how), and the product feature or positioning territory that maps to the solution.

Search patterns that surface negative signals: `"[product] problem"`, `"disappointed with"`, `"returned because"`, `"wish it had"`, `"what I hate about"`, `"broke after [timeframe]"`, `"looking for something better than"`, `"considering switching"`.

### Positive Signals

What buyers love, what they recommend unprompted, what keeps them loyal, what they brag about to others, what surprised them pleasantly. These feed positioning (what the brand can credibly claim) and content strategy (what resonates with happy buyers and triggers word-of-mouth).

### Mixed Signals

Contested territory — things buyers feel ambivalent about, where the community is genuinely split, or where satisfaction varies significantly by segment or use case. Mixed signals often reveal the most interesting positioning opportunities — contested territory that competitors haven't resolved.

---

**Platform priority:**
Reddit first (Rising sort for fresh momentum, Top last 30 days for validated signals, Controversial sort for mixed/contested territory). Amazon 2–3 star verified reviews for negative signals. YouTube comments for mixed signals and post-purchase validation language.

**Skills to invoke:**
- `/platform-reddit` — apply correct sort per signal type: Rising for fresh momentum, Top (last 30 days) for most-validated sentiment, Controversial for contested/mixed signals. Full VOC extraction protocol on comment sections.
- `/customer-research` — feed it persona cards from Pass 1 and generate specific Reddit + review mining queries tailored to each persona's context and platform.
- `/buyer-signal-extractor` — invoke after raw data collection. Runs: recurring pain pattern identification (frequency count per theme), emotional intensity ranking, addressability assessment, exact complaint and praise language extraction.

**Evidence:** Source URL for every signal record. Geo-tag with specific country when identifiable. Verbatim quotes stay raw — do not paraphrase the language map.

**Database:** All output goes to the Consumer Signals & Pain Points database. Sentiment field required on every record: Positive / Negative / Mixed. Every negative record includes: pain theme, frequency, emotional intensity, addressability, how the brand's product addresses it (specific — not generic), verbatim quote, source URL, date, country.

**Output:** Consumer signals database populated with all three sentiment types. Verbatim language map organised by sentiment type. Addressability assessment for negative signals — which pains are winnable for this brand's tier and how.
