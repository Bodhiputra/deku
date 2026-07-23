# Deku — Assistant Manual
*For host assistants helping brand owners set up and use Jinu, Nagi, and Koji on Claude Code, Codex, and Cursor.*

---

## What this project is

**Deku** is a platform-neutral AI company system. It gives brand owners access to canonical department leads through the current host platform.

| Name | Meaning |
|---|---|
| **Deku** | Repo and project name for the AI agentic company system |
| **Local folder** | Whatever you named the clone (e.g. `finecoustic/`) — paths in docs are relative to it |
| **Brand** (e.g. Finecoustic) | A client brand configured in `context/` — not the Deku system |

- **Jinu** — Chief Marketing Officer. Works task by task — market research, competitor intelligence, buyer profiling, market sizing, KOL discovery, retailer research, content strategy, and positioning. Findings go to the brand owner's documentation platform (Notion if they use it, otherwise structured reports).
- **Nagi** — Chief Design Officer. Handles all design work: brand identity, web design, social assets, presentations, ad creatives. All work is saved to Figma.
- **Koji** — Chief Operating Officer. Handles product catalog, inventory, B2B accounts, platform sync, and ops reporting. Where stock is tracked and reviewed is the brand owner's choice — Koji adapts; no dashboard or website required.

Some platforms expose them inline through persona switching. Others may expose them through native agent surfaces. That exposure model is an adapter concern, not the canonical system design.

Current first-class host adapters in this repo:
- Claude Code
- Codex
- Cursor

---

## Your role as the brand owner's assistant

When a brand owner says **"setup Deku"** (or asks for setup help after cloning), your job is to:

1. **Check prerequisites first** — especially Node.js (see §1 below). Do not run `./setup.sh` until Node.js is installed.
2. Run `./setup.sh` on their behalf
3. Walk them through the Chrome debugging step (see below — this is your tutorial to deliver, not Jinu's)
4. Ask which documentation platform they use — connect Notion OAuth only if they use Notion (see §4)
5. Guide them through Figma OAuth only if they plan to use Nagi
6. Confirm everything is working
7. Tell them they're ready — recommend **`Jinu, let's get started`** for first-time brand onboarding, or any chief (`Nagi`, `Koji`) as needed
8. Hand the brand owner **`context/jinu-user-guide.md`** — *"This is your step-by-step guide for working with Jinu. He'll walk you through it on first contact, or you can skim it anytime."*
9. Step back — chiefs own their domains from that point

**You are the setup guide.** After setup, the brand owner calls **Jinu**, **Nagi**, or **Koji** by name.

**Legacy alias:** If someone says **"setup Jinu"**, treat it the same as **"setup Deku"** (old phrasing before the full team existed).

Canonical architecture reference: `core/ARCHITECTURE.md`

---

## Setup — what to do and in what order

### 1. Prerequisites check — run this BEFORE setup.sh

**Stop and help the user install missing required tools before running `./setup.sh`.**

The brand owner needs:
- **Node.js installed** (`node -v` to verify) — **required**; `./setup.sh` exits if missing
- At least one first-class supported host assistant
- Google Chrome installed
- uv installed (`uvx --version` to verify) — for Reddit research. Optional but recommended.
- A Notion account — **only if** they use Notion as their documentation platform
- A Figma account — **only if** they plan to use Nagi

For CLI hosts, verify what is available:
- Claude Code: `claude --version`
- Codex: `codex --version`

Cursor is an app, not a required CLI binary.

If Node.js is missing, tell the user:

*"Before we can set up Deku, you need Node.js installed — it's what powers the research tools behind the scenes. Install it from nodejs.org (the LTS version is fine), then come back and say 'setup Deku' again."*

Do not proceed to `./setup.sh` until Node.js is confirmed.

If no supported host assistant is available, help them install one before proceeding.

### 2. Run setup.sh

```bash
./setup.sh
```

This creates all required config files, scaffolds the context directory, and prints a clear summary of what manual steps remain. It is safe to re-run.

What it creates:
- `.playwright-mcp-config.json` — browser config for public site scraping
- `.env` — local API keys (from `.env.example`; gitignored) — **single source of truth for secrets**
- `.claude/settings.local.json` — Claude host settings (synced from `.env` by setup.sh)
- `context/brand-context.md` — brand details (filled by Jinu during onboarding)
- `context/session-context.md` — rolling session state

Codex and Cursor use their own adapter surfaces already present in the repo.

What it does NOT do (manual steps required):
- Enable Chrome debugging (one-time toggle in Chrome)
- Connect documentation platform (Notion OAuth — only if the user uses Notion)
- Authenticate Figma (OAuth — only if the user plans to use Nagi)

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

### 4. Documentation platform and MCP authentication — your job to trigger and guide

**Ask first — do not assume Notion.**

*"Where do you want Jinu's research findings saved? Most people use Notion, but you can also get structured reports directly in this chat or as markdown files — no Notion account needed."*

**If they use Notion:** proceed with Notion OAuth below.

**If they do not use Notion:** skip Notion OAuth. Record their choice in `context/brand-context.md` under Documentation → Platform. Jinu delivers findings as structured markdown in chat or local files (see `.claude/agents/jinu.md` — Non-Notion Delivery).

**Figma** — same pattern: only connect if they plan to use Nagi.

Authentication doesn't happen automatically — you trigger it by calling a tool from each connected service, then guide the brand owner through the browser approval flow.

Do this during setup, before the brand owner calls Jinu for research tasks.

---

**Notion authentication (only if user chose Notion):**

Notion is Jinu's preferred write surface when the brand owner uses it. Without OAuth, Jinu cannot write to their Notion workspace — but can still deliver findings in chat or local files.

To trigger: call any Notion MCP tool — for example, search for a page or list workspaces. The current host assistant should return an authentication URL instead of a result.

**What to say to the brand owner:**

*"I'll connect to your Notion account so Jinu can write research findings there automatically. A browser window is about to open — log in with your Notion account and click 'Allow'. That's it."*

Then open the authentication URL. The brand owner logs in and approves. Once done, Notion MCP tools will work without interruption.

If they chose Notion but don't have an account yet: *"Notion is free — you can sign up at notion.so. It takes about two minutes. Once you're in, come back and I'll connect it."*

---

**Figma authentication:**

Figma is where Nagi saves all design work. Only required if the brand owner plans to use the design department.

To trigger: call any Figma MCP tool — for example, `whoami`. The current host assistant should return an authentication URL.

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

Canonical MCP definitions live at the project root. Adapters may load them differently, but the company should expose the same MCP set across first-class supported hosts.

The five MCP servers:
- **reddit** — buyer research, community intelligence
- **chrome** — browsing login-gated platforms (Instagram, TikTok, etc.)
- **playwright** — scraping public websites (competitor pages, product listings)
- **notion** — reading and writing research findings (when brand owner uses Notion)
- **figma** — reading and writing design work

If a server isn't responding, the easiest fix is to re-run `./setup.sh` and restart the current host assistant.

---

### 6. Optional API keys (`.env`) — explain in plain language

Most brands never touch `.env` on day one. OAuth handles Notion and Figma in the chat UI. Two **optional** keys speed up specific tasks — only introduce them when relevant.

**When to mention each key:**

| Key | Needed for | How to explain to the brand owner |
|---|---|---|
| *(none)* | Market research, competitors, buyers, content strategy | "You're all set — no API keys needed." |
| **Notion MCP (OAuth)** | Jinu writing to Notion in chat | Covered in §4 — browser Allow flow |
| **`NOTION_API_KEY`** | KOL dedup sync (`sync-kol-list.js`) | *"For creator dedup, I use a small Notion integration token in a local file — not shared in git. I'll walk you through creating one in Notion when we start KOL work. Takes about two minutes."* |
| **`NOTION_KOL_DATABASE_ID`** | Same — which database to sync | Jinu collects during onboarding → `brand-context.md` Documentation |
| **`YOUTUBE_API_KEY`** | Faster YouTube KOL stats | Jinu offers before every KOL task (see `jinu.md`) — *"Optional speed-up; manual collection works too."* |

**Rules for the setup assistant:**
- Never ask for all keys upfront — introduce only when the brand owner's first task needs them.
- Jinu walks through Google Console / Notion integration steps **one screen at a time** if the owner opts in.
- If they skip keys: KOL still works (manual YouTube; Notion writes via MCP OAuth; dedup via `--check` when token is added later).
- Keys live in `.env` only — never commit, never paste in chat.

---

## How to call Jinu, Nagi, and Koji

Once setup is complete and the host assistant is running, the brand owner calls them by name:

```
Jinu, let's get started
```

The current host assistant will adopt Jinu's persona and begin onboarding.

```
Nagi, I need a landing page design
```

The current host assistant will adopt Nagi's persona and begin the design brief.

```
Koji, what's our stock situation?
```

The current host assistant will adopt Koji's persona and load ops data.

To switch back to the regular host assistant:
- Address the assistant directly (by whatever name the brand owner uses for it)

The host assistant is **not** a Deku canonical agent — each owner chooses their own name (e.g. *Jarvis* on this workspace). Jinu, Nagi, and Koji are Deku chiefs and exist only in this repo.

**Important to explain to the brand owner:** Jinu, Nagi, and Koji are not separate products. They are canonical chiefs exposed through the current host assistant. Depending on the host, this may appear as inline persona switching or a native agent surface. The company behavior should remain the same.

---

## What Jinu does — explaining to brand owners

When a brand owner asks what Jinu does, explain it this way:

*"Jinu is your Chief Marketing Officer. He does everything a professional marketing department does — maps your market, profiles your buyers, finds your competitors, identifies which influencers (KOLs) to work with, finds retail distribution opportunities, and builds your content strategy. If you use Notion, he documents everything there; otherwise you get structured reports in chat or as files.*

*You work with Jinu task by task. Tell him what you need — 'research my competitors', 'find KOLs in the US', 'size my market' — and he goes and does it. Each task takes about 30–60 minutes.*

*You don't need to understand how the research works — just tell Jinu what your product is and what you need. He handles the rest."*

---

## What Nagi does — explaining to brand owners

*"Nagi is your Chief Design Officer. He handles all visual work — brand identity, website design, social media assets, presentations, ad creatives, everything. He writes the design in HTML/CSS first (which is the most precise way to control layout and typography), then pushes it directly to Figma so you can edit it there.*

*Nagi reads Jinu's research from Notion, so he already knows your buyer personas, competitors, and positioning before he starts designing. The marketing and design departments are connected."*

---

## What Jinu can research — task menu

Explaining to a brand owner what they can ask Jinu to do:

| Task | What Jinu delivers |
|---|---|
| Research the market | Industry size, growth rate, key trends, where the activity is |
| Research competitors | Who they are, how they position, where they're weak |
| Research buyers | Who's actually buying, what drives them, what frustrates them, their exact words |
| Size the market | TAM/SAM/SOM in plain numbers — what Year 1 looks like |
| Find KOLs | Ranked shortlist by platform, content fit, and engagement |
| Find retailers | Distribution opportunities by market — specific retailer targets |
| Build a content strategy | What to make, for whom, on which platform, in what order |
| Positioning | Where the brand should sit, what to say, what not to say |

---

## Run modes — explaining to brand owners

For each task, Jinu can work in one of two modes:

**Autonomous:** Jinu runs the task without check-ins. The brand owner comes back to completed findings. Good for straightforward tasks where the scope is clear.

**Interactive:** Jinu gives a brief update when something interesting comes up — an unexpected finding, a question about scope, or a fork in the research. Good for exploratory tasks where the brand owner wants visibility.

Default is Interactive. The brand owner can change the mode per task.

---

## Common questions from brand owners

**"Do I need to watch it run?"**
No. Give Jinu the task and you can step away. Each task runs on its own — typically 30–60 minutes — and Jinu will update you when it's done.

**"Where do my research findings go?"**
If you use Notion, everything goes there automatically — research databases plus narrative reports. If not, Jinu delivers structured written reports in chat or as local markdown files — same content, different packaging.

**"How long does a task take?"**
Typically 30–60 minutes depending on the task. KOL discovery and market sizing tend to take longer. Competitor research and trend checks are faster.

**"Can I do research for a new product?"**
Yes. Each task can be scoped to a specific product. Jinu will ask which product the task is for before starting.

**"Can Jinu and Nagi work at the same time?"**
Yes. Open two terminal windows in the project directory — run `claude` in each. Jinu and Nagi can run simultaneously. Nagi reads Jinu's findings from Notion, so any completed research is available to Nagi immediately.

**"What if I'm not technical?"**
You don't need to be. Just talk to Jinu normally. He asks questions in plain English and explains everything he needs from you before starting.

---

## File structure reference

```
project-root/                    ← Deku repo (local folder name may differ, e.g. finecoustic/)
├── core/
│   ├── ARCHITECTURE.md          ← Platform-neutral architecture
│   ├── COMPANY.md               ← Company operating rules (persona, MCP, permissions)
│   └── adapters/                ← Host adapter manifests
├── .mcp.json                    ← MCP configs (Claude Code)
├── .env.example                 ← Secret template (.env is gitignored)
├── CLAUDE.md                    ← Claude Code adapter (thin)
├── AGENTS.md                    ← Codex adapter (thin)
├── MANUAL.md                    ← This file
├── README.md                    ← Setup guide for brand owners
├── setup.sh                     ← One-time setup script
├── context/
│   ├── brand-context.md         ← Brand facts (gitignored)
│   ├── session-context.md       ← Research state (gitignored)
│   ├── ops-context.md           ← Ops config per brand (gitignored)
│   └── confirmed-markets.md     ← Tiered market list (written by Jinu after Phase 0)
└── .claude/
    ├── BOOTSTRAP.md             ← Session checklist (all hosts)
    ├── agents/                  ← Jinu, Nagi, Koji definitions
    ├── departments/             ← Department operating manuals
    ├── skills/                  ← Shared workflow library
    └── memory/                  ← Chief memory + feedback files
```

**How company rules load:** `.claude/BOOTSTRAP.md` runs every session and requires `core/COMPANY.md` for persona switching, MCP policy, and permissions. Department detail lives in `.claude/departments/`. Host adapters (`CLAUDE.md`, `AGENTS.md`, `.cursor/rules/`) only wire each platform — they do not restate company rules.

**What brand owners can configure:** `context/brand-context.md` is the configuration layer.

**Do not commit:** `.env`, `context/*` private state files, `.cursor/tmp/`, `.agents/skills.bak.*/`, `proofs/`, `output/`. See `.gitignore`.

**What brand owners should never touch:** `.claude/agents/`, `.claude/departments/`, `.claude/skills/`, `.claude/memory/`, `core/`, adapter configs. If something isn't working, check `context/brand-context.md` first.

---

## What to do if something isn't working

| Problem | Fix |
|---|---|
| Chrome MCP not connecting | Make sure Chrome is open, go to `chrome://inspect/#remote-debugging`, toggle "Allow remote debugging for this browser instance" ON |
| Notion MCP not responding | Re-run `./setup.sh`, restart the current host assistant, re-approve OAuth |
| Figma MCP not responding | Same as Notion |
| Reddit MCP not working | Install uv: `curl -LsSf https://astral.sh/uv/install.sh \| sh` |
| Playwright not launching | Re-run `./setup.sh` to regenerate `.playwright-mcp-config.json` |
| Skills not loading | All skills are local files in `.claude/skills/` — nothing to install. If a skill is missing, run `git checkout .claude/skills/<skill-name>/` to restore it from the repo. |
| Jinu not responding | Make sure you said "Jinu, ..." — the trigger is addressing him by name |
