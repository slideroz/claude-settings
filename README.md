# claude-settings

Global [Claude Code](https://github.com/anthropics/claude-code) configuration, backed up and version-controlled.

## What's in here

| File | Description |
|------|-------------|
| `settings.json` | Main Claude Code settings (default mode, status line config, etc.) |
| `settings.local.json` | Permission overrides (e.g. `Bash(ln:*)`) |
| `statusline.sh` | Status line script — shows model, directory, context %, cost, and duration |
| `install.sh` | Setup script for new machines |
| `check.sh` | Detects any new config in `~/.claude/` that isn't backed up yet |
| `add.sh` | Moves a new config file/dir into the repo and symlinks it |

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

## Staying up to date

As you use Claude Code, new config files may appear (`CLAUDE.md`, `commands/`, `agents/`, `keybindings.json`). To keep the backup complete:

**Check for un-backed-up config:**
```bash
./check.sh
```
Silent if everything is covered; prints a warning for any real file that isn't a symlink to this repo.

**Add a new config file to the repo:**
```bash
./add.sh CLAUDE.md        # or commands, agents, keybindings.json, etc.
```
This moves the file into the repo, creates the symlink, and tells you what to commit.

**Known locations to watch:**

| Path | Created when… |
|------|--------------|
| `~/.claude/CLAUDE.md` | You add global instructions for Claude |
| `~/.claude/commands/` | You create custom slash commands |
| `~/.claude/agents/` | You create custom sub-agents |
| `~/.claude/keybindings.json` | You customize key bindings |
