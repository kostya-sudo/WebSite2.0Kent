#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SVG_PATH="$REPO_ROOT/assets/logo.svg"
PNG_PATH="$REPO_ROOT/assets/logo.png"

if [ ! -f "$SVG_PATH" ]; then
  echo "SVG not found: $SVG_PATH"
  exit 1
fi

if command -v magick >/dev/null 2>&1; then
  magick "$SVG_PATH" "$PNG_PATH"
elif command -v convert >/dev/null 2>&1; then
  convert "$SVG_PATH" "$PNG_PATH"
elif command -v rsvg-convert >/dev/null 2>&1; then
  rsvg-convert -o "$PNG_PATH" "$SVG_PATH"
else
  echo "No SVG converter found. Install ImageMagick or librsvg."
  echo "Examples:"
  echo "  brew install imagemagick"
  echo "  sudo apt-get install imagemagick"
  echo "  sudo apt-get install librsvg2-bin"
  exit 1
fi

echo "Created: $PNG_PATH"
