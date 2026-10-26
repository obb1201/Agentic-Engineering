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
| Transmission | Workflows: the steps that turn a goal into actions |
| Map and GPS | Context and data: business knowledge, the right files, docs, and memory |
| Connections to the wheels | APIs, tool use, MCP servers, and skills |
| Inspection | Tests, evals, and review of the agent's output |
| Seatbelts and airbags | Failure handling: retries, rollback, and safe defaults |

The model sets the ceiling. The harness decides how much of that ceiling you actually get to use. Harness engineering is engineering the car around the AI engine.

### Example: AI for a company database

Suppose employees want to ask, "Which customers haven't paid their invoices?" The AI on its own doesn't know. The harness connects it to the company's data safely:

```
Employee: "Which customers haven't paid?"
   ↓
AI
   ↓
Harness
 ├── Who is this employee?
 ├── What are they allowed to see?
 ├── Which database should be queried?
 ├── Which query or tool should be used?
 ├── Is the query safe?
 ├── Is sensitive information involved?
 └── Should the result be logged?
   ↓
Company database
   ↓
Result
   ↓
AI explains it to the employee
```

The AI's reasoning is only one piece. Most of the engineering is making sure it can work with the real company safely.

### Why this matters now

In traditional software, developers write most of the steps:

```
IF this happens
    do this
ELSE
    do that
```

With an AI agent, you increasingly say: "Here is your goal, here are your tools, here is what you're allowed to do. Work out the steps."

That makes the setup around the AI very important. A good harness can make an average model surprisingly useful. A bad harness can make even a very capable model unreliable.

## What's in this repo

- **One folder per harness:** [claude/](claude/), [codex/](codex/), and [muse/](muse/) hold each harness's instruction files, skills, subagents, hooks, permissions, and MCP setups, with notes on how it handles them.
- **Domain practices:** a defined way of working with AI tools in a particular domain, built on the seven pieces above.
- **Experiments:** small, self-contained runs that test a practice or compare harnesses on the same task.

See [WordCloud.md](WordCloud.md) for the vocabulary this work covers, and [CLAUDE.md](CLAUDE.md) for the guidance agents follow in this repo.
