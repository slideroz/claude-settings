#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

mkdir -p "$CLAUDE_DIR"

files=(settings.json statusline-command.sh statusline.sh)

for f in "${files[@]}"; do
  target="$CLAUDE_DIR/$f"
  source="$REPO_DIR/$f"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Backing up existing $f → $target.bak"
    mv "$target" "$target.bak"
  fi

  ln -sf "$source" "$target"
  echo "Linked $f"
done

echo "Done. Claude settings installed."
