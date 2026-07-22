#!/usr/bin/env bash
# Upload a local image to Kie.ai temporary file storage and print the response JSON.
# The JSON contains `fileUrl` / `downloadUrl` — pass that URL to the editing tool.
# Files are auto-deleted by Kie.ai after ~3 days.
#
# usage: scripts/kie_upload.sh <image-file>
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "usage: $0 <image-file>" >&2
  exit 1
fi

if [ -z "${KIE_AI_API_KEY:-}" ]; then
  ENV_FILE="$(cd "$(dirname "$0")/.." && pwd)/.env"
  if [ -f "$ENV_FILE" ]; then
    set -a; . "$ENV_FILE"; set +a
  fi
fi
: "${KIE_AI_API_KEY:?KIE_AI_API_KEY is not set — put it in .env at the repo root (see README)}"

FILE="$1"
if [ ! -f "$FILE" ]; then
  echo "no such file: $FILE" >&2
  exit 1
fi

curl -sS -X POST "https://kieai.redpandaai.co/api/file-stream-upload" \
  -H "Authorization: Bearer ${KIE_AI_API_KEY}" \
  -F "file=@${FILE}" \
  -F "uploadPath=photo-polish" \
  -F "fileName=$(basename "$FILE")"
echo
