# Codex Chief Configs

Thin adapter surfaces for Codex native agent invocation. **Not the source of truth.**

| File | Canonical chief definition |
|---|---|
| `jinu.toml` | `.claude/agents/jinu.md` |
| `koji.toml` | `.claude/agents/koji.md` |
| `senku.toml` | `.claude/agents/senku.md` |
| `nagi.toml` | **Archived** — stub only; see `core/agents.yaml` and `.claude/archive/nagi-v1/` |

Each toml provides `name`, `description`, and bootstrap pointers only. Full operating manuals, task menus, and quality gates live in `.claude/agents/` + departments + skills.

Spec: `core/HOST-ADAPTER-SPEC.md` §5, §12 (no canonical logic forked into adapter-only files).
