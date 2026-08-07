#!/usr/bin/env bash
# Smoke test: start companion, push a screen, fetch it with/without key, stop.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
TMP="$(mktemp -d)"
JAR="$TMP/cookies"
SESSION_DIR=""
cleanup() {
  [ -n "$SESSION_DIR" ] && bash "$DIR/stop-server.sh" "$SESSION_DIR" >/dev/null 2>&1 || true
  rm -rf "$TMP"
}
trap cleanup EXIT

OUT="$("$DIR/start-server.sh" --project-dir "$TMP")"
URL="$(printf '%s' "$OUT" | node -e 'let s="";process.stdin.on("data",d=>s+=d).on("end",()=>console.log(JSON.parse(s).url))')"
SCREEN_DIR="$(printf '%s' "$OUT" | node -e 'let s="";process.stdin.on("data",d=>s+=d).on("end",()=>console.log(JSON.parse(s).screen_dir))')"
SESSION_DIR="$(dirname "$SCREEN_DIR")"

printf '<h2>SMOKE-MARKER-42</h2>' > "$SCREEN_DIR/smoke.html"
sleep 1

BARE="${URL%%\?*}"
# GET with ?key= mirrors the key into a cookie and returns a bootstrap page
# (by design, see server.cjs "mirrored into a cookie on first load"); a real
# browser follows that with a same-origin nav. Mimic that with a cookie jar.
curl -sf -c "$JAR" "$URL" >/dev/null
BODY="$(curl -sf -b "$JAR" "$BARE")"
echo "$BODY" | grep -q 'SMOKE-MARKER-42' || { echo "FAIL: screen not served"; exit 1; }
echo "$BODY" | grep -q 'Mindpowers Companion' || { echo "FAIL: brand missing"; exit 1; }
# Required MIT attribution lines ("Vendored from obra/superpowers ...")
# legitimately contain "superpowers"; exclude those before checking that no
# upstream branding leaked into visible content.
echo "$BODY" | grep -vi 'vendored from' | grep -qi 'superpowers' && { echo "FAIL: upstream branding leaked"; exit 1; }

CODE="$(curl -s -o /dev/null -w '%{http_code}' "$BARE")"
[ "$CODE" != "200" ] || { echo "FAIL: keyless request served"; exit 1; }

bash "$DIR/stop-server.sh" "$SESSION_DIR" >/dev/null
[ -f "$SESSION_DIR/state/server-stopped" ] || { echo "FAIL: no server-stopped marker"; exit 1; }
SESSION_DIR=""
echo PASS
