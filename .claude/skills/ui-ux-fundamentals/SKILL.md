---
name: ui-ux-fundamentals
description: Core UI/UX methodology for marketing sites, landing pages, and brand digital presence — not product UI. Covers information hierarchy, conversion-focused design, responsive layout as distinct problems, accessibility as craft standard, and user flow mapping. Used by Digital Designer for all web and digital briefs.
---

# UI/UX Fundamentals

**Scope:** Marketing pages, landing pages, brand digital presence. This skill is NOT for product UI (task-completion interfaces, dashboards, app screens). When a brief looks like product UI, flag to Nagi as a separate workstream.

**The core distinction:** A marketing page converts a stranger into a customer. A product UI helps an existing user complete a task. The psychology, hierarchy, and success metrics are different. This skill serves the former.

---

## The 0.05 Second Rule

Every above-the-fold element is processed before any conscious evaluation begins. Typeface, whitespace, hero image weight, and headline size communicate before the visitor reads a word.

This means the first design decision is not "what should the headline say" — it is "what does the page feel like in the first 50 milliseconds." Brand direction, visual weight, and emotional register are established before the visitor consciously engages.

Design the feeling before the content.

---

## Information Hierarchy

**How users scan vs read:**
- F-pattern: text-heavy pages — users scan the first line, then jump down the left edge. Headlines and subheads carry most of the reading load.
- Z-pattern: visual pages — users scan diagonally from top-left to top-right, then down to bottom-left, then across to the call to action. Hero image → logo → headline → CTA.

**Visual weight as attention guidance:**
Size, contrast, colour, whitespace, and position all carry hierarchy signals. The brain reads these before it reads text. A large high-contrast element at the top of the page is always seen first regardless of what it says.

**The 3-element hierarchy:**
1. Primary — what you want them to see first (headline, hero image, primary CTA)
2. Secondary — what supports the primary message (subhead, supporting copy, social proof)
3. Tertiary — what is available if they want it (navigation, fine print, secondary links)

More than three levels of hierarchy on a single page creates visual noise. Resist.

---

## Conversion-Focused Design

**CTA placement:**
- Primary CTA above the fold — visible without scrolling
- Secondary CTA after the value argument is made (typically after the main benefits section)
- Never bury the primary CTA below social proof or features

**Friction reduction:**
- Fewer form fields. Every field removed increases conversion.
- Clear error states — the user should understand immediately what went wrong and how to fix it
- Obvious next steps — the visitor should never have to decide what to do next
- Loading states on all form submissions — feedback that something is happening

**Social proof placement:**
Closest to the decision moment, not at the bottom. If the CTA is above the fold, social proof belongs between the first fold and the CTA.

**Value hierarchy:**
Lead with the transformation (what changes for the customer), not the features. The buyer does not care about the 10W tweeter — they care about what their room sounds like. Features are evidence for the transformation, not the transformation itself.

---

## Responsive Design — Three Distinct Layouts

Mobile is not scaled-down desktop. Each breakpoint is a distinct compositional problem.

**Desktop (1440px):** Full typographic scale, generous whitespace, editorial layouts, side-by-side comparisons, multi-column grids possible.

**Tablet (768px):** Two-column layouts emerge, sidebar patterns available, navigation remains visible, type scale compresses slightly.

**Mobile (375px):** One primary focus per screen. Navigation collapses. Social proof compresses. Single-column. Touch targets minimum 44×44px. Type size never below 16px for body text.

Design all three as distinct compositions that share a visual language. Do not design desktop and expect automatic scaling to produce good mobile — it never does.

---

## Accessibility as Craft Standard

Accessibility is not a compliance checkbox. It is a quality standard. Poor accessibility usually means poor readability for everyone.

**Contrast:**
- Body text: 4.5:1 minimum contrast ratio against background
- Large text (18px+ regular or 14px+ bold): 3:1 minimum
- Use a contrast checker. Never estimate contrast visually.

**Touch targets:** 44×44px minimum on mobile. Comfortable interaction, not just technically possible.

**Focus states:** Visible focus indicators for all interactive elements. `focus-visible` ring using the brand's accent colour. This is part of the design, not an afterthought.

**Alt text:** Written to communicate what the image conveys, not what it depicts. "Hako Nomad speaker on a desk in a warmly lit room" not "speaker.jpg."

**Semantic HTML:** Correct heading hierarchy (one H1 per page, H2 for sections, H3 for subsections). Proper landmark elements (nav, main, footer). These decisions are made in Figma — labelled layers and annotated layouts.

---

## User Flow Mapping

Before designing any page, trace the path from first arrival to primary action.

For each step ask:
- What does the visitor know at this point?
- What do they need to know to take the next step?
- What might make them leave at this step?

Design each step to reduce the gap between what they know and what they need to know. Identify drop-off risk points and design specifically to address them.

**Common drop-off points and design solutions:**
- Above the fold: unclear value proposition → lead with the transformation, not the product name
- Before the CTA: insufficient trust → add social proof at the decision moment
- At the form: too many fields → remove every optional field
- At checkout: unexpected costs → show full price early, never surprise
