---
name: idea-forge
description: Use when the user invokes /idea-forge or explicitly asks to run the idea-forge pipeline on a raw, messy, or half-formed idea. Do not trigger on ordinary feature requests, clear tasks, or ideas the user has not routed here.
---

# Idea Forge

Turn a messy idea into a battle-tested, agent-ready deliverable by running eight fixed stages in order. All eight stages run every time — no skipping, no merging. The pipeline is self-contained: every stage's method lives in this skill (inline below, or in `stages/`). Do not delegate a stage to an external skill; read the stage file and apply it yourself.

## Contract

- Interact with the user in Indonesian. Never add AI attribution to any artifact.
- After each stage: post a 1–3 line summary, save the stage output to `.idea-forge/<slug>/NN-<stage>.md` (slug = kebab-case from the idea) in the current project directory, then continue.
- If a run was interrupted, resume from the highest-numbered stage file present in `.idea-forge/<slug>/`.
- Stages 1 and 3 interview the user and wait for answers; every other stage flows on without asking permission.
- Interview questions go through the AskUserQuestion tool whenever it is available: one call per question, answers as selectable options, your recommended option first and marked "(Recommended)". Fall back to plain-text questions only when the tool is absent.

## Stages (fixed order)

### 1. Clarify

Interview the user until the idea has a stated purpose, constraints, and success criteria.

- One question per message; wait for the answer before the next. Prefer multiple choice with your recommended option first.
- Facts you can look up (filesystem, git, installed tools, project state) — look up, never ask. Decisions belong to the user — always ask, never assume.
- Tech stack gets its own question whenever the idea builds software and the surrounding project does not already fix the stack. Offer both paths in one AskUserQuestion call: the likely stack candidates as options, plus one option to delegate the pick ("pilihkan untukku"). A delegated pick is stated in the brief with a one-line reason and confirmed at the restatement — delegation transfers the choice, not the accountability.
- If the idea bundles several independent pieces, say so, help decompose, and forge the first piece only.
- YAGNI as you go: strike features the purpose does not need, out loud.
- Exit when you can restate the idea in three sentences plus a binary success criterion, and the user confirms the restatement.

Output: clarified idea brief.

### 2. Draft prompt

Apply `stages/2-draft.md`. Extract the nine intent dimensions, pick the target tool (Claude Code unless the idea names another), and write the first optimized prompt as a single paste-ready block.

### 3. Grill

Interrogate the brief and draft prompt until every weak assumption is dead.

- Walk each branch of the decision tree, resolving dependencies between decisions one at a time. For every question, state your recommended answer.
- One question per message. Do not proceed until the user confirms shared understanding.
- Use the eleven-point context checklist in `stages/5-optimize.md` § Missing context as ammunition: any unchecked item is a question.
- Record every decision and every killed assumption in the stage file.

Output: hardened spec.

### 4. Shape check

Apply `stages/4-shape.md`. Decide the best Claude Code shape for the idea: skill / slash command / subagent / hook / MCP / plain prompt. Output: shape decision + one-paragraph rationale.

### 5. Optimize

Apply `stages/5-optimize.md` to the draft prompt + hardened spec. Diagnose, fill gaps, compress. Output: final prompt text, full and quick versions.

### 6. De-AI

Apply `stages/6-deai.md` to every user-facing artifact produced so far (final prompt, spec, rationale). Output: cleaned artifacts.

### 7. Package

Always runs; its form adapts to Stage 4's decision. If the shape is reusable (skill / command / subagent / hook): build it per `stages/7-package.md`, including the one-subagent compliance test. Otherwise: finalize the polished prompt + spec as files. Output: the artifact + its path.

### 8. Handoff

Assemble the final deliverable — the document the user pastes to their agent. Contents in order:

1. The final optimized prompt, ready to paste verbatim, at the very top.
2. The Stage 7 artifact: path, what it does, how the receiving agent must use it.
3. Decisions log, open questions, next actions, and a short "suggested skills" list for the receiving agent.

Rules: redact secrets and personal data; do not duplicate content that lives in artifacts — reference paths instead. Save to `.idea-forge/<slug>/handoff.md` and print it in full as the last message.

## Red flags — stop and correct

- Skipping or merging a stage because the idea "seems clear" — all eight always run.
- Delegating a stage to an external skill instead of applying the stage file — the pipeline is self-contained and owns every transition.
- A handoff without the ready-to-paste prompt at the top — the handoff is the deliverable, not a meeting note.
- Asking the user for permission between non-interview stages — only Stages 1 and 3 interview.
