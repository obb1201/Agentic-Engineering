---
name: kt-outline
description: Plan the handover documents, their sections, the expert for each, and the test questions they must answer. Use after the inventory. Ends with a stop for human approval.
---

# Knowledge Transfer Outline

Goal: an approved list of documents that, together, let the receiver run, support, fix and change the system.

## Steps

1. Read `CLAUDE.md` (especially the contract handover requirements), `docs/kt/source-inventory.md` and `docs/kt/decision-log.md`.
2. Fill in `docs/kt/outline.md`. Start from the three main documents: `system-overview.md`, `daily-operations.md` and `known-issues.md`. Add a document only when a topic doesn't fit in these and would push one over 300 lines.
3. For each document, list its sections, the code areas it covers, the contract items it meets and the expert who will check it.
4. Check that every contract handover requirement maps to at least one document. List any that don't as open questions.
5. Draft **5 to 10 test questions** for each document in `docs/kt/test-questions.md`. Write them as real situations the receiver will face, for example "The nightly import didn't run. What do you check first?" Include daily work, known problems and at least one code change. Leave the expected answers empty, because the expert writes them.
6. Set the outline status to "awaiting human approval".
7. **Stop.** Don't start interviews or drafts until a human approves the outline.

## Done when

Every contract requirement is covered, every document has an expert, and every document has test questions.
