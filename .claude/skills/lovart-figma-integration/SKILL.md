---
name: lovart-figma-integration
description: Workflow for moving Lovart-generated assets into Figma production work correctly — asset preparation, image fill integration patterns, brand consistency check, and building a reusable Lovart style preset. Used by Visual Production and Digital Designer after any Lovart generation session.
---

# Lovart Figma Integration

Lovart generates images. Images are not components. An image sitting loose in a Figma file is a dead end — it can't respond to token changes, it can't be resized predictably, and it doesn't enforce brand consistency.

This skill teaches how to integrate Lovart output into the living design system rather than treating it as a flat asset.

---

## Step 1 — Asset Preparation (before importing to Figma)

**Resolution:** Export from Lovart at 2x resolution minimum. Raster images need resolution headroom for retina displays and large-format prints.

**Format:**
- WebP — web assets (smaller file size, wide browser support)
- PNG — assets requiring transparency
- High-res JPEG — print-adjacent work where file size matters less than quality

**Crop before importing:** Crop to the exact aspect ratio required before bringing into Figma. Do not crop inside Figma — cropping in Figma using clip content is less precise than proper pre-cropping.

**Naming:** Descriptive file names before import. `hero-product-angle-left-dark.webp` not `lovart-export-3.webp`. Names should be self-documenting — anyone looking at the file list should know what the asset is.

---

## Step 2 — Brand Consistency Check (before any asset enters a layout)

Check before importing. If an asset fails, iterate in Lovart — do not try to correct in Figma.

Ask:
- Does the colour temperature match the brand's established palette? (Lovart often defaults to warm tones — check against `context/brand-context.md [Design Direction]`)
- Does the lighting direction match other product photography in the system?
- Does the visual complexity level match the brand's aesthetic register?
- Would this image sit comfortably next to existing approved assets?

If any answer is no → iterate in Lovart, not in post-processing.

---

## Step 3 — Figma Integration Patterns

**Never drop images loose onto the canvas.** An image object sitting directly on a frame has no structural relationship to the design system.

**Correct pattern — image fills inside component frames:**
1. Create a frame at the exact dimensions needed (e.g. 1080×1080 for a square social asset)
2. Set a fill on the frame using the image
3. Set `clip content: on` — the image fill respects the frame's corner radius and constraints
4. The image component can now be resized, constrained, and placed in auto layout correctly

**Product photography component pattern:**
```
ProductHero (component, frame, 1:1 aspect ratio)
  └── Image fill (the Lovart-generated photo)
      └── clip content: on
      └── Fill: "Fill" (image scales to fill the frame without distortion)
```

Swap the image fill per usage without breaking the layout. This is the only correct way to use photography in a design system.

**For lifestyle/campaign images:** Same pattern — dedicated `LifestyleImage` component at the required aspect ratio, image fill inside. Multiple size variants as component variants.

**Image fill settings:**
- `Fill` — image scales to fill the frame, may crop edges. Best for hero images where the subject is centred.
- `Fit` — image scales to fit within the frame, may show empty space at edges. Best for product images on transparent or colour backgrounds.
- `Crop` — manual crop with a pan tool. Use when you need precise control over which part of the image is visible.

---

## Step 4 — Update the Lovart Style Preset

After any Lovart session that produced on-brand output, update `context/[brand-name]-lovart-preset.md`:

```
Brand: [Name]
Last updated: [date]
Aesthetic direction: [from brand-context.md — confirm still current]
Lighting: [what produced correct results]
Colour temperature: [cool/neutral/warm + specific guidance]
Backgrounds: [what works, what to avoid]
Negative prompt defaults: [standard exclusions for this brand]
Reference images: [paths to 2-3 anchoring reference images]
Session notes: [anything unexpected that worked or didn't]
```

If the file doesn't exist yet, create it. Check it at the start of every subsequent Lovart session.
