---
name: knowledge-bank-build
description: Writes and updates markdown knowledge units in Senku's local knowledge bank — file creation, header compliance, INDEX updates, and post-write verification. Load after domain-research or when structuring onboarding stubs into full modules.
---

# Knowledge Bank Build

Requires: `knowledge-bank-standards`. Input: labeled research notes from `domain-research` or pass plan from `industry-deep-dive`.

Transforms research into durable bank files.

## When to Invoke

- Completing an `industry-deep-dive` pass
- Persisting a one-off research answer the owner wants saved
- Refreshing a stale module
- Expanding `[TO BUILD]` stubs from onboarding

## Step 1 — Resolve Target Path

From `context/industry-context.md`:

```
bank_path = knowledge-bank/brands/<brand_slug>/<industry_slug>/
```

New file naming: lowercase, hyphenated, descriptive — e.g. `technical-standards/bluetooth-codecs.md`

## Step 2 — Write File

Use the markdown unit format from `knowledge-bank-standards`:

1. YAML header (industry, module, updated, freshness)
2. Scope — what this file covers and excludes
3. Summary — owner-readable, no Inference
4. Content — labeled Fact / Standard / Practice / Inference sections
5. Sources table — every Fact and Standard row required

**Writing style:** Imperative, precise, professional. Third-person. No hype. Senku sounds like a technical director briefing a CEO — not a blog post.

## Step 3 — Update INDEX Files

1. Edit root `INDEX.md` — module status, `updated` date, remove from Gaps if filled
2. Edit submodule `INDEX.md` if file lives in a folder
3. Add cross-links from related modules (relative paths)

## Step 4 — Update industry-context.md

- Bump `last_deep_dive` date
- Adjust `bank_maturity` if threshold crossed (see `industry-deep-dive`)
- Add brief note if owner requested specific topic

## Step 5 — Verification

Run reconciliation checklist from `knowledge-bank-standards`:

- [ ] Header complete
- [ ] Sources table complete for all Facts/Standards
- [ ] INDEX updated at root and submodule
- [ ] No GTM/strategy content
- [ ] Internal links valid

## Split vs Merge Rule

- File >1800 words → split by subtopic, update both INDEX files
- Two files >60% overlap → merge and redirect links

## Refresh Workflow

When updating existing file:

1. Read current file — preserve still-valid Facts with original source dates
2. Add `## Changelog` section at bottom with date + what changed
3. Set `freshness: current` after verification
4. Do not delete historical Facts — mark superseded: `**Superseded (YYYY-MM-DD):** ...`

## Output Message to Owner

After build session:

- Files created/updated (list)
- New bank maturity level
- 2–3 sentences: what they can now ask that they couldn't before
