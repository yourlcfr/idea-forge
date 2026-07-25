---
name: idea-forge
description: Use when the user invokes /idea-forge or explicitly asks to run the idea-forge pipeline on a raw, messy, or half-formed idea. Do not trigger on ordinary feature requests, clear tasks, or ideas the user has not routed here.
---

# Idea Forge

Turn a messy idea into a battle-tested, agent-ready deliverable by running eight fixed stages in order. All eight stages run every time — no skipping, no merging. The pipeline owns every transition: invoke each sub-skill for its method, and when that sub-skill reaches its own exit or next-step pointer, return here and continue to the next stage instead.

**Self-contained resolution rule.** Each stage names a skill. If that skill is installed, invoke it. If it is not, read the bundled equivalent in this skill's `references/` directory and apply it as the stage's method — same discipline, no external install required. Bundled copies: `brainstorming.md`, `prompt-master/SKILL.md` (+ its own references), `grill-me.md`, `shape-guide.md`, `prompt-optimizer.md`, `humanizer.md`, `writing-skills.md`, `handoff.md`.

## Contract

- Interact with the user in Indonesian. Never add AI attribution to any artifact.
- After each stage: post a 1–3 line summary, save the stage output to `.idea-forge/<slug>/NN-<stage>.md` (slug = kebab-case from the idea) in the current project directory, then continue.
- If a run was interrupted, resume from the highest-numbered stage file present in `.idea-forge/<slug>/`.
- Stages 1 and 3 interview the user and wait for answers; every other stage flows on without asking permission.

## Stages (fixed order)

1. **Clarify** — Invoke `superpowers:brainstorming` for its questioning discipline only (one question at a time; purpose, constraints, success criteria). Stop its flow once the idea is agreed: do NOT write its spec doc, do NOT invoke writing-plans. Output: clarified idea brief.
2. **Draft prompt** — Invoke `prompt-master`. Target tool defaults to Claude Code unless the idea names another tool. Output: first optimized prompt.
3. **Grill** — Invoke `grill-me` against the brief + draft prompt. Relentless interview; record every decision and killed assumption. Output: hardened spec.
4. **Shape check** — Read `references/shape-guide.md` and decide the best Claude Code shape for the idea: skill / slash command / subagent / hook / MCP / plain prompt. Output: shape decision + one-paragraph rationale.
5. **Optimize** — Invoke `ecc:prompt-optimizer` on the draft prompt + hardened spec. Output: final prompt text.
6. **De-AI** — Invoke `humanizer` on every user-facing artifact produced so far (final prompt, spec, rationale). Output: cleaned artifacts.
7. **Package** — Always runs; its form adapts to Stage 4's decision. If the shape is reusable (skill / command / subagent / hook): build it following `superpowers:writing-skills`, including one subagent compliance test. Otherwise: finalize the polished prompt + spec as files. Output: the artifact + its path.
8. **Handoff** — Invoke `handoff`. The handoff document IS the final deliverable the user pastes to their agent, containing in order: (a) the final optimized prompt, ready to paste verbatim; (b) the Stage 7 artifact — path, what it does, how the receiving agent must use it; (c) decisions log, open questions, next actions. Save to `.idea-forge/<slug>/handoff.md` and print it in full as the last message.

## Red flags — stop and correct

- Skipping or merging a stage because the idea "seems clear" — all eight always run.
- Following a sub-skill's own exit pointer (e.g. brainstorming → writing-plans) — the pipeline owns transitions.
- A handoff without the ready-to-paste prompt at the top — the handoff is the deliverable, not a meeting note.
- Asking the user for permission between non-interview stages — only Stages 1 and 3 interview.
