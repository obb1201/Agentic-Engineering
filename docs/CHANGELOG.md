# Changelog

Notable changes to this repository, newest first.

## 2026-10-25

- Replaced the one-sentence definition of harness engineering in `README.md`. It now names the tools, connections, rules, security, memory, and checks that let an AI agent work safely with real systems.
- Added the knowledge transfer harness for Claude Code in `claude/domains/knowledge-transfer/`, for handing a system over to a new vendor at the end of a contract. It contains a guide, design decisions, an experiment log, and a template with `CLAUDE.md`, permission settings, a hook that blocks writes outside `docs/kt/` and text that looks like a secret, a Stop hook that checks citations, five phase skills, three subagents, and document templates.
- Added `harness-notes.md` to the knowledge transfer template, for noting interventions during a real project. The experiment log now explains how to turn those notes into anonymized entries in this repo.
- Added the legacy migration harness for Claude Code in `claude/domains/legacy-migration/`. It contains a guide, design decisions, an experiment log, and a template with `CLAUDE.md`, permission settings, a Stop hook that runs the build and tests, four phase skills, and three subagents.
- Recorded in `CLAUDE.md` where domain harnesses go and how each one is laid out.
- Added "Working rules" to `CLAUDE.md`: write in clear, simple English, ask key questions when a requirement is unclear, and record notable changes in this file.
- Added this changelog.

## Initial commit

- Added `README.md` and `WordCloud.md`, which explain harness engineering.
- Added `CLAUDE.md` with guidance for agents, and a `.gitignore`.
- Added one folder per harness: `claude/`, `codex/`, and `muse/`.
