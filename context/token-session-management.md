# Token & Session Management — Company-Wide Guide
_For Jarvis (Claude Code), Jinu & Marketing Team, Nagi & Design Team, and all future departments_

Read this before running any pipeline. Applies to every agent, every department, every session.

---

## The Short Version

| Problem | Fix |
|---|---|
| Session budget burning too fast | `/compact` between every cluster |
| Starting a completely different task | `/clear`, rely on session-context.md for handoff |
| Don't know how much budget is left | `/context` at session start, watch the status bar |

| Pipeline too large for one session | Jinu splits deliberately — see Session Splitting below |

---

## What Actually Costs Tokens

### Heavy — manage these carefully

**1. Agent sub-agents running in parallel**
Every sub-agent is a separate Claude instance with its own full context window.
A 3-agent parallel run uses roughly 7x more tokens than a single-agent session.
The more agents running simultaneously, the faster the budget disappears.

**2. browser-use scraping live pages**
Every live page an agent opens loads the full rendered content into context.
A single scraping run across multiple sources can consume 10,000–30,000 tokens per cluster.

Important: browser-use must never be restricted to save tokens. Research quality comes
first. The answer is to manage sessions around browser-use costs, not to limit it.
Agents should scrape as deeply as the task requires. Token management happens at the
session level, not the research level.

**3. Conversation history accumulating without compaction**
Every message in the session history gets re-processed on every new message. The longer
a session runs without compaction, the heavier each new message becomes.

### Not a meaningful concern

**Skills installed from GitHub** — only name and description load at startup (~30–100
tokens per skill). Full content loads only when a skill is invoked. Install freely.

---

## Core Session Habits

### Habit 1: Run /context at session start
Before any work begins, run `/context` to see a full token breakdown:
system prompt, MCP tools, memory files, conversation history, free space.

This tells you how much budget you actually have, and which MCPs are burning tokens
before a single agent has run.

### Habit 2: Run /compact between every cluster
Run `/compact` manually after each cluster completes, before the next one starts.

You can give it a focus instruction:
```
/compact Focus on research findings, key data points, and conclusions reached so far
```

**On research quality and compaction:**
The focus instruction is the key. Without it, compaction summarizes generically and
some detail can be lost. With a well-written focus instruction, the essential research
output — findings, data, competitor registry, positioning conclusions — is preserved
in the summary. Raw scraped content and intermediate thinking are compressed away,
which is fine because that content has already been written to Notion.

This is why the Notion write happens before `/compact`. The full detail lives in
Notion permanently. The session only needs the compressed conclusions to continue.
Compaction never touches Notion — only the session conversation history.

### Habit 3: Watch the status bar — as a signal only
Claude Code shows token percentage at the bottom of the terminal at all times.

Use this as a monitoring signal only — not as a trigger for any automatic action.
Do not compact or interrupt mid-agent just because a percentage is reached.
Always wait for a natural breakpoint (end of current agent, before next cluster)
before running `/compact`. Interrupting an agent mid-task to manage tokens will
degrade results more than a full context window will.

The right rhythm: agent completes → Notion Manager writes → `/compact` → next agent.

---

## Session Splitting — Jinu Handles This

Jinu can split the pipeline across sessions deliberately. This is built into how
the pipeline is designed — `session-context.md` is the handoff mechanism.

**How session splitting works:**
1. Jinu completes a cluster and Notion Manager writes all findings
2. Notion Manager updates `session-context.md` with full current state
3. Jinu ends the session cleanly (or the session limit is reached)
4. Next session: Jinu reads `session-context.md` → knows exactly what was done,
   what is pending, what the current research state is → continues without gaps

**Resuming a session in Claude Code:**
```
claude --continue        # resumes the most recent session
claude --resume          # shows a list of recent sessions to pick from
```

**Recommended split for a full Marketing research run:**

| Session | Clusters |
|---|---|
| Session 1 | Cluster A: Industry Scout → Positioning Ph1 → Competitor Intel → Buyer Persona → Pain Point Miner |
| Session 2 | Clusters B + C: Market Sizing, KOL Tracker, Retailer B2B |
| Session 3 | Cluster D: Content chain → Positioning Ph2 → executive summary |

Jinu decides the split based on remaining budget, not a fixed rule. If Session 1 still
has budget after Cluster A, continue into Cluster B. If the budget is low, end cleanly
and let session-context.md handle the rest.

---

## On session-context.md — Structure It Correctly or History Gets Lost

session-context.md is rewritten at the end of every session by Notion Manager.
This keeps the file lean and prevents bloat — but if the file only captures current
state, future sessions will lose the reasoning behind decisions.

**What gets silently lost with a pure state-only rewrite:**
- A competitor was evaluated and deliberately excluded — future sessions won't know why
- A KOL was flagged as low-quality despite high followers — the reasoning disappears
- A conflict between Pain Point Miner and Buyer Persona was resolved by Jinu — gone
- A platform was deprioritized mid-research for a specific reason — no record of it

This causes future sessions to re-investigate things already settled, or worse, contradict
decisions that were made deliberately.

**The fix: two distinct sections in session-context.md**

**Section 1 — Current State** (fully rewritten every session)
What the research looks like right now: competitor registry, persona summary, positioning
hypothesis, content status, what clusters are complete, what is pending, recommended
next action. This is the rolling snapshot Jinu reads at session start.

**Section 2 — Decision Log** (append-only, never overwritten)
Every significant decision, exclusion, conflict resolution, or deliberate skip — one line
each, with a brief reason. Notion Manager appends new entries to this section at session
end. It never rewrites or removes existing entries.

Example entries:
```
[2026-03-27] Brand X excluded from competitor registry — targets enterprise, not consumer
[2026-03-27] Reddit deprioritized for KOL tracking — no meaningful audio community found
[2026-03-28] Buyer persona conflict resolved — Pain Point data overrides assumed persona
[2026-03-28] Market Sizing TAM revised down — IPO filing used instead of industry report
```

Section 1 stays lean. Section 2 grows slowly, only from meaningful decisions.
Together they give future sessions both the current research state and the full
reasoning history — no gaps, no repeated work, no contradicted decisions.

---

## Model Selection

Always use **Sonnet 4.6** for every agent in every department.

No exceptions. Sonnet 4.6 is the standard across the entire company for all research,
orchestration, writing, and design work.

---

## Quick Command Reference

```
/context    — Full token breakdown by category. Run at session start every time.
/compact    — Compress conversation history. Run between every cluster.
/clear      — Wipe context entirely. Use when switching to unrelated work.
/rename     — Name the current session before clearing, so it can be found later.
/resume     — Pick a past session to continue from.

claude --continue   — Resume the most recent session from terminal.
claude --resume     — Show session picker from terminal.
```

---

## For Future Departments

This guide is department-agnostic. Design (Nagi) and all future departments follow
the same rules:

- `/context` at session start — always
- `/compact` between major workflow clusters — always, with a focus instruction
- Watch the status bar as a signal only — never interrupt mid-agent
- Split large pipeline runs across sessions — use your department's session-context.md
- Sonnet 4.6 for all agents — no exceptions
- Never restrict browser-use or research depth to save tokens — manage at session level
