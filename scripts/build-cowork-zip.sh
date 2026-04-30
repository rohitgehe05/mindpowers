#!/usr/bin/env bash
# Build Cowork-format zip from Claude Code repo layout.
# Cowork requires SKILL.md at the top level; this repo nests it under skills/brainstorming/.
# Usage: ./scripts/build-cowork-zip.sh [version]
#   version defaults to plugin.json "version" field.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

VERSION="${1:-$(grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' .claude-plugin/plugin.json | sed 's/.*"\([^"]*\)"$/\1/')}"

if [[ -z "$VERSION" ]]; then
  echo "error: could not determine version" >&2
  exit 1
fi

OUT_DIR="$(mktemp -d)"
STAGE="$OUT_DIR/mindpowers"
mkdir -p "$STAGE"

cp -r .claude-plugin "$STAGE/"
cp skills/brainstorming/SKILL.md "$STAGE/"
cp -r skills/brainstorming/references "$STAGE/"
cp README.md LICENSE CHANGELOG.md CONTRIBUTING.md "$STAGE/"

ZIP_NAME="mindpowers-cowork-v${VERSION}.zip"
ZIP_PATH="$REPO_ROOT/dist/$ZIP_NAME"
mkdir -p "$REPO_ROOT/dist"
rm -f "$ZIP_PATH"

(cd "$OUT_DIR" && zip -r "$ZIP_PATH" mindpowers >/dev/null)

rm -rf "$OUT_DIR"

echo "built: $ZIP_PATH"
