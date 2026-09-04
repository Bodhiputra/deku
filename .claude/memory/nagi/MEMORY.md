# Nagi's Memory
*Repo-portable. Ships with the agent. Brand-agnostic — no brand-specific tokens here.*

## Brand typography (Finecoustic)
- [feedback_typography_alte_haas_grotesk.md](feedback_typography_alte_haas_grotesk.md) — **Alte Haas Grotesk only**; never generic grotesque or substitute fonts in briefs or deliverables. Canonical: `context/design-context.md`.

## Browser
- **Tab management:** Reuse one tab per platform per session — never open a new tab for each profile. Navigate within the existing tab.

## Figma
- **Direct Plugin API:** Always use `use_figma` (Plugin API) for all design output — never HTML/CSS capture pipelines. Produces native editable nodes, no spacing artifacts.
- **Local fonts — hard limitation:** Cloning a text node with a local font does NOT bypass the `loadFontAsync` requirement for `set_characters`. `loadFontAsync` only works for fonts on Figma's cloud server. Finecoustic uses **Alte Haas Grotesk** — if `loadFontAsync` fails, Space Grotesk is a **Figma-plugin editing workaround only**, not brand typography (see feedback_typography_alte_haas_grotesk.md). Clone logo/footer nodes as-is — no text modification. Flag cloned footer text to user for manual update in Figma.

## Design & Content
- **Content fidelity:** Use client's exact words for all copy — never rewrite, never add content, never stretch images.

## Presentation Work — How Nagi Approaches It

**Priority order — always in this sequence:**
1. Brand owner provides a reference presentation or existing design → extract its design language, follow it. Do not impose defaults.
2. Brand has an established design direction in `context/brand-context.md` with a `[Presentation Design System]` section → read and apply it exactly.
3. No reference, no existing design system → apply the default presentation principles below.

**The default is a fallback, not a starting point.** Always check for a reference first.

---

## Default Presentation Principles
*Applied only when no brand reference or existing design system exists.*

These are structural and compositional principles — not brand tokens. They produce clean, non-generic work regardless of brand.

**Canvas:** 1920×1080px, 16:9. Background determined by brand direction (default: dark, near-black or black).

**Typography discipline:**
- One typeface, two weights (bold + regular) — maximum. More weights = less hierarchy, not more.
- Display type tracks tight (negative letter-spacing). Small type at low opacity tracks open (small caps logic).
- Body copy uses fixed line heights slightly tighter than standard — deliberate density, not airy bullets.
- Every headline ends with a period. A headline is a statement, not a label.

**Colour discipline:**
- Maximum three colours in a presentation system: background, primary text, accent.
- The accent appears once per slide as the dominant element. Its role shifts per slide — it's never used as a pattern or on everything at once.
- Subdued text (footers, secondary labels) uses the primary colour at reduced opacity — not a separate grey.

**Structural elements (every content slide):**
- A consistent top rule or brand mark — thin, present on all content slides, absent on full-bleed photo slides.
- A logo or wordmark fixed to the same position on every slide (typically top-right). It never moves.
- A footer bar at a fixed position from the bottom — same information on every slide. Left: document context. Right: brand/year.
- Section label (top-left, small, uppercase, accent colour) + Headline below it (large, brand weight, ends with period).

**Spatial grid:**
- Fixed left and right margins — same on every slide. Content never bleeds past them.
- The footer zone is reserved. No content enters it.
- Two-column split for content-heavy slides (visual left, data right). Three-column for comparisons.

**Layout archetypes to choose from:**
1. Photo cover — full-bleed image + gradient vignette + title overlay bottom-left
2. Centred hero — large single element centred, body text beside or below
3. Two-column split — left: visual, right: structured content (spec table, list)
4. Multi-column comparison — equal columns, product/item images top, rows below
5. Label + value grid — labels small/uppercase/subdued left, values regular weight right
6. Editorial closing — oversized ghost text (low opacity tagline), headline right-aligned in accent colour

**What makes it not generic:**
- The period at the end of every headline
- Subdued footer text tuned precisely (not default 50% — closer to 40–45%)
- Accent colour used on exactly one thing per slide, not scattered
- Fixed line height slightly tighter than default on body copy
- Auto-layout used only to solve specific alignment problems — slide layouts are absolute positioning
