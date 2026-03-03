# claude-settings

Global [Claude Code](https://github.com/anthropics/claude-code) configuration, backed up and version-controlled.

## What's in here

| File | Description |
|------|-------------|
| `settings.json` | Main Claude Code settings (default mode, status line config, etc.) |
| `statusline.sh` | Status line script — shows model, directory, context %, cost, and duration |
| `install.sh` | Setup script for new machines |

The files in `~/.claude/` are symlinks pointing here, so any edits are immediately tracked by git.

## Install on a new machine

```bash
git clone git@github.com:slideroz/claude-settings.git ~/claude-settings
cd ~/claude-settings
chmod +x install.sh
./install.sh
```

The script will:
1. Create `~/.claude/` if it doesn't exist
2. Back up any existing files (as `*.bak`) before replacing them
3. Create symlinks from `~/.claude/` → this repo

## Making changes

Edit any file directly in `~/claude-settings/`, then commit and push:

```bash
cd ~/claude-settings
git add -p
git commit -m "describe your change"
git push
```

Changes take effect immediately (the symlinks mean Claude reads straight from this directory).
# claude-settings
