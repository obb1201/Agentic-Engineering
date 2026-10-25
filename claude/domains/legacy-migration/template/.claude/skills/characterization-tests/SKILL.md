---
name: characterization-tests
description: Record the current behavior of one legacy slice as characterization (golden master) tests, before any new code is written. Use at the start of every slice.
---

# Characterization Tests

Goal: tests that capture what the legacy code **actually does**, not what it should do. The new code must later pass the same tests.

## Steps

1. Read the slice entry in `docs/migration/plan.md` and the legacy code it names.
2. Write the **edge-case list** for the slice in the plan, before writing any tests. Check at least:
   - Empty, null and missing input
   - Boundary values (zero, negative, maximum length, date limits)
   - Invalid input and every error path: status code, message text, exceptions
   - Each branch on status or type fields
   - Rounding, culture, time zone and text encoding
   - Behavior that looks like a bug (keep it, and add a note)
3. For each case, capture the legacy output by running the legacy code or its tests. Store the expected outputs as files or test data under `tests/characterization/<slice-id>/`.
4. Write the tests so they can run against the **new** code, for example as HTTP-level tests against the endpoint.
5. If a legacy output can't be captured, mark the case as `manual` in the plan and add a parking-lot entry. Don't invent an expected value.

## Done when

Every case on the edge-case list has a test or a parking-lot entry.
