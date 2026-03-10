# Global Claude Instructions

Applies to every project and session. Project-level CLAUDE.md overrides these where they conflict.

---

## Context Management

### Decision rules (match the status line)

| Context bar | Action |
|-------------|--------|
| < 50% | Continue freely |
| 50–70% | Finish current task, then consider `/compact` |
| 70–89% | Run `/compact [topic]` before starting the next task |
| ≥ 90% | Stop. Compact or start a new session — do not proceed |

### When to use each option

**`/compact [focus]`** — keep the session, summarize history, preserve file state.
Use when: mid-task, switching sub-topics, context is 70%+ but work is ongoing.
Example: `/compact focus on pricing tool changes and listing file updates`

**New session (`/clear` or `claude`)** — full reset, cheapest start.
Use when: task is complete, switching to a different project, or context ≥ 90% with no active work to preserve.

**`/resume`** — continue a named session after a reset.
Use when: you cleared but need to pick up exactly where you left off.

---

## File Hygiene

Before reading any file, ask: **is this file relevant to the current task?**
- Do not read files speculatively. Read only what the task requires.
- Prefer `Grep` over `Read` when searching for a specific value, pattern, or function — it returns only matching lines, not the full file.
- Prefer `Glob` over broad directory reads when locating files by name pattern.
- When a task is complete, do not re-read files already loaded unless the content may have changed.

---

## Outdated or Irrelevant Files

If a file referenced in CLAUDE.md, memory, or a task appears outdated or no longer relevant, **ask before loading it**:
> "This file (`X`) was last relevant in [context]. Is it still needed for this task?"

Do not silently skip it — flag it so the user can decide to update, archive, or remove the reference.

---

## Session Start

At the start of each session:
1. Read `MEMORY.md` and the active project's `CLAUDE.md` — nothing else until the task is clear.
2. Do not pre-load catalogs, listings, reports, or tool files unless the task requires them.
3. If the user's first message is ambiguous, ask one clarifying question before reading any files.

---

## Session End

Follow the `## Session End Protocol` in the active project's CLAUDE.md.
If no project protocol exists: stage only files touched this session, commit with a descriptive message, push.

---

## Output Style

- No emojis unless explicitly requested.
- Tables over prose for structured data.
- Short, direct sentences. Lead with the answer.
- No preamble, no restating the question.
