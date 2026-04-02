# Finecoustic — Claude Code Workspace

## Brand
**Finecoustic** — "Fine sound for everyone"
Pre-launch audio brand. Targeting everyday listeners, NOT audiophiles.

Finecoustic believe in precision, innovation, and premium sound experiences. Our visual identity reflects our commitment to high-fidelity audio technology with a design language that is modern, minimalist, and sophisticated.

## Products
| Product Name | Type | Primary Target |
|---|---|---|
| Hako Nomad | Small Marshall-like, portable | Campers, lifestyle buyers, small-space dwellers |
| Hako Nomad L | Big Marshall-like, non-portable | Cafe owners, desk setup, home setup |
| Hako Studio 301 | Bookshelf speaker | Desk setup, room/TV, music lovers, video editors |
| Hako Studio 302 | Bookshelf speaker (variant) | Desk setup, room/TV, music lovers, video editors |

---

## Agent Team

| Agent | Role | Reports To |
|---|---|---|
| `marketing-analyst` | **Team Captain** — directs research, synthesizes findings, builds strategy | You (the user) |
| `reddit-scraper` | Reddit research operative — searches, reads, notes, reports | marketing-analyst |
| `notion-manager` | Notion documentation — creates pages, updates databases | marketing-analyst |

**Chain of command**: You → marketing-analyst → reddit-scraper / notion-manager

---

## Pipeline: Full Research-to-Docs

When you give a research prompt:

1. **marketing-analyst** writes a brief and dispatches `reddit-scraper`
2. **reddit-scraper** searches Reddit and returns a raw findings report
3. **marketing-analyst** reviews — if not satisfied, sends `reddit-scraper` back with a follow-up brief (up to 3 rounds)
4. **marketing-analyst** synthesizes findings into a full report: STP, buyer personas, competitive landscape, positioning, GTM priorities
5. **marketing-analyst** writes a handoff brief and dispatches `notion-manager`
6. **notion-manager** creates the research page and updates all relevant databases

---

## Sub-Agent Routing Rules

**Sequential only** (this team works in a chain, not in parallel):
- reddit-scraper must finish before analyst synthesizes
- analyst must finish before notion-manager documents

**Single agent tasks** (skip the full pipeline):
- "Update Notion with X" → `notion-manager` only
- "Search Reddit for X" → `reddit-scraper` only (but analyst still reviews)
- "Analyze our positioning" → `marketing-analyst` only

---

## Trigger Prompts

```
Research the market for Hako Nomad and document everything in Notion.
```
```
What are cafe owners saying on Reddit about audio equipment? Full pipeline.
```
```
Find new and unexpected competitors to Hako Nomad L — run the full pipeline.
```
```
Who is buying bookshelf speakers right now? Build personas and save to Notion.
```
```
Research the desk setup community for Hako Studio 301. What do they care about?
```
```
Find competitors we haven't considered yet for any of our product lines.
```
