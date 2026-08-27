---
name: knowledge-bank-standards
description: Global data standards for Senku's knowledge bank — directory schema, markdown unit format, INDEX rules, freshness policy, and write verification. Load before any knowledge bank read or write, regardless of brand or industry.
disable-model-invocation: true
---

# Knowledge Bank Standards

Load this skill before reading or writing any knowledge bank file. All other Senku skills depend on these standards.

## File Locations

```
knowledge-bank/_template/                              # committed scaffold (copy, do not edit in place)
knowledge-bank/brands/<brand-slug>/<industry-slug>/    # brand bank (gitignored)
context/industry-context.md                            # active industry assignment (gitignored)
context/industry-context.example.md                    # committed template
```

**Git policy:** Only `_template/`, `README.md`, and `industry-context.example.md` are committed. All brand bank content stays local.

## Directory Schema

Every industry bank uses this structure (copy from `_template/`):

```
<industry-slug>/
├── INDEX.md                 # master map — required
├── industry-overview.md     # optional bootstrap
├── glossary.md              # optional bootstrap
├── products/                # product types and subcategories
│   └── INDEX.md
├── topics/                  # main growth surface — one file per subject
│   └── INDEX.md
├── brand-overlay.md         # brand SKUs/specs on top of industry (optional)
├── supply-chain/            # DEFERRED — create only if owner asks
└── regulatory/              # DEFERRED — create only if owner asks
```

For **services** industries, use `products/` for service categories and `topics/` for delivery/pricing subjects.

**Default for product brands (e.g. audio):** grow `topics/` and `products/` from owner data + internet research. Do not pre-create supply-chain or regulatory folders.

## Markdown Unit Format

Every knowledge file starts with this header block:

```markdown
---
industry: <industry-slug>
module: <module-path>
updated: YYYY-MM-DD
freshness: current | review-due | stale
---

# <Title>

## Scope
One paragraph: what this file covers and what it excludes.

## Summary
Executive summary — 3–5 sentences a brand owner can read without the rest.

## Content
(Facts, standards, practices — labeled per department manual)

## Sources
| Claim type | Source | URL | Date visited |
|---|---|---|---|
| Fact | ... | ... | ... |
```

## Claim Labeling Inside Content

Use inline labels in the Content section:

```markdown
**Fact:** Bluetooth 5.3 adds LE Audio capability. (Bluetooth SIG, 2024)
**Standard:** IPX4 = splash resistance per IEC 60529.
**Practice:** Premium portable speakers often spec 20h+ battery at 50% volume.
**Inference:** At this price tier, buyers rarely distinguish aptX HD from LDAC in blind tests — validation needed per market.
```

**Inference never appears in Summary** unless explicitly marked.

## INDEX.md Rules

Every `INDEX.md` must contain:

1. Industry slug and human-readable name
2. Bank maturity level (`seeded` | `building` | `operational` | `mature`)
3. Module list with one-line description and last-updated date per module
4. **Gaps** section — topics the owner has asked about that are not yet written
5. **Suggested next topics** — from INDEX Gaps or owner interest

## Write Rules

1. Update parent `INDEX.md` whenever a new file or folder is created.
2. Update `context/industry-context.md` `bank_maturity` when crossing a maturity threshold.
3. Set `meta.updated_at` equivalent via file header `updated:` field on every save.
4. Never duplicate content across files — link with relative paths instead.
5. After bulk write: verify all internal links resolve and INDEX lists new files.
6. Prefer one focused file (500–1500 words) over one mega-file.

## Freshness Policy

| Topic class | Re-verify if older than |
|---|---|
| Wireless protocols, chipsets, codecs | 90 days |
| Regulations and certifications | 180 days |
| Manufacturing/supply chain patterns | 365 days |
| Fundamental physics/acoustics | Stable — note standard edition date |

Set `freshness: review-due` in header when threshold exceeded.

## industry-context.md Schema

```markdown
# Industry Context — <Brand Name>

brand_slug: finecoustic
industry_slug: consumer-portable-audio
industry_label: Consumer Portable Audio
bank_path: knowledge-bank/brands/finecoustic/consumer-portable-audio/
bank_maturity: seeded
assigned_date: YYYY-MM-DD
last_deep_dive: null
notes: |
  Optional freeform notes.
```

## Reconciliation Checklist (after any write session)

- [ ] File header complete (industry, module, updated, freshness)
- [ ] Every **Fact** and **Standard** has a Sources table row
- [ ] INDEX.md updated
- [ ] No strategy or GTM recommendations in bank content
- [ ] `context/industry-context.md` maturity accurate

## References

- Department manual: `.claude/departments/intelligence.md`
- Template tree: `knowledge-bank/_template/`
