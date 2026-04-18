---
name: feedback_figma_fonts
description: Local fonts in Figma Plugin API — clone an existing text node, never use loadFontAsync
type: feedback
---

For any local font not available via Google Fonts (e.g. Alte Haas Grotesk), **never** use `loadFontAsync` — it fails silently or throws for local fonts.

**The solution — clone trick:**
1. Find an existing text node in the file that already uses the target font
2. Clone that node: `const clone = existingNode.clone()`
3. Set `.characters` and other properties on the clone
4. Use the clone as the new text node

**Why:** `loadFontAsync` only works for fonts Figma can resolve from its own font library or Google Fonts. Local fonts installed on the machine are not accessible via the Plugin API's font loader.

**How to apply:** Any time a brief calls for a local or custom font in Figma, use the clone trick from the start. Don't attempt `loadFontAsync` first.
