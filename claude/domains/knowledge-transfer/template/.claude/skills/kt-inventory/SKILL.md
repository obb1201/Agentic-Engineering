---
name: kt-inventory
description: Map the code in source/ and record its areas, jobs, monitoring, external systems, known-issue candidates and terms in docs/kt/. Use at the start of a knowledge transfer, or when the inventory is out of date.
---

# Knowledge Transfer Inventory

Goal: know what the code contains and who knows what, so the outline can be planned. Only read the code in this phase.

## Steps

1. Record the code version at the top of `docs/kt/source-inventory.md`, using the command in `CLAUDE.md`. Every citation refers to this version.
2. Delegate the reading to the `source-analyst` subagent, one area at a time (for example one project or folder per call), so the main context stays small.
3. Fill in `docs/kt/source-inventory.md`:
   - **Code areas:** what each one does
   - **Jobs and background processes:** scheduled tasks, Windows services, SQL Agent jobs, timers and queue handlers. These are the daily work.
   - **Monitoring and logging:** where logs go, health checks, alerts and dashboards that appear in code or config
   - **External systems:** what the system calls, and what calls it
   - **Known-issue candidates:** TODO, HACK and FIXME comments, workaround code, retry loops, swallowed exceptions and hard-coded dates or IDs. These are candidates only, because an expert must confirm each one.
4. Add terms found in names to `docs/kt/glossary.md`, but only where the code makes the meaning clear. Put unclear terms in `open-questions.md`.
5. Leave the **Experts** table for a human to fill in, and list in it the areas that have no known expert.

## Done when

Every code area, job and external system is listed with a source location, and every known-issue candidate has a confidence level.
