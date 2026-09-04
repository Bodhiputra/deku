# GA4 MCP Setup

One-time setup for the official [Google Analytics MCP server](https://github.com/googleanalytics/google-analytics-mcp). Deku runs it via `uvx` (Python 3.12+) — same pattern as Reddit MCP.

## Prerequisites

- Python **3.10+** (Deku uses 3.12 via `uvx`)
- Google account with **Viewer** (or higher) access to the Finecoustic GA4 property
- Google Cloud project with APIs enabled

## 1. Enable Google Cloud APIs

In your GCP project, enable:

- [Google Analytics Admin API](https://console.cloud.google.com/apis/library/analyticsadmin.googleapis.com)
- [Google Analytics Data API](https://console.cloud.google.com/apis/library/analyticsdata.googleapis.com)

## 2. Authenticate (Application Default Credentials)

**Option A — OAuth (recommended for local dev)**

1. Create an OAuth **Desktop** client in GCP → APIs & Services → Credentials.
2. Download the client JSON.
3. Run:

```bash
gcloud auth application-default login \
  --scopes https://www.googleapis.com/auth/analytics.readonly,https://www.googleapis.com/auth/cloud-platform \
  --client-id-file=PATH_TO_CLIENT_JSON
```

4. Note the credentials path printed (`Credentials saved to file: ...`).

**Option B — Service account impersonation**

Use if your org requires a service account. See the [official README](https://github.com/googleanalytics/google-analytics-mcp#configure-credentials-).

## 3. Local env (`.env`)

Add to `.env` (gitignored):

```bash
GOOGLE_APPLICATION_CREDENTIALS=/path/to/application_default_credentials.json
GOOGLE_PROJECT_ID=your-gcp-project-id
GA4_PROPERTY_ID=properties/123456789
```

`GA4_PROPERTY_ID` should also be copied to `context/brand-context.md` → **Web Analytics**.

If `GOOGLE_APPLICATION_CREDENTIALS` is omitted, the MCP uses the default ADC location from `gcloud auth application-default login`.

## 4. MCP wiring

Deku registers the server in `.mcp.json` and `.cursor/mcp.json`:

```json
"analytics": {
  "command": "uvx",
  "args": ["--python", "3.12", "analytics-mcp"]
}
```

Optional `env` block (add paths from your `.env` if Cursor does not inherit shell env):

```json
"env": {
  "GOOGLE_APPLICATION_CREDENTIALS": "/path/to/credentials.json",
  "GOOGLE_PROJECT_ID": "your-project-id"
}
```

Restart Cursor / Claude Code after changing MCP config.

## 5. Verify

Ask Jinu: *"List my GA4 properties"* — should call `get_account_summaries`.

Or test MCP tools directly after restart.

## 6. Property ID in brand context

Find property ID in GA4 → Admin → Property settings, or from `get_account_summaries`.

Format: `properties/123456789` or numeric `123456789`.

Add to `context/brand-context.md`:

```markdown
## Web Analytics

- **ga4_property_id:** `properties/XXXXXXXX`
- **Default currency:** USD
- **Shopify stream:** (confirm web data stream name if multiple)
```

## Troubleshooting

| Error | Fix |
|---|---|
| MCP not listed | Restart host; confirm `.cursor/mcp.json` has `analytics` entry |
| Permission denied | Grant GA4 property access to the authenticated Google account |
| API not enabled | Enable Admin + Data APIs in GCP |
| Python version | Ensure `uvx --python 3.12` — GA MCP requires 3.10+ |
| Empty reports | Wrong property ID; verify with `get_property_details` |

## Security

- Scope is **read-only** (`analytics.readonly`) — MCP cannot change GA4 config.
- Never commit credentials or `.env`.
