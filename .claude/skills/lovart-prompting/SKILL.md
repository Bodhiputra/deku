---
name: lovart-prompting
description: Professional Lovart prompting methodology — platform controls, prompt structure, product photography workflow, three-round iteration protocol, inpainting/editing tools, and Chrome DevTools MCP access. Used by Visual Production and Digital Designer before any generative image session.
---

# Lovart Prompting

Lovart is the primary AI generative image tool for the design department. It is a design agent platform — not a one-shot image generator. It maintains context within a session, remembers style choices, and builds on previous outputs. Work with it conversationally, not as a black box where you input a prompt and accept what comes out.

Accessed via Chrome DevTools MCP through the user's live Chrome session. The user must be logged into Lovart in Chrome before the session begins. If Chrome session is unavailable — flag to Nagi. Do not proceed.

---

## The Non-Negotiable Quality Bar

**The goal is never "AI-generated looking" output. The goal is "could have been shot by a photographer and art director with a full studio budget."**

Reject and re-prompt if output shows any of:
- Unnaturally perfect surfaces with no material texture or imperfection
- Lighting with no clear single source or direction
- Product edges that look composited rather than naturally placed
- Backgrounds that look like generic stock photo backdrops or gradient fills
- Colours oversaturated beyond what a real scene would produce
- Any element that visually reads as "generated" rather than photographed

Aim for output where:
- A single motivated light source is identifiable — you know where the light comes from
- Material texture is visible and correct for the material — the surface reads as what it actually is
- The product sits in its environment with physical credibility — gravity, shadow, surface contact
- Colour temperature is consistent across the entire frame
- A photographer would be proud to have taken this shot

---

## Platform Controls — Know These Before Prompting

Lovart has specific controls that affect output quality. Use them deliberately.

**Guidance / Creativity slider:**
- High guidance = output stays closer to the prompt. Use for product photography where brand constraints matter.
- Low guidance = more creative interpretation. Use for mood/lifestyle exploration in early rounds only.
- Default for brand work: high guidance.

**Seed:**
- Fix the seed when you want to iterate on the same base image — change one element, keep everything else stable.
- Leave random for exploration rounds where you want variety.
- Save the seed number of any output worth building on.

**Style Strength:**
- Controls how aggressively a chosen style preset affects the image.
- For subtle brand-consistent work: medium-low.
- For strong aesthetic direction: medium-high.

**Aspect Ratio:**
- Set before generating — changing ratio after forces awkward crops.
- 1:1 for Instagram square, 4:5 for Instagram portrait (preferred for product), 9:16 for Stories/Reels, 16:9 for YouTube/web banners.

**ChatCanvas:**
- Lovart's canvas allows you to sketch rough layouts, mark areas, and give visual guidance alongside text.
- Use it for product placement control — sketch where the product should sit, where light should come from, where negative space should be.
- Visual guidance combined with text produces significantly more controlled results than text alone.

---

## Prompt Structure — The LOVART Formula

Every prompt: **[SUBJECT] + [STYLE] + [LIGHTING] + [COMPOSITION] + [QUALITY + CONSTRAINTS]**

Keep prompts under 100 words. Contradictory instructions ("hyper-realistic but also minimal 2D") produce incoherent output — choose one direction per prompt. Change one element at a time between iterations — not everything at once.

**Layer 1 — Subject:** What is in the image and its physical state
*"A palm-sized cube speaker on a concrete surface, cable coiled naturally beside it"*

**Layer 2 — Style:** Aesthetic direction from `context/brand-context.md [Design Direction]`
*"Clean industrial product photography, engineered transparency aesthetic, material texture visible, precise and restrained"*

**Layer 3 — Lighting:** Specific and motivated — vague lighting produces AI-looking results
*"Single soft light source upper left, directional shadow with clear edge, no fill light"*

**Layer 4 — Composition:** Angle, framing, negative space
*"Slight top-down angle, subject slightly off-centre, generous negative space right side"*

**Layer 5 — Quality + what to avoid:**
*"Sharp focus, muted cool neutral palette, avoid warm backgrounds, avoid composite-looking edges, avoid decorative elements, studio product photography quality"*

**Real product photography prompt example:**
*"A matte black portable speaker on a concrete surface, cable coiled naturally to the left. Clean industrial product photography, engineered transparency aesthetic, material texture visible. Single soft light source upper left, directional shadow, no fill light. Slight top-down angle, subject slightly off-centre. Sharp focus, muted cool neutral palette, avoid warm backgrounds, avoid composite-looking edges, avoid decorative elements."*

---

## Product Photography — Specific Workflow

For product shots specifically:

1. **Upload the actual product image** as a reference before prompting. Image-to-image anchoring produces far more accurate product rendering than text description alone.
2. **Set guidance to high** — you need the AI to follow brand constraints, not interpret freely.
3. **Fix the seed** after a promising Round 1 result — iterate on that base.
4. Use **ChatCanvas** to indicate product placement and light direction visually.

**Lighting vocabulary that produces real photography quality:**
- "single soft light source, north-facing window quality" — diffused, no hard shadows
- "directional side light revealing surface texture" — reveals material grain
- "controlled studio, large soft box upper left, no secondary fill" — precise
- "rim light only, dark field" — dramatic, isolates product against dark background

**Material vocabulary — derive from the actual product:**
Read `context/brand-context.md` for the product's materials and surfaces. Describe them with physical precision — what the material is, how light interacts with it, what texture is visible at the relevant scale.

Principles:
- Name the material specifically, not generically ("anodised aluminium" not "metal", "unglazed ceramic" not "matte surface")
- Describe how light hits it ("visible directional grain", "subtle specular highlight", "diffused through translucent")
- Describe texture at the correct scale for the shot ("visible weave pattern" for a close product shot, "slight surface texture" for a wider lifestyle frame)
- Describe how flexible materials behave ("natural drape", "loose coil", "slight tension")

Build this vocabulary from the brand's actual product and photography direction in `context/brand-context.md [Design Direction]` — never assume materials.

---

## Three-Round Iteration Protocol

Lovart is a conversational agent — each round builds on the previous within the session.

**Round 1 — Exploration:**
Upload 2–3 reference images from Design Research Scout before prompting. Broad prompt, guidance medium-low, seed random. Generate 3–4 variations. Evaluate: lighting direction, colour temperature, material rendering, product placement. Note the seed of the best result.

**Round 2 — Fix Seed, Tighten:**
Set seed to the Round 1 winner. Increase guidance to high. Tighten style language. Add specific negative prompts for everything that appeared in Round 1 that you didn't want. Change one element at a time. *"Keep directional lighting and cool palette. Background reads too warm — specify cooler neutral concrete. Product edges look composited — add 'natural placement, physically credible surface contact'."*

**Round 3 — Brand Lock + Humanness Check:**
Add brand colour constraints from `context/brand-context.md`. Check explicitly: does it look photographed? Could this have been a studio shot? If no — one more round with tighter material and lighting language. Only accept output that passes the humanness bar.

---

## Editing Tools — Use These Before Re-Generating

Lovart has post-generation tools that fix specific problems without regenerating the whole image. Use them before deciding to restart.

**Inpainting:**
Select a specific area and regenerate only that region. Use when one area of an otherwise good image has an AI-looking artefact. *"Product looks good but background corner has wrong texture — inpaint just that corner with 'smooth concrete, neutral cool, no texture variation'."*

**Outpainting / Extend:**
Expand the canvas in any direction without stretching the subject. Use when the composition needs more negative space for text overlay, or you need to adapt a square crop to a portrait.

**Edit Elements:**
Separates any image into layers — background, foreground, subject — for non-destructive editing. Use when you want to adjust the background without touching the product, or swap a lifestyle element while keeping the product rendering. This solves the "flat and uneditable" problem of AI output.

**Variations:**
Generate multiple versions from a strong seed before committing. Explore angle, lighting direction, or colour temperature while preserving the core composition.

---

## After Generation

All Lovart output must pass `brand-compliance-review` before entering production. At Level 3, add an explicit humanness check: does it look photographed? Output that looks AI-generated fails Level 3 regardless of brand alignment.

Load `lovart-figma-integration` skill to move approved assets into Figma correctly. Export at 2× resolution minimum. WebP for web, PNG for transparency, high-res JPEG for print-adjacent work.

---

## Lovart Style Preset — Build and Maintain

After 2–3 successful sessions for a brand, save to `context/[brand-name]-lovart-preset.md`:

```
Brand: [Name]
Last updated: [date]
Aesthetic direction: [from brand-context.md]

Seed bank: [seeds of outputs that passed the humanness check — save these]
Guidance setting: [what produced best results]
Style strength: [what produced best results]

Lighting: [specific source language that worked]
Colour temperature: [what worked, what to avoid]
Material vocabulary: [surface descriptions that produced correct rendering]
Backgrounds: [what works, what to avoid]

Negative prompts (standard for this brand): [list]
Reference images: [paths to 2-3 uploaded references that anchored best results]

Humanness notes: [what specifically made output look photographed]
Common failures: [what kept appearing that required inpainting or re-prompting]
```

Check for this file at the start of every Lovart session. If it exists, start from the seed bank and saved settings — never start from scratch when a preset exists.
