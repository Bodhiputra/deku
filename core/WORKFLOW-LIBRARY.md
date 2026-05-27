# Shared Workflow Library — Path Strategy
*Version 1.0 — 2026-05-28*

This document defines how skills and the broader shared runtime are resolved across hosts. It is part of the platform-neutral architecture (`core/ARCHITECTURE.md`).

---

## Principle

**Semantic name:** shared workflow library  
**Not:** "Claude skills" or "Codex skills"

The library is company infrastructure. Host adapters only alias it for their own discovery mechanisms.

---

## Current layout (stable — do not rename without migration plan)

```
.claude/                          ← shared runtime root (historical folder name)
├── BOOTSTRAP.md
├── TASK-DOD.md
├── agents/
├── departments/
├── memory/
└── skills/                       ← canonical skill files live here

.agents/
└── skills → ../.claude/skills    ← Codex alias only (symlink)
```

| Host | How it resolves skills |
|---|---|
| **Claude Code** | `.claude/skills/<name>/SKILL.md` |
| **Cursor** | `.claude/skills/<name>/SKILL.md` (via rules + BOOTSTRAP) |
| **Codex** | `.agents/skills/<name>/SKILL.md` (symlink to same files) |

**Rule for all agents:** Match task → read `.claude/skills/<skill-name>/SKILL.md` → execute.  
Codex may discover via `.agents/skills/`; content is identical.

---

## Why `.claude/skills/` is still the physical path

Renaming the tree (e.g. to `runtime/` or `company/`) would touch:

- Every skill reference in agents, departments, BOOTSTRAP, Cursor rules
- Codex agent toml files
- Memory feedback files
- Git history and active clones

**Decision:** Keep physical path `.claude/skills/` for now. Treat the folder name as legacy implementation detail. Semantic ownership is documented here and in `core/ARCHITECTURE.md`.

A future rename is optional and requires a dedicated migration (not part of current architecture track).

---

## Codex alias (`.agents/skills/`)

Codex discovers project skills under `.agents/skills/` per its conventions. This repo uses a **symlink**, not a copy:

```
.agents/skills → ../.claude/skills
```

**Created by:** `./setup.sh`  
**Must never be:** a real directory with duplicated skill files (causes drift and was the source of past symlink/recursion issues)

### Historical breakage (resolved)

Previously `.agents/skills` was a full directory copy. `setup.sh` now:

1. Backs up duplicate directories to `.agents/skills.bak.<timestamp>`
2. Replaces with a single symlink to `.claude/skills`
3. Verifies a sample skill is reachable through the alias

### Anti-pattern — circular symlinks (never do this)

**Never** symlink individual skill folders inside `.claude/skills/` back to `.agents/skills/`:

```
# WRONG — infinite loop
.claude/skills/copywriting → ../../.agents/skills/copywriting
.agents/skills → ../.claude/skills
```

Canonical skill **content** must live as real files under `.claude/skills/`. Only the top-level `.agents/skills` alias is allowed.

`setup.sh` detects and fails on skill entries that are symlinks pointing into `.agents/`.

---

## Shared runtime beyond skills

These also live under `.claude/` today (same historical path):

| Path | Purpose |
|---|---|
| `.claude/agents/` | Chief definitions (Jinu, Nagi, Koji) |
| `.claude/departments/` | Department operating manuals |
| `.claude/memory/` | Cross-session feedback and rules |
| `.claude/BOOTSTRAP.md` | Session checklist (all hosts) |
| `.claude/TASK-DOD.md` | Definition of done |

Host-neutral company rules: `core/COMPANY.md`  
Host wiring: `CLAUDE.md`, `AGENTS.md`, `.cursor/rules/`, `.codex/`

---

## Verification

After `./setup.sh`, confirm:

```bash
test -L .agents/skills && readlink .agents/skills
test -f .agents/skills/kol-discovery/SKILL.md && echo OK
test -f .claude/skills/kol-discovery/SKILL.md && echo OK
```

Both `OK` means alias and canonical path match.

---

## Future migration (deferred)

If the tree is renamed (e.g. `.claude/` → `runtime/`):

1. Update this document and `core/ARCHITECTURE.md` first
2. Add symlinks from old paths for one release cycle
3. Update all adapters and BOOTSTRAP in one pass
4. Run verification script on all three hosts

Until that migration runs, **`.claude/skills/` is canonical.**
