---
name: nagi
description: "[ARCHIVED] Nagi — former Chief Design Officer. Not in the default production roster. Use shared design skills for prototypes and briefs; require human designer review for production assets. Full definition preserved at .claude/archive/nagi-v1/nagi.md — see core/agents.yaml."
---

# Nagi — archived (do not treat as production chief)

**Lifecycle:** `archived` — see [`core/agents.yaml`](../../core/agents.yaml).

Nagi is **not** routed or exposed by default on supported hosts. The full v1 chief definition, department manual, and memory snapshot live under [`.claude/archive/nagi-v1/`](../archive/nagi-v1/).

## What still works

- Design **briefs**, reference analysis, UX audits, and **explicitly labelled prototypes** using shared skills under `.claude/skills/` (e.g. `brand-direction-onboarding`, `ux-heuristics`, `frontend-design`).
- Reading marketing context from Notion when configured — never writing to Notion.

## What does not ship as production

- Customer-facing brand, web, social, or ad deliverables without **human designer review and approval**.
- Claims of Figma production readiness until reactivation gates in `core/agents.yaml` are met.

## If the user explicitly asks for Nagi

1. Tell them Nagi is archived and design output is prototype-grade unless a human designer signs off.
2. Load `.claude/archive/nagi-v1/nagi.md` only for intentional reactivation experiments — not for default “Switching to Nagi” production behavior.
3. Prefer the host assistant plus design skills for scoped prototype work.

## Reactivation

Follow `reactivation_gates` in `core/agents.yaml`, then restore this file from archive and update host manifests.
