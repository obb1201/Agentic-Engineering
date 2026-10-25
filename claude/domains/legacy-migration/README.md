# Legacy Migration Harness for Claude Code

A reusable Claude Code harness for **porting a legacy application to a new stack without changing its behavior**. Copy the [template/](template/) folder into a migration project, fill in the placeholders, and Claude Code follows a fixed, checked process to do the work one slice at a time.

The template doesn't depend on any one stack. The worked example and the default check commands target **.NET 10 / ASP.NET Core**.

> Status: version 1, structure and docs only. Nothing has been tested yet against a real migration. See [experiments/log.md](experiments/log.md).

## The approach in one paragraph

The migration is a **like-for-like port**: the new code must do exactly what the old code did, including its odd behavior. The work is split into **slices**, and each slice is one API endpoint or use case. Before a slice is migrated, the agent records the legacy system's behavior as **characterization tests** (also called golden master tests). The slice is done only when the new code passes those same tests. A human approves the plan, decides any unclear business rules, and merges each slice.

## How the work flows

```
 1. Inventory      ──►  2. Plan          ──►  [Human approves plan]
    (skill: migration-inventory)    (skill: migration-plan)

 For each slice, on its own git branch:
 3. Characterize   ──►  4. Port          ──►  5. Verify       ──►  6. Review     ──►  [Human merges]
    (skill: characterization-tests) (skill: migrate-slice) (agent: slice-verifier) (agent: slice-reviewer)

 At any step: unclear business rule ──► parking lot ──► [Human decides]
```

| Step | Who does it | Output |
|---|---|---|
| 1. Inventory | `legacy-analyst` subagent, guided by the `migration-inventory` skill | `docs/migration/inventory.md`, `domain-glossary.md`, `business-rules.md` |
| 2. Plan | Main agent, `migration-plan` skill | `docs/migration/plan.md`: the ordered list of slices |
| Gate | **Human** | Plan approved |
| 3. Characterize | Main agent, `characterization-tests` skill | Tests that record the legacy behavior of the slice |
| 4. Port | Main agent, `migrate-slice` skill | New code on branch `migrate/<slice-id>` |
| 5. Verify | `slice-verifier` subagent | Pass or fail report against the characterization tests |
| 6. Review | `slice-reviewer` subagent | Review against `slice-checklist.md` |
| Gate | **Human** | Slice merged |

## The seven harness pieces

This harness is organized around the seven pieces in the repo [README](../../../README.md).

| Piece | How this harness handles it | Where |
|---|---|---|
| 1. Tools | File read and search for analysis. Build and test commands for both stacks. The database schema as read-only SQL files, so no live database connection is needed. | `settings.json` allow list, `docs/migration/schema/` |
| 2. Information | A short `CLAUDE.md` with links to the inventory, domain glossary, business rules, decision log and plan. | `template/CLAUDE.md`, `template/docs/migration/` |
| 3. Permissions | Legacy source is read-only. No production data or config. No `git push`, deploys, or destructive commands. | `template/.claude/settings.json` |
| 4. Instructions | A short `CLAUDE.md` holds the rules. One skill per phase holds the step-by-step procedure. | `template/CLAUDE.md`, `template/.claude/skills/` |
| 5. Checking work | A Stop hook runs the build and tests automatically before the agent can finish. Verifier and reviewer subagents check each slice. | `template/.claude/hooks/run-checks.ps1`, `template/.claude/agents/` |
| 6. Limits | One slice per session. Human gates at the plan and at every merge. | `template/CLAUDE.md` |
| 7. Failure handling | One git branch per slice, so a slice can be thrown away. After 3 failed fix attempts, the agent stops and writes up the blocker. | `template/CLAUDE.md`, `template/docs/migration/parking-lot.md` |

## What the harness defends against

These are the failure modes the harness is designed around, and the parts that guard against each one.

| Expected agent mistake | Guard |
|---|---|
| Guessing at a business rule instead of asking | Rule in `CLAUDE.md`: never guess, write it in the parking lot. The `business-rules.md` file lists each rule with its source location and a confidence level. |
| "Improving" the code and changing its behavior | Characterization tests written *before* porting. The like-for-like rule. The reviewer checks the diff for behavior changes. |
| Skipping edge cases (the area where we trust the agent least) | The characterization skill needs an edge-case list for each slice. The reviewer checks it. |
| Claiming success without running the tests | The Stop hook runs the build and tests automatically. |
| Editing the legacy code | A `deny` rule on `legacy/**`. |

## How to use it

1. Set up the migration project like this:
   ```
   my-migration/
     legacy/        # the old application (read-only reference)
     src/           # the new application
     tests/         # characterization and unit tests
   ```
2. Copy everything inside [template/](template/) into the project root.
3. Fill in the `<PLACEHOLDERS>` in `CLAUDE.md`.
4. Edit the `$Checks` list in `.claude/hooks/run-checks.ps1` to match your build and test commands. It runs with PowerShell 7 (`pwsh`), which works on Windows, macOS and Linux.
5. If the legacy app uses a database, export the schema as `.sql` files into `docs/migration/schema/`.
6. Start Claude Code in the project and ask: *"Run the migration inventory."*
7. Review and approve `docs/migration/plan.md`, then ask: *"Migrate the next slice."*

## Known gaps in version 1

- **Shell commands can still edit `legacy/`.** The `deny` rule blocks Claude's edit tools, but not a shell command such as `Set-Content`. For stronger protection, mark the folder read-only on disk, or keep it as a separate git checkout that you reset.
- **The Stop hook retries only once in a row.** After one blocked stop, the hook lets the agent finish so it can't get stuck in a loop. From then on, the "3 attempts" rule in `CLAUDE.md` is enforced by instruction only.
- **Running the legacy app is not covered.** Characterization tests assume the legacy app or its logic can be run. If it can't, record the behavior from logs or by hand, and add a note in the decision log.
- **Not yet compared** with Codex or Muse. That comes after the Claude version has been tried.

## Files

- [design-decisions.md](design-decisions.md): the choices behind this harness, and why each was made
- [template/](template/): the files to copy into a migration project
- [experiments/log.md](experiments/log.md): results from trial runs
