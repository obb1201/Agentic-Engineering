# Claude

Harness engineering with Anthropic's Claude, mainly through Claude Code.

| Harness piece | Where it lives in Claude Code |
|---|---|
| Instructions | `CLAUDE.md` (project, user, and local) |
| Tools | Built-in tools, MCP servers, skills |
| Permissions and limits | `.claude/settings.json` permission rules and modes |
| Checking work | Hooks, subagent reviewers, tests |
| Delegation | Subagents (`.claude/agents/`) and workflows |

## Domain harnesses

- [Legacy migration](domains/legacy-migration/): port a legacy application to a new stack with identical behavior, one slice at a time.
- [Knowledge transfer](domains/knowledge-transfer/): hand a system over to a new vendor at the end of a contract, with docs where every fact cites the code or an expert interview.
