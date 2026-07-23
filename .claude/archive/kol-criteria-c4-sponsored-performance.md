# Archived KOL Criterion — C4 Sponsored Content Performance
*Removed from active gates: 2026-06-22. Restore by re-adding to `kol-discovery` skill and `TASK-DOD.md`.*

---

## C4 — Sponsored content performance (archived definition)

Has the creator done branded content? Does it perform at a similar level to their organic content? If sponsored posts have **<50% of normal engagement** — disqualifying.

**Applicability:** Conditional — "if applicable." If a creator has never done branded content, C4 does not block them.

---

## How to check (Instagram)

**Step 1 — Find sponsored posts** while scrolling the last 15 posts (same window as C6):

- Paid Partnership label
- Caption markers: `#ad`, `#sponsored`, `#gifted`, "thanks to @brand"
- Obvious brand/product features that break their normal content pattern
- Collab posts with a brand account tagged

If none found → C4 N/A, pass.

**Step 2 — Build comparison sets:**

- **Sponsored:** every clearly branded post in the last 15 (or further back if only 1–2 exist)
- **Organic baseline:** normal posts from the same window — exclude pinned outliers and sponsored posts

Need at least 1 sponsored post and 2–3 organic posts for a fair read.

**Step 3 — Compare engagement** by opening individual posts and reading UpDog per-post overlays (likes, comments, views on Reels). Compare sponsored vs organic on the same metric type:

- Reels → views + likes + comments
- Statics → likes + comments

Do not use follower-based ER for this — post vs post against their own baseline.

**Fail threshold:** sponsored post engagement **<50%** of typical organic → skip.

**Step 4 — Record in Agent Reason:**

- `C4 N/A — no sponsored posts in last 15`
- `C4 pass — [brand] posts at ~70% of organic engagement`
- `C4 fail — last brand post at ~25% of organic avg`

---

## Edge cases

| Situation | Call |
|---|---|
| Never done a brand deal | Pass (C4 N/A) |
| Only one old sponsored post | Assess that post; lean pass unless clearly tanked |
| Sponsored Reel vs organic statics | Compare Reel-to-Reel only |
| Pinned viral organic post | Exclude from baseline (same as C1 ER outlier rule) |

---

## YouTube (when platform applies)

Find videos with sponsorship disclosures or obvious brand integrations in the last 10–12 months. Compare views/likes/comments to non-sponsored videos. Same <50% threshold. API script does not automate C4 — manual channel review required.

---

## Relationship to content-fit rules

`context/brand-kol-strategy.md` notes that **product promotion history is a positive signal** (willingness + audience tolerance). That is separate from C4, which measured **performance** of sponsored posts, not existence.
