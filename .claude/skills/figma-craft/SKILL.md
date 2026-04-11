---
name: figma-craft
description: Advanced Figma craft techniques for design agents — file navigation via API (not screenshots), auto layout mastery, component architecture, variable system, prototyping, and Figma MCP-specific protocols. Includes the mandatory local font clone trick and the read-before-screenshot rule. Used by Brand Designer, Visual Production, and Digital Designer for all Figma production work.
---

# Figma Craft

Advanced Figma techniques that separate competent Figma users from designers whose files are actually buildable, maintainable, and scalable.

**The `figma:figma-use` skill handles the MCP connection and write operations. This skill handles the design decisions and navigation within those operations.**

---

## Critical: Read Before Screenshot

**Screenshots are slow, expensive, and unnecessary for most Figma tasks. The Figma MCP gives direct API access to the file structure — use it.**

### When to use API reads (not screenshots)

Use the Figma MCP's node query and read capabilities for everything except final visual verification:

| Task | Method |
|---|---|
| Find a specific frame or section | Query nodes by name |
| Understand page structure | Read page children |
| Find a component in the library | Query component by name |
| Check layer hierarchy | Read node tree |
| Verify a token or style is applied | Read node fill/stroke/style properties |
| Get frame dimensions | Read node width/height from API |
| Find all instances of a component | Query by component ID |
| Check text content | Read node characters property |
| Navigate between pages | Read file pages list |

**Use a screenshot only when:**
- You need to verify the final visual output of a rendered frame
- You are doing a brand compliance quality check
- The task explicitly requires seeing how something looks visually

One screenshot per quality check. Not one screenshot per action. Never screenshot to navigate or find things.

### API navigation pattern

Before any write operation:

```
1. Read the file's page list → identify which page to work on
2. Read the target page's children → identify frames by name
3. Read the target frame's node tree → understand layer structure
4. Read specific node properties → confirm current state before writing
5. Execute the write operation
6. Read the affected nodes back → verify write succeeded as intended
7. Screenshot ONLY if a visual quality check is needed
```

This replaces the pattern of: screenshot → interpret → act → screenshot → interpret → act. That pattern is slow, error-prone, and burns unnecessary tokens.

### Finding nodes efficiently

Always query by name first. Figma files with proper layer naming (which this department requires) are fully navigable by name alone.

```
// Find a frame named "Hero — Desktop"
→ Read page children, filter by name "Hero — Desktop"

// Find a component named "Button/Primary/Default"  
→ Query component library by name "Button/Primary/Default"

// Find all text nodes in a frame
→ Read frame node tree, filter by type "TEXT"

// Find a frame's exact dimensions before writing
→ Read node properties: width, height, x, y
```

Only fall back to visual interpretation (screenshot) if the file has unnamed or poorly named layers — and in that case, flag the naming issue to Nagi as a production quality problem.

---

## Critical: Local Font Protocol

**Never use `loadFontAsync` for local fonts (any font not served by Google Fonts).**

`loadFontAsync` fails silently for local fonts in Figma Plugin API. The text node appears to have changed but reverts on save, or throws an error with no clear message.

**The only reliable method for local fonts:**
1. Find an existing text node in the Figma file that already uses the target font
2. Clone that node using the Plugin API
3. Modify the cloned node's content, position, and styling as needed
4. The cloned node inherits the font correctly because it was never loaded — it was copied

This applies to ALL non-Google fonts: custom brand fonts, purchased typefaces, variable fonts hosted locally. If the font is not in Google Fonts, clone — never `loadFontAsync`.

---

## Mandatory Pre-Write Protocol

Before ANY write operation to a Figma canvas:
1. Invoke `figma:figma-use` skill first — read the current file state via API
2. Confirm which frame/page you are working on by reading the node tree — not by screenshotting
3. Only then proceed with write operations
4. After writing, read the affected nodes back via API to verify the write succeeded as intended
5. Screenshot only if a final visual quality check is required — not as a default verification step

Never assume the file is in the state you last left it. Always read before write. Always verify via API after write.

---

## Auto Layout Mastery

Auto layout is Figma's flexbox — stack direction, gap, padding, and alignment.

**Hug vs Fill vs Fixed:**
- `Hug contents` — frame shrinks to fit its children. Use for buttons, tags, any component that should be as small as its content.
- `Fill container` — frame expands to fill available space in the parent auto layout. Use for full-width elements inside a row or column.
- `Fixed` — locks to a specific size regardless of content. Use sparingly — only when a specific dimension must never change.

**Min/max width:** Set on elements that should grow but not beyond a limit. Critical for responsive column layouts that should expand on wide screens but not become unreadable.

**Space between:** Distributes items evenly in the remaining space — equivalent to `justify-content: space-between` in CSS. Use for navigation items, icon rows, split layouts.

**Nested auto layout:** A horizontal row of cards inside a vertical page layout — inner and outer frames each have independent auto layout settings. This is how responsive layouts are built correctly.

**When auto layout breaks:**
- Overlapping elements: elements using absolute position override auto layout. Use deliberately, not accidentally.
- Components with conflicting constraints: check that nested components don't have fixed constraints that fight the parent's auto layout.

---

## Component Architecture — Professional Patterns

**Component properties (use these, not workarounds):**
- `Boolean` — show/hide an element. Use for optional elements like icons, badges, or decorative details.
- `Text` — allow text override without detaching the component. Every text string should be a text property.
- `Instance swap` — allow swapping a nested component for another from the same library. Use for icon slots, avatar slots, illustration slots.
- `Variant` — switch between named states of the component. Use for type (primary/secondary/ghost), size (sm/md/lg), and state (default/hover/active/disabled).

**Master component location:** Always outside the layout hierarchy — in a dedicated `_Components` page. Never nested inside layout frames. When a component is placed on a layout page it is always an instance, never the master.

**Naming convention:** `ComponentName/Variant/State` — consistent with code naming. Examples: `Button/Primary/Default`, `Button/Primary/Hover`, `Card/Product/Default`.

**Never expose internal structure as overrideable.** Only expose what the consumer needs to change. A button's label and icon are appropriate overrides. Its internal padding structure is not.

---

## Variable System — Advanced Usage

**One variable collection per concern:**
- Colour collection (separate from spacing and type)
- Spacing collection
- Typography collection (size, line-height, tracking)

Never bundle concerns into one collection.

**Mode switching:** Define light and dark mode in the colour collection as two modes. Switch the entire file with one click. All components update automatically.

**Multi-brand:** A second mode in the colour collection for a brand variant — same components, different brand colours. Switching mode changes the brand without touching a single component.

**Variable aliases:** Semantic token references primitive token. `color.text.primary` → `color.gray.900`. When `color.gray.900` changes, every semantic reference updates. This is the reason the two-layer token system exists.

**Number variables:** Use for border radius, font size, line height, opacity — not just spacing.

**Boolean variables:** Show/hide layers based on mode or component property. `show-dark-logo: true` in dark mode, `false` in light mode.

---

## Figma MCP-Specific Craft

**Reading file structure before writing:**
Always read the current node tree before any write operation. Use `figma-get-node` or equivalent read tool to confirm the exact node IDs, names, and current property values before modifying them. This prevents writing to the wrong node and avoids the screenshot-to-navigate pattern.

**Generating designs:** When using `figma-generate-design`, specify the token names you want used — the AI generation tool defaults to hardcoded values if not instructed. Always pass: *"Use semantic token names from the variable collection, not hardcoded hex values."*

**After writes:** Run `figma-generate-design-system-rules` on new files before building — understand what conventions already exist. Run it during audits to catch drift.

**Prototype verification:** After writing components, check that component interactions (hover, active, focus states) are correctly linked using the Interactions panel — these do not transfer automatically from design to prototype mode.

---

## Figma for Handoff

**Layer naming is navigation.** Every layer must be named for what it is — not "Frame 47" or "Rectangle 12". Named layers are queryable via API. Unnamed layers require screenshots to navigate. Unnamed layers are a production quality failure.

**Section organisation:** Use Figma sections to separate `Working` / `For Review` / `Approved`. Developers and reviewers see only what they need to.

**Dev Mode check:** Before handoff, toggle Dev Mode and confirm:
- No hardcoded hex values in colour properties
- No hardcoded font sizes — all linked to text style variables
- All spacing values linked to spacing variables
- Component variants correctly named

**Version history:** Commit a named version before any major direction change. *"Before direction B exploration"* — so revert is always possible.

**Code Connect:** For every component that maps to a codebase component, configure Code Connect. This eliminates the gap between Figma component and shipped component.
