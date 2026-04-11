---
name: visual-production
description: Full-range static and animated visual production methodology. Part A covers static asset production — platform specs, template discipline, Lovart generative workflow, quality gate. Part B covers motion production — motion schools, Remotion workflow, timing system, audio-visual coherence. Loaded contextually by Visual Production agent based on brief type.
---

# Visual Production

Load Part A for static briefs. Load Part B for motion briefs. Load both for combined static + motion campaigns.

---

## Part A — Static Visual Production

### Platform Specifications
Verify before production — platforms update their specs periodically.

| Format | Dimensions | Notes |
|---|---|---|
| Instagram post | 1080×1080 (1:1) or 1080×1350 (4:5) | 4:5 takes more feed space — preferred for product visibility |
| Instagram story / reel cover | 1080×1920 | Safe zones: 14% top and bottom (UI overlaps these zones) |
| YouTube thumbnail | 1280×720 | Must read at 120×68px — test at small size |
| YouTube Shorts | 1080×1920 | Text in centre third — UI covers top and bottom edges |
| Meta feed ad | 1080×1080, 1080×1350, or 1200×628 | 1080×1350 maximises feed real estate |
| Email header | 600px wide | Max — not full bleed |

**Safe zone rule:** All primary text and logo within safe zones. Platform UI elements overlap edges — anything outside safe zones gets covered or cropped on actual devices. Build safe zones as a locked layer in every social template.

### Template Discipline

All social templates:
- Brand component tokens for colour, type, and spacing — zero hardcoded values
- Auto layout so resizing does not break composition
- Locked brand layer groups (logo, safe zone guides)
- Campaign-variable layers clearly labelled and unlocked for easy swap

Build templates once, use across campaigns. The brand token system means a palette update propagates through all templates automatically.

### Generative Image Workflow (Lovart via Chrome DevTools MCP)

Load `lovart-prompting` skill before any Lovart session.

1. Prepare exact prompt including brand direction keywords from `context/brand-context.md [Design Direction]`, aspect ratio, and style references
2. Check if reference images are available from Design Research Scout — upload 2–3 before prompting
3. Send to Lovart via Chrome DevTools MCP (user must be logged into Lovart in Chrome)
4. Three-round iteration protocol — do not try to achieve final output in one prompt
5. Load `lovart-figma-integration` skill to move approved assets into the Figma production file
6. If Chrome session unavailable, flag to Nagi — do not proceed without generative image access

### Static Quality Gate (before submitting to Nagi)

Load `brand-compliance-review` skill. Additionally verify:
- Dimensions correct for the platform and format
- All values from brand tokens — zero hardcoded colour, type, or spacing
- Visual hierarchy clear at thumbnail size (not just full screen) — export a small preview and check
- Safe zones respected
- No placeholder text or approximated assets
- Export settings correct: PNG for assets with transparency, WebP for web, high-res JPEG for print-adjacent

---

## Part B — Motion Production

### Read Design Direction First

Before touching any timeline, read `context/brand-context.md [Design Direction]` for the motion character. Nagi sets motion intensity direction per campaign. Never assume.

Motion character by design school:

| School | Motion signature |
|---|---|
| Classical / Neo-Minimalism | Economy — one thing moves, everything holds still. Long holds. Deliberate timing. |
| Engineered Transparency | Precise, mechanical, restrained. Reveals structure and function. Feels specified. |
| Tech Spec | Controlled, data-driven. Component breakdowns, spec reveals. |
| Quiet Luxury | Slow, weighted, organic. Materials under gravity. The physics of precision manufacturing. |
| Retro Specificity | Analogue equipment movement — the warm mechanical feel of physical controls. |
| Maximalism / Signal | Broadcast-era energy, rapid transitions. Only when the brief explicitly calls for it. |

### Remotion Workflow

Static layers always from Figma — never built from scratch in Remotion.

1. Design all static frames in Figma using brand tokens
2. Export frames as high-res PNG or SVG
3. Import into Remotion as static layers
4. Animate timing, position, opacity, and transform — never rebuild the visual in Remotion

**Timing system — no magic numbers:**

```js
// Named constants at the top of every composition
const BRAND_EASE = Easing.bezier(0.25, 0.1, 0.25, 1)  // CSS ease — balanced, natural
const BRAND_ENTER = 400    // ms — component transitions, drawer opens
const BRAND_HOLD = 1200    // ms — time a statement holds before transitioning
const BRAND_EXIT = 300     // ms — exits are faster than entrances
const BRAND_HERO = 800     // ms — hero entrances, brand statements
```

Adjust constants to match the brand's motion character — a Quiet Luxury brand uses longer ENTER (600ms) and HOLD (2000ms). An Engineered Transparency brand uses precise, shorter timings (ENTER 300ms, mechanical feel).

**Audio-reactive motion:** When the brand has a sonic identity, use `getAudioData` and `visualizeAudio` from Remotion for waveform-driven animations.

### Export Formats

| Use case | Format | Specs |
|---|---|---|
| TikTok / Reels / YouTube Shorts | MP4 H.264 | 1080×1920, 30fps |
| Instagram square | MP4 H.264 | 1080×1080, 30fps |
| GIF (email / web) | GIF | 800×800 max, 15fps, under 5MB |
| YouTube (standard) | MP4 H.264 | 1920×1080, 30fps |

### The 12 Principles — Applied to Brand Motion

Restraint first: motion that reveals information or communicates character is design. Motion that exists for its own sake is decoration.

**Most relevant principles for brand motion:**
- **Staging** — one element takes focus at a time. Everything else holds or moves minimally. Most important discipline for brand work.
- **Timing** — longer duration = heavier and more important. Shorter = lighter. Every timing decision communicates weight and priority.
- **Ease-out** — starts fast, ends slow. Objects settling with intention. Use for elements landing on screen.
- **Ease-in** — starts slow, gains momentum. Use for elements exiting or objects being set in motion.
- **Follow-through** — elements don't stop abruptly; they continue slightly past the end point then settle. Communicates physical weight.
- **Secondary action** — smaller supporting motions that reinforce the primary action. One primary motion, secondary elements respond quietly.

**Avoid for precision/engineering brands:** Spring (playful overshoot), Squash and stretch (deformation), Anticipation (can feel dated).

### Motion Quality Gate (before submitting to Nagi)

- Motion intensity matches the brand direction from `context/brand-context.md [Design Direction]`
- Static layers sourced from Figma — no visual elements built in Remotion
- All timing as named constants — zero magic numbers in the timeline
- Export specs correct for the platform
- Load `brand-compliance-review` skill for final approval
