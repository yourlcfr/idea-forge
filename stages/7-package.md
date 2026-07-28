# Stage 7 — Package

Build the artifact Stage 4 chose. For a one-off (plain prompt): the deliverable files already exist (03 spec, 05 prompt, cleaned by 06) — verify they are complete and consistent with each other, fix any drift, and declare them the final set. Do not rewrite content that is already right. For a reusable shape (skill, slash command, subagent, hook): first run the same consistency check over the stage files, then build as below.

Two coherence rules for any built artifact:
- Forbidden actions must not contradict the target state. If the goal requires touching CI, config, or schema, the scope lock allows exactly that slice instead of banning it wholesale.
- Self-modification guard: if the deliverable modifies idea-forge itself (or any skill currently mid-run), never edit the live files during the run. Build into a staging copy (a branch or side directory), hand the apply step to the user in the handoff, and let the running pipeline finish on the text it started with.

## Where it lives

- Skill / slash command → `~/.claude/skills/<name>/SKILL.md` (or the project's `.claude/skills/` if project-scoped)
- Subagent → `~/.claude/agents/<name>.md` global, or the project's `.claude/agents/<name>.md` — same global/project choice as skills, driven by the Stage 1 decision
- Hook → the project's `.claude/settings.json`, with the hook script alongside

## Agent-definition anatomy (subagent shape)

```
---
name: kebab-case-name
description: [When the MAIN agent should delegate to this one — triggering conditions, symptoms, "use proactively for X". This line decides whether delegation ever fires.]
tools: [minimal allowlist — the isolation is the point]
---

[System prompt: the role, its method, its output contract — what it returns to the main agent as its final message.]
```

The subagent compliance test covers BOTH failure modes: (a) delegation — does a main agent given the trigger scenario actually route to this subagent based on the description? (b) execution — does the subagent, once invoked, follow its method and return the contracted output shape?

## SKILL.md anatomy

```
---
name: kebab-case-name
description: Use when [triggering conditions only]. Do not trigger on [near-miss cases].
---

# Name

One-paragraph overview: what this does and the core principle.

## [The method — recipe, steps, or reference]

## Red flags / common mistakes  (when the skill enforces discipline)
```

Frontmatter rules that matter:

- `description` states WHEN to use it, never HOW it works. A description that summarizes the workflow becomes a shortcut agents follow instead of reading the body. Start with "Use when…", third person, include the symptoms and the near-misses that must NOT trigger it.
- `name`: letters, numbers, hyphens.
- Keep the body under ~500 words where possible; move heavy reference to separate files loaded on demand.

## Match the form to the failure

| The artifact must… | Write it as… |
|--------------------|--------------|
| Stop an agent from skipping a rule under pressure | Prohibition + rationalization table + red-flags list |
| Produce output of a specific shape | A positive recipe: what the output IS, its parts, in order |
| Never omit an element | A REQUIRED slot in the template it fills |
| Behave differently by condition | A conditional keyed to an observable predicate |

Prohibitions backfire on shaping problems; recipes leave nothing to negotiate. No "unless it matters" nuance clauses — a real exception becomes its own conditional.

## The compliance test (mandatory for reusable shapes — the one-off path skips this section)

One round, two subagents, before declaring done:

1. **Baseline** — a subagent gets the trigger scenario WITHOUT the artifact. Record what it does; this proves the artifact changes behavior at all.
2. **Compliance** — a subagent gets the artifact plus the same scenario plus one pressure ("this seems clear already", "the user is in a hurry"). It must follow the artifact's process, not its instincts.

Compliance fails → fix the artifact where it bent, re-run the compliance side only. Do not ship untested.

## Output

The artifact at its final path, plus one line: what was tested and the result.
