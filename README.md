# Deku — Platform-Neutral AI Company System

Deku gives your brand a full marketing, design, and operations department powered by AI.

> **Naming:** **Deku** = this repo and AI company system. Your local folder can be anything (e.g. `finecoustic/`). **Finecoustic** in `context/` and `ops-hub/` = a brand running on Deku, not the system name.

**Jinu** is your Chief Marketing Officer. He maps your market, profiles your buyers, finds your competitors, identifies KOLs, discovers retail distribution opportunities, and builds your content strategy — all documented automatically in Notion.

**Nagi** is your Chief Design Officer. He handles all design work — brand identity, website design, social assets, presentations, and ad creatives — and saves everything to Figma.

**Koji** is your Chief Operating Officer. He handles product catalog structure, inventory, B2B account tracking, Shopify sync, and ops dashboards.

You talk to them directly through your current host assistant. They do the work. You get the report.

---

## What you need before starting

- A computer running macOS or Linux
- [Node.js](https://nodejs.org) installed
- One first-class supported host assistant installed: Claude Code, Codex, or Cursor
- A [Notion](https://notion.so) account (free) — Jinu writes all research here
- A [Figma](https://figma.com) account (free) — Nagi saves all design work here
- Google Chrome installed

That's it.

---

## Getting started

**Step 1 — Clone the repo and open your host assistant**

```bash
git clone https://github.com/bodhiputra/deku.git
cd deku    # or your chosen folder name — e.g. cd finecoustic
```

Then open the project in one of the supported hosts:

- Claude Code: `claude`
- Codex: `codex`
- Cursor: open the folder in Cursor

---

**Step 2 — Run setup**

Once your host assistant is open, say:

```
setup Deku
```

Your assistant handles everything from here — checks your system, creates the files it needs, connects Chrome, walks you through Notion and Figma (a browser window opens for each, you log in and click Allow). You just follow along.

---

**Step 3 — Meet your team**

Once setup is complete, call any chief by name:

```
Jinu, let's get started
```

Most new brands start with **Jinu** (marketing onboarding). You can also call **Nagi** (design) or **Koji** (operations) directly when you need them.

---

## What happens next

Jinu starts with a short onboarding conversation — about 15 minutes. He asks about your brand, your product, your goals, and your market. Everything goes into Notion.

From there, you work task by task. Tell Jinu what you need and he goes and does it:

- **Research the market** — industry landscape, key dynamics, where the opportunity is
- **Research competitors** — who they are, how they position, where they're weak
- **Research buyers** — who's actually buying, what drives them, their exact words
- **Size the market** — TAM/SAM/SOM with methodology and sources
- **Find KOLs** — ranked shortlist by platform, content fit, and engagement
- **Find retailers** — distribution opportunities by market
- **Build a content strategy** — what to make, for whom, on which platform
- **Positioning** — where your brand should sit and what to say

Each task runs on its own — typically 30–60 minutes — and all findings are documented in Notion automatically.

---

## Calling Jinu, Nagi, and Koji

From anywhere in your host assistant, you can switch directly to any of them:

| To talk to | Say |
|---|---|
| Jinu (marketing) | `Jinu, ...` |
| Nagi (design) | `Nagi, ...` |
| Koji (operations) | `Koji, ...` |
| Back to your assistant | Address your assistant directly |

Example:
```
Jinu, I want to run research on my new product
```
```
Nagi, design a landing page for the Hako speaker
```

---

## What stays private (gitignored)

These are never pushed to GitHub:

- `context/brand-context.md`, `context/session-context.md`, `context/ops-context.md` — brand and ops state
- `.env` — API keys (template is `.env.example`, which **is** committed)
- `.claude/settings.local.json` — local Claude config synced from `.env`
- `proofs/`, `output/`, `research-snapshots/` — scratch and deliverable drafts
- `.cursor/tmp/`, `.agents/skills.bak.*/` — temporary session and setup backup files
- `shopify/` — separate theme repo

See `.gitignore` for the full list.

---

## Troubleshooting

**Chrome isn't connecting**
Make sure Chrome is open, go to `chrome://inspect/#remote-debugging`, and toggle "Allow remote debugging for this browser instance" ON.

**Notion isn't connecting**
Run `claude` in the project folder and follow any OAuth prompts that appear.

**Skills or MCPs seem missing**
Run `./setup.sh` again — it's safe to re-run and will only create what's missing.

**Something else**
Say `Jinu, something isn't working` and describe what you see. He'll diagnose it.
