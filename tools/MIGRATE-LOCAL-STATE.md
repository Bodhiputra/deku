# Migrate local state (keys + gitignored data)

Git push covers **code only**. This flow moves **secrets and local context** between machines (e.g. Mac mini → Windows laptop).

## What is not in GitHub

| Repo | Copy manually |
|------|----------------|
| **Deku** | `.env`, `context/`, `knowledge-bank/brands/`, optional `fonts/`, `.claude/settings.local.json` |
| **Shopify** | `.env`, `context/`, optional `.shopify/`, `shopify.theme.toml` |
| **Finehub** | `.env.local`, `brands/finecoustic/ops-data.json`, `data/` |
| **Either** | GA4/gcloud JSON if referenced by `GOOGLE_APPLICATION_CREDENTIALS` |

MCP **OAuth** (Notion, Figma) is not in files — sign in again in Cursor on the new machine.

---

## Step A — Mac mini (after `git push`)

From Deku repo root:

```bash
chmod +x tools/migrate-local-state-export.sh
./tools/migrate-local-state-export.sh
```

Default output: `~/Desktop/laptop-local-state-YYYYMMDD/local-state-bundle/`

Encrypt and move:

```bash
zip -er ~/Desktop/deku-local-state-YYYYMMDD.zip ~/Desktop/laptop-local-state-YYYYMMDD/local-state-bundle
```

Use USB or AirDrop. Do not email the zip.

If Shopify or Hub live elsewhere:

```bash
SHOPIFY_ROOT=/path/to/shopify HUB_ROOT=/path/to/finecoustic-ops-hub ./tools/migrate-local-state-export.sh
```

---

## Step B — Laptop (Windows, native)

### 1. Clone three repos (same layout)

```text
C:\dev\finecoustic
C:\dev\finecoustic\shopify
C:\dev\finecoustic-ops-hub
```

```bash
cd C:/dev
git clone git@github.com:Bodhiputra/deku.git finecoustic
git clone git@github.com:Bodhiputra/FinecousticSite.git finecoustic/shopify
git clone git@github.com:Bodhiputra/finecoustic-hub.git finecoustic-ops-hub
```

(Use HTTPS remotes if you prefer.)

### 2. Unzip the bundle

Extract `local-state-bundle` anywhere (e.g. `C:\Users\You\Downloads\local-state-bundle`).

### 3. Import (Git Bash)

```bash
cd /c/dev/finecoustic
chmod +x tools/migrate-local-state-import.sh
./tools/migrate-local-state-import.sh "/c/Users/You/Downloads/local-state-bundle" "/c/dev"
```

Or run the copy of `migrate-local-state-import.sh` inside the bundle.

### 4. Fix Windows paths

Open `C:\dev\finecoustic\.env` and set `GOOGLE_APPLICATION_CREDENTIALS` to where you placed the gcloud JSON (or re-run `tools/ga4-auth-setup.sh` in Git Bash).

### 5. Finish setup

- Deku: `./setup.sh` (Git Bash) — optional if you merged `.env` already
- Finehub: `npm install` → `npm run dev`
- Shopify: `shopify auth login`
- Cursor: 3-folder workspace + MCP OAuth

---

## Verify

- [ ] `finecoustic/context/session-context.md` exists and looks current
- [ ] `knowledge-bank/brands/finecoustic/...` includes your xlsx files
- [ ] `shopify/context/shopify-context.md` exists
- [ ] `git status` in each repo does **not** show `.env` as tracked
- [ ] One MCP or script that needs `.env` works

Keep the Mac mini until this checklist passes.
