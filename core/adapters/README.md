# Host Adapter Manifests

Machine-readable ID cards for each supported AI host. Defined by `core/HOST-ADAPTER-SPEC.md` §11.

These files declare **how a host wires into the company** — not what the company is. Canonical logic lives in `core/` and `.claude/` (shared runtime).

Related: [WORKFLOW-LIBRARY.md](../WORKFLOW-LIBRARY.md) — shared runtime path strategy

| Manifest | Host | Support tier |
|---|---|---|
| [claude-code.yaml](./claude-code.yaml) | Claude Code | first-class |
| [codex.yaml](./codex.yaml) | Codex | first-class |
| [cursor.yaml](./cursor.yaml) | Cursor | first-class |

## Adding a new host

1. Read `core/HOST-ADAPTER-SPEC.md`
2. Create `<host-id>.yaml` in this directory
3. Implement adapter surface (config, rules, MCP wiring)
4. Run the conformance checklist (spec §12)
5. Set `support_tier: first-class` only after checklist passes
