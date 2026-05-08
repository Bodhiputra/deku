---
name: grid-systems
description: Professional grid system methodology — the six grid types, when to use each, construction in Figma, and selection by design direction. Grids inform the design from the start, never added retrospectively. Used by Brand Designer and Digital Designer before any logo or layout work begins.
---

# Grid Systems

Grids must inform the design from the start. They are not a justification layer added after the fact.

Load this skill before placing any element on the canvas.

---

## The Six Grid Types

### 1. Baseline Grid
Establishes vertical rhythm in typography. Every line of text, every caption, every label sits on a baseline increment.

- Standard: 4px or 8px base unit
- Application: set as a Figma layout grid on master frames (rows, colour #FF0000, opacity 10%)
- Use when: typography is a primary design element and consistent vertical rhythm matters

### 2. Column Grid
Multi-column layout structure. Defines the horizontal skeleton every layout element aligns to.

- Standard column counts: 4 (mobile), 8 (tablet), 12 or 16 (desktop)
- Gutter width: typically 16–32px
- Margin: typically 16px (mobile) to 80px (desktop widescreen)
- Application: set as a Figma layout grid (columns, stretch, with count/gutter/margin values)
- Use when: the layout has multiple content zones that must align across the page

### 3. Modular Grid
Rows plus columns creating a matrix of modules. Content lives in repeating units.

- Application: editorial pages, data-dense layouts, product catalogues
- Figma setup: both a column grid and a row grid applied simultaneously
- Use when: content repeats in a structured pattern and the layout has both horizontal and vertical rhythm needs

### 4. Axial Grid
Elements organised along a dominant axis — horizontal, vertical, or diagonal. Creates strong directional energy.

- Common in Swiss-influenced and Engineered Transparency aesthetics
- Application: single-product pages, poster layouts, identity systems where a central axis anchors composition
- Figma setup: a single guide line (vertical or horizontal centre) plus offset guides for content zones
- Use when: the design school calls for strong directional movement and a clear visual axis

### 5. Hierarchical Grid
Content arranged by visual importance rather than uniform columns. Breaks from regularity to create rhythm through contrast.

- Application: editorial and Maximalist aesthetics, feature articles, brand campaigns
- Figma setup: custom frame sizes per content zone — no uniform column structure
- Use when: the brief calls for editorial, feature-article, or Maximalist layouts

### 6. Fibonacci / Golden Ratio Grid
Proportioning system derived from the Fibonacci sequence (0, 1, 1, 2, 3, 5, 8, 13, 21...).

**Primary use cases:**
- Logo construction: circles sized by Fibonacci values (10, 20, 30, 50px) placed edge-to-edge build naturally harmonious proportion relationships
- Layout division: 62%/38% content-to-sidebar ratio approximates the golden ratio
- Typography scale: 13, 21, 34px follow the sequence
- Composition: the golden spiral guides where the eye naturally travels — place primary elements at convergence points

**Construction in Figma:**
1. Draw a square (e.g. 100×100)
2. Duplicate and scale by 1.618 (golden ratio) → 162×162
3. Place new square adjacent to original
4. Repeat 5–6 times
5. Draw arcs through each square's corners to create the logarithmic spiral
6. Use circle diameters from the sequence as the proportional system for shapes

**Practical shortcut:** The 5:8 ratio is close enough for most layout work and simpler to calculate.

---

## Grid Selection by Design Direction

Read `context/brand-context.md [Design Direction]` before selecting. Match the grid to the school:

| Design School | Grid Type | Notes |
|---|---|---|
| Classical Minimalism | Column grid | Generous gutters, generous whitespace, 12 columns desktop |
| Neo-Minimalism | Column or Axial | Aggressive whitespace, very wide margins — sometimes a single central axis |
| Engineered Transparency | Modular or Axial | Precision over flexibility, mathematical column relationships |
| Tech Spec / Swiss Grid | Strict Modular | Mathematical, often with an unusual column count (5, 7) that enforces precision |
| Quiet Luxury | Column or Hierarchical | Vast margin space — the whitespace is the design |
| Retro Specificity | Hierarchical | Editorial asymmetry, deliberate grid-breaking within an implied structure |
| Maximalism | Hierarchical | Deliberate grid-breaking — the grid exists but the design argues with it |
| Logo construction | Fibonacci/Golden Ratio | Always. No exceptions. |

---

## Setting Up in Figma

**Column grid:**
1. Select the master frame
2. Add layout grid → Columns
3. Set: Count, Gutter, Margin
4. Set colour to `#FF0000` or `#0000FF`, opacity 10% — visible but not distracting
5. Lock the grid layer — it should never be accidentally moved

**Baseline grid:**
1. Add a second layout grid → Rows
2. Set height to 4px or 8px
3. Offset to 0
4. Same low-opacity colour

**Fibonacci grid for logos:**
Build it as a frame with circle shapes at Fibonacci diameters. Lock to a dedicated grid layer. Use as underlay — export the logo without it.

---

## Non-Negotiables

- Grid established before any element is placed
- Grid selection justified against the active design direction
- Grid documented in the Figma file (grid frame on a dedicated Grids page)
- For logo work: always Fibonacci. No exceptions.
- Never add grid retrospectively as justification — it must inform the design
