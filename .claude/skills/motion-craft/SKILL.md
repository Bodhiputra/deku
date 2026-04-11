---
name: motion-craft
description: Motion design methodology — the restraint principle, 12 animation principles applied to brand motion, easing vocabulary, timing reference, audio-visual coherence, and Remotion architecture. Used by Visual Production for all motion and animation briefs.
---

# Motion Craft

**The restraint principle:** Motion that reveals information or communicates character is design. Motion that exists for its own sake is decoration. Start from restraint and add only what earns its place.

Before any timeline work: read `context/brand-context.md [Design Direction]` for the motion character. Nagi sets motion intensity per campaign. Never assume.

---

## Motion Character by Design School

| School | What the motion says | How it moves |
|---|---|---|
| Classical / Neo-Minimalism | Deliberate, considered | One thing moves. Everything holds still. Long holds. |
| Engineered Transparency | Precise, mechanical, reveals function | Reveals structure. Feels specified in a technical document. |
| Tech Spec | Controlled, data-driven | Component breakdowns, spec reveals. Machine precision. |
| Quiet Luxury | Weighted, organic, material | Slow. Objects under gravity. The physics of precision manufacturing. |
| Retro Specificity | Analogue, warm mechanical | Rotary encoders, tape transport, physical controls. Warm but not a costume. |
| Maximalism / Signal | High energy, broadcast era | Rapid transitions. Only when the brief explicitly calls for it. |

---

## The 12 Principles — Applied to Brand Motion

**1. Timing:** Duration communicates weight. Longer = heavier, more important. Shorter = lighter. Every timing decision is a priority signal.

**2. Ease-in:** Starts slow, gains momentum. Objects being set in motion, gaining speed. Use for elements exiting frame.

**3. Ease-out:** Starts fast, decelerates to rest. Objects settling with intention. Use for elements entering and landing.

**4. Ease-in-out:** Slow start, fast middle, slow end. The most natural-feeling motion. Use for most UI transitions and component movements.

**5. Spring:** Overshoots slightly then settles. Communicates elasticity and personality. Use only for brands that can carry it — not for precision/engineering aesthetics.

**6. Linear:** Constant speed. Feels mechanical and unnatural. Exception: Tech Spec and Engineered Transparency aesthetics where machine precision is the point.

**7. Anticipation:** Slight opposite movement before the main action. Communicates intentionality. Use sparingly — powerful but can feel dated if overused.

**8. Staging (most important for brand work):** One element takes focus at a time. Everything else holds or moves minimally. The audience can only attend to one thing — give them one thing. The most critical discipline in brand motion.

**9. Follow-through:** Elements continue slightly past the end point then settle. Communicates physical weight and naturalness. Prevents motion from feeling abrupt.

**10. Secondary action:** Smaller supporting motions that reinforce the primary action. One primary motion; secondary elements respond quietly. Never compete with the primary.

**11. Squash and stretch:** Deformation under motion. Only for explicitly playful or character-driven brands. Never for precision/engineering aesthetics.

**12. Appeal:** The intangible quality that makes motion feel right. Achieved by combining proper timing with staging and restraint.

---

## Easing Vocabulary

```js
// Standard library — use these, not magic numbers
const EASE_BALANCED   = Easing.bezier(0.25, 0.1, 0.25, 1)   // CSS ease — balanced, natural, widely familiar
const EASE_MATERIAL   = Easing.bezier(0.4, 0, 0.2, 1)       // Material Design — smooth, slightly organic
const EASE_ACCELERATE = Easing.bezier(0.4, 0, 1, 1)         // Accelerate — objects gaining speed (exits)
const EASE_DECELERATE = Easing.bezier(0, 0, 0.2, 1)         // Decelerate — objects slowing to rest (entries)
const EASE_SPRING     = Easing.bezier(0.68, -0.55, 0.265, 1.55) // Spring — playful overshoot. Brands that can carry it only.
```

Select the easing constant that matches the brand's motion character from `context/brand-context.md [Design Direction]`. Assign it as `BRAND_EASE` at the top of every composition.

---

## Timing Reference

| Duration | Use case |
|---|---|
| 100–200ms | Micro-interactions, hover states, tooltip appears |
| 200–400ms | Component transitions, drawer opens, tab switches |
| 400–600ms | Page transitions, modal enters |
| 600–1000ms | Brand statements, hero entrances |
| 1000ms+ | Cinematic moments — reserved for launch reveals |

For Quiet Luxury: slide all durations toward the longer end. For Engineered Transparency: precise, shorter durations feel more specified.

---

## Remotion Architecture

**Named constants — no magic numbers, ever:**
```js
// Top of every composition — named for what they are
const BRAND_EASE    = Easing.bezier(0.25, 0.1, 0.25, 1)
const BRAND_ENTER   = 400   // component entry duration in ms
const BRAND_HOLD    = 1200  // hold duration before transition
const BRAND_EXIT    = 300   // exit duration (exits faster than entrances)
const BRAND_HERO    = 800   // hero statements and brand reveals
const FPS           = 30
```

**Static layers always from Figma:**
1. Design all frames in Figma with brand tokens
2. Export as high-res PNG or SVG
3. Import into Remotion as static layers
4. Animate timing, position, opacity, transform in Remotion
Never rebuild static visual elements from scratch in Remotion. The design system lives in Figma.

**Audio-reactive motion (when brand has sonic identity):**
```js
import { getAudioData, visualizeAudio } from '@remotion/media-utils'
// Use getAudioData to analyse the audio file
// Use visualizeAudio to drive waveform-responsive properties
```

---

## Audio-Visual Coherence

When a brand has a defined sonic identity, motion should feel like it has a sonic counterpart.

A brand that sounds precise and mechanical should move precisely and mechanically.
A brand that sounds warm and analogue should move with organic weight and warmth.

Sonic identity and motion direction both come from `context/brand-context.md [Design Direction]`. If the sonic character is not yet defined, ask Nagi before beginning any motion work.

---

## Export Formats

| Use case | Format | Specs |
|---|---|---|
| TikTok / Reels / YouTube Shorts | MP4 H.264 | 1080×1920, 30fps |
| Instagram square | MP4 H.264 | 1080×1080, 30fps |
| YouTube standard | MP4 H.264 | 1920×1080, 30fps |
| GIF (email / web) | GIF | 800×800 max, 15fps, under 5MB |

---

## Quality Gate Before Submitting to Nagi

- Motion intensity matches `context/brand-context.md [Design Direction]`
- Staging principle applied — one primary motion at a time
- All static layers sourced from Figma — no visual elements built in Remotion
- All timing and easing as named constants — zero magic numbers
- Export specs correct for the platform
- Load `brand-compliance-review` skill for final approval
