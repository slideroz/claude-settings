# User Preferences

## Output Style
- No emojis
- Concise, direct output — tables preferred over prose
- Sessions always end with "log and close session"

## Workflow Conventions
- Skills invoked via slash command from project directory
- All session decisions logged before closing
- Output files follow `type_YYYY-MM-DD[_descriptor].md` naming

## Session End Protocol
- Trigger: "log and close session" or "update repo"
- Run `git status` first to identify changes
- Stage only files touched this session — NO `git add -A`
- Commit message format: `<project>: <short description>` or `session: <brief summary>` for multi-project
- Push to origin/main, then report files committed and commit message
