---
name: design-system-build
description: Professional sequenced methodology for building a brand's visual identity system from zero in Figma. Based on W3C Design Tokens spec, Style Dictionary patterns, and Figma Schema 2025 variable system. Used by Brand Designer for all identity system work.
---

# Design System Build

Build in this exact sequence. Do not skip steps. Do not start components before tokens exist. The sequence exists because each layer depends on the one before it.

**Before starting:** Read `context/brand-context.md [Design Direction]` — every decision in this build is an expression of that direction.

---

## Step 1 — Colour Palette

Establish the brand palette: primary, secondary, neutral, and semantic colours.

For each colour decision, document:
- The hex value
- The emotional and strategic rationale: *"We chose this warm off-white because the brand direction is Quiet Luxury — pure white reads clinical, warm white reads material and considered."*
- Which design school it serves

Save to a dedicated Colour page in the Figma brand file.

---

## Step 2 — Primitive Tokens

Raw values. Never used directly in components — only referenced by semantic tokens.

Naming convention (W3C Design Tokens spec):
- `primitive.color.blue.500`
- `primitive.color.gray.900`
- `primitive.spacing.4`
- `primitive.spacing.8`

In Figma: create one Variable Collection named `Primitive Tokens`. One variable per value. No modes needed at this layer.

---

## Step 3 — Semantic Tokens

Purpose-based. Always reference primitives — never raw values.

Naming convention (purpose, not appearance):
- `color.text.primary` → references `primitive.color.gray.900`
- `color.text.secondary` → references `primitive.color.gray.500`
- `color.background.default` → references `primitive.color.white`
- `color.accent.primary` → references `primitive.color.brand.500`
- `space.component.gap.sm` → references `primitive.spacing.4`
- `space.section.padding.md` → references `primitive.spacing.32`

**Why this naming tier matters:** Semantic tokens survive a rebrand. When the brand colour changes, update the primitive. Every semantic token that references it updates automatically. `color.text.primary` is not tied to a specific colour — it is tied to a function.

In Figma: create a second Variable Collection named `Semantic Tokens`. Set modes if needed (light/dark, or multi-brand).

---

## Step 4 — Typography System

Typeface selection with rationale. Scale using Fibonacci-based increments.

**Scale (Fibonacci-based):** 12, 13, 16, 21, 34px — use these as the base steps. Adjust to the nearest logical point size if needed.

For each typeface decision, document:
- The typeface name and why it was chosen against the brand direction: *"Alte Haas Grotesk — its optical neutrality and low x-height echo Swiss grid discipline without the sterility of Helvetica. Correct for Engineered Transparency."*
- The full type scale: display, heading 1-4, body, caption, label, overline
- Line-height rules per level
- Tracking rules per level
- Usage guidelines (when to use display vs h1, when to use caption vs label)

In Figma: Text Style variables for every scale step. Name as semantic tokens: `type.display`, `type.heading.1`, `type.body`, `type.caption`.

**Local font note:** For any non-Google font in Figma Plugin API — do NOT use `loadFontAsync`. Clone an existing text node that already uses the target font, then modify its content. This is the only reliable method.

---

## Step 5 — Spacing System

Base unit establishment. Fibonacci-derived scale.

**Scale:** 4, 8, 13, 21, 34px (Fibonacci approximation of 4-8-12-16-24 but with mathematical relationship)

Semantic spacing tokens:
- `space.component.gap.xs` → 4px (tight internal component spacing)
- `space.component.gap.sm` → 8px (standard internal component spacing)
- `space.component.gap.md` → 13px (generous internal component spacing)
- `space.section.padding.sm` → 21px (tight section padding)
- `space.section.padding.md` → 34px (standard section padding)
- `space.section.padding.lg` → 55px (generous section padding — calculated from Fibonacci: 34+21)
- `space.layout.margin` → established by grid system (see Step 6)

---

## Step 6 — Grid System

Load `grid-systems` skill. Select the grid appropriate to the brand's design direction.

Classical/Neo-Minimalism → column grid, generous gutters, generous whitespace
Tech Spec/Swiss Grid → strict modular grid, mathematical column relationships
Engineered Transparency → modular or axial, precision over flexibility
Quiet Luxury → column or hierarchical grid, vast margin space
Logo construction → always Fibonacci/golden ratio grid

Document the grid as a Figma layout grid applied to a master frame. This master frame is the template for all subsequent layout work.

---

## Step 7 — Component Primitives (Atoms)

Build the atoms everything else derives from. Full state coverage on every component.

Required atoms:
- Button (primary, secondary, ghost, destructive) — all states: default, hover, active, disabled, focus, loading
- Input field — all states: default, focus, filled, error, disabled
- Badge/tag
- Icon system (establish the icon style — outline, filled, or duotone — consistent with the design school)
- Checkbox and radio
- Toggle

In Figma: each atom is a component with variants for all states. Stored in a dedicated Components page. Never embedded in layout frames.

Naming: `ComponentName/Variant/State` — matches code naming conventions for Code Connect.

**No component ships without full state coverage. No exceptions.**

---

## Step 8 — Compound Components (Molecules)

Build from primitives. Do not rebuild atoms inside compound components — use the atom components.

Required compounds:
- Card (product card, content card, feature card)
- Navigation bar
- Modal / sheet
- Form group (label + input + error state)
- Notification / toast

Document each compound in Figma with a usage note: when to use this component, when not to.

---

## Step 9 — Documentation

Every decision recorded in Figma (dedicated Documentation page in the brand file) with its rationale.

Not "we chose this typeface" — "we chose this typeface because [specific reasoning about the brand's character and the typeface's optical behaviour at the target scale]."

Documentation format per decision:
```
Decision: [what was decided]
Rationale: [why — connect to brand direction]
Alternatives considered: [what was rejected and why]
Date: [when locked]
```

**Not Notion — everything in Figma.** The brand file is the source of truth.
