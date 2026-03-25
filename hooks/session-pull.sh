#!/bin/bash
# Pulls latest from origin/main once per Claude session on first user prompt.
# Triggered by UserPromptSubmit hook — fires before Claude processes any message.

# Skip web environment (Claude Code web mounts at /home/user/)
if [[ "$PWD" == /home/user/* ]]; then
    exit 0
fi

# Skip if not a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    exit 0
fi

# Read session_id from hook JSON input on stdin
INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('session_id',''))" 2>/dev/null)

# Pull once per session using session_id as marker key
if [ -n "$SESSION_ID" ]; then
    MARKER="/tmp/claude-pulled-${SESSION_ID}"
    if [ ! -f "$MARKER" ]; then
        git pull origin main --quiet 2>/dev/null || true
        touch "$MARKER"
    fi
else
    # No session_id available — pull every time as fallback
    git pull origin main --quiet 2>/dev/null || true
fi

exit 0
