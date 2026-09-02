#!/usr/bin/env bash
# Downloads the seven images the site references into ./assets/.
#
# These live on the current Squarespace CDN. Run this once from the `site/`
# directory, then commit `assets/` so the new site no longer depends on the
# Squarespace account staying alive.
#
#   ./fetch-assets.sh
#
set -euo pipefail

cd "$(dirname "$0")"
mkdir -p assets

BASE="https://images.squarespace-cdn.com/content/v1/6a4588b7a805f6688af51b95"

fetch() {
  local url="$1" out="assets/$2"
  if curl -fsS -L --max-time 60 -o "$out" "$url"; then
    printf '  ok   %-38s %s bytes\n' "$2" "$(wc -c < "$out")"
  else
    rm -f "$out"
    printf '  FAIL %-38s (%s)\n' "$2" "$url"
    return 1
  fi
}

echo "Fetching images into ./assets ..."
status=0
fetch "$BASE/22bef011-9d5d-48a3-97e0-0b03c42c0cb3/Goliath+Consulting+LLC+logo.png"                    "logo.png"                          || status=1
fetch "$BASE/1783968060701-O3RNF2UU3UQR8FLA8JIP/unsplash-image-5U_28ojjgms.jpg"                       "hero-meeting.jpg"                  || status=1
fetch "$BASE/45f2ab60-a779-4829-b64c-db7636c4434b/84486BC2-C787-4F7F-B717-CF0DFC518902_1_105_c.jpeg"  "founder.jpeg"                      || status=1
fetch "$BASE/1784067649484-ZICM8R4SPJZ4B4HL0N1T/unsplash-image-fT4SwA83jH4.jpg"                       "supply-chain-cargo.jpg"            || status=1
fetch "$BASE/1784124795467-BWWCTZRH8I7TM2UATNM8/unsplash-image-5hPe-Tr2wog.jpg"                       "operational-efficiency-factory.jpg" || status=1
fetch "$BASE/1784140144630-2AX5NAKU12NP7N215IGO/unsplash-image-kN_kViDchA0.jpg"                       "customer-intelligence-office.jpg"  || status=1
fetch "$BASE/1784655767137-8DCQGTV8EPTLICYORWSV/unsplash-image-abh7zBccJS8.jpg"                       "business-resilience-open.jpg"      || status=1

if [ "$status" -eq 0 ]; then
  echo "Done — all seven images downloaded."
else
  echo "Some downloads failed. If the CDN paths have changed, grab the images"
  echo "from goliathconsultingllc.com and save them under ./assets with the"
  echo "filenames listed above."
fi
exit "$status"
