# How to Use Jinu — Brand Owner Guide
*Brand-agnostic. Step-by-step reference for every new user. Jinu reads this file and walks owners through it — never assumes they have read it.*

---

## What this guide is for

Jinu is your Chief Marketing Officer. This guide shows you **how to work with him correctly** so research stays on-brief, findings land where you expect, and you never have to understand the technical setup.

**Three rules that never change:**

1. **Jinu always asks before assuming** — product, market, scope, format, run mode. If something is unclear, he asks. You never need to "know the right answer" upfront.
2. **You stay flexible** — change scope, pause, switch tasks, or ask for a shorter version anytime. The process serves you.
3. **You don't edit repo files** — Jinu maintains `brand-context` and session notes. You talk; he writes.

---

## Part 1 — Before your first Jinu session

*If someone helped you set up Deku, they already did most of this. Skip to Part 2.*

| Step | What happens | Who does it |
|---|---|---|
| 1 | Clone the Deku repo and install Node.js | Your technical helper |
| 2 | Run `./setup.sh` | Your technical helper |
| 3 | Turn on Chrome remote debugging (one-time) | Your helper explains; you toggle in Chrome |
| 4 | Connect Notion (optional) — browser "Allow" flow | You, when prompted |
| 5 | Say **`Jinu, let's get started`** | You |

**You do not need API keys on day one.** Jinu introduces optional speed-ups (YouTube API, Notion integration token for KOL dedup) only when a task needs them — one step at a time.

Full setup script for helpers: `MANUAL.md`

---

## Part 2 — Your first conversation (onboarding)

**You say:** `Jinu, let's get started`

**Jinu will:**

1. **Introduce himself** in plain language — what he does, how task-by-task work flows.
2. **Offer this guide** — *"I can walk you through how we'll work together step by step, or jump straight in — your choice."*
3. **Ask for links first** — website, product page, Instagram, Shopify, pitch deck. *"Share what you have; I'll read it before asking questions."*
4. **Ask only what's missing** — brand name, product, price, who might buy it, which countries, competitors (or "I don't know — find them"), where notes should live (Notion vs reports in chat).
5. **Write your brand file** — Jinu saves answers to `context/brand-context.md` (you never touch it).

**Good answers when you don't know yet:**

- *"I'm not sure who the buyer is — that's what I need you to find."*
- *"US and UK, but open to your recommendation."*
- *"No Notion yet — just give me the report here."*

---

## Part 3 — How every task works (the standard loop)

Use this loop for **every** task — market research, KOLs, competitors, content, etc.

| Step | Jinu | You |
|---|---|---|
| **1. Name the task** | Listens | *"Find KOLs"*, *"Research competitors"*, *"Size the market"* |
| **2. Confirm scope** | States what he understood + asks to confirm | Answer or correct — product, markets, depth, deliverable |
| **3. Confirm run mode** | Asks unless you already said | **Interactive** (updates as he goes) or **Autonomous** (come back when done) |
| **4. Confirm output** | Asks where findings go | Notion page, chat report, or local `.md` file |
| **5. Execute** | Loads skills, researches, documents | Step away or stay — your choice |
| **6. Deliver** | Summary + links + clear "what to do next" | Review, approve, or redirect |
| **7. Next or close** | Asks what's next | New task, refinement, or *"close session"* |

**Jinu never starts browsing or writing to Notion until steps 2–4 are confirmed** (or your message was already fully explicit).

**Example — explicit enough to skip re-asks:**

> *"Jinu, KOL brief: [product], reviewer preset, Instagram + YouTube, US and Canada, micro tier, 10 verified, autonomous — write to Notion."*

**Example — Jinu will ask:**

> *"Find me some influencers."* → Jinu walks the KOL brief template (Part 5).

---

## Part 4 — What you can ask for

| You say (examples) | What you get | Typical time |
|---|---|---|
| *"Research the market"* | Industry landscape + competitor map | 30–60 min |
| *"Research our buyers"* | Personas + real buyer language | 30–60 min |
| *"Research competitors"* | Pricing, positioning, gaps | 30–60 min |
| *"Size the market"* | TAM / SAM / SOM with sources | 45–90 min |
| *"Find KOLs"* | Verified creators in Notion (or report) | 60+ min |
| *"Find retailers"* | B2B distribution targets by market | 45–90 min |
| *"What should we post?"* | Trend scan + content angles | 30–45 min |
| *"Build a content strategy"* | Full content intelligence package | 60+ min |
| *"What's our positioning?"* | Positioning + messaging direction | 45–90 min |
| *"Quick trend check"* | Fast viral/format scan | ~30 min |
| *"Add a new product"* | Updates brand file + optional research | Varies |

**You can combine or narrow scope anytime:** *"Just US"*, *"Only YouTube"*, *"Skip retailers for now"*, *"I need this by tomorrow — prioritize depth on competitors only."*

---

## Part 5 — Task-specific step-by-step

### KOL discovery (find creators)

1. Jinu opens `context/kol-brief-templates.md` with you.
2. You confirm: **product**, **creator type** (reviewer / lifestyle / cinematic / interior / desk / music), **platforms**, **countries**, **size tier**, **how many verified**.
3. If **Instagram**: Jinu asks which Chrome profile and IG account to use (stored in your brand file).
4. If **YouTube**: Jinu offers optional API setup — manual collection is always valid.
5. Jinu runs quality gates (country, engagement, activity, content fit) — **never lowers the bar to hit a quota**.
6. Each qualified creator goes to Notion immediately (if you use Notion). **You** set Tags and Description; Jinu fills metrics and Agent Reason.
7. Jinu delivers a summary with Notion links and how many passed vs. target.

### Market / buyer / competitor research

1. Confirm **product** and **markets**.
2. Jinu checks what's already in Notion — won't duplicate old work without asking (update vs. version vs. merge).
3. Findings need source URLs. Jinu discards unverified claims.
4. Delivered as chat briefing + Notion (or markdown report).

### Content strategy

1. Confirm product, platforms, and goal (awareness vs. conversion vs. launch).
2. Jinu may ask about brand stage (figuring it out vs. scaling).
3. Deliverable: prioritized content angles + what to make first.

---

## Part 6 — Run modes

| Mode | Best for | What you experience |
|---|---|---|
| **Interactive** (default) | First time on a task type, exploratory work | Jinu flags surprises and asks when scope forks |
| **Autonomous** | Clear brief, you want to step away | Jinu runs end-to-end; reports when done |

**Switch anytime:** *"Go autonomous on this"* or *"Check in with me before you write to Notion."*

---

## Part 7 — Things you never need to do

- Edit files in the repo (`brand-context`, skills, hooks)
- Understand MCP, Chrome DevTools, or API keys unless you opt into a walkthrough
- Pre-fill perfect briefs — Jinu helps you build them
- Watch the agent work — tasks run 30–60+ minutes; you can leave
- Feel bad about not knowing marketing terms — ask Jinu to explain

---

## Part 8 — Ending a session

**You say:** *"Close session"* or *"That's all for today"*

**Jinu will:** Write a short checkpoint (what was done, what's open, suggested next step). You don't edit session files.

---

## Part 9 — When something isn't working

| Issue | What to do |
|---|---|
| Chrome won't connect | Open Chrome → `chrome://inspect/#remote-debugging` → toggle ON → tell Jinu to retry |
| Notion won't write | Re-authenticate when Jinu prompts; or get findings in chat |
| Instagram KOL blocked | Chrome must be connected; confirm correct IG account in Chrome |
| "I want to change direction" | Just say so — Jinu stops and re-confirms scope |

---

## Quick reference — phrases that work

```
Jinu, let's get started
Jinu, walk me through how to use your services
Jinu, find KOLs — [product], [creator type], [markets], [N] verified
Jinu, research competitors for [product] in [markets] — interactive
Jinu, size the market for [product] — autonomous, report in chat
Close session
```

---

*Canonical agent behavior: `.claude/agents/jinu.md` · Onboarding flow: `.claude/jinu-onboarding.md` · KOL brief fields: `context/kol-brief-templates.md`*
