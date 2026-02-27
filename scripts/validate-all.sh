#!/usr/bin/env bash
# validate-all.sh — verify every exercise's reference solution passes all tests
#
# Usage:
#   ./scripts/validate-all.sh              # validate all exercises
#   ./scripts/validate-all.sh 01 05 11     # validate specific exercises by number
#
# For each exercise, the script temporarily swaps solution.ml in for exercise.ml,
# runs `dune test`, then restores the original skeleton.

set -euo pipefail

BASE="$(cd "$(dirname "$0")/.." && pwd)/exercises"
PASS=0
FAIL=0
ERRORS=()

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

run_exercise() {
  local dir="$1"
  local name
  name="$(basename "$dir")"
  local skeleton="$dir/lib/exercise.ml"
  local solution="$dir/lib/solution.ml"
  local backup="$dir/lib/exercise.ml.bak"

  if [ ! -f "$solution" ]; then
    echo -e "  ${YELLOW}SKIP${NC}  $name  (no solution.ml)"
    return
  fi

  # Swap in the solution
  cp "$skeleton" "$backup"
  cp "$solution" "$skeleton"

  # Run tests
  local output
  local exit_code=0
  output=$(cd "$dir" && dune test --no-buffer 2>&1) || exit_code=$?

  # Restore skeleton
  cp "$backup" "$skeleton"
  rm "$backup"

  if [ $exit_code -eq 0 ]; then
    echo -e "  ${GREEN}PASS${NC}  $name"
    PASS=$((PASS + 1))
  else
    echo -e "  ${RED}FAIL${NC}  $name"
    FAIL=$((FAIL + 1))
    ERRORS+=("$name")
    echo "$output" | grep -E "Error|FAIL|assert" | head -5 | sed 's/^/          /'
  fi
}

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " OCaml Curriculum — Solution Validator"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $# -gt 0 ]; then
  for num in "$@"; do
    for dir in "$BASE"/${num}-*/; do
      [ -d "$dir" ] && run_exercise "$dir"
    done
  done
else
  for dir in "$BASE"/*/; do
    [ -d "$dir" ] && run_exercise "$dir"
  done
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Results: ${PASS} passed, ${FAIL} failed"
if [ ${#ERRORS[@]} -gt 0 ]; then
  echo " Failed:  ${ERRORS[*]}"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

[ $FAIL -eq 0 ]
