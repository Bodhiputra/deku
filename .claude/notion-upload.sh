#!/bin/bash
# notion-upload.sh
# Upload a local image file to Notion's File Upload API.
# Returns the file_upload ID, which can be used to embed the image as a block.
#
# Usage:
#   ./notion-upload.sh /path/to/image.png
#   ./notion-upload.sh /path/to/image.png <token>   (overrides NOTION_API_KEY)
#
# Output:
#   Prints the file_upload ID to stdout on success.
#   Prints an error to stderr and exits 1 on failure.
#
# To embed in a Notion page after getting the ID:
#   PATCH /v1/blocks/{page_id}/children with:
#   {
#     "children": [{
#       "object": "block",
#       "type": "image",
#       "image": {
#         "type": "file_upload",
#         "file_upload": { "id": "<upload_id>" }
#       }
#     }]
#   }

set -e

FILE_PATH="$1"
TOKEN="${2:-$NOTION_API_KEY}"

if [ -z "$FILE_PATH" ]; then
  echo "Usage: notion-upload.sh <file_path> [token]" >&2
  exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
  echo "File not found: $FILE_PATH" >&2
  exit 1
fi

if [ -z "$TOKEN" ]; then
  echo "NOTION_API_KEY is not set" >&2
  exit 1
fi

FILENAME=$(basename "$FILE_PATH")
MIME_TYPE=$(file --mime-type -b "$FILE_PATH")

# Step 1 — Create upload slot
SLOT_RESPONSE=$(curl -s -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Notion-Version: 2022-06-28" \
  -H "Content-Type: application/json" \
  -d "{\"name\": \"$FILENAME\", \"content_type\": \"$MIME_TYPE\"}" \
  https://api.notion.com/v1/file_uploads)

UPLOAD_ID=$(echo "$SLOT_RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('id',''))" 2>/dev/null)

if [ -z "$UPLOAD_ID" ]; then
  echo "Failed to create upload slot. Response: $SLOT_RESPONSE" >&2
  exit 1
fi

# Step 2 — Send file bytes (POST, not PUT)
SEND_RESPONSE=$(curl -s -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Notion-Version: 2022-06-28" \
  -F "file=@$FILE_PATH;type=$MIME_TYPE" \
  "https://api.notion.com/v1/file_uploads/$UPLOAD_ID/send")

STATUS=$(echo "$SEND_RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('status',''))" 2>/dev/null)

if [ "$STATUS" != "uploaded" ]; then
  echo "Upload failed. Status: $STATUS. Response: $SEND_RESPONSE" >&2
  exit 1
fi

# Output the upload ID
echo "$UPLOAD_ID"
