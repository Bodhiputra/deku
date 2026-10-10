---
name: feedback_brand_typography
description: Brand typography comes from private workspace context, never public framework defaults
type: feedback
---

**Hard rule:** The canonical typeface and approved fallbacks come from the brand's gitignored `context/design-context.md` → Typography.

Never infer a brand typeface from public examples, visual similarity, or tool availability. Do not present an editing fallback as approved brand typography.

**KOL / creator briefs:** If on-screen text is needed, use the configured brand typeface and follow the owner's font-sharing and licensing rules. Most creator content has no type overlays — mention typography only when relevant.

**Figma exception (technical only):** When `loadFontAsync` cannot load a local font, an owner-approved substitute may be used temporarily for editing. It must never be stated as the brand typeface in briefs, exports, or handoffs.
