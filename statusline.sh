#!/bin/bash
input=$(cat)

GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

MODEL=$(echo "$input" | jq -r '.model.display_name // "unknown"')
DIR=$(echo "$input" | jq -r '.workspace.current_dir // ""')

PCT_RAW=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
TOTAL_TOKENS=$(echo "$input" | jq -r '.context_window.context_window_size // 0')

USED_TOKENS=$(echo "$input" | jq -r '
  (.context_window.current_usage.input_tokens // 0) +
  (.context_window.current_usage.cache_read_input_tokens // 0) +
  (.context_window.current_usage.cache_creation_input_tokens // 0)
')

if [ -n "$PCT_RAW" ]; then
  PCT=$(printf "%.0f" "$PCT_RAW")
else
  if [ "$TOTAL_TOKENS" -gt 0 ]; then
    PCT=$(( (USED_TOKENS * 100) / TOTAL_TOKENS ))
  else
    PCT=0
  fi
fi

USED_K=$(echo "$USED_TOKENS" | awk '{printf "%dk", ($1+500)/1000}')

if [ "$USED_TOKENS" -ge 90000 ]; then LINE_COLOR="$RED"
elif [ "$USED_TOKENS" -ge 80000 ]; then LINE_COLOR="$YELLOW"
else LINE_COLOR="$GREEN"; fi

printf "\033[36m[%s]\033[0m \033]8;;file://%s\033\\%s\033]8;;\033\\ | %b%s tokens | %s%%%b\n" \
  "$MODEL" "$DIR" "${DIR##*/}" "$LINE_COLOR" "$USED_K" "$PCT" "$RESET"
