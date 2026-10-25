# Experiment Log

One short entry for each trial run of the harness. The main measures are:

- **Cold-reader pass rate:** test questions the `cold-reader` subagent answered correctly using only the docs.
- **Shadowing help:** shadowing tasks where the receiver needed help that the docs should have given.
- **Human interventions:** how many times a person had to correct, unblock or redirect the agent for a document.

## Template

```
## YYYY-MM-DD: <system>, document <doc-id>

- Harness version / changes since last run:
- Cold-reader result: <answered>/<total>
- Human interventions: <number>, with one line each on why
- Expert corrections: <number> facts that were wrong or missing
- Result: approved | redone | abandoned
- What worked:
- What failed:
- Harness change to try next:
```

## Runs

None yet. The next step is to try the harness on one real or sample system, starting with `known-issues.md`.
