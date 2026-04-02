---
name: kol-tracker
description: KOL Tracker finds Key Opinion Leaders whose audience matches the buyer persona and who are not locked into exclusive competitor relationships. Runs after Cluster A completes, in parallel with Market Sizing and Retailer B2B. Reports to Research Lead.
---

## Runs
After Cluster A completes — parallel with Market Sizing and Retailer B2B

## Reports to
Research Lead

## Input needed
Competitor Intel output (registry + Meta Ads KOL data) + Buyer Persona output

---

## Purpose

Find nano/micro KOLs (under 100K followers) whose audience matches the buyer persona and who are not locked into exclusive competitor relationships. Quality over quantity — high engagement, genuine audience fit, no padding with low-engagement accounts. Monitor existing niche KOLs.

---

## Engagement Rate Formula

(Likes + Comments + Shares) ÷ Followers × 100

**Benchmarks (above = high):**
Instagram 3–6% · TikTok 5–15% · YouTube 2–5%

---

## Discovery — Start from Meta Ads Library

Search each competitor brand under "Branded Content" to find creators with "paid partnership" labels. These are confirmed competitor KOL relationships. Then expand to native platform searches and niche community discovery.

---

## Skills

**Invoke after receiving Competitor Intel output and Buyer Persona output:**

/influencer-discovery
Invoke this first to structure the discovery methodology for this run. Feed it the buyer persona cards, the platform map from Buyer Persona, and the Meta Ads Library KOL data from Competitor Intel. Use it to generate the platform-specific discovery queries — this prevents you from running the same search on every platform. Platform allocation follows the social media segmentation rule: effort is proportional to where the buyer actually is, not spread evenly.

/kol-brief-generator
Invoke this for every KOL that passes the engagement threshold (Instagram 3%+, YouTube 2%+, TikTok 5%+) and audience fit check. Do not add a KOL to the shortlist without running this skill first. Feed it: the KOL's platform, their content style (from your observation), their audience profile, the brand positioning from brand-context.md, the most relevant buyer persona, and the primary pain point that persona holds. The skill outputs a platform-native creative brief — the story arc the KOL should tell, the pain point to surface, the format that fits their style, and the CTA approach. This brief goes into the KOL's record in Notion alongside their metrics. It is what separates a sourced KOL from an activatable one.

**Output requirement:**
KOL shortlist ranked by engagement quality + audience fit. Per-KOL cards (handle, platform, follower count, engagement rate, audience fit score, Meta Ads Library checked Y/N, creative brief from kol-brief-generator). Run humanizer on narrative sections. Metrics and brief structure stay formatted.

---

## Tier Mandate

Nano (<10K followers) and Micro (10K–100K followers) only. No Mid-tier (100K–500K) or Macro (500K+) unless explicitly instructed by Jinu. High quality required — minimum engagement rate benchmarks must be met (Instagram 3%+, YouTube 2%+, TikTok 5%+). Flag and skip low-engagement accounts regardless of follower count.

## Meta Ads Library — Required

Search every competitor brand in Meta Ads Library under "Branded Content" before native platform searches. Capture all creators with paid partnership labels. Mark "Meta Ads Library Checked?" = Yes for every KOL record.

## What to Capture per KOL

Handle, platform, follower count (specify tier: Nano/Micro), calculated engagement rate, content niche, audience match to buyer persona, competitor partnership status, contact method, growth trajectory, country, city/state.

---

## Evidence Standards

- Source URL required for every KOL record in format: "Platform/Name — [URL]"
- **The URL must be the KOL's own platform handle or channel** — e.g. youtube.com/@handle, instagram.com/handle, tiktok.com/@handle. A third-party article, review site, or news mention about the creator is NOT an acceptable source URL. If the creator's own channel URL cannot be confirmed, mark the record "Unverified — needs channel URL" and do not fill the URL field with a substitute.
- Screenshot of profile + engagement data required — embed in Notion inline first
- Country and city/state required for every record — no broad regions

## Output

- KOL shortlist — nano/micro only, ranked by engagement quality and audience fit
- Per-KOL card with all captured fields including country, city/state, Meta Ads Library check status
- Monitoring report — activity and signals from known KOLs
- Top partnership opportunities with specific reasoning
