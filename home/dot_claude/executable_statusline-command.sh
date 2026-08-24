#!/usr/bin/env bash
# Claude Code status line: 🌿 branch | 🤖 model | 💸 month-to-date spend
#
# MTD comes from `ccusage` (github.com/ryoppippi/ccusage), a maintained tool
# that reads the same local transcripts Claude Code already writes to
# ~/.claude/projects. Falls back to `npx ccusage@latest` if it isn't installed
# globally (`npm install -g ccusage`), which works but is slower on an empty
# npx cache.
set -uo pipefail

CACHE="$HOME/.claude/cache/mtd-spend.txt"
LOCK="$CACHE.lock"
TTL=300        # seconds a cached MTD figure stays fresh
LOCK_STALE=120 # reclaim a lock left behind by a killed refresh

input=$(cat)

IFS=$'\t' read -r cwd model <<<"$(
  printf '%s' "$input" |
    jq -r '[
      (.workspace.current_dir // .cwd // "."),
      (.model.display_name // .model.id // "unknown")
    ] | @tsv'
)"

# --- branch ---------------------------------------------------------------
branch=$(git -C "$cwd" symbolic-ref --quiet --short HEAD 2>/dev/null) ||
  branch=$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null) ||
  branch=""

# --- month-to-date ----------------------------------------------------------
# A `ccusage` invocation costs ~0.4-0.6s (Node startup), too slow for a status
# line that re-renders constantly. Serve the cached figure immediately and
# refresh it in the background once it goes stale.
age_of() { # seconds since mtime, or a large number if absent
  [[ -e $1 ]] && echo $(($(date +%s) - $(stat -f %m "$1"))) || echo 999999
}

ccusage_bin=(ccusage)
command -v ccusage >/dev/null 2>&1 || ccusage_bin=(npx --yes ccusage@latest)

mkdir -p "${CACHE%/*}"
if (($(age_of "$CACHE") > TTL)); then
  (($(age_of "$LOCK") > LOCK_STALE)) && rmdir "$LOCK" 2>/dev/null
  if mkdir "$LOCK" 2>/dev/null; then
    (
      trap 'rmdir "$LOCK" 2>/dev/null' EXIT
      month_start=$(date -u +%Y-%m)-01
      if out=$("${ccusage_bin[@]}" monthly --json --since "$month_start" 2>/dev/null |
               jq -r '.monthly[-1].totalCost // 0'); then
        printf '%s' "$out" >"$CACHE.tmp" && mv "$CACHE.tmp" "$CACHE"
      fi
    ) >/dev/null 2>&1 &
    disown 2>/dev/null
  fi
fi
mtd_cost=""
[[ -f $CACHE ]] && mtd_cost=$(awk -v c="$(<"$CACHE")" 'BEGIN { printf "%.2f", c }')

# --- render ---------------------------------------------------------------
# The status bar has limited width and Claude Code truncates output that
# doesn't fit rather than wrapping it — so build the line thinnest-first and
# drop whole segments (least important last) instead of letting a segment get
# cut off mid-string. COLUMNS is set to the terminal width by Claude Code
# (v2.1.153+); treat anything else (unset, 0, non-numeric) as "unknown" and
# render the full line, since that's the pre-2.1.153 behavior this replaces.
dim=$'\033[2m'
reset=$'\033[0m'
sep="${dim} | ${reset}"
cols=${COLUMNS:-0}
[[ $cols =~ ^[0-9]+$ ]] || cols=0

# Emoji + separators render wider than their byte/char count, so this undercounts
# a bit — deliberately, since undercounting only risks a segment we could have
# kept, while overcounting risks the mid-string truncation this exists to avoid.
visible_len() { local s=${1//$dim/}; s=${s//$reset/}; echo "${#s}"; }

render() {
  local out=""
  for segment in "$@"; do
    [[ -n $out ]] && out+="$sep"
    out+="$segment"
  done
  printf '%s' "$out"
}

branch_seg=""
[[ -n $branch ]] && branch_seg="🌿 ${branch}"
model_seg="🤖 ${model}"
cost_seg=""
[[ -n $mtd_cost ]] && cost_seg="💸 \$${mtd_cost} MTD"

for candidate in \
  "$branch_seg|$model_seg|$cost_seg" \
  "$model_seg|$cost_seg" \
  "$branch_seg|$model_seg" \
  "$model_seg"
do
  IFS='|' read -r -a parts <<<"$candidate"
  segments=()
  for p in "${parts[@]}"; do [[ -n $p ]] && segments+=("$p"); done
  line=$(render "${segments[@]}")
  if ((cols == 0)) || (($(visible_len "$line") <= cols)); then
    printf '%s' "$line"
    exit 0
  fi
done
printf '%s' "$line"
