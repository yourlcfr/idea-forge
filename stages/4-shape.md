# Stage 4 — Shape check

Used by Stage 4. Pick the FIRST row that matches; when two match, prefer the lighter form (lower row number). State the pick and a one-paragraph rationale.

| # | Shape | Pick when | Signals |
|---|-------|-----------|---------|
| 1 | Plain prompt | One-off task; run once, maybe twice; no reuse across projects | "build me X", a migration, a single report |
| 2 | Slash command / skill | Reusable procedure the USER starts deliberately; needs instructions, not code | a workflow, a checklist, a review discipline, a pipeline |
| 3 | Subagent | Work that should run in its own context window — read-heavy research, parallel fan-out, or a role with restricted tools | "keep this out of main context", bulk file reading, independent parallel tasks |
| 4 | Hook | Something that must happen EVERY time an event fires, enforced by the harness, not by model discipline | "always run tests after edit", "block dangerous git commands", "format on save" |
| 5 | MCP server | Claude needs a capability it does not have — an external API, database, or system boundary requiring real code | third-party service, auth-guarded data, stateful tooling |

Distinctions that decide close calls:

- **Skill vs plain prompt** — will anyone run this a second time? No → prompt. The cost of a skill is maintenance; a one-off does not deserve it.
- **Skill vs hook** — if forgetting is acceptable, skill. If forgetting must be impossible, hook. Skills rely on the model choosing to comply; hooks are enforced by the harness.
- **Skill vs subagent** — a subagent is a skill plus isolation: its own context, its own tool allowlist. Reach for it only when isolation itself is the point.
- **MCP vs everything else** — MCP is the only shape that adds NEW capability. If the model could already do it with existing tools, MCP is over-engineering.

A composite idea can take two shapes (e.g. a skill that a hook enforces). Name the primary shape, note the secondary.
