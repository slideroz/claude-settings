#!/usr/bin/env bash
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

# All known config locations to watch
watch=(
  settings.json
  settings.local.json
  CLAUDE.md
  keybindings.json
  commands
  agents
)

found=0
for f in "${watch[@]}"; do
  target="$CLAUDE_DIR/$f"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "⚠️  Not backed up: $target"
    echo "   Run: ./add.sh $f"
    found=1
  fi
done

[ "$found" -eq 0 ] && echo "✓ All known config is backed up."
