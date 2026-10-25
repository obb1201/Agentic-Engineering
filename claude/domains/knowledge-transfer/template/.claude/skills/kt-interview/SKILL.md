---
name: kt-interview
description: Prepare interview questions for one document's gaps, then turn the expert's pasted answers into usable sources. Use before drafting a document, and again after a human pastes the answers.
---

# Knowledge Transfer Interview

Goal: capture knowledge that exists only in people's heads, in a form that can be cited. Claude prepares the questions, and a human asks them. Claude never talks to the expert directly.

## Part 1: Prepare the questions

1. Pick the next document in `docs/kt/outline.md` that has gaps.
2. List the gaps:
   - Outline sections with no source in the code
   - Open questions for this document in `open-questions.md`
   - Known-issue candidates in `source-inventory.md` that need confirming
   - Test questions with no expected answer
3. Create `docs/kt/interviews/I<nn>-<topic>.md` from `interviews/_template.md`. Use the next free number.
4. Write **at most 15 questions**, grouped by topic. For each question, say why you are asking and what source prompted it. Ask about facts and steps ("What do you do when X fails?"), not opinions.
5. **Stop.** A human runs the interview and pastes the answers into the file.

## Part 2: Process the answers

1. Read the answers. **Never change the expert's words** in the answers section.
2. For each open question an answer settles, set it to `answered` and write `Answer: see I<nn>`.
3. Add expected answers from the interview to `test-questions.md`.
4. If an answer is unclear, or disagrees with the code or another interview, add a new open question.
5. Fill in the "Used in" section at the bottom of the interview file.

## Done when

Every question has an answer, or a reason it is still open.
