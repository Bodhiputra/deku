---
name: source-intake
description: Ingest owner-provided data into Senku's knowledge bank — spec sheets, URLs, pasted text, local files, and product pages. Extracts labeled facts and writes structured markdown units. Load whenever the brand owner gives Senku material to learn from.
---

# Source Intake

Requires: `knowledge-bank-standards`.

Processes **owner-provided** inputs before or instead of open web research.

## When to Invoke

- Owner shares a URL: *"read this spec page"*
- Owner pastes text: datasheet excerpt, supplier email, meeting notes
- Owner points to a local file: PDF, markdown, CSV in the workspace
- Owner uploads product documentation for Senku to learn (factory BOMs, QC sheets, internal spec docs)
- Owner says: *"learn from this"*, *"add this to the bank"*, *"here's our spec sheet"*, *"here's the FBS factory doc"*

## Step 1 — Identify the Source

| Input type | Action |
|---|---|
| URL | Fetch via Playwright or web fetch; confirm page loads |
| Local file path | Read file from workspace; respect `.gitignore` and secrets |
| Pasted text | Treat as primary source; ask owner for origin if unclear |
| Multiple sources | Process one at a time; cross-link in bank |

Ask if ambiguous: *"Should I treat this as about [product/topic X]?"*

## Step 2 — Extract (do not summarize loosely)

Extract:

- Measurable specs (dimensions, dB, mAh, IP rating, codec list)
- Named standards referenced (Bluetooth 5.x, IEC, etc.)
- Product category claims — label as **Practice** unless spec-backed
- Glossary terms new to the bank

**Do not** import marketing adjectives as **Fact** without a test or spec behind them.

## Step 3 — Label and Attribute

Every extract gets:

```markdown
**Fact:** ... 
**Source:** Owner-provided | [filename or URL] | YYYY-MM-DD
```

Owner-provided facts are valid bank content — same write standards as web research.

If owner data conflicts with web research later, note both in file **Changelog** — do not silently overwrite.

## Step 4 — Write to Bank

Via `knowledge-bank-build`:

- New subject → `topics/<topic-slug>.md`
- Product-type info → `products/<product-type-slug>.md`
- Brand SKU / factory doc → `products/<sku-slug>.md` (e.g. `fbs.md`, `fbb.md`)
- Append to `brand-overlay.md` if brand-specific summary across SKUs

Update INDEX: list source under topic entry.

## Step 5 — Confirm with Owner

Short confirmation:

- What was extracted (bullet list)
- Where it was saved
- Anything unclear or conflicting in the source
- Offer web research to verify or expand owner-provided claims

## Boundaries

- Do not ingest `.env`, credentials, or private customer data unless owner explicitly scopes it
- Do not push owner files to Notion or git — bank stays local markdown
- Strategy interpretation of specs → note as **Inference**; GTM implications → hand off to Jinu
