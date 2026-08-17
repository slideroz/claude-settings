---
name: project-ye-ops-product
description: "YE stopped being franchise cost-tracking and became an activity-agnostic operations product; YE is instance #1, not the customer"
metadata: 
  node_type: memory
  type: project
  originSessionId: 1aa36a8d-f9a1-4b7d-9b6b-985ca52f460d
  modified: 2026-08-17T16:20:05.403Z
---

On 2026-08-17 YE's scope changed deliberately. It began as cost capture for one Young Engineers franchise. Reading `Scénarios.xlsx` showed every money line in it reduces to one object — `kind × amount × basis → scope`, with floor, cap and tax treatment — which makes the model portable across any business built on {program, instructor, facility, cohort}.

It is now a product: operations software covering the Plan, Deliver and Close phases of a term. It runs **alongside** Bookwhen and Stripe and deliberately does not compete for registration or payments. Two roles: operator and instructor. Eventually sellable — the franchisor, not individual studio owners, is the buyer hypothesis worth testing.

**Why this matters:** the earlier YE rules said "a spreadsheet is the correct implementation until December 2026" and forbade a config engine. Oussama overrode the first after I flagged the conflict; the second still holds, and `YE/CLAUDE.md` was rewritten to match. Do not re-raise the spreadsheet rule.

**How to apply:** YE-specific numbers belong only in `docs/ye-instance.md` and `packages/ledger/instance/`. The domain model, the engine and the product spec must stay domain-neutral — checked by grep, no industry or jurisdiction word in any field name, enum or formula. If a new requirement can't be expressed as a row in the line table, that's a finding about the primitive, not a reason to add a settings layer.

Related: [[feedback-build-dont-analyze]] · [[feedback-project-isolation]]
