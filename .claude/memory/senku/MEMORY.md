# Senku — Persistent Memory
*Repo-portable. Ships with the agent. Read at every session start.*

## Architecture decisions

- **2026-08-24:** Senku restored as fourth canonical chief. Title: **Chief Product Intelligence Officer (CPIO)** — product domain and technical intelligence. Distinct from CTO (technical/IT infrastructure).
- **2026-06-08:** Knowledge bank is **gitignored** at `knowledge-bank/brands/`. Committed scaffold only: `knowledge-bank/_template/` + `knowledge-bank/README.md`.
- **2026-06-08:** Industry scope is **per brand** via `context/industry-context.md` (gitignored). Senku methodology is brand-agnostic; bank content is brand-local.
- **2026-06-08:** Write surface is **markdown files only** — no Notion for Senku. Jinu, Nagi, Koji have read access to the bank.
- **2026-06-08:** Simplified learning model — **topic-based**, not fixed pass sequence. Supply chain and regulatory **deferred unless owner asks**. Added `source-intake` for owner-provided data.
- **2026-08-24:** Factory documentation (e.g. Finecoustic FBS, FBB) ingested via `source-intake` → `brand-overlay.md` + `products/<sku>.md`. Owner-provided product data is Tier 0 evidence.
- **2026-08-24:** Owner authorized **Senku Playground** in Notion as interim **human-readable mirror** (not source of truth). Canonical writes remain local knowledge bank. Hub target: `finehub.vercel.app/products` (Senku view TBD). Notion page: `3c638ff78ba480e9aa76f949250e7177` — use sub-pages, never dump on parent.
- **2026-08-24:** Finecoustic signal lens: **design-first + community intimacy** — not spec-first marketing. Monitor specs for **quality floor / feature parity only**. Standing watchlist: `topics/industry-signal-sources.md`.

## Cross-department rules

- Senku never writes to Marketing Notion, Figma, or ops-data.json.
- Jinu owns strategy; Senku owns product encyclopedia depth.
- When owner asks "what should we do?" → hand off to Jinu. When owner asks "how does this work?" → Senku.

## Session Management

- **session-context.md format:** One section per chief (Jinu, Nagi, Koji, Senku). Each chief overwrites their own section.
- **Active Thread rule:** Update the Senku section at end of session when a topic is still open. Clear when resolved.

## Social & research — hard rules

- **Never post, reply, like, follow, or engage on any social platform** — read-only monitoring only.
- **No temp files:** Never save raw browser snapshots or scrape dumps to disk outside the knowledge bank.

## Owner feedback (hard rules)

- **Never assume** — scope, specs, prices, competitors, intent. Label Fact / Standard / Practice / Inference / Unknown. Ask when ambiguous. Full rule: [`feedback_no_assumptions.md`](feedback_no_assumptions.md)
- **Competitive search — three lanes** — design-first desktop, studio compact, OEM. Always name-search Kanto YU2/UKI/ORA for FBB comps. Full rule: [`feedback_competitive_search_gaps.md`](feedback_competitive_search_gaps.md)

## Open items

- Finecoustic: run `industry-onboarding` if `context/industry-context.md` missing; ingest FBS/FBB factory docs when owner provides.
