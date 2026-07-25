# idea-forge

A Claude Code skill that takes a messy, half-formed idea and walks it through eight fixed stages until it becomes something you can actually hand to an agent: a battle-tested prompt, plus a packaged artifact (a new skill, slash command, or spec) when the idea warrants one.

The output of a run is a single handoff document. At the top sits the final optimized prompt, ready to paste verbatim into a fresh agent session. Below it: the packaged artifact and its usage notes, then the decision log.

## The pipeline

Every run executes all eight stages, in order, no skipping. Two of them stop and interview you; the rest flow on their own.

| # | Stage | What happens | Composes |
|---|-------|--------------|----------|
| 1 | Clarify | One-question-at-a-time interview: purpose, constraints, success criteria | `superpowers:brainstorming` |
| 2 | Draft prompt | First optimized prompt, targeting Claude Code by default | `prompt-master` |
| 3 | Grill | Relentless interrogation of the brief and draft; weak assumptions die here | `grill-me` |
| 4 | Shape check | Decides the right Claude Code form: skill, slash command, subagent, hook, MCP, or plain prompt | `claude-howto` lesson material |
| 5 | Optimize | Compresses and sharpens the prompt against the hardened spec | `ecc:prompt-optimizer` |
| 6 | De-AI | Strips AI-writing tells from every user-facing artifact | `humanizer` |
| 7 | Package | Builds the artifact — a tested skill if the idea is reusable, polished prompt + spec files if it is one-off | `superpowers:writing-skills` |
| 8 | Handoff | Assembles the final document and prints it in full | `handoff` |

Stage outputs land in `.idea-forge/<slug>/NN-<stage>.md` inside the current project, so an interrupted run resumes from the last completed stage instead of starting over.

## Requirements

idea-forge is an orchestrator: it composes skills you need to have installed. Missing ones will break the stage that calls them.

- [superpowers](https://github.com/obra/superpowers) — `brainstorming`, `writing-skills`
- [mattpocock/skills](https://github.com/mattpocock/skills) — `grill-me`, `handoff`
- [ECC (everything-claude-code)](https://github.com/affaan-m/ECC) — `prompt-optimizer`
- [prompt-master](https://github.com/nidhinjs/prompt-master)
- [humanizer](https://github.com/blader/humanizer)
- [claude-howto](https://github.com/luongnv89/claude-howto) — cloned locally, read at stage 4

Swapping any stage for an equivalent skill you prefer is a one-line edit in `SKILL.md`.

## Install

```bash
git clone https://github.com/yourlcfr/idea-forge.git ~/.claude/idea-forge-repo
ln -s ~/.claude/idea-forge-repo ~/.claude/skills/idea-forge
```

Restart Claude Code (or reload skills) so the slash command registers.

## Usage

```
/idea-forge <dump your messy idea here>
```

Answer the interview questions at stages 1 and 3 — or wave them through — and collect the handoff at the end.

## Opinionated defaults

The contract in `SKILL.md` reflects how I run it: interaction in Indonesian, no AI attribution on any artifact, target tool defaulting to Claude Code. Edit the Contract section to taste; nothing else depends on it.

## License

MIT
