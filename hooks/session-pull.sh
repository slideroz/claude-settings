#!/bin/bash
# Runs once per working directory per day before the first tool call.
# Pulls latest from origin/main so every CLI session starts on current state.

# Skip web environment (Claude Code web mounts at /home/user/)
if [[ "$PWD" == /home/user/* ]]; then
    exit 0
fi

# Skip if not a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    exit 0
fi

# Pull once per directory per day using a marker file
DIR_SLUG=$(echo "$PWD" | tr '/' '-' | tr ' ' '_')
MARKER="/tmp/claude-pulled${DIR_SLUG}-$(date +%Y%m%d)"

if [ ! -f "$MARKER" ]; then
    git pull origin main --quiet 2>/dev/null || true
    touch "$MARKER"
fi

exit 0
