# Deku — AI Marketing & Design Team

Deku gives your brand a full marketing and design department powered by AI.

**Jinu** is your Chief Marketing Officer. He maps your market, profiles your buyers, finds your competitors, identifies KOLs, discovers retail distribution opportunities, and builds your content strategy — all documented automatically in Notion.

**Nagi** is your Chief Design Officer. He handles all design work — brand identity, website design, social assets, presentations, and ad creatives — and saves everything to Figma.

You talk to them directly. They do the work. You get the report.

---

## What you need before starting

- A computer running macOS or Linux
- [Node.js](https://nodejs.org) installed
- [Claude Code](https://claude.ai/code) installed
- A [Notion](https://notion.so) account (free) — Jinu writes all research here
- A [Figma](https://figma.com) account (free) — Nagi saves all design work here
- Google Chrome installed

That's it.

---

## Getting started

**Step 1 — Clone the repo and open Claude Code**

```bash
git clone https://github.com/bodhiputra/deku.git
cd deku
claude
```

---

**Step 2 — Run setup**

Once Claude Code is open, say:

```
setup Jinu
```

Your assistant handles everything from here — checks your system, creates the files it needs, connects Chrome, walks you through Notion and Figma (a browser window opens for each, you log in and click Allow). You just follow along.

---

**Step 3 — Meet Jinu**

Once setup is complete, your assistant will tell you to say:

```
Jinu, let's get started
```

Jinu will introduce himself, ask you about your brand, and guide you through everything from there.

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

## Calling Jinu and Nagi

From anywhere in Claude Code, you can switch directly to either of them:

| To talk to | Say |
|---|---|
| Jinu (marketing) | `Jinu, ...` |
| Nagi (design) | `Nagi, ...` |
| Back to your assistant | Address your assistant directly |

Example:
```
Jinu, I want to run research on my new product
```
```
Nagi, design a landing page for the Hako speaker
```

---

## What stays private

These files are gitignored and never shared:

- `context/brand-context.md` — your brand details and goals
- `context/session-context.md` — rolling research progress
- `.claude/settings.local.json` — your local configuration
- `proofs/` — screenshots captured during research

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
