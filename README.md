# Deku — Platform-Neutral AI Company System

Deku is a **multi-agent-capable** company framework: distinct marketing, operations, and product-intelligence chiefs with shared skills, hooks, and brand workspace state. It is not a fully autonomous multi-agent company yet — chiefs are invoked through your host assistant (inline persona or native agents, depending on platform).

> **Naming:** **Deku** = this repo and AI company system. Your local folder can have any name. A client brand is configured in gitignored `context/` files — it is not the same as the Deku system name.

**Active chiefs** (see [`core/agents.yaml`](core/agents.yaml)):

| Chief | Role | Typical output |
|---|---|---|
| **Jinu** | Chief Marketing Officer | Notion (optional) or structured research reports |
| **Koji** | Chief Operating Officer | Your system of record (spreadsheet, Shopify, JSON, chat) |
| **Senku** | Chief Product Intelligence Officer | Local markdown knowledge bank |

**Nagi** (Chief Design Officer) is **archived** — preserved under [`.claude/archive/nagi-v1/`](.claude/archive/nagi-v1/) for reversible reactivation. Design **briefs, UX audits, and labelled prototypes** still use shared design skills; **production design requires a human designer**.

You talk to chiefs through Claude Code, Codex, or Cursor. They do the work; you get the report.

---

## What you need before starting

- macOS or Linux
- **[Node.js](https://nodejs.org)** and **Python 3** — required; `./setup.sh` exits if either is missing
- One supported host: Claude Code, Codex, or Cursor
- Google Chrome (for login-gated browsing / KOL discovery)
- **Notion** (optional) — Jinu can write research there
- **Figma** (optional) — exploration only while Nagi is archived

---

## Getting started

**Step 1 — Clone and open your host**

```bash
git clone https://github.com/Bodhiputra/deku.git
cd deku    # or your chosen folder name
```

- Claude Code: `claude`
- Codex: `codex`
- Cursor: open the folder in Cursor

**Step 2 — Run setup**

Say in chat:

```
setup Deku
```

Your assistant checks **Node.js and Python 3**, runs `./setup.sh`, walks through Chrome remote debugging, and connects Notion (if you use it).

**Step 3 — Meet the team**

```
Jinu, let's get started
```

New brands usually start with Jinu. Call **Koji** or **Senku** when you need ops or product intelligence.

---

## What Jinu does (examples)

- Market, competitor, and buyer research
- Market sizing (TAM/SAM/SOM)
- KOL discovery and retailer research
- Content strategy and positioning

Tasks are scoped one at a time; deliverables go to Notion (if connected) or structured reports in chat.

---

## Calling active chiefs

| To talk to | Say |
|---|---|
| Jinu (marketing) | `Jinu, ...` |
| Koji (operations) | `Koji, ...` |
| Senku (product intelligence) | `Senku, learn my industry` or `Senku, ...` |
| Back to your assistant | Address your assistant directly |

**Design:** ask your assistant for a **design brief or prototype** — not `Nagi, ...` for production work while Nagi is archived.

Example:

```
Jinu, I want to run research on my new product
```

```
Senku, explain how planar magnetic drivers work in our category
```

---

## What stays private (gitignored)

- `context/*` — brand, session, ops, and industry state
- `.env` — API keys (template: `.env.example`)
- `knowledge-bank/brands/` — Senku brand banks
- `proofs/`, `output/`, `research-snapshots/`

Storefront theme code lives in a **separate repository** if you use one — not assumed inside this clone.

See [`.gitignore`](.gitignore) for the full list.

---

## Troubleshooting

**Setup failed — Node.js or Python 3 not found**  
Install both, then say `setup Deku` again.

**Chrome isn't connecting**  
Open `chrome://inspect/#remote-debugging` and enable remote debugging.

**Notion isn't connecting**  
Only if you use Notion — start a fresh host session after OAuth.

**Skills or MCPs seem missing**  
Re-run `./setup.sh` and restart the host.

**Something else**  
Say `Jinu, something isn't working` and describe what you see.
