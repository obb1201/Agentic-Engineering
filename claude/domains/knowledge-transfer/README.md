# Knowledge Transfer Harness for Claude Code

A reusable Claude Code harness for **handing a system over to a new vendor at the end of a contract**. Copy the [template/](template/) folder into a handover project, fill in the placeholders, and Claude Code follows a fixed, checked process to write handover docs that the new team can act on without asking us.

The worked situation: we are the contractor, a new vendor won the contract competition, and their developers must take over running, supporting, fixing and changing the system.

> Status: version 1, structure and docs only. Nothing has been tested yet against a real handover. See [experiments/log.md](experiments/log.md).

## The approach in one paragraph

The docs are written from two sources only: **the code** and **interviews with our experts**. Every fact cites one of them, and anything that can't be cited becomes an open question for an expert instead of a guess. Claude maps the code, plans the documents, prepares interview questions, and drafts one document at a time. A human asks the interview questions. The expert checks each document for accuracy, and the receiver checks it for clarity. The real test is **shadowing**: for about a month the new vendor shadows us, then we shadow them, and every gap they hit goes back into the docs.

## How the work flows

```
 1. Inventory  ──►  2. Outline  ──►  [Human approves outline]
    (skill: kt-inventory)  (skill: kt-outline)

 For each document:
 3. Interview  ──►  [Human asks expert]  ──►  4. Draft  ──►  5. Verify  ──►  [Expert + receiver review]
    (skill: kt-interview)                      (skill: kt-draft-doc)  (agents: doc-reviewer, cold-reader)

 6. Hand over: shadow plan ──► they shadow us ──► we shadow them ──► gaps fixed
    (skill: kt-handover)

 At any step: no source, or sources disagree ──► open questions ──► [Expert answers in an interview]
```

| Step | Who does it | Output |
|---|---|---|
| 1. Inventory | `source-analyst` subagent, guided by the `kt-inventory` skill | `source-inventory.md`, first `glossary.md` entries |
| 2. Outline | Main agent, `kt-outline` skill | `outline.md` and draft `test-questions.md` |
| Gate | **Human** | Outline approved |
| 3. Interview | Main agent writes the questions, and a **human** asks them | `interviews/I<nn>-<topic>.md` |
| 4. Draft | Main agent, `kt-draft-doc` skill | One handover document |
| 5. Verify | `doc-reviewer` and `cold-reader` subagents | Review findings, and test questions answered from the docs alone |
| Gate | **Expert, then receiver** | Document approved |
| 6. Hand over | Main agent, `kt-handover` skill, plus **both teams** | `shadow-plan.md`, with gaps turned into fixes |

## The seven harness pieces

This harness is organized around the seven pieces in the repo [README](../../../README.md).

| Piece | How this harness handles it | Where |
|---|---|---|
| 1. Tools | File read and search over a local copy of the code. Read-only history commands (`git log`, `tf history`). No web access. | `template/.claude/settings.json` |
| 2. Information | A short `CLAUDE.md` with links to the source inventory, outline, glossary, decision log, open questions and interviews. | `template/CLAUDE.md`, `template/docs/kt/` |
| 3. Permissions | The code is read-only. Claude may write only in `docs/kt/`. Secrets files are blocked. No push, check-in or web. | `settings.json`, `hooks/guard-writes.ps1` |
| 4. Instructions | A short `CLAUDE.md` holds the rules, including what must never be shared with a competitor. One skill per phase holds the procedure. | `template/CLAUDE.md`, `template/.claude/skills/` |
| 5. Checking work | A Stop hook checks that every fact cites a source that exists. A PreToolUse hook blocks secrets. The reviewer spot-checks citations, and the cold reader tests the docs. Humans review, and shadowing tests the whole set. | `template/.claude/hooks/`, `template/.claude/agents/` |
| 6. Limits | One document or one interview per session. Documents under 300 lines. Human gates after the outline and after each document. | `template/CLAUDE.md` |
| 7. Failure handling | Unknown or conflicting facts go to `open-questions.md` and come back through interviews. After 3 failed fix attempts, the agent stops and writes up a blocker. | `template/CLAUDE.md`, `template/docs/kt/open-questions.md` |

## What the harness defends against

| Expected agent mistake | Guard |
|---|---|
| Made-up facts written with confidence | Rule in `CLAUDE.md`: write only what a source proves. The Stop hook rejects uncited facts and citations to files that don't exist. The reviewer opens cited sources to check them. |
| Missing knowledge that lives only in people's heads | The interview skill turns gaps into questions. The cold reader shows which test questions the docs can't answer. Shadowing finds what's left. |
| Leaking secrets | The PreToolUse hook blocks text that looks like a secret. `deny` rules block reading secrets files. |
| Sharing commercial information with a competitor | A rule in `CLAUDE.md` and a decision-log entry, checked by the reviewer. |
| Docs too long to read | Fixed templates. The Stop hook rejects cited documents over 300 lines. |
| Docs out of date before handover | The code version is recorded in the inventory, and every citation refers to it. |
| Editing the client's code | A `deny` rule on `source/**`, and the write hook allows only `docs/kt/`. No check-in or push. |

## How to use it

1. Set up the handover project as a git repo:
   ```
   my-handover/
     source/      # read-only copy of the code: a TFS workspace mapped to trunk, or a git clone
     docs/kt/     # the handover docs (from the template)
   ```
   Add `source/` to the project's `.gitignore` if it is its own clone or workspace.
2. Copy everything inside [template/](template/) into the project root.
3. Fill in the `<PLACEHOLDERS>` in `CLAUDE.md`, especially the out-of-scope items and the contract handover requirements.
4. Install PowerShell 7 (`pwsh`), which runs the hooks on Windows, macOS and Linux. On Windows without it, change `pwsh` to `powershell` in `.claude/settings.json`, because the hooks also run on Windows PowerShell 5.1.
5. Start Claude Code in the project and ask: *"Run the knowledge transfer inventory."* Then fill in the Experts table.
6. Ask for the outline. Review and approve `docs/kt/outline.md`, and have experts write the expected answers in `test-questions.md`.
7. For each document, ask: *"Prepare the interview for the next document."* Run the interview, paste the answers, then ask: *"Process the interview and draft the document."*
8. When the documents are approved, ask: *"Build the shadow plan."* During shadowing, paste session notes and ask Claude to process them.
9. Throughout, note interventions and surprises in `docs/kt/harness-notes.md`. When a document is approved and at the end, copy the lessons, anonymized, into this repo's [experiments/log.md](experiments/log.md).

## Known gaps in version 1

- **Shell commands can still write anywhere.** The hook and `deny` rule cover Claude's Write and Edit tools, but not a shell command such as `Set-Content`. Make `source/` read-only on disk, or use a TFS workspace or clone you can reset.
- **The secret check uses patterns.** It catches common formats, but not every secret. Commercial information and other clients are checked by instruction and review only.
- **The citation check proves a source exists, not that it is right.** The reviewer spot-checks at least 5 citations, and the expert reviews the rest.
- **The cold reader's limit to the finished docs is enforced by instruction only.** It has the same read tools as other agents.
- **Line numbers drift** if the code changes after the inventory. Out-of-date docs are not detected in version 1.
- **Tickets, wiki and chat are not used.** Only the code and interviews are sources.
- **The Stop hook retries only once in a row.** After that, the "3 attempts" rule in `CLAUDE.md` is enforced by instruction only.
- **Not yet compared** with Codex or Muse. That comes after the Claude version has been tried.

## Files

- [design-decisions.md](design-decisions.md): the choices behind this harness, and why each was made
- [template/](template/): the files to copy into a handover project
- [experiments/log.md](experiments/log.md): results from trial runs
