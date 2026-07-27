---
name: idea-forge
description: Use when the user invokes /idea-forge or explicitly asks to run the idea-forge pipeline on a raw, messy, or half-formed idea. Do not trigger on ordinary feature requests, clear tasks, or ideas the user has not routed here.
---

# Idea Forge

Turn a messy idea into a battle-tested, agent-ready deliverable by running eight fixed stages in order. All eight stages run every time — no skipping, no merging. The pipeline is self-contained: every stage's method lives in this skill (inline below, or in `stages/`). Do not delegate a stage to an external skill; read the stage file and apply it yourself.

## Contract

- Interact with the user in Indonesian. Never add AI attribution to any artifact.
- After each stage: post a 1–3 line summary, save the stage output to `.idea-forge/<slug>/NN-<stage>.md` in the directory where the command was invoked, then continue. Slug = a 2–4 word kebab-case summary of the idea; if that directory already exists for a DIFFERENT idea, append `-2`, `-3`, …
- If a run was interrupted, resume from the highest-numbered stage file present in `.idea-forge/<slug>/`.
- Stages 1 and 3 are the only stages that interview. Later stages never ask the user anything; a critical gap discovered later becomes an explicit ASSUMED decision (best-guess value + one-line reason) and surfaces in the handoff's open questions.
- Interview questions go through the AskUserQuestion tool whenever it is available: answers as selectable options, your recommended option first and marked "(Recommended)". Stage 1 asks one decision per call; Stage 3 may batch related questions (the tool carries up to four per call) — but never bundle a question whose answer depends on another question in the same call. Fall back to plain-text questions only when the tool is absent.

## Stages (fixed order)

### 1. Clarify

Interview the user until the idea has a stated purpose, constraints, and success criteria.

- One decision per message; wait for the answer before the next. Prefer multiple choice with your recommended option first.
- Facts you can look up (filesystem, git, installed tools, project state) — look up, never ask. Decisions belong to the user — always ask, never assume.
- For a vague idea, settle early whether the solution is software at all — a routine, a document, or a process change is a legitimate outcome, and the pipeline still runs on it.
- Tech stack gets its own question whenever the idea builds software and the surrounding project does not already fix the stack. Offer both paths in one AskUserQuestion call: the likely stack candidates as options, plus one option to delegate the pick ("pilihkan untukku"). Delegation is available on ANY decision question, not just stack, and always follows the same protocol: record the pick with a one-line reason, confirm it at the restatement — delegation transfers the choice, not the accountability.
- If the user explicitly waves the interview through ("go ahead", "kamu saja yang tentukan semua") or delegates everything at once: stop asking — a blanket delegation covers every remaining question, including stack, and carries into Stage 3. Blanket delegation must be explicit; a hesitant or partial answer is not delegation. After two consecutive per-question delegations, offer blanket delegation for everything remaining. Infer the answers, mark each ASSUMED with a one-line reason, present the restatement marked "koreksi yang salah kalau ada", and continue in the same turn — corrections may arrive later and follow Stage 3's reversal protocol.
- If the idea is bigger than one deliverable (several subsystems, a multi-session build), decompose by scope even when the pieces are coupled: propose a first slice (a thin tracer through the product) and record the rest as a roadmap in the brief. The user may insist on full scope — their call; then mark scope = epic and let Stages 5 and 8 carry the split.
- YAGNI as you go: strike features the purpose does not need, out loud.
- Exit when you can restate the idea in three sentences plus a binary success criterion, and the user confirms the restatement.

Output: clarified idea brief.

### 2. Draft prompt

Apply `stages/2-draft.md`. Extract the nine intent dimensions, pick the target tool (Claude Code unless the idea names another), and write the first optimized prompt as a single paste-ready block.

### 3. Grill

Interrogate the brief and draft prompt until every weak assumption is dead.

- If Stage 1 ended in blanket delegation, skip the interview entirely: resolve every open point with your recommended answer marked ASSUMED, list them in one message, and proceed.
- Build the decision tree first: extract every open decision from the brief and draft — features, data, edge cases, failure modes, operations — plus every ASSUMED entry Stage 2 recorded. Order by dependency, resolve parents before children; within that order, ASSUMED entries come first (a non-ASSUMED parent still precedes its ASSUMED child).
- For every question, state your recommended answer. Batch related questions into one AskUserQuestion call (max four) unless one depends on another's answer; unrelated ones stay separate calls. A delegated pick here is confirmed in the closing decisions-list message, not by re-asking.
- Use the eleven-point context checklist in `stages/5-optimize.md` § Pass 2 — Fill as ammunition — but items that plainly do not apply to this idea are marked N/A in the stage file without asking. Never ask a question whose answer cannot change the spec.
- If the user reverses a decision Stage 1 closed: update `01-clarify.md` and `02-draft.md` to the new value, log the reversal, and redo any downstream conclusion that depended on it. No restart — stage files are living documents.
- If the user declines the grill or stops answering: resolve each remaining open point with your recommended answer marked ASSUMED, list them in one message, and proceed.
- Record every decision, every N/A, and every killed assumption in the stage file.

Output: hardened spec.

### 4. Shape check

Apply `stages/4-shape.md`. Decide the best Claude Code shape for the idea: skill / slash command / subagent / hook / MCP / plain prompt. Output: shape decision + one-paragraph rationale.

### 5. Optimize

Apply `stages/5-optimize.md` to the draft prompt + hardened spec. Diagnose, fill gaps, compress. Output: final prompt text, full and quick versions.

### 6. De-AI

Apply `stages/6-deai.md` to every user-facing artifact produced so far (final prompt, spec, rationale). Output: cleaned artifacts.

### 7. Package

Always runs; its form adapts to Stage 4's decision. If the shape is reusable (skill / command / subagent / hook): build it per `stages/7-package.md`, including the compliance test defined there. Otherwise: verify and finalize the prompt + spec files per the same file's one-off path. Output: the artifact + its path.

### 8. Handoff

Assemble the final deliverable — the document the user pastes to their agent. Contents in order:

1. The final optimized prompt, ready to paste verbatim, at the very top. Epic scope: the top block is Prompt 1 of the series; the remaining prompts follow in order — "standalone" then means the series, not one block.
2. The Stage 7 artifact: path, what it does, how the receiving agent must use it. Non-agentic target (image/video/voice tools): this becomes "how to use the prompt in the target tool".
3. Decisions log, open questions (including every surviving ASSUMED), next actions, and — only when the receiver is an agent — a short "suggested skills" list.

Rules: apply the Stage 6 patterns to the handoff's own prose before printing. Redact real secrets and personal data — clearly-labeled fake fixtures and placeholders stay. Do not duplicate content that lives in artifacts — reference paths instead; the final prompt is the ONE exception and is always inlined in full, because the handoff must work standalone when pasted. Save to `.idea-forge/<slug>/handoff.md` and print it in full as the last message.

## Red flags — stop and correct

- Skipping or merging a stage because the idea "seems clear" — all eight always run.
- Delegating a stage to an external skill instead of applying the stage file — the pipeline is self-contained and owns every transition.
- A handoff without the ready-to-paste prompt at the top — the handoff is the deliverable, not a meeting note.
- Asking the user for permission between non-interview stages — only Stages 1 and 3 interview.
