#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

if [ -z "$1" ]; then
  echo "Usage: ./add.sh <filename>  (e.g. ./add.sh CLAUDE.md)"
  exit 1
fi

f="$1"
src="$CLAUDE_DIR/$f"
dest="$REPO_DIR/$f"

if [ ! -e "$src" ]; then
  echo "Error: $src does not exist"; exit 1
fi
if [ -L "$src" ]; then
  echo "$f is already a symlink — nothing to do"; exit 0
fi

mv "$src" "$dest"
ln -s "$dest" "$src"
echo "✓ Moved $f into repo and created symlink."
echo "  Don't forget: cd ~/claude-settings && git add $f && git commit -m 'Add $f'"
