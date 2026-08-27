---
name: industry-deep-dive
description: Topic-based industry learning for Senku — bootstrap overview once, then build the knowledge bank from owner-provided sources and internet research on whatever product subjects matter. No fixed pass sequence; supply chain and regulatory are deferred unless the owner asks.
---

# Industry Deep Dive

Requires: `knowledge-bank-standards`, `industry-onboarding` (must be complete).

Senku learns **what the owner needs**, not a fixed curriculum. Two input modes:

1. **Owner-provided** — spec sheets, URLs, PDFs, pasted notes, product pages (`source-intake`)
2. **Internet research** — web search, Playwright, Reddit (`domain-research`)

Both write to the same markdown knowledge bank via `knowledge-bank-build`.

## How Senku learns (default model)

```
Owner asks a question OR gives data
        ↓
Check bank (knowledge-bank-query)
        ↓
Gap? → source-intake and/or domain-research
        ↓
Write topic file → update INDEX
```

No mandatory order beyond optional **bootstrap** (below).

## Bootstrap (optional, once)

Run when the bank is empty and the owner wants a starting map — not required for every task.

| Output | Purpose | Time limit |
|---|---|---|
| `industry-overview.md` | What this product category is, major segments | 15 min |
| `glossary.md` | Terms the owner will hear | 15 min |

Trigger phrases: *"Senku, bootstrap the bank"*, *"give me the lay of the land"*, first session after onboarding.

**Do not** call this "pass 0" in user-facing language — say **bootstrap**.

## Core bank areas (build on demand)

Create files when the owner asks or when research naturally produces them:

| Area | Folder / file | Examples (audio) |
|---|---|---|
| Product types | `products/` | Portable speakers, TWS, soundbars |
| Product knowledge | `topics/` | Bluetooth codecs, drivers, IP ratings, battery runtime |
| Brand mapping | `brand-overlay.md` | Finecoustic SKUs mapped to category terms |

`topics/` is the main growth surface — one file per subject, linked from INDEX.

## Deferred (owner must ask)

Do **not** build unless explicitly requested:

- `supply-chain/` — manufacturing, ODM/OEM, sourcing
- `regulatory/` — FCC, CE, certification marks

If the owner never asks, these folders do not exist.

## Per-topic workflow

1. Confirm topic scope with owner (one sentence)
2. Check bank — skip if current unless refresh requested
3. If owner attached data → `source-intake` first
4. If gaps remain → `domain-research`
5. `knowledge-bank-build` → `topics/<topic-slug>.md` or `products/<slug>.md`
6. Update INDEX **Gaps** and **Topics covered**

## Maturity (honest reporting)

| Level | Meaning |
|---|---|
| `seeded` | Scaffold only |
| `building` | Bootstrap done OR 3+ topic files with sources |
| `operational` | Owner can get solid answers on their core product areas from bank alone |
| `mature` | Broad topic coverage; owner rarely needs live research |

## Sufficiency rule

A topic is **done** when the owner could ask a reasonable question about it and Senku answers from the bank. Not when every article on the internet is indexed.

## After each session

Report plainly:

- What was learned and where it was saved (file paths)
- Source types used (owner-provided / web / both)
- 2–3 useful facts
- Suggested next topic — only if useful, not a mandatory "pass 1"

## References

Audio product topic ideas: `references/audio-topic-seeds.md`
