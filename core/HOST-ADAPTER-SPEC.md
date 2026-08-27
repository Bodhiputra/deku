# Host Adapter Specification
*Version 1.0 — 2026-05-28*

This document defines what every AI host adapter must implement to run the canonical company system. It is platform-neutral by design. Named hosts (Claude Code, Codex, Cursor) are implementations of this spec, not the spec itself.

**Canonical architecture:** `core/ARCHITECTURE.md`  
**Architecture work checkpoint:** `context/architecture-session-context.md`

---

## 1. Purpose

A host adapter translates the portable company core into a specific AI runtime. Adapters are thin. They wire tools, expose chiefs, and load bootstrap rules. They must not redefine business logic, agent identity, or workflow behavior.

The **host assistant** is the brand owner's AI on any platform and in any project — not a canonical company agent. Each owner may use their own name for it (e.g. *Jarvis* is one owner's choice, not a Deku default). This spec applies when the host is running the **Deku** company system; other projects use the same host with their own rules and context.

---

## 2. Layer Model

Every implementation must respect this stack:

| Layer | What it contains | Who owns it |
|---|---|---|
| **Canonical core** | Architecture, entity model, collaboration modes, quality contract | `core/` |
| **Shared runtime assets** | Agents, departments, skills, memory, DOD, bootstrap | Currently `.claude/` (historical path) |
| **Workspace state** | Brand and session context | `context/` |
| **Host adapter** | Config format, MCP wiring, hooks, persona/agent invocation | `.claude/`, `.codex/`, `.cursor/`, etc. |
| **Implementation workspaces** | Brand-specific outputs (gitignored) | `output/`, `proofs/`, paths in `context/ops-context.md` |

Adapters may only vary the bottom two rows' *host-specific mechanics*. Everything above the adapter line is shared and normative.

---

## 3. Required Resolution Paths

Every adapter must resolve these paths from the workspace root. Paths may be symlinked or aliased, but semantic names must not change.

### 3.1 Canonical references

| Path | Purpose |
|---|---|
| `core/ARCHITECTURE.md` | Architecture source of truth |
| `core/HOST-ADAPTER-SPEC.md` | This spec |

### 3.2 Shared runtime (required)

| Path | Purpose |
|---|---|
| `.claude/BOOTSTRAP.md` | Session bootstrap checklist (all hosts) |
| `.claude/TASK-DOD.md` | Definition of done by task type |
| `.claude/agents/` | Canonical chief definitions |
| `.claude/departments/` | Department operating manuals |
| `.claude/skills/` | Shared workflow library |
| `.claude/memory/` | Agent memory and feedback |

> **Transitional note:** `.claude/` is the current shared runtime home. Adapters must treat it as a shared library path, not as proof the system is Claude-specific. Future migration may rename this tree; adapters should reference it via bootstrap, not hardcode "Claude" semantics.

### 3.3 Workspace state (required)

| Path | Purpose |
|---|---|
| `context/brand-context.md` | Permanent brand facts |
| `context/session-context.md` | Rolling agent operational state |
| `context/confirmed-markets.md` | Geo-scoped market list |
| `context/ops-context.md` | Brand ops config (system of record, review surface) |

### 3.4 Onboarding entry (required)

| Trigger | Handler |
|---|---|
| User says `setup Deku` (legacy: `setup Jinu`) | Host assistant reads `MANUAL.md` and runs setup sequence |

---

## 4. Bootstrap Contract

Every session on every host must execute equivalent bootstrap behavior before company work begins.

### 4.1 Universal session start (all tasks)

1. Run `date`
2. Read `context/brand-context.md` and `context/session-context.md`
3. Read the relevant agent memory file and every linked `feedback_*.md`
4. If browser research is expected: confirm Chrome DevTools connectivity (when that MCP is available)
5. Announce which skill(s) will be loaded before executing

### 4.2 Task-scoped bootstrap

| Chief | Additional required reads |
|---|---|
| **Jinu** | `.claude/agents/jinu.md`, `.claude/departments/marketing.md`, matched skills, `.claude/TASK-DOD.md` |
| **Nagi** | `.claude/agents/nagi.md`, `.claude/departments/design.md`, design skills, `brand-compliance-review` before delivery |
| **Koji** | `.claude/agents/koji.md`, `.claude/departments/operations.md`, matched ops skills |
| **Senku** | `.claude/agents/senku.md`, `.claude/departments/intelligence.md`, matched product intelligence skills |

### 4.3 Skill loading rule

Match task → read `.claude/skills/<skill-name>/SKILL.md` → execute. Improvisation without loading the skill is a conformance failure.

### 4.4 Adapter surface for bootstrap

Each adapter must expose bootstrap to the host in one of:

- A root-level adapter doc that points to `.claude/BOOTSTRAP.md` (e.g. `AGENTS.md`, `CLAUDE.md`)
- Always-on project rules (e.g. `.cursor/rules/bootstrap.mdc`)
- Host-native config that injects bootstrap instructions at session start

The mechanism differs; the behavior must not.

---

## 5. Chief Exposure

Canonical chiefs:

| ID | Role | Primary output surface |
|---|---|---|
| `jinu` | Marketing (CMO) | Notion (if configured) or structured reports |
| `nagi` | Design (CDO) | Figma |
| `koji` | Operations (COO) | Brand's system of record (`context/ops-context.md`) |
| `senku` | Product Intelligence (CPIO) | Local knowledge bank (`knowledge-bank/brands/`) |

### 5.1 Exposure modes (adapter choice)

Adapters may implement chiefs using any of:

| Mode | Description | Acceptable when |
|---|---|---|
| **Inline persona** | Host assistant adopts chief identity in conversation | Host lacks native multi-agent runtime |
| **Native agent** | Separate agent config per chief | Host supports agent delegation |
| **Subagent / task spawn** | Chief runs as isolated child agent | Host supports background agents |

All modes must load the same canonical agent file and memory. The mode affects invocation only.

### 5.2 Switch triggers (minimum)

Adapters must support equivalent triggers:

| User intent | Result |
|---|---|
| Address chief by name (`Jinu, ...`, `Nagi, ...`, `Koji, ...`, `Senku, ...`) | Switch to or invoke that chief |
| Cross-department discussion request | Multi-chief inline or sequential exchange |
| Address host assistant directly (owner's chosen name) | Return to host assistant surface |

### 5.3 Switch announcements

When switching to a chief inline: announce the switch. When returning to host assistant: announce handback. Exact phrasing may vary; the user must never be confused about who is speaking.

---

## 6. Tool and MCP Policy Parity

Adapters wire tools differently. Policy parity is required; wire format is not.

### 6.1 Logical tool set (minimum)

| Logical tool | Use |
|---|---|
| **Notion** | Research documentation (marketing writes) |
| **Chrome DevTools** | Login-gated browsing (Instagram, etc.) |
| **Playwright** | Public sites, no login |
| **Figma** | Design read/write |
| **Reddit** | Buyer language, community research |
| **Web search** | Quick lookups, URL verification |

Adapters register these via host-native MCP config. Skills may reference Claude Code-style names (`mcp__chrome__*`, `mcp__notion__*`). Adapters must document the mapping to local server names.

### 6.2 Tool selection policy (normative)

1. Dedicated MCP available → use it
2. Login-gated site → Chrome DevTools
3. Public site → Playwright
4. Playwright failure on public site → Chrome fallback
5. Notion MCP disconnect → stop Notion calls immediately; tell user to start fresh session

This policy is canonical. Adapters must not weaken it.

### 6.3 MCP mapping table (adapter responsibility)

Each adapter must maintain a mapping from skill/tool references to local MCP server IDs. Example categories:

| Skill reference | Resolves to |
|---|---|
| `mcp__chrome__*` | Chrome DevTools MCP |
| `mcp__notion__*` | Notion MCP |
| Playwright MCP | Public browsing |
| Figma MCP | Figma server |

---

## 7. Onboarding Contract

After `setup.sh` completes, any first-class host must support the same onboarding flow:

1. Clone repo
2. Run `./setup.sh`
3. Open host assistant in workspace
4. Say `setup Deku`
5. Host assistant delivers setup tutorial (Chrome, OAuth, verification)
6. User meets a chief — typically `Jinu, let's get started` for new brand onboarding; or `Nagi` / `Koji` as needed

`setup.sh` is host-neutral. It must not assume a single CLI host is installed.

### 7.1 What setup.sh must produce

- Required context file templates (if missing)
- Required directories (`context/`, `proofs/`)
- Cross-platform skill aliases (e.g. Codex `.agents/skills/` → `.claude/skills/`)
- Local-only config stubs (never commit secrets)

---

## 8. Collaboration Modes

Canonical modes (from `core/ARCHITECTURE.md`):

| Mode | Required behavior |
|---|---|
| **Direct** | User ↔ one chief |
| **Discussion** | Two or more chiefs exchange inline |
| **Handoff** | Chief A completes; state passes to Chief B |
| **Parallel** | Concurrent workstreams (simulated inline if host cannot parallelize) |
| **Review** | One chief critiques another against a quality gate |

Hosts that cannot run true parallel agents may simulate inline. That limitation is adapter-local and must be documented in the adapter manifest.

---

## 9. Quality and Definition of Done

Adapters must enforce:

- Skill loading is mandatory
- Memory feedback files are mandatory reads
- Context loading is mandatory
- `.claude/TASK-DOD.md` governs completion for research/KOL/design tasks
- Chat-only deliverables do not satisfy DOD for tasks that require Notion/Figma writes

Adapters must not redefine DOD. They reference it.

---

## 10. Config and Secrets Rules

### 10.1 Allowed in committed adapter config

- MCP server definitions (command, args, URLs)
- Bootstrap pointers to canonical paths
- Hook/event wiring
- Tool name mappings
- Non-secret environment variable *names* (e.g. `PROJECT_ROOT`)

### 10.2 Forbidden in committed adapter config

- API keys, tokens, OAuth secrets
- Machine-specific absolute paths (use relative paths or env vars resolved at setup)
- Canonical business logic duplicated from agents/skills/departments
- Brand-specific state

### 10.3 Local-only surfaces

These may exist on disk but must be gitignored or generated by `setup.sh`:

- `.env`
- `*.local.json` / `settings.local.json`
- Host auth state

---

## 11. Adapter Manifest

Each adapter must have a machine-readable manifest. **Canonical registry:** `core/adapters/<adapter-id>.yaml`

Format may vary by host for native config, but the YAML registry fields below are normative.

### 11.1 Required fields

```yaml
adapter_id: string          # e.g. "cursor", "codex", "claude-code"
spec_version: "1.0"
support_tier: enum          # first-class | planned | experimental
bootstrap_entry: path       # file that points to .claude/BOOTSTRAP.md
adapter_instructions: path  # primary host doc (AGENTS.md, CLAUDE.md, rules/)
chief_exposure: enum        # inline | native-agent | subagent | mixed
mcp_config: path            # where MCP servers are defined
skill_alias: path | null    # e.g. .agents/skills → .claude/skills
parallel_agents: boolean    # true if host runs real parallel agents
known_limitations: [string]
```

### 11.2 Support tiers

| Tier | Meaning |
|---|---|
| **first-class** | Covered by `setup.sh`, onboarding, and parity contract |
| **planned** | Spec-compliant design exists; adapter not yet in repo |
| **experimental** | Partial implementation; not parity-guaranteed |

Current first-class: Claude Code, Codex, Cursor.

---

## 12. Conformance Checklist

Use this before declaring an adapter first-class.

### Setup and paths

- [ ] `setup.sh` completes without requiring this host specifically
- [ ] All required resolution paths (§3) are reachable
- [ ] Skill library alias works (if host uses a different skills path)

### Bootstrap

- [ ] Session start runs universal bootstrap (§4.1)
- [ ] Task-scoped bootstrap works for Jinu, Nagi, Koji, Senku
- [ ] Skills are announced before execution

### Chiefs

- [ ] All four chiefs invokable by name (Jinu, Nagi, Koji, Senku)
- [ ] Chief loads canonical agent file + memory, not adapter-only copy
- [ ] Switch/handback behavior is clear to the user

### Tools

- [ ] Minimum logical tool set wired (§6.1)
- [ ] MCP mapping documented for skill references
- [ ] Tool selection policy honored

### Onboarding

- [ ] `setup Deku` trigger works (legacy `setup Jinu` accepted)
- [ ] Chrome + OAuth setup tutorial deliverable from host assistant
- [ ] Post-setup handoff to Jinu works

### Quality

- [ ] TASK-DOD referenced for applicable tasks
- [ ] No canonical logic forked into adapter-only files

### Security

- [ ] No secrets in committed config
- [ ] No hardcoded absolute paths in committed config

---

## 13. Non-Goals (Adapter Scope)

Adapters must **not**:

- Redefine agent identity or department boundaries
- Store brand research in adapter config
- Become the sole copy of skills, memory, or DOD
- Encode external project repos (e.g. storefront theme code) into core bootstrap
- Block company operation when one optional tool (e.g. Reddit/uv) is missing

---

## 14. Current Implementations (Informational)

Manifests: `core/adapters/`

| Host | Manifest | Adapter surface | Chief exposure | MCP config | Bootstrap |
|---|---|---|---|---|---|
| Claude Code | `core/adapters/claude-code.yaml` | `CLAUDE.md`, `.claude/settings.json` | Inline persona | `.mcp.json` | `.claude/BOOTSTRAP.md` |
| Codex | `core/adapters/codex.yaml` | `AGENTS.md`, `.codex/agents/*.toml` | Native agents + inline | `.codex/config.toml` | `AGENTS.md` → BOOTSTRAP |
| Cursor | `core/adapters/cursor.yaml` | `.cursor/rules/*.mdc` | Inline persona | `.cursor/mcp.json` | `bootstrap.mdc` → BOOTSTRAP |

Known gaps to close (architecture track): **none — track complete as of 2026-05-28.**

Deferred by design (not gaps):

- Physical rename of `.claude/` shared runtime tree — see `core/WORKFLOW-LIBRARY.md`
- External storefront theme repo (`shopify/`) — out of scope for company architecture

---

## 15. Versioning

- Bump `spec_version` when required behavior changes
- Adapters declare which spec version they target in their manifest
- Breaking changes require updating `core/ARCHITECTURE.md` and this file before adapter rollout
