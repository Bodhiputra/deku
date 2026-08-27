---
name: domain-research
description: Live domain research methodology for Senku — web search, Playwright, Reddit, and Chrome with evidence standards for industry and product knowledge. Load before any Senku research that fills gaps in the knowledge bank or answers owner questions not yet in the bank.
---

# Domain Research

Requires: `knowledge-bank-standards` when findings will enter the bank.

Senku researches **how industries and products work** — not buyer personas, positioning, or GTM (Jinu).

## When to Invoke

- `knowledge-bank-query` found a gap
- Owner asks a question not covered by current bank content
- Building a new `topics/` or `products/` bank file
- Refreshing stale bank entries (`freshness: review-due`)

## Step 0 — Check Existing Knowledge (5 min)

1. Read bank INDEX and relevant module files
2. Read `context/industry-context.md`
3. If answer exists and is current → use `knowledge-bank-query` instead; do not duplicate research

## Step 0b — Owner-Provided Sources (when available)

If the owner supplied URLs, files, or pasted specs → run `source-intake` **before** open web research. Owner data is Tier 0 — highest trust for *their* products; still verify generic industry claims on the web if needed.

## Step 1 — Source Priority

Search in this order — exhaust higher tiers before expanding:

| Tier | Source types | Use for |
|---|---|---|
| **0** | Owner-provided specs, URLs, factory docs, files (`source-intake`) | Brand product **Fact** |
| **1** | Standards bodies, IEEE, Bluetooth SIG, IEC, etc. | **Standard**, **Fact** |
| **2** | Manufacturer white papers, chip vendor docs, academic papers | **Fact**, mechanisms |
| **3** | Trade publications, industry analysts (with named report) | **Practice**, trends |
| **4** | Reddit, forums (technical subreddits), social read-only | **Practice**, real-world failure modes, industry signals |
| **5** | General web / blogs | Lead generation only — verify against Tier 1–2 before bank write |

**Never** enter Tier 5 alone as **Fact** in the bank.

**Audio industry:** Load `references/audio-source-tiers.md` for site-specific tiers (RTings, ASR, SoundGuys, Reddit subs, etc.).

## Step 2 — Tool Selection (company policy)

1. Reddit MCP — technical community discussion, owner experience with specs
2. Web search — standards doc discovery, quick entity verification
3. Playwright — public spec pages, Wikipedia (verify primary source after)
4. Chrome DevTools — login-gated technical databases if owner session available

Notion MCP is **not required** for Senku research.

## Step 3 — Research Execution

**Time budget:** 25 minutes default per topic unless owner scoped larger.

For each subtopic:
1. Formulate a precise question (not "research audio" — "what does IPX4 test procedure require")
2. Visit sources — confirm URL loads
3. Extract mechanism-level notes with date visited
4. Label each extract: Fact / Standard / Practice / Inference
5. Discard undated or unverifiable claims

## Step 4 — Community Pass (when category has active communities)

Search relevant subreddits via Reddit MCP (e.g. r/audiophile, r/Bluetooth, r/headphones, r/Speakers — adapt per industry). For audio, see subreddit list in `references/audio-source-tiers.md`.

Pull 3–5 high-signal threads:
- Technical questions with expert answers
- "Why does X work this way" discussions
- Failure/defect patterns (factual reports, not anecdotes as Fact)

Use Reddit for **Practice** and question discovery — verify technical claims against Tier 1–2 before bank write.

## Step 5 — Handoff to Build

If findings persist beyond the immediate answer:
→ Pass structured notes to `knowledge-bank-build`

If owner asked a one-off question:
→ Answer inline with labels; offer to write bank entry

## Quality Gates

- [ ] Every **Fact** has visited URL + date
- [ ] Standards cite body and identifier (e.g. IEC 60529)
- [ ] No marketing copy from brands presented as industry fact
- [ ] No buyer personas or "target audience" (Jinu scope)
- [ ] Geo-specific regulatory claims name the jurisdiction

## Banned Patterns

- "Industry-leading" / "best-in-class" without measurable criterion
- Spec sheet marketing adjectives as facts ("studio-quality" — unless defined with test)
- Single Amazon review as evidence
- AI-generated summary pages without primary source follow-up
