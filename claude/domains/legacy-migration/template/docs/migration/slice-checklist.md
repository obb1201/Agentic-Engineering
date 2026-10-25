# Slice Checklist

A slice is done only when every item is checked. The `slice-reviewer` subagent works through this list.

## Behavior

- [ ] Every characterization test for the slice passes.
- [ ] Every case on the slice's edge-case list has a test or a parking-lot entry.
- [ ] Error paths match the legacy code: status codes, message text, exception types.
- [ ] Side effects match the legacy code: database writes, files, emails, logs, calls to other services.
- [ ] No "improvements". Odd legacy behavior is kept and noted.

## Business rules

- [ ] Every rule used comes from `business-rules.md` or the legacy code. Nothing is guessed.
- [ ] Unclear rules are in the parking lot, not decided in code.

## Scope

- [ ] Only files for this slice were changed, or each shared change is explained in the commit.
- [ ] Nothing in `legacy/` was changed.
- [ ] Work is on branch `migrate/<slice-id>`.

## Records

- [ ] Slice status and human-intervention count are updated in `plan.md`.
- [ ] New decisions are in `decision-log.md`.
