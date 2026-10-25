# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a learning and practice repository for agentic engineering: working with agent harnesses (Claude Code, OpenAI Codex, Muse, and others), working out good practices for them, and defining those practices for specific domains so AI tools can be used well in each one.

Expect content to be a mix of notes, harness configuration (CLAUDE.md / AGENTS.md files, skills, subagents, hooks, MCP setups), and small experiments, rather than a single application.

## Current state

There is no code, build system, or tests yet. Material specific to one harness goes in its folder: `claude/`, `codex/`, or `muse/`. `README.md` defines harness engineering using seven pieces (tools, information, permissions, instructions, checking work, limits, and failure handling). Organize each harness folder around those same pieces so the harnesses can be compared.

As the repo grows, update this file with:

- Where domain practices and experiments that span harnesses belong
- Commands to run any experiments, scripts, or tests
- Conventions for documenting a practice so it can be compared across harnesses and domains

## Environment

- Windows 11. PowerShell is the primary shell, and Git Bash is also available.
- Git repository on the `master` branch.
