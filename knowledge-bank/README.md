# Knowledge Bank

Senku's local markdown store. He learns from **two inputs**:

1. **What you give him** — spec sheets, URLs, pasted notes, product pages
2. **What he finds** — internet research (web, Reddit, public docs)

Everything worth keeping goes into markdown files under `brands/<your-brand>/<industry>/`. Content is **gitignored** — stays on your machine.

## How to use Senku (plain language)

| You say | Senku does |
|---|---|
| *"Learn from this URL / spec"* | Ingests your data → saves to bank |
| *"Research [topic]"* | Web research → writes `topics/<topic>.md` |
| *"Explain [concept]"* | Answers from bank; researches if missing |
| *"Bootstrap the bank"* | Optional one-time overview + glossary |

There is **no fixed pass sequence**. Supply chain and regulatory are **not built unless you ask**.

## Example — Finecoustic (consumer portable audio)

Bank path: `knowledge-bank/brands/finecoustic/consumer-portable-audio/`

Good first prompts:

- *"Senku, learn my industry"* — assign consumer portable audio + scaffold bank
- *"Senku, bootstrap the bank"* — optional category overview
- *"Senku, research portable Bluetooth speaker specs"*
- *"Senku, learn from [paste FBS/FBB factory doc or URL]"*

## Committed vs local

| Committed | Local (gitignored) |
|---|---|
| `_template/`, this README | `brands/*/` bank content |
| `context/industry-context.example.md` | `context/industry-context.md` |
