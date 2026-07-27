# Stage 7 — Package

Build the artifact Stage 4 chose. For a one-off (plain prompt): the deliverable files already exist (03 spec, 05 prompt, cleaned by 06) — verify they are complete and consistent with each other, fix any drift, and declare them the final set. Do not rewrite content that is already right. For a reusable shape (skill, slash command, subagent, hook): build it as below.

## Where it lives

- Skill / slash command → `~/.claude/skills/<name>/SKILL.md` (or the project's `.claude/skills/` if project-scoped)
- Subagent → `.claude/agents/<name>.md`
- Hook → the project's `.claude/settings.json`, with the hook script alongside

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

## The compliance test (mandatory)

One round, two subagents, before declaring done:

1. **Baseline** — a subagent gets the trigger scenario WITHOUT the artifact. Record what it does; this proves the artifact changes behavior at all.
2. **Compliance** — a subagent gets the artifact plus the same scenario plus one pressure ("this seems clear already", "the user is in a hurry"). It must follow the artifact's process, not its instincts.

Compliance fails → fix the artifact where it bent, re-run the compliance side only. Do not ship untested.

## Output

The artifact at its final path, plus one line: what was tested and the result.
