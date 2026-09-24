---
name: ga4-analytics
description: Web and marketing analytics for GA4 via the official Google Analytics MCP server. Use when the user asks about site traffic, acquisition channels, landing pages, funnels, conversions, revenue, realtime activity, or weekly/monthly performance. Jinu loads this for "how's the site performing", analytics readouts, and paid attribution cross-checks (with paid-ads). Read-only — never change GA4 configuration.
metadata:
  version: 1.0.0
---

# GA4 Analytics

Load at the start of every web analytics task. Jinu uses the **official [Google Analytics MCP server](https://github.com/googleanalytics/google-analytics-mcp)** (`analytics-mcp`) — read-only access to GA4 Admin and Data APIs.

**Owner:** Jinu (CMO). **Not** for GTM/tag installation (host assistant) or SEO-only organic reports (`seo-google` skill).

---

## Before Starting

1. Read `context/brand-context.md` → **Web Analytics** for `ga4_property_id` and currency.
2. Read `context/confirmed-markets.md` — geo-tag findings to confirmed countries when reporting by region.
3. Confirm scope: date range, comparison period, and deliverable (chat snapshot vs Notion write).
4. Load `references/setup.md` if MCP auth fails or property ID is missing.
5. Load `references/report-recipes.md` when building `run_report` / funnel calls.

**Hard rules:**
- **Read-only.** Never attempt to mutate GA4 configuration.
- **Fact vs implication.** Numbers from MCP = Fact. Marketing recommendations = labelled *Implication:*.
- **Compare periods.** Default: current window vs equal prior window (e.g. last 7 days vs previous 7).
- **Cross-check paid claims** with `paid-ads` — platform CPA is inflated vs GA4 last-click.

---

## MCP Tool Map

| MCP tool | When to use |
|---|---|
| `get_account_summaries` | Property ID unknown — find property by name |
| `get_property_details` | Confirm timezone, currency, display name |
| `list_google_ads_links` | Paid attribution questions — verify GA ↔ Ads link |
| `list_property_annotations` | Property notes / config context |
| `get_custom_dimensions_and_metrics` | Before custom/Shopify event reports |
| `run_report` | Traffic, channels, pages, geo, devices, events, revenue |
| `run_realtime_report` | Launch monitoring — active users, live pages/events |
| `run_funnel_report` | PDP → cart → checkout → purchase drop-offs |
| `run_conversions_report` | Conversion-specific breakdowns |

Skills may reference tools as `mcp__ga4__*`. Use the `ga4` MCP namespace configured in `~/.cursor/mcp.json` (Cursor) / `.mcp.json` (Claude Code).

---

## Session Start Checklist

1. Call `get_account_summaries` — confirm MCP connected and property accessible.
2. Resolve `property_id`:
   - Primary: `context/brand-context.md` → **Web Analytics** → `ga4_property_id`
   - Fallback: search account summaries for "Finecoustic" or owner-provided name
3. Call `get_property_details` once per session — note timezone for date boundaries.
4. For e-commerce or event questions: call `get_custom_dimensions_and_metrics` before custom dims.
5. For paid performance: call `list_google_ads_links` — flag if unlinked when user asks about ads.

If MCP fails with auth errors → stop, read `references/setup.md`, give owner the setup steps. Do not guess numbers.

---

## Task Recipes

### Weekly snapshot
**Question:** *How did the site perform this week?*

1. `run_report` — recipe **weekly-overview** (see report-recipes.md)
2. Repeat for prior week (comparison `date_ranges`)
3. Deliver: users, sessions, engagement rate, conversions, revenue + % change

### Acquisition mix
**Question:** *Where is traffic coming from?*

1. `run_report` — recipe **acquisition-channels**
2. Sort by sessions; note paid vs organic vs social vs direct share
3. If paid-heavy: load `paid-ads` for platform-side comparison

### Landing page performance
**Question:** *Which pages drive or lose conversions?*

1. `run_report` — recipe **top-landing-pages**
2. Flag high-traffic / low-conversion pages as *Implication:* for content or UX handoff to Nagi

### Product / e-commerce
**Question:** *What sold / what got views?*

1. Confirm e-commerce events fire (`get_custom_dimensions_and_metrics` if needed)
2. `run_report` — recipe **top-products**
3. Pair with **acquisition-channels** filtered to converting sessions if scope allows

### Funnel drop-off
**Question:** *Where do we lose buyers?*

1. `run_funnel_report` — recipe **ecommerce-funnel**
2. Break down by `deviceCategory` if mobile drop-off suspected
3. *Implication:* only — hand UX fixes to Nagi, checkout fixes to host/Shopify

### Realtime (launches)
**Question:** *What's happening right now?*

1. `run_realtime_report` — active users, top pages, top events
2. Short snapshot only — no long-form Notion write unless owner asks

### Paid attribution sanity check
**Question:** *Do Meta/Google numbers match GA4?*

1. `list_google_ads_links`
2. `run_report` — recipe **acquisition-channels** (paid subset)
3. Explain attribution differences — do not treat platform dashboard as ground truth

---

## Output Format

**Chat (default):**

1. **Run summary** — property, date range, question
2. **Headline numbers** — users, sessions, conversions, revenue (if e-com)
3. **What changed** — vs comparison period; biggest movers up/down
4. **Implications** — 2–3 prioritized marketing actions
5. **Data caveats** — attribution model, missing events, unlinked Ads, sampling

**Notion (when owner uses Notion and asks for durable record):**
- Page title: `Web Analytics — [date range] — [topic]`
- Same structure as chat; link to relevant campaign or content pages if they exist

Omit sections not covered by the task.

---

## Related Skills

| Skill | Relationship |
|---|---|
| `paid-ads` | Platform-side spend/CPA; cross-check with GA4 acquisition |
| `content-strategy` | Use landing page + channel data to prioritize content |
| `seo-google` | Organic search only — GSC + GA4 organic slice; not full marketing analytics |

---

## References

- [setup.md](references/setup.md) — MCP install, GCP auth, property ID
- [report-recipes.md](references/report-recipes.md) — dimension/metric sets for `run_report` and funnels
- [tools/integrations/ga4.md](../../../tools/integrations/ga4.md) — integration summary
- [Official GA MCP repo](https://github.com/googleanalytics/google-analytics-mcp)
- [GA4 dimensions & metrics schema](https://developers.google.com/analytics/devguides/reporting/data/v1/api-schema)
