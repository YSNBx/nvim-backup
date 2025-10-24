#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# 0. Usage:
#    NVIM_ROOT=/path/to/nvim-config ./flatten.sh [out_file]
#    - If NVIM_ROOT not set, tries to locate init.lua from CWD; otherwise
#      falls back to the script's directory.
# ---------------------------------------------------------------------------

# Resolve root directory
if [[ -n "${NVIM_ROOT:-}" && -f "$NVIM_ROOT/init.lua" ]]; then
  ROOT_DIR="$(realpath "$NVIM_ROOT")"
elif [[ -f "init.lua" ]]; then
  ROOT_DIR="$(dirname "$(realpath "init.lua")")"
else
  # fall back to where this script lives
  ROOT_DIR="$(dirname "$(realpath "$0")")"
  [[ -f "$ROOT_DIR/init.lua" ]] || { echo "Error: init.lua not found. Set NVIM_ROOT or run from your nvim config root." >&2; exit 1; }
fi

SRC_DIR="$ROOT_DIR/lua"
[[ -d "$SRC_DIR" ]] || { echo "Error: $SRC_DIR not found." >&2; exit 1; }

# Name shown in headers (use the directory name as "package" label)
PKG_NAME="$(basename "$ROOT_DIR")"

# Output file (default: combined.lua in ROOT)
OUT="${1:-combined.lua}"
OUT_PATH="$ROOT_DIR/$OUT"

# fresh file
: >"$OUT_PATH"

# Header (Lua comments!)
{
  printf -- '-- ===== Flattened source for "%s" =====\n' "$PKG_NAME"
  printf -- '-- Generated: %s\n\n' "$(date -Iseconds)"
} >>"$OUT_PATH"

# Stitch every *.lua under ./lua (recursive, alphabetical)
# Use -print0 / sort -z for safety with spaces
mapfile -d '' FILES < <(find "$SRC_DIR" -type f -name '*.lua' -print0 | sort -z)

for FILE in "${FILES[@]}"; do
  REL="$(realpath --relative-to="$ROOT_DIR" "$FILE")"
  {
    printf -- '-- ===== %s :: %s =====\n\n' "$PKG_NAME" "$REL"
    cat "$FILE"
    printf '\n\n'
  } >>"$OUT_PATH"
done

echo "Wrote $OUT_PATH"

