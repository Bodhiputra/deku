# Audio Industry Source Tiers

Reference for `domain-research` when the active industry is consumer audio or adjacent.

## Tier 1 — Standards & primary technical sources

| Source | Use for |
|---|---|
| Bluetooth SIG | Bluetooth versions, profiles, LE Audio, codec specs |
| IEC / ISO | IP ratings (60529), safety, environmental tests |
| IEEE | Wireless, signal processing papers |
| Chip vendor docs (Qualcomm, BES, Actions, Airoha, Realtek) | SoC features, codec support, power specs |
| Driver manufacturer datasheets (Knowles, Goertek, etc.) | Driver types, sensitivity, THD |

## Tier 2 — Credible review & measurement sites

| Source | Strength | Caveat |
|---|---|---|
| [RTings.com](https://www.rtings.com) | Headphones/speakers — measured frequency response, consistency | Not all portable categories covered |
| [Audio Science Review (ASR)](https://www.audiosciencereview.com) | Measurements, DAC/amp analysis, technical forums | Audiophile-leaning audience |
| [SoundGuys](https://www.soundguys.com) | Consumer audio explainers, codec comparisons | Less lab-grade than RTings |
| [Crinacle](https://crinacle.com) | IEM/headphone measurements and rankings | IEM-focused |
| [InnerFidelity / Stereophile measurements](https://www.stereophile.com) | Legacy measurement archive | Update frequency varies |
| Manufacturer white papers | Product mechanism claims | Marketing filter — verify test method |

## Tier 3 — Trade & editorial (trends, not primary specs)

| Source | Use for |
|---|---|
| Gear Patrol | Lifestyle/product discovery — lead gen only |
| What Hi-Fi?, Sound & Vision | Category trends, product announcements |
| The Verge, Engadget (audio section) | Launch news — verify specs against primary source |

**Never enter Tier 3 alone as Fact in the bank.**

## Tier 4 — Community & social signals

| Source | Tool | Use for |
|---|---|---|
| Reddit | Reddit MCP | r/audiophile, r/Bluetooth, r/headphones, r/BudgetAudiophile, r/Speakers — real-world failure modes, spec questions, buyer confusion |
| Head-Fi forums | Playwright | Long-form technical discussion |
| YouTube (technical reviewers) | Playwright | Teardowns, spec walkthroughs — verify claims, don't trust alone |
| X / Instagram | Chrome (read-only) | Launch buzz, industrial design trends — **Practice** only |

Use community sources for **Practice** and question discovery. Verify technical claims against Tier 1–2 before bank write.

## Tier 5 — General web / blogs

Lead generation only. Always verify against Tier 1–2 before entering bank as **Fact**.

## Industry scan workflow

When the assigned industry is consumer audio and the owner requests an industry scan:

1. Check 2–3 Tier 2 sites for recent reviews in the brand's product category
2. Reddit pass — top threads from last 30 days in relevant subreddits
3. Note new chipsets, codec adoption, form factors (open-ear, clip, glasses)
4. Label everything; write summary to `topics/industry-signals-<YYYY-MM>.md` if persisting
