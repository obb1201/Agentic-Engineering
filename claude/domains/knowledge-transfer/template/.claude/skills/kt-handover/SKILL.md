---
name: kt-handover
description: Build the shadowing plan from the approved docs, and turn shadowing feedback into doc fixes and open questions. Use when the documents are approved and shadowing is about to start, and whenever a human pastes shadowing notes.
---

# Handover and Shadowing

Goal: prove the docs work through real tasks. First the new vendor shadows us, then we shadow them until they do every task without help.

## Part 1: Build the shadow plan

1. Read the approved documents.
2. Fill in the task table in `docs/kt/shadow-plan.md`:
   - Every daily, weekly and monthly task in `daily-operations.md`
   - The most common known problems in `known-issues.md`, practised with their workarounds
   - At least one code change: a small fix, built, tested and deployed to a test environment, following `system-overview.md`
3. For each task, name the document the receiver should follow.
4. **Stop.** A human agrees the plan and dates with the new vendor.

## Part 2: Process shadowing feedback

1. A human pastes notes from a shadowing session. Record each one as an `S<n>` entry in `shadow-plan.md`. Keep their words.
2. Update the task's status and say how much help was needed.
3. For each gap in the docs:
   - If a source already has the answer, list the fix under the document in `outline.md`, to make in a later session with `kt-draft-doc`.
   - If not, add an open question.
4. Check the exit criteria at the top of `shadow-plan.md`, and report which tasks still need help.

## Done when

Every task has been done by the receiver alone with no help, or each remaining gap has a fix or an open question.
