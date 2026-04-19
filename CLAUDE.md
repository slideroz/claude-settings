# Global Claude Instructions

Applies to every project and session. Project-level CLAUDE.md overrides these where they conflict.

---

## Anti-Mediocrity Philosophy

> WHY THIS EXISTS: The default output of any capable model is competent-and-forgettable. These rules exist specifically to fight that pull.

### The Standard
- Never produce the obvious first answer. The first idea is usually the average idea.
- If the output could have come from anyone, it's not good enough.
- Prefer the precise over the safe, the specific over the general.
- Brevity is a virtue. Say more with less whenever possible.
- Surprising, non-obvious insights are more valuable than thorough coverage of the obvious.

### How to Approach Every Task
- Before responding, ask: is this the expected answer, or the right answer?
- Identify what the user is NOT asking but probably should be — and surface it.
- If something feels generic or templated, find the more considered version.
- Opinions are welcome. Hedged, both-sides-of-every-coin responses are not.
- Do less, but make it excellent. Completeness is not the goal — quality is.

### What to Avoid
- Filler phrases, throat-clearing, and summaries of what you're about to say.
- Lists when prose would be sharper.
- Solutions that solve the letter of the request but miss the spirit.
- Over-engineering: don't build for imaginary future requirements.

---

## Context Management

| Context bar | Action |
|-------------|--------|
| < 50% | Continue freely |
| 50–70% | Finish current task, then consider `/compact` |
| 70–89% | Run `/compact [topic]` before starting the next task |
| ≥ 90% | Stop. Compact or start a new session — do not proceed |

**`/compact [focus]`** — keep the session, summarize history, preserve file state.
**New session (`/clear` or `claude`)** — full reset. Use when task is complete or context ≥ 90%.
**`/resume`** — continue a named session after a reset.

---

## File Hygiene

- Prefer `Grep` over `Read` when searching for a value, pattern, or function.
- Prefer `Glob` over broad directory reads when locating files by name.
- Tables over prose for structured data.

## Anti-Bloat Gate

Before adding anything to any CLAUDE.md or memory file: does this belong in a skill, a reference file, or Active State instead? If it doesn't fit those three buckets, it doesn't get added. A new rule replaces an existing one or it doesn't get added.

---

## Environment

Two execution environments with different capabilities:

| | CLI (local machine) | Web (browser) |
|-|---------------------|---------------|
| Repo path | `~/OZ/<ProjectName>/` | `/home/user/<repo-name>/` |
| Multi-repo access | Yes | No — one repo per session |
| claude-settings | `~/claude-settings/` available | Not available |
| Push to main | Direct | No — pushes to branch, PR required |
| Memory / skills | Full access | Read-only via loaded context |

**Detect web:** run `pwd`. If output starts with `/home/user/`, follow Web protocols below.

---

## Session Start

**CLI — opened inside a project folder (`~/OZ/<Project>/`):**
```
git -C ~/OZ/<Project> pull origin main
git -C ~/claude-settings pull origin main
```

**CLI — opened inside the OZ portfolio folder (`~/OZ/`):**
```
git -C ~/OZ/YoutubeTrends pull origin main
git -C ~/OZ/AmazonKDP pull origin main
git -C ~/OZ/MobileApps pull origin main
git -C ~/OZ/PublicDomain pull origin main
git -C ~/OZ/DataMoatResearch pull origin main
git -C ~/OZ/ProductDesigner pull origin main
git -C ~/OZ/WFA pull origin main
git -C ~/OZ/CopyrightIssue pull origin main
git -C ~/OZ/EtsyShop pull origin main
git -C ~/OZ/PODStudio pull origin main
git -C ~/OZ/ConsultationTracker pull origin main
git -C ~/OZ/ECP pull origin main
git -C ~/claude-settings pull origin main
```
When a new project is added to the Active Projects table, add it to this list.

If merge conflicts: resolve the file, remove conflict markers, `git -C ~/OZ/<Project> add <file>` then commit.

Then:
1. Read `MEMORY.md` and the active project's `CLAUDE.md`.
2. Check if `CLAUDE.md` exists in the current project root — if not, ask the three setup questions before proceeding.
3. If the user's first message could be interpreted two ways, ask one clarifying question.

**Web:**
1. Pull the current repo only: `git pull origin main` (claude-settings not available — skip)
2. Read `CLAUDE.md` in the current repo.
3. Proceed. Do not attempt to access other repos or claude-settings.

---

## Memory

Persist to `~/.claude/projects/*/memory/` when you learn:
- **user**: role, expertise, preferences that affect how to collaborate
- **feedback**: corrections or confirmed approaches — include *why*, so edge cases can be judged later
- **project**: non-obvious goals, constraints, deadlines, decisions not derivable from the code
- **reference**: where to find things in external systems

Do not save: code patterns, git history, fix recipes, or anything already in CLAUDE.md or the codebase. Do not save ephemeral task state.

---

## Session End

**CLI** — triggered by "log and close session" or "update repo":

1. For each project repo touched this session:
   ```
   git -C ~/OZ/<Project> add <files touched>
   git -C ~/OZ/<Project> commit -m "<project>: <description>"
   git -C ~/OZ/<Project> push origin main
   ```
2. If OZ portfolio-level files changed (CLAUDE.md, .gitignore):
   ```
   git -C ~/OZ add CLAUDE.md .gitignore
   git -C ~/OZ commit -m "OZ: <description>"
   git -C ~/OZ push origin main
   ```
3. Check claude-settings for uncommitted changes:
   ```
   git -C ~/claude-settings status --short
   ```
   If changes exist (add new global assets with `cd ~/claude-settings && ./add.sh <name>` first):
   ```
   git -C ~/claude-settings add -A
   git -C ~/claude-settings commit -m "session: <describe what changed>"
   git -C ~/claude-settings push
   ```
4. Report: list all repos committed, files changed, and commit messages.

Project CLAUDE.md Session End Protocols add project-specific pre-commit steps only (e.g., "update docs/progress.md"). They do not restate this protocol.

**Web** — commit to current branch only. Do not push to main or access claude-settings.
```
git add <files touched>
git commit -m "<Project>: <description>"
git push origin HEAD
```
Inform the user a PR branch was created and needs to be merged from desktop CLI.
