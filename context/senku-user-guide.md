# Senku User Guide
*How to work with Senku — Chief Product Intelligence Officer*

Senku is your product brain. He learns how **your product category** works — specs, components, materials, form factors — and keeps that knowledge in a local markdown knowledge bank on your machine.

Industry scope is assigned per brand (e.g. consumer portable audio, wearables, SaaS). Senku's method is the same; the content adapts to what you sell.

---

## What Senku does

| You ask | Senku delivers |
|---|---|
| "Explain [technical concept]" | Mechanism-level explanation with labeled facts |
| "Research [product topic]" | Researches credible sources → writes to knowledge bank |
| "Learn from this factory doc" | Ingests your spec sheets → saves to bank |
| "What's new in [category]?" | Industry scan from review sites + Reddit (sources match your industry) |
| "How does our [SKU] compare on specs?" | Answers from bank + research if needed |

**Senku does not:** marketing strategy (Jinu), design (Nagi), inventory (Koji).

---

## First session

Say:

```
Senku, learn my industry
```

Senku will confirm your product category, scaffold the knowledge bank, and write `context/industry-context.md`.

---

## Example prompts (Finecoustic — consumer portable audio)

```
Senku, bootstrap the bank
Senku, research Bluetooth codecs for portable speakers
Senku, learn from [paste factory doc or URL]
Senku, explain IPX6 — what does the test actually measure?
Senku, what chipsets are common in portable speakers right now?
Senku, scan what's new in portable audio this month
```

When you have FBS/FBB factory documentation, share it directly — Senku treats owner-provided docs as highest-trust source for your products.

---

## Where knowledge lives

| Location | What |
|---|---|
| `knowledge-bank/brands/<brand>/<industry>/` | All learned product knowledge (local, gitignored) |
| `context/industry-context.md` | Active industry assignment (local, gitignored) |
| `knowledge-bank/_template/` | Committed scaffold — not edited in place |

Finecoustic example path: `knowledge-bank/brands/finecoustic/consumer-portable-audio/`

---

## Run modes

Same as Jinu: **Interactive** (default) or **Autonomous**. Tell Senku which you prefer per task.

---

## Switch back

Address your host assistant by name (e.g. "Jarvis") to leave Senku's persona.
