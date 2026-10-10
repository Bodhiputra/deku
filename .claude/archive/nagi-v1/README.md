# Nagi v1 — archived chief (reversible)

**Status:** archived as of 2026-10-10. Not in the default production roster.

Nagi remains preserved here so the design department can be reactivated without recovering history from git.

## Contents

| File | Role |
|---|---|
| `nagi.md` | Full canonical chief definition at time of archival |
| `design.md` | Department manual |
| `MEMORY.md` | Agent memory snapshot |
| `feedback_brand_typography.md` | Typography feedback rule |

## Active routing

- Default hosts expose **Jinu**, **Koji**, and **Senku** only (`core/agents.yaml`).
- Design production is **prototype / human-review** until reactivation gates pass.
- Shared design skills under `.claude/skills/` remain available for briefs and audits.

## Reactivation

See `reactivation_gates` in `core/agents.yaml`. When ready, restore routing in `core/COMPANY.md`, host manifests, and replace `.claude/agents/nagi.md` stub with an updated production definition.
