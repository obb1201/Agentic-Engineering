# Design Decisions

The choices this harness is built on. To change the harness, change the decision here first.

## Purpose and scope

| Question | Decision |
|---|---|
| What comes out of this? | A reusable template: `CLAUDE.md`, settings, skills, subagents and hooks. |
| One migration or general? | General legacy migration, with one worked example. |
| Who is it for? | Anyone reading the repo, so it is written as a public guide. |
| What does version 1 contain? | The structure and docs. Nothing has been run yet. |

## The migration

| Question | Decision |
|---|---|
| Source and target stack | Stack-agnostic. The preferred target for the worked example is .NET 10 / ASP.NET Core. |
| Migration style | A like-for-like port that keeps behavior identical. |
| Unit of work (slice) | One API endpoint or use case. |
| Main risks | Business rules buried in code or stored procedures, and having to work out the domain context from the code base alone. |
| How a slice is proven correct | Characterization (golden master) tests. |

## Where the agent fits

| Question | Decision |
|---|---|
| Agent does | Inventory, planning, writing code, writing tests, and review. |
| Human does | Approves the plan, merges each slice, and decides unclear business rules. |
| Least trusted area | Edge cases and error handling. |
| Expected mistakes | Guessing business rules, changing behavior while "improving" code, skipping edge cases. |

## The seven pieces

| Piece | Decision |
|---|---|
| Tools | File read and search, build and test for both stacks, and read-only database schema. |
| Information | `CLAUDE.md` plus docs files: glossary, business rules, decision log, plan. |
| Permissions | Legacy source is read-only. No production data. No push, deploy or destructive commands. |
| Instructions | A short `CLAUDE.md`, plus one skill per phase. |
| Checking work | Hooks run the build and tests automatically. |
| Limits | One slice per session. |
| Failure handling | One git branch per slice. Stop after N failed attempts (N = 3) and write up the blocker. |

## Learning and comparison

| Question | Decision |
|---|---|
| What to learn | Which harness pieces matter most for migration. |
| Success measure | How many times a human had to step in for each slice. |
| Compare with Codex or Muse | Later, once the Claude version works. |
| Recording | A short note in [experiments/log.md](experiments/log.md) after each run. |

## Practical limits

| Question | Decision |
|---|---|
| Sample app | A small open-source legacy app (not chosen yet). |
| Budget | A few days. |
| Privacy | None, because only public or sample code is used. |
