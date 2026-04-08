---
name: research-primer
description: Before any research agent begins a session, runs a structured pre-research snapshot using Reddit MCP + web search + Notion MCP to establish what is current, what has already been documented, and what specific gaps this session must fill. Replaces the last30days skill dependency. Used by Market Intelligence Agent, Buyer Intelligence Agent, Content Intelligence Agent, and Jinu on-demand trend checks.
---

# Research Primer

Run this skill at the start of every research agent session — before touching any browser tool, before any platform research begins. It costs minimal tokens and prevents the session from re-discovering things already known or researching topics Notion already has documented.

**Time budget: 15 minutes maximum.** If it takes longer, scope it down.

## When to Invoke

- At the start of every Market Intelligence Agent session (before any pass begins)
- At the start of every Buyer Intelligence Agent session
- At the start of every Content Intelligence Agent session
- At the start of every Viral Content Radar cycle
- Any time an agent needs to establish "what do we already know and what is current" before primary research

## Step 1 — Reddit MCP (5 minutes)

Search the brand category + research topic on Reddit MCP. Run two sorts:
- **Hot** — established conversation, what the community has validated over time
- **Rising** — fresh momentum, what is gaining traction right now

Pull top 5 posts per sort. For each post extract: subreddit name, upvote count, top comment verbatim (Best sort), post date.

Apply basic VOC signal identification on the comments — flag any frustration language, relief language, comparison language, or price-sensitivity language you encounter.

## Step 2 — Web Search (5 minutes)

Run three targeted searches:
1. `[topic] site:x.com` — recent X posts and brand/category conversation
2. `[topic] youtube` — recent YouTube coverage and creator activity
3. `[brand/category] news` — any press, product launches, or announcements in the last 30 days

Pull top 3 results per query with source name and date.

## Step 3 — Notion MCP (3 minutes)

Query the Notion workspace for existing research records matching this topic, brand, or competitor. Surface:
- What databases have records on this topic
- When those records were last written (agent source + date)
- A recency assessment per topic: "Researched [X weeks ago] — needs refresh" OR "Not yet researched — start fresh"

This step prevents the agent from duplicating work that Notion already holds.

## Step 4 — Snapshot Output (2 minutes)

Produce the standardised snapshot and hand it to the requesting agent before any further research begins.

```
RESEARCH PRIMER — [Topic] — [Date]

SECTION 1: WHAT IS CURRENT (last 30 days)

Reddit:
  [Thread 1]: r/[subreddit] | [upvotes] upvotes | [date]
  Top comment: "[verbatim quote]"
  [Threads 2–5]: same format

X / Web:
  [Post or article 1]: [source name] | [date] | [one-sentence summary]
  [Posts/articles 2–3]: same format

YouTube:
  [Video 1]: [channel name] | [view count] | [upload date]
  [Videos 2–3]: same format

SECTION 2: WHAT WE ALREADY KNOW
[Existing Notion findings with dates and agent source]
[Recency flags: needs refresh / start fresh]

SECTION 3: RESEARCH GAPS THIS SESSION MUST ANSWER
1. [Specific question] → Priority platform: [platform] → Evidence recency needed: [30/90 days]
2. [Specific question] → Priority platform: [platform] → Evidence recency needed: [30/90 days]
3. [Specific question] → Priority platform: [platform] → Evidence recency needed: [30/90 days]
```

## What This Skill Does NOT Do

- Does not do deep research — it surfaces what is current and what is known
- Does not replace platform-specific skills — it is the layer before those are invoked
- Does not take more than 15 minutes — if it is running long, scope it down
- Does not replace Reddit MCP as a primary research tool — this uses it at shallow depth for priming only
