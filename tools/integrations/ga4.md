# Google Analytics 4 — Deku Integration

**MCP server:** Official [google-analytics-mcp](https://github.com/googleanalytics/google-analytics-mcp) (`analytics-mcp` on PyPI)  
**Skill:** `.claude/skills/ga4-analytics/SKILL.md`  
**Owner:** Jinu (CMO)  
**Access:** Read-only (`analytics.readonly`)

## MCP registration

| Host | Config file |
|---|---|
| Cursor | `~/.cursor/mcp.json` → `ga4` (global — works in multi-root workspace) |
| Claude Code | `.mcp.json` → `ga4` |

Command: `uvx --python 3.12 analytics-mcp`

## Tools exposed

| Tool | Purpose |
|---|---|
| `get_account_summaries` | List accessible GA4 accounts/properties |
| `get_property_details` | Property metadata |
| `list_google_ads_links` | GA ↔ Google Ads links |
| `list_property_annotations` | Property annotations |
| `get_custom_dimensions_and_metrics` | Custom schema |
| `run_report` | Standard Data API reports |
| `run_realtime_report` | Last ~30 minutes |
| `run_funnel_report` | Funnel analysis |
| `run_conversions_report` | Conversion reports |

## Brand config

- `context/brand-context.md` → **Web Analytics** → `ga4_property_id`
- `.env` → `GOOGLE_APPLICATION_CREDENTIALS`, `GOOGLE_PROJECT_ID`, `GA4_PROPERTY_ID` (optional)

Setup: `.claude/skills/ga4-analytics/references/setup.md`

## Related

- `paid-ads` skill — platform-side metrics; cross-check with GA4
- `seo-google` skill — organic SEO slice only; not full marketing analytics
