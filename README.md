# Deku — AI Marketing & Design Team

Deku gives your brand a full marketing and design department powered by AI.

**Jinu** is your Chief Marketing Officer. He runs a research team that maps your market, profiles your buyers, finds your competitors, identifies KOLs, discovers retail distribution opportunities, and builds your content strategy — all documented automatically in Notion.

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

**Step 1 — Clone and run setup**

```bash
git clone https://github.com/bodhiputra/deku.git
cd deku
./setup.sh
```

Setup will check your system, create the files it needs, and tell you exactly what to do next.

---

**Step 2 — Open Claude Code and run setup**

In the project folder, run:

```bash
claude
```

Then say:

```
setup Jinu
```

Your Claude Code assistant will read the setup guide, run the setup script on your behalf, walk you through the Chrome connection step, and tell you when everything is ready. You just follow along.

---

During setup, your assistant will also connect Notion and Figma for you — a browser window will open for each, you log in and click Allow. This is how Jinu writes research findings to Notion automatically and how Nagi saves design work to Figma.

---

**Step 3 — Meet Jinu**

Once setup is complete, your assistant will tell you to say:

```
Jinu, let's get started
```

Jinu will introduce himself, ask you about your brand, and guide you through everything from there.

---

## What happens next

Jinu starts with a short conversation — about 15 minutes. He asks about your brand, your product, your goals, and your market. Then he briefs his research team and the work begins.

A full research run takes about 3 hours and runs completely on its own. You come back to a full report covering:

- Your market — size, growth, key dynamics
- Your competitors — who they are, how they position, where the gaps are
- Your buyers — who's actually buying at your price tier, what they care about, what frustrates them
- Market opportunity — how big the addressable market is
- KOLs — ranked shortlist with fit reasoning
- Retailers — distribution opportunities by market
- Content strategy — what to make, for whom, on which platform
- Positioning — where your brand should sit and what to say

Everything is documented in Notion with links to the full data.

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
Make sure Chrome is open and `chrome://inspect/#devices` has "Discover network targets" toggled ON.

**Notion isn't connecting**
Run `claude` in the project folder and follow any OAuth prompts that appear.

**Skills or MCPs seem missing**
Run `./setup.sh` again — it's safe to re-run and will only create what's missing.

**Something else**
Say `Jinu, something isn't working` and describe what you see. He'll diagnose it.
