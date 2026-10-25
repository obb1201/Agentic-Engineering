---
name: migration-plan
description: Turn the migration inventory into an ordered list of slices (one API endpoint or use case each) in docs/migration/plan.md. Use after the inventory is complete and before migrating any slice.
---

# Migration Plan

Goal: an ordered list of small slices that a human can approve.

## Steps

1. Read `docs/migration/inventory.md`, `business-rules.md` and `decision-log.md`.
2. Make one slice for each API endpoint or use case. Give each one an id such as `S01-get-customer`.
3. Order the slices:
   - Shared foundations first: data access, models, configuration. Record these as decisions in `decision-log.md`.
   - Then read-only slices before slices that write data.
   - Then simple before complex. Slices with Low confidence business rules go last.
4. For each slice, write in `plan.md`: the id, the entry point, the legacy files involved, the business rules involved, known edge cases, and the status (`todo`).
5. List anything that blocks planning in `parking-lot.md`.

## Then stop

Tell the human the plan is ready for review. **Don't start any slice until the plan is approved.** Approval is recorded in `decision-log.md`.
