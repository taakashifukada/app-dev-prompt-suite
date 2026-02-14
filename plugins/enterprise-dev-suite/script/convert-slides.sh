#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $(basename "$0") <input.md> <format> [output_path]"
  echo ""
  echo "Convert Marp markdown to presentation format."
  echo ""
  echo "Arguments:"
  echo "  input.md     Path to Marp markdown file"
  echo "  format       Output format: pptx, pdf, html"
  echo "  output_path  Optional output file path (default: same dir as input)"
  exit 1
}

if [[ $# -lt 2 ]]; then
  usage
fi

INPUT_FILE="$1"
FORMAT="$2"
OUTPUT_PATH="${3:-}"

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: Input file not found: $INPUT_FILE" >&2
  exit 1
fi

case "$FORMAT" in
  pptx|pdf|html) ;;
  *)
    echo "Error: Unsupported format '$FORMAT'. Use: pptx, pdf, html" >&2
    exit 1
    ;;
esac

if [[ -z "$OUTPUT_PATH" ]]; then
  INPUT_DIR="$(dirname "$INPUT_FILE")"
  INPUT_BASE="$(basename "$INPUT_FILE" .md)"
  OUTPUT_PATH="${INPUT_DIR}/${INPUT_BASE}.${FORMAT}"
fi

# Detect Marp CLI
MARP_CMD=""
if command -v marp &>/dev/null; then
  MARP_CMD="marp"
elif command -v npx &>/dev/null; then
  MARP_CMD="npx @marp-team/marp-cli"
else
  echo "Error: Marp CLI not found. Install via:" >&2
  echo "  npm install -g @marp-team/marp-cli" >&2
  echo "  # or use npx (requires npm)" >&2
  exit 1
fi

echo "Converting: $INPUT_FILE -> $OUTPUT_PATH (format: $FORMAT)"
echo "Using: $MARP_CMD"

$MARP_CMD "$INPUT_FILE" \
  --"$FORMAT" \
  --html \
  --allow-local-files \
  -o "$OUTPUT_PATH"

echo "Done: $OUTPUT_PATH"
