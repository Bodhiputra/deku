---
name: industry-onboarding
description: First-session industry assignment for a brand — identifies the primary industry vertical, scaffolds the local knowledge bank from _template, writes context/industry-context.md, and sets bank maturity to seeded. Load before Senku's first work with any brand or when the brand enters a new industry.
---

# Industry Onboarding

Requires: `knowledge-bank-standards`.

Assigns one primary industry vertical per brand. Senku stays brand-agnostic in method; the assignment is brand-specific.

## When to Run

- `context/industry-context.md` is missing
- Brand owner says "learn my industry" or "onboard industry" with no prior assignment
- Brand pivots to a new primary industry (confirm before overwriting)

## Step 1 — Confirm Scope (ask, never assume)

Ask the brand owner (plain language):

1. **What industry or product category defines your business?** (e.g. "portable Bluetooth speakers", "B2B payroll SaaS", "specialty coffee retail")
2. **Physical products, services, or both?**
3. **Depth preference for first session:** overview only, or start building the bank immediately?

If `context/brand-context.md` exists, state what you infer and ask for confirmation — do not proceed on inference alone.

## Step 2 — Define Slugs

| Field | Rule | Example (Finecoustic) |
|---|---|---|
| `brand_slug` | lowercase, hyphenated | `finecoustic` |
| `industry_slug` | lowercase, hyphenated, 2–4 words | `consumer-portable-audio` |
| `industry_label` | Human-readable | `Consumer Portable Audio` |

## Step 3 — Scaffold Bank

1. Copy `knowledge-bank/_template/` → `knowledge-bank/brands/<brand_slug>/<industry_slug>/`
2. Edit root `INDEX.md`: set industry name, maturity `seeded`, list all modules as `not started`
3. Edit `industry-overview.md`: write Scope + placeholder Summary — mark sections `[TO BUILD]`
4. Create `brand-overlay.md` stub linking to `context/brand-context.md` facts (product names only — no strategy)

## Step 4 — Write industry-context.md

Create `context/industry-context.md` using schema in `knowledge-bank-standards`.

## Step 5 — Deliver Onboarding Summary

Tell the owner:

- Industry assigned (slug + label)
- Bank path on disk
- Maturity: `seeded`
- Recommended next step: *"Senku, research [topic]"*, *"Senku, learn from [your spec/URL]"*, or optional *"Senku, bootstrap the bank"*

## Output Checklist

- [ ] Owner confirmed industry scope
- [ ] Bank directory exists and INDEX populated
- [ ] `context/industry-context.md` written
- [ ] `session-context.md` Active Thread updated
- [ ] No Notion, Figma, or ops writes

## Handoff Hints

After onboarding, if owner asks about buyers or competitors → suggest **Jinu**.  
If owner asks about specs for a purchase order → suggest **Koji** after Senku explains the spec.
