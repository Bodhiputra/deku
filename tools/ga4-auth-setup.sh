#!/usr/bin/env bash
# One-time GA4 MCP auth setup for Deku / Jinu.
# Official guide: https://github.com/googleanalytics/google-analytics-mcp
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT/.env"
ADC_FILE="${HOME}/.config/gcloud/application_default_credentials.json"
SCOPES="https://www.googleapis.com/auth/analytics.readonly,https://www.googleapis.com/auth/cloud-platform"

die() { echo "Error: $*" >&2; exit 1; }

command -v gcloud >/dev/null 2>&1 || die "gcloud not found. Install: brew install --cask gcloud-cli"

echo ""
echo "======================================"
echo "  GA4 MCP — gcloud auth setup"
echo "======================================"
echo ""

echo "Before continuing, confirm in Google Cloud Console:"
echo "  1. Google Analytics Admin API — enabled"
echo "  2. Google Analytics Data API — enabled"
echo "  3. OAuth Desktop client created → JSON downloaded"
echo ""
echo "  Admin API:  https://console.cloud.google.com/apis/library/analyticsadmin.googleapis.com"
echo "  Data API:   https://console.cloud.google.com/apis/library/analyticsdata.googleapis.com"
echo "  Credentials: https://console.cloud.google.com/apis/credentials"
echo ""

read -r -p "Path to OAuth Desktop client JSON (or Enter to skip client-id-file): " CLIENT_JSON
CLIENT_JSON="${CLIENT_JSON/#\~/$HOME}"

if [[ -n "$CLIENT_JSON" && ! -f "$CLIENT_JSON" ]]; then
  die "OAuth client file not found: $CLIENT_JSON"
fi

read -r -p "Google Cloud project ID (e.g. finecoustic-analytics): " PROJECT_ID
[[ -n "$PROJECT_ID" ]] || die "Project ID required"

echo ""
echo "Opening browser for Google sign-in (Application Default Credentials)..."
echo "Use the Google account that has Viewer access to your Finecoustic GA4 property."
echo ""

if [[ -n "$CLIENT_JSON" ]]; then
  gcloud auth application-default login \
    --scopes "$SCOPES" \
    --client-id-file "$CLIENT_JSON"
else
  gcloud auth application-default login \
    --scopes "$SCOPES"
fi

[[ -f "$ADC_FILE" ]] || die "ADC file not created at $ADC_FILE"

echo ""
echo "ADC saved: $ADC_FILE"
echo ""

# Update or create .env
touch "$ENV_FILE"
upsert_env() {
  local key="$1" val="$2"
  if grep -q "^${key}=" "$ENV_FILE" 2>/dev/null; then
    if [[ "$(uname)" == "Darwin" ]]; then
      sed -i '' "s|^${key}=.*|${key}=${val}|" "$ENV_FILE"
    else
      sed -i "s|^${key}=.*|${key}=${val}|" "$ENV_FILE"
    fi
  else
    echo "${key}=${val}" >> "$ENV_FILE"
  fi
}

upsert_env "GOOGLE_APPLICATION_CREDENTIALS" "$ADC_FILE"
upsert_env "GOOGLE_PROJECT_ID" "$PROJECT_ID"

if ! grep -q "^GA4_PROPERTY_ID=" "$ENV_FILE" 2>/dev/null; then
  echo "GA4_PROPERTY_ID=" >> "$ENV_FILE"
fi

echo "Updated $ENV_FILE:"
grep -E '^(GOOGLE_|GA4_)' "$ENV_FILE" || true

echo ""
read -r -p "GA4 property ID (properties/123456789) — Enter to set later: " GA4_ID
if [[ -n "$GA4_ID" ]]; then
  upsert_env "GA4_PROPERTY_ID" "$GA4_ID"
  echo ""
  echo "Add the same ID to context/brand-context.md → Web Analytics → ga4_property_id"
fi

echo ""
echo "Next steps:"
echo "  1. Restart Cursor (reload analytics MCP)"
echo "  2. Ask Jinu: \"List my GA4 properties\""
echo "  3. Set ga4_property_id in context/brand-context.md if not done"
echo ""
echo "Done."
