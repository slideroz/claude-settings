#!/bin/bash
# Pulls latest from origin/main once per Claude session (identified by parent PID).
# Fast no-op if already up to date. Skips web environment and non-git directories.

# Skip web environment (Claude Code web mounts at /home/user/)
if [[ "$PWD" == /home/user/* ]]; then
    exit 0
fi

# Skip if not a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    exit 0
fi

# Use parent PID as session identifier — same for all tool calls in one session
MARKER="/tmp/claude-pulled-${PPID}"

if [ ! -f "$MARKER" ]; then
    git pull origin main --quiet 2>/dev/null || true
    touch "$MARKER"
fi

exit 0
