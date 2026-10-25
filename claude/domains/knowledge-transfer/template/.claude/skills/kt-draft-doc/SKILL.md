---
name: kt-draft-doc
description: Write one handover document from its template, citing a source for every fact, then review and test it. Use after the document's interview answers are in.
---

# Draft a Handover Document

Goal: one document a new developer at the new vendor can act on without asking us.

## Steps

1. Pick the document from `docs/kt/outline.md`. Read its sections, its template in `docs/kt/`, and every source it needs: code, interviews and answered open questions.
2. Write the document:
   - Keep `<!-- kt:cited -->` as the first line.
   - Write each fact as a bullet, numbered step or table row, with a citation. See "Citations" in `CLAUDE.md`.
   - Write for someone who knows the stack but not this system. Use exact names: jobs, servers, config keys, screens and commands.
   - Steps must be exact enough to follow without help.
   - Don't use guess words such as "probably", "seems", "likely" or "should". If you are not sure, it is an open question.
   - Use terms from `glossary.md`, and add any new ones.
3. Run the `doc-reviewer` subagent. Fix its findings, or explain why a finding doesn't apply.
4. Run the `cold-reader` subagent. Give it **only the question text** for this document from `test-questions.md`, never the expected answers.
5. Compare its answers with the expected answers. For each wrong or missing answer, fix the document if a source exists. Otherwise, add an open question.
6. In `outline.md`, set the status to `in-review`, and record the cold-reader result and the number of human interventions.
7. **Stop.** The expert checks accuracy, and the receiver checks clarity.

## Done when

The citation hook passes, the reviewer approves, and every test question is answered or has an open question.
