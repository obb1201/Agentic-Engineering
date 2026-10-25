---
name: migration-inventory
description: Analyze the legacy application in legacy/ and record its modules, entry points, dependencies, domain terms and business rules in docs/migration/. Use at the start of a migration, or when the inventory is out of date.
---

# Migration Inventory

Goal: understand the legacy system well enough to plan the migration, using only the code base. Don't change any code in this phase.

## Steps

1. Delegate the reading to the `legacy-analyst` subagent, one area at a time (for example one project or folder per call), so the main context stays small.
2. Fill in `docs/migration/inventory.md`:
   - Modules and what each one does
   - **Entry points**: every API endpoint, page, scheduled job and message handler. Each one is a candidate slice.
   - Dependencies: libraries, external services, database objects and config files that each entry point uses
   - Shared code that many entry points depend on
3. Fill in `docs/migration/domain-glossary.md` with business terms found in class, table and variable names, and what they appear to mean.
4. Fill in `docs/migration/business-rules.md`. For each rule:
   - Where it lives (file and line, or stored procedure name)
   - What it does, in plain words
   - Confidence: **High** (code is clear), **Medium** (likely), or **Low** (a guess)
   - Look hard at stored procedures, triggers, validation code, calculations and `if` branches on status or type fields.
5. Every **Low** confidence rule also goes in `docs/migration/parking-lot.md` as a question for a human.

## Done when

Every entry point is listed, and every business rule has a source location and a confidence level.
