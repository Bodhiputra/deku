---
name: frontend-for-designers
description: The 2026 design engineer mindset — which tool to use for which brief, Figma Make for exploration, Figma Sites for publishing, Tailwind + React for precision components, and implementation-aware layout decisions. Used by Digital Designer for all web briefs.
---

# Frontend for Designers

**The 2026 design engineer:** Designers who can build have more influence over what ships. This skill teaches how to move from concept to working, deployed web product without a handoff gap — not by replacing developers, but by reducing the translation loss between design intent and shipped product.

---

## Tool Decision Framework

Choose the right tool before opening anything. Wrong tool choice costs days.

| Brief type | Tool | Why |
|---|---|---|
| Complex product UI, multi-screen UX, design system components | Figma → Dev handoff | Systematic, token-connected, scalable |
| Rapid concept exploration, layout ideation | Figma Make | AI-generated starting points in minutes |
| Marketing page or landing page that ships as a live URL | Figma Sites | Included in Figma Pro — publish directly from Figma |
| Specific UI component with production-grade quality | Tailwind + React via Claude Code | Precise control, code-correct, reusable |
| Complex CMS, JavaScript logic, e-commerce beyond Figma Sites | Framer ($5/month) | Design-to-production React — natural next step |

When in doubt: Figma Sites first. Flag to Nagi if the brief exceeds its capability.

---

## Figma Make — Professional Exploration Workflow

Figma Make (launched May 2025) generates clickable prototypes from text prompts directly inside Figma. **It is a thinking tool, not a production tool.** Never hand off Figma Make output directly.

**Professional use pattern:**
1. At the start of a new page brief, generate 3–5 layout interpretations using the design direction from `context/brand-context.md [Design Direction]`
2. Evaluate which interpretation has the strongest hierarchy and information flow
3. Use the winner as the foundation for a properly structured Figma file — with correct auto layout, token application, and component structure
4. The Figma Make output is a directional sketch, not the deliverable

**Effective Figma Make prompts reference the design school:**
*"A hero section for a portable audio hardware brand. Engineered transparency aesthetic. Large product image left, sparse typography right. Monochrome with a single accent colour. No decorative elements. Clean, precise, restrained."*

---

## Figma Sites — Publish Live Directly from Figma

For marketing pages and landing pages, Figma Sites eliminates the handoff. Included in Figma Pro — no additional subscription.

**Professional workflow:**
1. Design with Sites features from the start:
   - Auto layout throughout every section
   - Figma variables for all colour and spacing tokens
   - Sites breakpoints set (desktop / tablet / mobile) before designing any section
2. Build sections as reusable Figma components — clean structure reduces publish quality
3. Set responsive behaviour at each breakpoint explicitly via Figma's breakpoint controls — do not rely on auto-scaling
4. Add scroll animations and hover interactions via Figma's Interactions panel — these publish as real CSS animations
5. Publish via the Sites panel — live URL, shareable immediately

**Current capability ceiling (April 2026 beta):** Static and lightly interactive marketing pages. Does not support complex CMS-driven content, JavaScript logic, or e-commerce. When a brief exceeds this, flag to Nagi: *"This brief exceeds Figma Sites' current capability — recommend Framer at $5/month for this project."*

---

## Tailwind CSS + React — Precision Component Production

For specific UI components where code quality matters more than visual speed.

**The mental model:** The design is expressed in the markup. Every visual decision is a utility class. Read the class list and you see the design.

**Brand token bridge — Tailwind config:**
```js
// tailwind.config.js — brand-context.md values become code
module.exports = {
  theme: {
    extend: {
      colors: {
        brand: {
          primary: '#[from brand-context.md]',
          secondary: '#[from brand-context.md]',
          accent: '#[from brand-context.md]',
          neutral: '#[from brand-context.md]',
        }
      },
      fontFamily: {
        sans: ['[BrandFont]', 'system-ui', 'sans-serif'],
      },
      borderRadius: {
        brand: '[from design system]',
      }
    }
  }
}
```

**Professional component pattern:**
```jsx
// Props mirror Figma component variants exactly
function ProductCard({ title, price, imageUrl, featured = false }) {
  return (
    <div className={`bg-white rounded-2xl overflow-hidden border ${featured ? 'border-brand-accent' : 'border-gray-100'}`}>
      <img src={imageUrl} alt={title} className="w-full aspect-square object-cover" />
      <div className="p-5">
        <h3 className="font-medium text-gray-900 text-base">{title}</h3>
        <p className="text-gray-500 text-sm mt-1">{price}</p>
      </div>
    </div>
  )
}
```

---

## Vibe-Coding with Claude Code — Precise Prompt Protocol

Vague prompts produce generic output. Use this protocol:

```
Stack: React + Tailwind CSS
Brand: primary [hex], secondary [hex], accent [hex]. Font: [name].
Design direction: [active school from brand-context.md]

Component: [name and type]
Visual description: [specific — not "nice looking" but "large tracking in headline, generous whitespace, product image fills left half at 1:1 aspect ratio"]
Props: [list all variant-producing props]
States: [hover, active, disabled — whichever apply]
Responsive: [describe layout change at 768px and 375px]
Accessibility: semantic HTML, WCAG AA contrast, focus-visible states
```

**Iteration loop:** Generate → run in browser → describe the delta precisely (*"the headline tracking is too tight, increase to tracking-widest"* not *"it doesn't look right"*) → regenerate. Three rounds typically produces production-ready output.

---

## Implementation-Aware Layout Decisions

When making layout decisions in Figma, consider how they build:

**Decisions that translate cleanly to code:**
- Auto layout → Flexbox/Grid
- Figma constraints → CSS position properties
- Component variants → React props
- Figma variables → CSS custom properties

**Decisions that create handoff problems:**
- Absolute positioning for elements that should be in flow
- Mixed fixed and percentage widths in the same row
- Text layers without style variables (hardcoded sizes, weights)
- Components without consistent naming

Make the right decision in Figma. The developer's job should be translation, not interpretation.
