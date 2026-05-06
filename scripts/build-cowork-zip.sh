#!/usr/bin/env bash
# Build Cowork-format zip from this repo.
#
# Cowork's plugin upload expects:
#   - Files at the ZIP ROOT (no wrapper folder)
#   - skills/<name>/SKILL.md nesting preserved
#   - .claude-plugin/plugin.json + .claude-plugin/marketplace.json present
#
# Usage: ./scripts/build-cowork-zip.sh [version]
#   version defaults to plugin.json "version" field.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

VERSION="${1:-$(grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' .claude-plugin/plugin.json | head -1 | sed 's/.*"\([^"]*\)"$/\1/')}"

if [[ -z "$VERSION" ]]; then
  echo "error: could not determine version" >&2
  exit 1
fi

STAGE="$(mktemp -d)"

cp -r .claude-plugin "$STAGE/"
cp -r skills "$STAGE/"
cp README.md LICENSE "$STAGE/"

ZIP_NAME="mindpowers-cowork-v${VERSION}.zip"
ZIP_PATH="$REPO_ROOT/dist/$ZIP_NAME"
mkdir -p "$REPO_ROOT/dist"
rm -f "$ZIP_PATH"

(cd "$STAGE" && zip -r "$ZIP_PATH" . >/dev/null)

rm -rf "$STAGE"

echo "built: $ZIP_PATH"
