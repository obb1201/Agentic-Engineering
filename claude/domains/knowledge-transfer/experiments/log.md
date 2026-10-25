# Experiment Log

What we learned about this **harness** from each trial run. The handover work itself stays in the project where the template is used. Only lessons about the harness come here.

## Where the data comes from

When the template is used in a real project, these files collect the raw data during the work:

| File in the project | What to take from it |
|---|---|
| `docs/kt/outline.md` | Cold-reader result and human interventions for each document |
| `docs/kt/harness-notes.md` | One line for each intervention, hook block or surprise |
| `docs/kt/shadow-plan.md` | Shadowing tasks that needed help |
| `docs/kt/open-questions.md` | What the docs couldn't answer |

## How to write an entry

1. Write one entry when a document is approved, and one at the end of the handover.
2. **Anonymize.** Write "System A (.NET, TFS)", not client, vendor or system names. Leave out code and file paths.
3. Use numbers where you can.
4. Give one line for each intervention, naming the harness piece it points to.
5. End with one harness change to try. Record it in [design-decisions.md](../design-decisions.md), and in the repo changelog if you make it.

The main measures are:

- **Cold-reader pass rate:** test questions the `cold-reader` subagent answered correctly using only the docs.
- **Shadowing help:** shadowing tasks where the receiver needed help that the docs should have given.
- **Human interventions:** how many times a person had to correct, unblock or redirect the agent for a document.

## Template

```
## YYYY-MM-DD: <anonymous system name (stack)>, document <doc-id> | end of handover

- Harness version / changes since last run:
- Cold-reader result: <answered>/<total>
- Human interventions: <number>
  - <one line each: what happened → which harness piece>
- Expert corrections: <number> facts that were wrong or missing
- Shadowing (end of handover only): <tasks done alone>/<total>
- Result: approved | redone | abandoned
- What worked:
- What failed:
- Harness change to try next:
```

## Example

```
## 2026-11-12: System A (.NET, TFS), document known-issues.md

- Harness version / changes since last run: v1, first run
- Cold-reader result: 6/9
- Human interventions: 3
  - Cited a TODO comment as a confirmed issue → instructions (candidate vs confirmed unclear)
  - Secret hook blocked "Password: see KeyVault-Prod" → checking work (false alarm)
  - Had to remind it of the one-document limit → limits
- Expert corrections: 2 facts wrong, 1 workaround missing a step
- Result: approved after one redo
- What worked: interview questions were specific; citation hook caught 7 uncited lines
- What failed: cold reader couldn't answer "who to call"; no template has a contacts section
- Harness change to try next: add a "Contacts" section to daily-operations.md
```

## Runs

None yet. The next step is to try the harness on one real or sample system, starting with `known-issues.md`.
