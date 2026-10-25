# Design Decisions

The choices this harness is built on. To change the harness, change the decision here first.

## Purpose and scope

| Question | Decision |
|---|---|
| What comes out of this? | A reusable template: `CLAUDE.md`, settings, hooks, skills, subagents and document templates. |
| What situation is it for? | We are the contractor. A new vendor won the contract competition, and we hand our work over to them. |
| Who receives the knowledge? | Developers at the new vendor with the same skills as our team, who are new to this system. |
| What must they be able to do afterwards? | Run, support and fix the system (operational ownership), **and** change and extend the code safely (development ownership). |
| One-off or kept up to date? | One-off handover with a fixed end date. |
| What does version 1 contain? | The structure and docs. Nothing has been run yet. |

## The knowledge

| Question | Decision |
|---|---|
| What must be transferred? | Known problems, workarounds and technical debt, plus daily work and monitoring. A short system overview is added because the receiver must also change the code (see "Additions" below). |
| Where does it live? | In the code, and in people's heads. Tickets, wiki and chat are not used in version 1. |
| How does Claude read the code? | From a local, read-only copy in `source/`: a TFS workspace mapped to the trunk, or a clone of the GitHub repo. |
| How is knowledge in people's heads captured? | An interview skill. Claude writes the questions, a human asks the expert, and the answers are pasted back into an interview file. |

## Trust and safety

| Question | Decision |
|---|---|
| What must never appear in the docs? | Secrets: passwords, keys, tokens, connection strings, certificates. A hook blocks text that looks like one. |
| Where may Claude write? | Only inside `docs/kt/`. A hook blocks Write and Edit calls anywhere else. The code is read-only. |
| Must every statement have a source? | Yes. Every fact cites a code location (`[src: ...]`) or an interview (`[int: ...]`). A hook checks this. |
| Sources disagree, or a fact can't be confirmed? | Write it in `open-questions.md` for the expert. Never guess. |

## Quality

| Question | Decision |
|---|---|
| What does a good document look like? | A fixed template for each document type, under 300 lines. |
| Who reviews? | The expert checks accuracy, then the receiver checks clarity. |
| Automatic test | A `cold-reader` subagent answers test questions using only the finished docs. |
| How do we know the transfer worked? | Shadowing. For about a month the new vendor shadows us. Then we shadow them until they do the tasks without help. Gaps found while shadowing go back into the docs. |

## The seven pieces

| Piece | Decision |
|---|---|
| Tools | File read and search over `source/`. Read-only history commands (`git log`, `tf history`). No web access. |
| Information | A short `CLAUDE.md`, plus working files: source inventory, outline, glossary, decision log, open questions and interview notes. |
| Permissions | `source/` is read-only. Writes only in `docs/kt/`. No secrets files, no push or check-in, no web. |
| Instructions | A short `CLAUDE.md` holds the rules. One skill per phase holds the procedure. |
| Checking work | A hook checks citations. A hook blocks secrets. The `doc-reviewer` and `cold-reader` subagents check each document. Humans review each document, and shadowing tests the whole set. |
| Limits | One document or one interview per session. Human gates after the outline and after each document. |
| Failure handling | Unknown or conflicting facts go to `open-questions.md`. After 3 failed attempts to fix the same problem, the agent stops and writes up a blocker. |

## Process

| Question | Decision |
|---|---|
| Steps | Inventory → outline → interview → draft → verify → review → hand over (shadowing). |
| Human gates | After the outline, and after each document. |
| Out-of-date docs | Not covered in version 1. Each set of docs records the code version it was written against. |
| Reused from legacy migration | Glossary, decision log, parking lot (here called open questions), human gates, and reviewer and verifier subagents. |

## Additions not in the original answers

These were added while building the harness. Change them here if they don't fit.

| Addition | Why |
|---|---|
| A short `system-overview.md` (components, build, deploy, where to start a change) | The receiver must change and extend the code, and the known-issues and daily-operations documents alone don't explain how. |
| No commercial information, nothing about other clients, and none of our own internal tools in the docs | The receiver is a competitor that won the contract. Secrets are blocked by a hook. These other items rely on the instructions and the reviewer. |
| A "contract handover requirements" section in `CLAUDE.md` | A contract exit plan often lists required handover items. The outline must cover each one. |

## Learning and comparison

| Question | Decision |
|---|---|
| What to learn | Which harness pieces matter most for knowledge transfer. |
| Success measures | Cold-reader pass rate, shadowing tasks that needed help, and human interventions for each document. |
| Compare with Codex or Muse | Later, once the Claude version works. |
| Recording | A short note in [experiments/log.md](experiments/log.md) after each run. |
