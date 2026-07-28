# Stage 5 — Optimize

Take the draft prompt (Stage 2) plus the hardened spec (Stage 3) and produce the final prompt. Three passes: diagnose, fill, compress. Advisory output only — never start executing the task itself.

## Pass 1 — Diagnose

State what the draft does well in one line, then table its problems:

| Issue | Impact | Fix |
|-------|--------|-----|
| (what is wrong) | (what breaks downstream) | (the change) |

Classify the scope, because scope decides the prompt's architecture:

| Scope | Heuristic | Consequence for the prompt |
|-------|-----------|---------------------------|
| Trivial | Single file, small change | Direct instruction, no ceremony |
| Low | One component or module | Single prompt with acceptance criteria |
| Medium | Several components, one domain | Prompt includes a plan step + verify step |
| High | Cross-domain, 5+ files | Plan-first prompt; phased execution |
| Epic | Multi-session, architectural | Split into sequential prompts (below) |

Tie-breaks: between Medium and High, cross-domain wins — touching more than one subsystem is High even if the file count is small. Non-code deliverables (research, content, process) map by effort, not files: one sitting = Low, needs its own plan = Medium, multi-session = Epic. Scope escalation found here (e.g. creep recorded by Stage 3's reversal protocol) is applied and logged, never re-asked.

## Pass 2 — Fill

Missing context is the top cause of first-attempt failure. Check all eleven; anything missing that the spec answers, fold in. Anything still open: mark it ASSUMED (best-guess value + one-line reason) or scope it out explicitly — never ask the user here; interviews ended at Stage 3. Every ASSUMED item surfaces again in the handoff's open questions:

1. Tech stack — named or detectable?
2. Target scope — files, directories, modules?
3. Acceptance criteria — how does the agent know it is done?
4. Error handling — edge cases, failure modes?
5. Security — auth, input validation, secrets?
6. Testing expectations — unit, integration, e2e?
7. Performance constraints — load, latency, limits?
8. UI/UX requirements — if frontend: responsive, a11y, design refs?
9. Database changes — schema, migrations, indexes?
10. Existing patterns — reference files the agent must imitate?
11. Scope boundaries — what NOT to do?

## Pass 3 — Compress

- Delete every sentence that does not change what the agent would do.
- Strongest signal words: MUST / NEVER, not should / avoid.
- Most critical constraints inside the first 30% of the prompt.
- Convert vague adjectives to measurable specs; convert prose lists to structure only when structure adds parseability.
- For Epic scope, split: Prompt 1 = research + plan; Prompts 2..N = one phase each, ending with verification; final prompt = integration check. Each prompt self-contained — carry a short context block forward.

## Output

Two fenced blocks, both paste-ready, shaped by the target tool:

1. **Full version** — the complete prompt. Agentic targets (Claude Code, IDEs, autonomous agents): self-contained with acceptance criteria, verification steps, and scope boundaries. Non-agentic targets (image / video / voice / one-shot chat): the best complete prompt in the target's native syntax per `stages/2-draft.md` routing — agentic scaffolding never leaks in.
2. **Quick version** — the compact variant: for agentic targets 3–6 lines (task, gates, stop conditions); for non-agentic targets the shortest prompt that still carries the essentials.

Epic scope: the Full version block is Prompt 1 of N; the remaining prompts follow as additional fenced blocks in order, each self-contained with its carried context block.

ASSUMED entries live OUTSIDE the prompt fences (in the stage file and the handoff's open questions). Inside a prompt, an assumption appears only as a plain constraint where the task needs it — never as a meta "list of assumptions" the receiving tool would misread as content.

Then a two-column table: enhancement → reason, one row per change that matters.
