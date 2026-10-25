# CLAUDE.md: Knowledge Transfer

We are **<OUR_COMPANY>**, the current contractor for **<SYSTEM_NAME>**. Our contract ends on **<END_DATE>**, and **<NEW_VENDOR>** takes over. This project writes the handover docs that let their developers run, support, fix and change the system without us.

## The one rule

**Write only what a source proves.** Every fact must cite where it came from: the code (`[src: path:line]`) or an interview (`[int: I<number>]`). If you can't find a source, don't write the fact. Add a question to `docs/kt/open-questions.md` instead.

## Who reads these docs

Developers at <NEW_VENDOR> who know the stack (<STACK, e.g. .NET, SQL Server, Azure>) as well as we do, but have never seen this system. Don't explain the stack. Do explain everything specific to this system: names, jobs, odd behavior, workarounds and who to contact.

## Layout

- `source/`: a read-only copy of the code (<TFS_TRUNK_PATH or GITHUB_REPO_URL>). **Never edit it.**
- `docs/kt/`: the handover docs. **The only place you may write.**
  - `source-inventory.md`: code areas, jobs, monitoring, external systems, experts, and the code version
  - `outline.md`: the documents to write, their sections and their status
  - `system-overview.md`, `daily-operations.md`, `known-issues.md`: the main handover documents
  - `glossary.md`: terms specific to this system
  - `test-questions.md`: questions the docs must answer, with expected answers
  - `decision-log.md`: decisions already made. Don't reopen them.
  - `open-questions.md`: questions waiting for an expert
  - `interviews/`: interview question sheets and the expert's answers
  - `shadow-plan.md`: shadowing tasks and feedback
  - `doc-checklist.md`: what "done" means for a document
  - `harness-notes.md`: notes on how this harness performed. Not handed over.

## What must never go in the docs

The new vendor is a competitor that won the contract. Never write:

- **Secrets:** passwords, keys, tokens, connection strings or certificates. Say where a secret is kept (for example "Key Vault `kv-prod`, secret `SqlPassword`"), never its value.
- **Our commercial information:** rates, costs, staffing and contract terms.
- **Anything about our other clients.**
- **Our own internal tools or code** that are not contract deliverables: <OUT_OF_SCOPE_ITEMS>.

A hook blocks text that looks like a secret. The other items depend on you, and the `doc-reviewer` checks them.

## Contract handover requirements

<List what the contract's exit plan requires, or write "None stated.">

The outline must cover each item.

## Process

Follow the skill for each phase:

1. Inventory: `kt-inventory` skill
2. Outline: `kt-outline` skill. **Stop and wait for human approval of the outline.**
3. For each document, in outline order:
   1. Interview for the gaps: `kt-interview` skill. A human asks the questions and pastes the answers back.
   2. Draft: `kt-draft-doc` skill
   3. Run the `doc-reviewer` subagent, then the `cold-reader` subagent
   4. **Stop. The expert checks accuracy, the receiver checks clarity, and a human commits.**
4. Hand over: `kt-handover` skill builds the shadow plan and turns shadowing feedback into fixes.

## Citations

- `[src: path:line]`: a code location, with the path relative to `source/`. For example `[src: Jobs/NightlyImport.cs:42]` or `[src: Jobs/NightlyImport.cs:42-60]`. Leave out the line for a fact about a whole file. Use one path per tag.
- `[int: I03]`: an interview, in the file `docs/kt/interviews/I03-<topic>.md`.
- In a document whose first line is `<!-- kt:cited -->`, every bullet, numbered step and table row needs at least one citation. Write facts as bullets, steps or table rows, not long paragraphs. A hook checks this when you finish.

## Limits

- **One document or one interview per session.** When it is finished or blocked, stop.
- A cited document stays under **300 lines**. If it grows longer, split it and update `outline.md`.
- Never push, check in, or change anything in TFS or GitHub.
- Don't use the web. Client code and docs stay on this machine.

## When you are unsure or stuck

- **No source, or sources disagree:** don't guess and don't pick one. Add a question to `open-questions.md` with every source you found.
- **The code and an interview disagree:** leave the fact out and add a question. The expert decides which one is right.
- **A hook keeps failing:** after **3** failed attempts to fix the same problem, stop. Write a blocker in `open-questions.md` covering what fails, what you tried and your best guess at the cause.
- **Before you say a document is done,** run the `doc-reviewer` and `cold-reader` subagents and report their real results.
- **When a human corrects or redirects you, or a hook blocks you,** add one line to `harness-notes.md`.

## Commands

- Code version: `<git -C source rev-parse HEAD | tf history source -recursive -stopafter:1 -noprompt>`
