#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

mkdir -p "$CLAUDE_DIR"

files=(settings.json settings.local.json statusline.sh skills commands templates hooks)

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

# Memory — path encodes the OZ project directory location
MEMORY_PARENT="$HOME/.claude/projects/-Users-$(whoami)-OZ"
mkdir -p "$MEMORY_PARENT"
if [ -e "$MEMORY_PARENT/memory" ] && [ ! -L "$MEMORY_PARENT/memory" ]; then
  echo "Backing up existing memory → $MEMORY_PARENT/memory.bak"
  mv "$MEMORY_PARENT/memory" "$MEMORY_PARENT/memory.bak"
fi
ln -sf "$REPO_DIR/memory" "$MEMORY_PARENT/memory"
echo "Linked memory"

echo ""
echo "Done. Claude settings installed."
echo "Tip: run ./check.sh to see if any new config needs to be backed up."
