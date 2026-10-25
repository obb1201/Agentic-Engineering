# CLAUDE.md: Legacy Migration

This project ports **<SOURCE_STACK>** (in `legacy/`) to **<TARGET_STACK, e.g. .NET 10 / ASP.NET Core>** (in `src/`).

## The one rule

**Keep behavior identical.** The new code must do exactly what the legacy code does, including bugs, odd rounding, error messages and edge cases. Don't fix, improve, rename or redesign anything during the port. If you think something should change, write it in `docs/migration/parking-lot.md` and keep the old behavior.

## Layout

- `legacy/`: the old application. **Read only.** Never edit it, not even with shell commands.
- `src/`: the new application.
- `tests/characterization/`: tests that record legacy behavior. The new code must pass them.
- `docs/migration/`: everything we know about the migration. Read the file you need before starting a task:
  - `inventory.md`: modules, entry points, dependencies
  - `domain-glossary.md`: business terms and what they mean in the code
  - `business-rules.md`: rules found in the code, with source location and confidence
  - `decision-log.md`: decisions already made. Don't reopen them.
  - `plan.md`: the ordered list of slices and their status
  - `parking-lot.md`: open questions waiting for a human
  - `slice-checklist.md`: what "done" means for a slice
  - `schema/`: the database schema as read-only SQL files

## Process

Follow the skill for each phase:

1. Inventory: `migration-inventory` skill
2. Plan: `migration-plan` skill. **Stop and wait for human approval of the plan.**
3. For each slice (one API endpoint or use case):
   1. `git switch -c migrate/<slice-id>`
   2. Write characterization tests: `characterization-tests` skill
   3. Port the code: `migrate-slice` skill
   4. Run the `slice-verifier` subagent, then the `slice-reviewer` subagent
   5. Commit on the branch. **Stop. A human merges.**

## Limits

- **One slice per session.** When a slice is finished or blocked, stop.
- Only touch files that belong to the current slice. If a shared file must change, explain why in the commit message.
- Never push, deploy, or connect to a production system or production data.

## When you are unsure or stuck

- **Unclear business rule:** don't guess. Add it to `parking-lot.md` with the source location, what you think it means, and the options. Then continue with other work or stop.
- **Tests keep failing:** after **3** failed attempts to fix the same failure, stop. Write a blocker entry in `parking-lot.md` covering what fails, what you tried, and your best guess at the cause.
- **Before you say a slice is done**, run the build and tests yourself and report the real result. A hook also runs them when you finish.

## Commands

- Build: `<BUILD_COMMAND, e.g. dotnet build>`
- Test: `<TEST_COMMAND, e.g. dotnet test>`
- Run legacy app or its tests: `<LEGACY_RUN_COMMAND>`
