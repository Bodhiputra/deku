# Deku — Assistant Manual
*For Claude Code assistants helping brand owners set up and use Jinu and Nagi.*

---

## What this project is

Deku is an AI marketing and design team built on Claude Code. It gives brand owners access to two senior roles:

- **Jinu** — Chief Marketing Officer. Runs a full research pipeline: market scoping, competitor intelligence, buyer profiling, market sizing, KOL discovery, retailer research, content intelligence, and positioning. All findings are written to Notion automatically.
- **Nagi** — Chief Design Officer. Handles all design work: brand identity, web design, social assets, presentations, ad creatives. All work is saved to Figma.

Both operate as inline personas — when a brand owner says "Jinu" or "Nagi," Claude Code adopts that persona directly. No subagents, no separate processes.

---

## Your role as the brand owner's assistant

When a brand owner says **"setup Jinu"** (or asks for setup help after cloning), your job is to:

1. Run `./setup.sh` on their behalf
2. Walk them through the Chrome debugging step (see below — this is your tutorial to deliver, not Jinu's)
3. Guide them through Notion and Figma OAuth approval
4. Confirm everything is working
5. Tell them to say "Jinu, let's get started"
6. Step back — Jinu owns the brand relationship from that point

**You are the setup guide. Jinu is the ongoing relationship.**

This entire setup sequence — including Chrome — happens before the brand owner calls Jinu. Jinu only tests Chrome at session start to confirm it's still connected. If it's not, he tells the brand owner to re-enable it — he doesn't give the full tutorial again.

---

## Setup — what to do and in what order

### 1. Prerequisites check

The brand owner needs:
- Node.js installed (`node -v` to verify)
- Claude Code installed (`claude --version` to verify)
- uv installed (`uvx --version` to verify) — for Reddit research. Optional but recommended.
- Google Chrome installed
- A Notion account (free at notion.so)
- A Figma account (free at figma.com)

If anything is missing, help them install it before proceeding.

### 2. Run setup.sh

```bash
./setup.sh
```

This creates all required config files, scaffolds the context directory, and prints a clear summary of what manual steps remain. It is safe to re-run.

What it creates:
- `.playwright-mcp-config.json` — browser config for public site scraping
- `.claude/settings.local.json` — enables all MCP servers for this project
- `context/brand-context.md` — brand details (filled by Jinu during onboarding)
- `context/session-context.md` — rolling session state

What it does NOT do (manual steps required):
- Enable Chrome debugging (one-time toggle in Chrome)
- Authenticate Notion and Figma (OAuth prompts in Claude Code)

### 3. Enable Chrome debugging — your tutorial to deliver

This step is your responsibility as the assistant. Deliver it to the brand owner in plain language before they call Jinu. Jinu will test the connection at session start, but the setup explanation is yours.

**What to say to the brand owner:**

*"Jinu uses your Chrome browser to browse websites on your behalf — things like competitor product pages, Instagram profiles, and other sites that need to be logged in. To allow this, Chrome needs a quick one-time setting:*

*1. Open Chrome (if it isn't already open)*
*2. Click in the address bar and type exactly:*
*`chrome://inspect/#remote-debugging`*
*then press Enter*
*3. A settings page will open. Find the toggle that says:*
*'Allow remote debugging for this browser instance'*
*4. Turn it ON*
*5. That's it — leave Chrome open as you normally would*

*This setting tells Chrome it's okay for Jinu's tools to connect to it. Without this, Jinu can't browse login-gated platforms like Instagram or TikTok, which limits the research quality. You only need to do this once — Chrome remembers it."*

The Chrome MCP uses `--autoConnect` — it automatically finds a running Chrome instance with remote debugging enabled. No port numbers or terminal commands needed on the brand owner's side.

### 4. Authenticate MCPs that need it — your job to trigger and guide

Two MCPs require OAuth authentication before they work: **Notion** and **Figma**. Authentication doesn't happen automatically — you need to trigger it by calling a tool from each, then guide the brand owner through the browser approval flow.

Do this during setup, before the brand owner calls Jinu. Do not wait until Jinu tries to use Notion mid-research and hits an auth error.

---

**Notion authentication:**

Notion is where all research findings are written. Without it, Jinu cannot document anything.

To trigger: call any Notion MCP tool — for example, search for a page or list workspaces. Claude Code will return an authentication URL instead of a result.

**What to say to the brand owner:**

*"I need to connect to your Notion account so Jinu's team can write research findings there automatically. A browser window is about to open — just log in with your Notion account and click 'Allow'. That's it."*

Then open the authentication URL. The brand owner logs in and approves. Once done, Notion MCP tools will work without interruption.

If they don't have a Notion account: *"Notion is free — you can sign up at notion.so. It takes about two minutes. Once you're in, come back and I'll connect it."*

---

**Figma authentication:**

Figma is where Nagi saves all design work. Only required if the brand owner plans to use the design department.

To trigger: call any Figma MCP tool — for example, `whoami`. Claude Code will return an authentication URL.

**What to say to the brand owner:**

*"I need to connect to your Figma account so Nagi can save design work there. Same process — a browser window will open, log in and click Allow."*

If they only need marketing research and don't plan to use Nagi: Figma authentication can be skipped for now. Note this so you can guide them through it if they call Nagi later.

---

**Reddit, Chrome, Playwright — no authentication needed:**

- Reddit MCP connects automatically via `uvx`
- Chrome MCP connects automatically via `--autoConnect` once the browser has remote debugging enabled
- Playwright MCP launches its own browser — no login required

---

### 5. Verify MCPs are active

All MCP servers are defined in `.mcp.json` at the project root. Claude Code loads these automatically when `enableAllProjectMcpServers: true` is set in `.claude/settings.local.json` (which setup.sh creates).

The five MCP servers:
- **reddit** — buyer research, community intelligence
- **chrome** — browsing login-gated platforms (Instagram, TikTok, etc.)
- **playwright** — scraping public websites (competitor pages, product listings)
- **notion** — reading and writing all research findings
- **figma** — reading and writing design work

If a server isn't responding, the easiest fix is to re-run `./setup.sh` and restart `claude`.

---

## How to call Jinu and Nagi

Once setup is complete and `claude` is running, the brand owner calls them by name:

```
Jinu, let's get started
```

Claude Code will adopt Jinu's persona and begin onboarding.

```
Nagi, I need a landing page design
```

Claude Code will adopt Nagi's persona and begin the design brief.

To switch back to the regular Claude Code assistant:
- Address the assistant directly (e.g. "Jarvis, can you check something for me")

**Important to explain to the brand owner:** Jinu and Nagi are not separate apps or separate tabs. They're the same Claude Code session — the persona switches inline. When they say "Jinu" they get Jinu. When they're done and address the assistant normally, Jinu steps back.

---

## What Jinu does — explaining to brand owners

When a brand owner asks what Jinu does, explain it this way:

*"Jinu is your Chief Marketing Officer. He runs a research team that does everything a professional marketing department does — maps your market, profiles your buyers, finds your competitors, identifies which influencers (KOLs) to work with, finds retail distribution opportunities, and builds your content strategy. He documents everything in Notion so you have a real research workspace, not just a chat history.*

*A full research run takes about 3 hours and runs completely on its own. Jinu talks to you for about 15 minutes at the start to understand your brand and product. Then the team goes to work and comes back with a full report.*

*You don't need to understand how the research works — just tell Jinu what your product is and what you're trying to achieve. He handles the rest."*

---

## What Nagi does — explaining to brand owners

*"Nagi is your Chief Design Officer. He handles all visual work — brand identity, website design, social media assets, presentations, ad creatives, everything. He writes the design in HTML/CSS first (which is the most precise way to control layout and typography), then pushes it directly to Figma so you can edit it there.*

*Nagi reads Jinu's research from Notion, so he already knows your buyer personas, competitors, and positioning before he starts designing. The marketing and design departments are connected."*

---

## What the full research pipeline covers

Explaining to a brand owner what a full run produces:

| Area | What Jinu finds |
|---|---|
| Market | Size, growth rate, key trends, where the activity is |
| Competitors | Who they are, how they position, where they're weak |
| Buyers | Who's actually buying, what drives them, what frustrates them, their exact words |
| Market opportunity | TAM/SAM/SOM in plain numbers — what Year 1 looks like |
| KOLs | Ranked shortlist by platform, content fit, and engagement |
| Retailers | Distribution opportunities by market — specific retailer targets |
| Content strategy | What to make, for whom, on which platform, in what order |
| Positioning | Where the brand should sit, what to say, what not to say |

---

## Run modes — explaining to brand owners

Jinu asks at the start of every research run which mode the brand owner prefers:

**Autonomous:** Jinu runs the full research without any check-ins. The brand owner comes back to a completed, validated report. Good for busy founders who want to step away completely.

**Interactive:** Jinu sends a brief update after each major phase — what was found, what's interesting, what's coming next. The brand owner can respond and redirect if needed, or just read. Good for brand owners who want visibility.

Default is Interactive.

---

## Common questions from brand owners

**"Do I need to watch it run?"**
No. You set it up with Jinu at the start (15 minutes), then you can close the laptop or do other work. Jinu runs the pipeline on his own.

**"Where do my research findings go?"**
Everything goes to Notion automatically — 10 research databases plus narrative reports. If you don't have Notion, Jinu can also deliver findings as structured written reports.

**"How long does a full run take?"**
About 3 hours for a full pipeline. Individual targeted runs (just competitors, just KOLs) are much faster — usually 30–60 minutes.

**"Can I run it again if I launch a new product?"**
Yes. Each run can be scoped to a specific product. Jinu asks at intake which product this run is for.

**"Can Jinu and Nagi work at the same time?"**
Yes. Open two terminal windows in the project directory — run `claude` in each. Jinu and Nagi can run simultaneously. Nagi reads from Notion, so Jinu's research findings are available to Nagi immediately.

**"What if I'm not technical?"**
You don't need to be. Just talk to Jinu normally. He asks questions in plain English and explains everything he needs from you before starting.

---

## File structure reference

```
project-root/
├── .mcp.json                    ← All MCP server configs (auto-loaded)
├── .playwright-mcp-config.json  ← Browser config for public scraping
├── CLAUDE.md                    ← Team identity, switching rules, department registry
├── MANUAL.md                    ← This file
├── README.md                    ← Setup guide for brand owners
├── setup.sh                     ← One-time setup script
├── skills-lock.json             ← Community skill versions
├── context/
│   ├── brand-context.md         ← Brand facts (gitignored)
│   ├── session-context.md       ← Research state (gitignored)
│   └── confirmed-markets.md     ← Tiered market list (written by Jinu after Phase 0)
└── .claude/
    ├── agents/                  ← Jinu, Nagi, and all sub-agent definitions
    ├── skills/                  ← Custom skills for the team
    ├── memory/
    │   ├── jinu/                ← Jinu's repo-portable memory (ships with the agent)
    │   └── nagi/                ← Nagi's repo-portable memory (ships with the agent)
    └── settings.local.json      ← Local config and env vars (gitignored)
```

**How CLAUDE.md works:** CLAUDE.md holds the full team specification — identity, persona switching, the complete research pipeline, all coherence rules, tools, and design department rules. Jinu and Nagi each load their own memory at session start from `.claude/memory/jinu/` and `.claude/memory/nagi/` — these are repo-portable files that ship with the team and carry learned behaviors across any brand owner. They also load `context/brand-context.md` and `context/session-context.md` for brand-specific state. You don't need to do anything — it's wired into their session start protocols.

---

## What to do if something isn't working

| Problem | Fix |
|---|---|
| Chrome MCP not connecting | Make sure Chrome is open, `chrome://inspect/#devices` has "Discover network targets" ON |
| Notion MCP not responding | Re-run `./setup.sh`, restart `claude`, re-approve OAuth |
| Figma MCP not responding | Same as Notion |
| Reddit MCP not working | Install uv: `curl -LsSf https://astral.sh/uv/install.sh \| sh` |
| Playwright not launching | Re-run `./setup.sh` to regenerate `.playwright-mcp-config.json` |
| Skills not loading | All skills are local files in `.claude/skills/` — nothing to install. If a skill is missing, run `git checkout .claude/skills/<skill-name>/` to restore it from the repo. |
| Jinu not responding | Make sure you said "Jinu, ..." — the trigger is addressing him by name |
