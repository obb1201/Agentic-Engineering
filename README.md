# Agentic Engineering

Studying and practicing **harness engineering** across Claude Code, OpenAI Codex, Muse, and other agent harnesses, then turning what works into practices for specific domains.

## What is harness engineering?

In one sentence:

> Harness engineering is building the tools, connections, rules, security, memory, and checks that allow an AI agent to safely work with real systems.

### The new hire

Picture hiring a very smart employee. They're capable, but being smart isn't enough to get good work out of them on day one. They still need:

1. **The right tools** to do the job
2. **Access to the right information** at the moment they need it
3. **The correct permissions**, no more and no less
4. **Instructions and rules** that say how work is done here
5. **A way to check their work** before it ships
6. **Limits** on what they're allowed to do
7. **A process for when something fails**, so mistakes are caught and recovered from

That surrounding setup is the harness. A model is the smart employee, and the harness is everything that makes them productive and trustworthy.

### The engine and the car

An AI model is a powerful engine, but an engine on its own isn't a car.

| Car part | Harness equivalent |
|---|---|
| Engine | The AI model |
| Steering wheel | Instructions and prompts (`CLAUDE.md`, `AGENTS.md`, system prompts) |
| Dashboard | Monitoring, logs, and usage tracking |
| Brakes | Permissions, guardrails, and approval gates |
| Map and GPS | Context and retrieval: the right files, docs, and memory |
| Tools in the trunk | Tool use, MCP servers, and skills |
| Inspection | Tests, evals, and review of the agent's output |
| Seatbelts and airbags | Failure handling: retries, rollback, and safe defaults |

The model sets the ceiling. The harness decides how much of that ceiling you actually get to use.

## What's in this repo

- **One folder per harness:** [claude/](claude/), [codex/](codex/), and [muse/](muse/) hold each harness's instruction files, skills, subagents, hooks, permissions, and MCP setups, with notes on how it handles them.
- **Domain practices:** a defined way of working with AI tools in a particular domain, built on the seven pieces above.
- **Experiments:** small, self-contained runs that test a practice or compare harnesses on the same task.

See [WordCloud.md](WordCloud.md) for the vocabulary this work covers, and [CLAUDE.md](CLAUDE.md) for the guidance agents follow in this repo.
