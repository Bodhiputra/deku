# Platform-Neutral Architecture
*Last updated: 2026-05-28*

This file is the canonical architecture source of truth for the AI company system.

**Project name:** **Deku** — the platform-neutral AI agentic company (GitHub repo: `deku`).  
**Local folder:** Whatever you named the clone (e.g. `finecoustic/` on this machine). Paths in docs are relative to that folder.  
**Brand workspaces:** Brands you run on Deku (e.g. Finecoustic) live in `context/` and `ops-hub/brands/<slug>/` — not the same as the Deku project name.

The system is not Claude-first, Codex-first, or Cursor-first.

## Core Principles

1. Canonical company logic is platform-neutral.
2. Host assistants are adapters, not canonical company agents.
3. Jinu, Nagi, Koji, and future department leads are independent canonical agents.
4. Platform-specific tool names, command syntax, and config details stay in adapter files.
5. Brand state lives in workspace context files, not in adapter config.
6. Secrets, machine-local paths, and local auth state must not define the architecture.

## Canonical Entity Model

### Agents

Canonical agents are business roles:

- `Jinu` — marketing
- `Nagi` — design
- `Koji` — operations

The host assistant on each platform may expose these agents through persona switching, delegation, or separate agent runtimes. That exposure model is an adapter concern.

### Skills

Skills are reusable workflow assets. They define how work is executed, what inputs are required, what evidence standards apply, and what counts as done.

**Path strategy:** `core/WORKFLOW-LIBRARY.md`

Today the shared skill library lives under `.claude/skills/`. That path is historical. It should be treated as the current shared workflow library, not as proof that the workflows belong only to Claude. Codex resolves the same files via `.agents/skills/` (symlink).

### Memory

Memory stores durable agent feedback, behavior corrections, and cross-session rules. Memory belongs to canonical agents, not to any one host platform.

### Workflows

Workflows are repeatable operating procedures built from skills plus rules:

- research workflows
- design workflows
- operations workflows
- handoff workflows
- review workflows

### Contexts

Contexts store brand and session state:

- `context/brand-context.md`
- `context/session-context.md`
- `context/confirmed-markets.md`
- `context/architecture-session-context.md`

These files are workspace state, not platform state.

### Workspaces

Workspaces hold brand-specific implementations and outputs.

Examples in this repo:

- **Deku repo root** — the AI company system checkout (local folder name is arbitrary; e.g. `finecoustic/`)
- `ops-hub/` — operations UI and data for brands running on Deku

**External to this repo:** storefront theme code lives in a separate gitignored repo (`shopify/`). It is not part of the AI company system. Koji may sync **store data** from Shopify Admin via the `shopify-sync` skill — that is a platform integration, not the theme codebase.

### Platform Adapters

Platform adapters translate the canonical system into each host environment:

- `.claude/` — Claude adapter (also hosts shared runtime library)
- `.codex/` — Codex adapter
- `.cursor/` — Cursor adapter

Adapters may define:

- host-specific bootstrap rules
- MCP wiring
- prompt formatting
- local permissions
- persona exposure method

Adapters must not redefine canonical business logic unless there is a host-specific constraint.

## Platform Adapter Contract

**Full specification:** `core/HOST-ADAPTER-SPEC.md`

Every supported host platform must expose the same company system after setup. File formats may differ, but the observable company behavior must match. Named platforms (Claude Code, Codex, Cursor) are implementations of the generic host adapter spec — not the spec itself.

### Required parity across supported hosts

After `setup.sh` completes, a user on any first-class supported host should get:

1. The same canonical chiefs:
   - `Jinu`
   - `Nagi`
   - `Koji`
   - future chiefs added to the canonical core
2. The same context model:
   - `context/brand-context.md`
   - `context/session-context.md`
   - `context/confirmed-markets.md`
3. The same shared workflow library:
   - agents
   - departments
   - skills
   - memory
   - definition of done
4. The same onboarding flow:
   - clone repo
   - run `setup.sh`
   - open host assistant
   - say `setup Deku`
5. The same company-level operating rules:
   - skill loading is mandatory
   - context loading is mandatory
   - tool-selection policy is consistent
   - quality gates are consistent

### What adapters may vary on

Adapters may vary only in host-specific mechanics:

- config file format
- MCP registration mechanism
- hook/event wiring
- persona invocation syntax
- whether agents run inline or through native agent surfaces

### Support tiers

- `first-class supported` — Claude Code, Codex, Cursor

These three hosts are the complete supported surface. New hosts may be added later by implementing `core/HOST-ADAPTER-SPEC.md` and adding a manifest to `core/adapters/`.

## Collaboration Model

The canonical multi-agent model supports these modes:

- `direct mode` — user talks to one agent directly
- `discussion mode` — two or more agents discuss inline
- `handoff mode` — one agent completes work and passes state to another
- `parallel mode` — multiple agents execute separate workstreams concurrently
- `review mode` — one agent critiques another agent's output against a quality gate

If a host platform cannot run true parallel agents, it may simulate the interaction inline. That limitation belongs to the adapter layer, not the canonical design.

## Current Transitional Rule

The repo is mid-migration.

For now:

- `core/ARCHITECTURE.md` is the canonical architecture source of truth
- `.claude/` remains the current shared workflow library and most complete runtime definition
- `.codex/` and `.cursor/` should reference that shared workflow library instead of forking it

This keeps the system working while the neutral core is separated from adapter-specific implementation.

## Migration Map

### Canonical core

- `core/ARCHITECTURE.md`
- `core/COMPANY.md`
- `core/WORKFLOW-LIBRARY.md`
- `core/HOST-ADAPTER-SPEC.md`
- `core/adapters/` — host adapter manifests
- `context/architecture-session-context.md`

### Shared workflow library

- `.claude/agents/`
- `.claude/departments/`
- `.claude/skills/`
- `.claude/memory/`
- `.claude/TASK-DOD.md`
- `.claude/BOOTSTRAP.md`

### Platform adapters

- `AGENTS.md` — Codex adapter instructions
- `CLAUDE.md` — Claude adapter instructions
- `.codex/`
- `.cursor/`
- `.claude/settings.json`
- `.claude/settings.local.json`

### Brand workspace state

- `context/brand-context.md`
- `context/session-context.md`
- `context/confirmed-markets.md`

### In-repo implementation workspaces

- `ops-hub/`
- `output/`
- `proofs/`

### External projects (not in this repo)

- `shopify/` — storefront theme codebase; separate git repo, gitignored. Not part of the AI company architecture.

### Legacy or archive

- `.claude/_archived/`
- `.claude/archive/`
- `.agents/skills.bak.*`

### Local-only or secret-bearing surfaces

- `.env`
- machine-local adapter config with absolute paths
- adapter settings carrying API tokens or local auth assumptions

These surfaces must be treated as non-canonical even if they are currently operationally necessary.

## Refactor Rules From This Point

1. New cross-platform architectural decisions go here first.
2. Adapter docs should reference this file instead of restating architecture from scratch.
3. Canonical logic should move out of host-specific wording over time.
4. No platform adapter should become the sole source of truth for agent identity or workflow behavior.
5. Secret-bearing and machine-specific config should be isolated from portable repo logic.
