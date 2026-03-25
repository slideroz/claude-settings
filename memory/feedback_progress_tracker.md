---
name: progress tracker accuracy
description: Don't treat progress.md as ground truth — it can lag behind actual state
type: feedback
---

Never assume progress.md reflects current reality. The user keeps Etsy, Prodigi, and other systems updated independently of the tracker. When answering status questions, note that the tracker may be stale, or ask the user to confirm before acting on PENDING items.

**Why:** User corrected me for saying listing images were incomplete — they were actually live. The tracker still said PENDING.

**How to apply:** Before citing a PENDING item as a blocker or next action, ask the user to confirm it's actually incomplete. Update the tracker when the user clarifies.
