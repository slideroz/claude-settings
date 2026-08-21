#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

mkdir -p "$CLAUDE_DIR"

files=(CLAUDE.md settings.json settings.local.json statusline.sh skills commands templates hooks)

for f in "${files[@]}"; do
  target="$CLAUDE_DIR/$f"
  source="$REPO_DIR/$f"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Backing up existing $f → $target.bak"
    mv "$target" "$target.bak"
  fi

  ln -sfn "$source" "$target"
  echo "Linked $f"
done

link_memory() {
  local dir="$1"
  [ -d "$dir" ] || return 0
  local slug parent
  slug="$(printf '%s' "$dir" | tr './' '--')"
  parent="$HOME/.claude/projects/$slug"
  mkdir -p "$parent"
  if [ -e "$parent/memory" ] && [ ! -L "$parent/memory" ]; then
    echo "Backing up existing memory → $parent/memory.bak"
    mv "$parent/memory" "$parent/memory.bak"
  fi
  ln -sfn "$REPO_DIR/memory" "$parent/memory"
  echo "Linked memory for $dir"
}

link_memory "$HOME/OZ"
[ -n "$CODESPACE_VSCODE_FOLDER" ] && link_memory "$CODESPACE_VSCODE_FOLDER"

echo ""
echo "Done. Claude settings installed."
echo "Tip: run ./check.sh to see if any new config needs to be backed up."
