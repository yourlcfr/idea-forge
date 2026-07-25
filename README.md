# idea-forge

A Claude Code skill that takes a messy, half-formed idea and walks it through eight fixed stages until it becomes something you can actually hand to an agent: a battle-tested prompt, plus a packaged artifact (a new skill, slash command, or spec) when the idea warrants one.

The output of a run is a single handoff document. At the top sits the final optimized prompt, ready to paste verbatim into a fresh agent session. Below it: the packaged artifact and its usage notes, then the decision log.

## The pipeline

Every run executes all eight stages, in order, no skipping. Two of them stop and interview you; the rest flow on their own.

| # | Stage | What happens | Method |
|---|-------|--------------|--------|
| 1 | Clarify | One-question-at-a-time interview: purpose, constraints, success criteria | inline in `SKILL.md` |
| 2 | Draft prompt | First optimized prompt, targeting Claude Code by default | [`stages/2-draft.md`](stages/2-draft.md) |
| 3 | Grill | Relentless interrogation of the brief and draft; weak assumptions die here | inline in `SKILL.md` |
| 4 | Shape check | Decides the right Claude Code form: skill, slash command, subagent, hook, MCP, or plain prompt | [`stages/4-shape.md`](stages/4-shape.md) |
| 5 | Optimize | Diagnose, fill gaps, compress into full + quick versions | [`stages/5-optimize.md`](stages/5-optimize.md) |
| 6 | De-AI | Strips AI-writing tells from every user-facing artifact | [`stages/6-deai.md`](stages/6-deai.md) |
| 7 | Package | Builds the artifact — a tested skill if the idea is reusable, polished prompt + spec files if it is one-off | [`stages/7-package.md`](stages/7-package.md) |
| 8 | Handoff | Assembles the final document and prints it in full | inline in `SKILL.md` |

Stage outputs land in `.idea-forge/<slug>/NN-<stage>.md` inside the current project, so an interrupted run resumes from the last completed stage instead of starting over.

## One skill, no dependencies

idea-forge is fully self-contained. Each stage's method is native to this repository: the small ones live inline in `SKILL.md`, the larger ones in `stages/` and load only when their stage runs. Nothing is invoked from outside; there is nothing else to install.

The methods are distilled from a set of excellent MIT-licensed projects — superpowers, mattpocock/skills, prompt-master, ECC, humanizer, claude-howto. [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md) maps each stage to its source. The originals go deeper than the slices this pipeline needs; they are worth installing on their own merits, just not required here.

Swapping any stage's method is an edit to one file in `stages/`.

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
