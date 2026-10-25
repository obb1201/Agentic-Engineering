# Changelog

Notable changes to this repository, newest first.

## 2026-10-25

- Added the legacy migration harness for Claude Code in `claude/domains/legacy-migration/`. It contains a guide, design decisions, an experiment log, and a template with `CLAUDE.md`, permission settings, a Stop hook that runs the build and tests, four phase skills, and three subagents.
- Recorded in `CLAUDE.md` where domain harnesses go and how each one is laid out.
- Added "Working rules" to `CLAUDE.md`: write in clear, simple English, ask key questions when a requirement is unclear, and record notable changes in this file.
- Added this changelog.

## Initial commit

- Added `README.md` and `WordCloud.md`, which explain harness engineering.
- Added `CLAUDE.md` with guidance for agents, and a `.gitignore`.
- Added one folder per harness: `claude/`, `codex/`, and `muse/`.
