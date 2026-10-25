---
name: migrate-slice
description: Port one slice from legacy/ to src/ with identical behavior, then verify and review it. Use after the slice's characterization tests exist.
---

# Migrate Slice

Goal: new code in `src/` that passes the slice's characterization tests, with no change in behavior.

## Steps

1. Make sure you are on branch `migrate/<slice-id>` and the characterization tests exist.
2. Port the code. Keep the same logic, order of checks, error messages and output shapes. Map legacy patterns to the target stack's idioms only where behavior stays the same. Record any mapping you reuse in `decision-log.md`.
3. Run the build and the slice's tests. Fix any failures. **After 3 failed attempts on the same failure, stop** and write a blocker in `parking-lot.md`.
4. Run the `slice-verifier` subagent. Fix any gaps it reports.
5. Run the `slice-reviewer` subagent. Fix any findings, or explain in the commit why a finding doesn't apply.
6. Update the slice status in `plan.md` to `ready-for-merge`, and record the number of human interventions.
7. Commit on the branch, then stop. A human merges.
