#!/bin/bash
# Pulls latest from origin/main before every CLI session's first tool call.
# Fast no-op if already up to date.

# Skip web environment (Claude Code web mounts at /home/user/)
if [[ "$PWD" == /home/user/* ]]; then
    exit 0
fi

# Skip if not a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    exit 0
fi

git pull origin main --quiet 2>/dev/null || true

exit 0
