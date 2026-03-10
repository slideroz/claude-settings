#!/bin/bash
input=$(cat)

GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')

BRANCH=""
git -C "$DIR" rev-parse --git-dir > /dev/null 2>&1 && BRANCH=" | $(git -C "$DIR" branch --show-current 2>/dev/null)"

# OSC 8 hyperlink: use printf with \033 (not echo -e with \e) so ESC is real
# Format: ESC]8;;URI ESC\ visible text ESC]8;; ESC\
printf "\033[36m[%s]\033[0m \033]8;;file://%s\033\\%s\033]8;;\033\\%s\n" \
  "$MODEL" "$DIR" "${DIR##*/}" "$BRANCH"

# --- Context window bar ---
# Use pre-calculated used_percentage if available (most accurate: reflects full context)
PCT_RAW=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
TOTAL_TOKENS=$(echo "$input" | jq -r '.context_window.context_window_size // 0')

if [ -n "$PCT_RAW" ]; then
  PCT=$(printf "%.0f" "$PCT_RAW")
  # Derive used tokens from percentage for display
  USED_TOKENS=$(echo "$input" | jq -r '
    (.context_window.current_usage.input_tokens // 0) +
    (.context_window.current_usage.cache_read_input_tokens // 0) +
    (.context_window.current_usage.cache_creation_input_tokens // 0)
  ')
else
  # Fallback: compute from current_usage if no pre-calculated field
  USED_TOKENS=$(echo "$input" | jq -r '
    (.context_window.current_usage.input_tokens // 0) +
    (.context_window.current_usage.cache_read_input_tokens // 0) +
    (.context_window.current_usage.cache_creation_input_tokens // 0)
  ')
  if [ "$TOTAL_TOKENS" -gt 0 ]; then
    PCT=$(( (USED_TOKENS * 100) / TOTAL_TOKENS ))
  else
    PCT=0
  fi
fi

# Pick bar color based on context usage
if [ "$PCT" -ge 90 ]; then BAR_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"; fi

FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
BAR=$(printf "%${FILLED}s" | tr ' ' '█')$(printf "%${EMPTY}s" | tr ' ' '░')

# Abbreviate to k rounded to nearest integer (e.g. 22341 -> 22k)
USED_K=$(echo "$USED_TOKENS" | awk '{printf "%dk", ($1+500)/1000}')
TOTAL_K=$(echo "$TOTAL_TOKENS" | awk '{printf "%dk", ($1+500)/1000}')

printf "%b%s%b %s%% context | %s/%s tokens" \
  "$BAR_COLOR" "$BAR" "$RESET" "$PCT" "$USED_K" "$TOTAL_K"

# --- Session cost estimate ---
# Pricing for claude-sonnet-4-6 (as of 2025-08):
#   Input:               $3.00 / 1M tokens
#   Output:             $15.00 / 1M tokens
#   Cache write:         $3.75 / 1M tokens  (25% surcharge on input price)
#   Cache read:          $0.30 / 1M tokens  (90% discount on input price)
# Uses cumulative session totals (total_input_tokens, total_output_tokens).
# current_usage cache breakdown is per-call; total_* are session-level aggregates.
COST=$(echo "$input" | jq -r '
  def r(p): . * p / 1000000;
  (.context_window.total_input_tokens // 0)  | r(3.00) as $in |
  (.context_window.total_output_tokens // 0) | r(15.00) as $out |
  ($in + $out)
' 2>/dev/null)

if [ -n "$COST" ] && [ "$COST" != "null" ]; then
  COST_FMT=$(echo "$COST" | awk '{
    if ($1 < 0.01) printf "$0.00"
    else if ($1 < 1.00) printf "$%.2f", $1
    else printf "$%.2f", $1
  }')
  printf " | ~%s session\n" "$COST_FMT"
else
  printf "\n"
fi

# --- Daily quota bar ---
DAILY_LIMIT=40

TRANSCRIPT=$(echo "$input" | jq -r '.transcript_path // empty')

if [ -n "$TRANSCRIPT" ]; then
  PROJECTS_ROOT=$(echo "$TRANSCRIPT" | sed 's|/projects/.*|/projects/|')
  TODAY_MIDNIGHT=$(date -v0H -v0M -v0S '+%Y-%m-%dT%H:%M:%S')
  SESSION_COUNT=$(find "$PROJECTS_ROOT" -maxdepth 2 -name "*.jsonl" -newermt "$TODAY_MIDNIGHT" 2>/dev/null | wc -l | tr -d ' ')

  QUOTA_PCT=$(( (SESSION_COUNT * 100) / DAILY_LIMIT ))
  [ "$QUOTA_PCT" -gt 100 ] && QUOTA_PCT=100

  if [ "$QUOTA_PCT" -ge 90 ]; then QUOTA_COLOR="$RED"
  elif [ "$QUOTA_PCT" -ge 70 ]; then QUOTA_COLOR="$YELLOW"
  else QUOTA_COLOR="$GREEN"; fi

  Q_FILLED=$((QUOTA_PCT / 10)); Q_EMPTY=$((10 - Q_FILLED))
  QUOTA_BAR=$(printf "%${Q_FILLED}s" | tr ' ' '█')$(printf "%${Q_EMPTY}s" | tr ' ' '░')

  printf "%b%s%b %s%% quota | %s/%s sessions today\n" \
    "$QUOTA_COLOR" "$QUOTA_BAR" "$RESET" "$QUOTA_PCT" "$SESSION_COUNT" "$DAILY_LIMIT"
fi