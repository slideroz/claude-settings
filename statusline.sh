#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

# Pick bar color based on context usage (using printf \033 codes directly)
if [ "$PCT" -ge 90 ]; then BAR_COLOR="\033[31m"
elif [ "$PCT" -ge 70 ]; then BAR_COLOR="\033[33m"
else BAR_COLOR="$GREEN"; fi

FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
BAR=$(printf "%${FILLED}s" | tr ' ' '█')$(printf "%${EMPTY}s" | tr ' ' '░')

MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))

BRANCH=""
git rev-parse --git-dir > /dev/null 2>&1 && BRANCH=" | 🌿 $(git branch --show-current 2>/dev/null)"

# OSC 8 hyperlink: use printf with \033 (not echo -e with \e) so ESC is real
# Format: ESC]8;;URI ESC\ visible text ESC]8;; ESC\
printf "\033[36m[%s]\033[0m 📁 \033]8;;file://%s\033\\%s\033]8;;\033\\%s\n" \
  "$MODEL" "$DIR" "${DIR##*/}" "$BRANCH"
# Sum all token types sent in the last request to get current context window usage
USED_TOKENS=$(echo "$input" | jq -r '
  (.context_window.current_usage.input_tokens // 0) +
  (.context_window.current_usage.cache_read_input_tokens // 0) +
  (.context_window.current_usage.cache_creation_input_tokens // 0)
')
TOTAL_TOKENS=$(echo "$input" | jq -r '.context_window.context_window_size // 0')

# Abbreviate to k (e.g. 22341 -> 22k)
USED_K=$(echo "$USED_TOKENS" | awk '{printf "%dk", $1/1000}')
TOTAL_K=$(echo "$TOTAL_TOKENS" | awk '{printf "%dk", $1/1000}')

COST_FMT=$(printf '$%.2f' "$COST")
printf "%s%s\033[0m %s%% | \033[36m%s/%s\033[0m | \033[33m%s\033[0m | ⏱️ %sm %ss\n" \
  "$BAR_COLOR" "$BAR" "$PCT" "$USED_K" "$TOTAL_K" "$COST_FMT" "$MINS" "$SECS"