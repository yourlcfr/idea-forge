# Stage 6 — De-AI

Strip AI-writing tells from every user-facing artifact produced so far: the final prompt's prose sections, the spec, the shape rationale. (The handoff does not exist yet — Stage 8 applies these same patterns to its own prose before printing.) Rewrite, never merely delete — the cleaned text covers everything the original covered, at the same length class. Preserve meaning and register.

Scope: every pattern below, including the dash ban, applies to PROSE only. Code blocks, structural templates, and quoted material are exempt from both the edits and the final scan. One clarification with teeth: a fence that merely wraps the final prompt for copy-paste does NOT exempt it — the prompt's prose is the primary target. Exempt are code blocks and templates INSIDE artifacts, not the delivery fence around a prompt.

## Process

1. Scan the artifact against all 33 patterns below.
2. Draft rewrite.
3. Self-audit: "what still reads as AI-generated?" — answer in two or three bullets.
4. Final rewrite addressing them. Hard rule: the final PROSE contains no em dashes (—) and no en dashes (–), including spaced ` — ` and double-hyphen ` -- ` forms. Replace each, in order of preference: period, comma, colon, parentheses, or restructure. Scan the prose (outside code fences) for `—` and `–` before returning; any prose hit means the draft is not done.

## Content patterns

| # | Tell | Cue | Fix |
|---|------|-----|-----|
| 1 | Significance inflation | "pivotal", "testament", "marks a shift", "broader trend", "setting the stage" | State the fact; cut the meaning-making |
| 2 | Notability name-dropping | "cited in NYT, BBC…", "active social media presence" | One specific, contextualized reference or nothing |
| 3 | -ing appendages | trailing "highlighting…", "ensuring…", "showcasing…", "reflecting…" | End the sentence; a new sentence with a real claim, or nothing |
| 4 | Promotional tone | "vibrant", "nestled", "stunning", "renowned", "rich heritage", "must-visit" | Neutral description with one concrete detail |
| 5 | Vague attribution | "experts argue", "observers note", "industry reports" | Name the source or drop the claim |
| 6 | Formulaic challenges sections | "Despite its…, X faces challenges…; despite these challenges…" | Specific problems with specific facts, or cut |

## Language patterns

| # | Tell | Cue | Fix |
|---|------|-----|-----|
| 7 | AI vocabulary clusters | delve, crucial, pivotal, landscape, tapestry, underscore, foster, intricate, showcase, garner, interplay, enduring, vibrant | Plain synonyms; one occurrence fine, clusters are the tell |
| 8 | Copula avoidance | "serves as", "stands as", "boasts", "features", "offers" | is / are / has |
| 9 | Negative parallelism | "not just X, but Y"; "it's not merely…"; tailing fragments ("no guessing") | State the positive claim once, as a real clause |
| 10 | Rule of three | every list has exactly three items | Use the real number of items |
| 11 | Synonym cycling | protagonist / main character / central figure / hero | Repeat the word or use a pronoun |
| 12 | False ranges | "from X to Y" where X and Y share no scale | List the actual items |
| 13 | Subjectless passives | "No configuration needed.", "Results are preserved automatically." | Name the actor: "You need no…", "The system preserves…" |

## Style patterns

| # | Tell | Cue | Fix |
|---|------|-----|-----|
| 14 | Em/en dashes | — and – anywhere | Hard ban; see Process step 4 |
| 15 | Bold overuse | mechanical **emphasis** on phrases | Bold only what a reader must find when scanning |
| 16 | Inline-header lists | "- **Performance:** improved…" | Prose, or plain list items |
| 17 | Title Case Headings | Every Word Capitalized | Sentence case |
| 18 | Emojis as decoration | 🚀 in headings/bullets | Remove |
| 19 | Curly quotes | “…” from chat paste | Straight quotes in technical artifacts |

## Communication patterns

| # | Tell | Cue | Fix |
|---|------|-----|-----|
| 20 | Chatbot artifacts | "I hope this helps", "Would you like…", "Certainly!" | Delete |
| 21 | Cutoff disclaimers & gap-filling | "as of my last update", "details are scarce… likely…", "maintains a low profile" | State what is known with its source; say plainly what is not known, or cut |
| 22 | Sycophancy | "Great question!", "You're absolutely right" | Address the content directly |

## Filler and hedging

| # | Tell | Cue | Fix |
|---|------|-----|-----|
| 23 | Filler phrases | "in order to", "due to the fact that", "it is important to note that" | "to", "because", delete the frame |
| 24 | Hedging stacks | "could potentially possibly" | One qualifier, or none |
| 25 | Generic upbeat closers | "the future looks bright", "exciting times ahead" | End on a concrete fact or next step |
| 26 | Uniform hyphenated pairs | "the report is high-quality" (predicate position) | Hyphenate attributive ("a high-quality report"), drop otherwise |
| 27 | Authority tropes | "the real question is", "at its core", "what really matters" | Make the point without the ceremony |
| 28 | Signposting | "let's dive in", "here's what you need to know" | Start with the content |
| 29 | Fragmented headers | heading, then a one-line restatement of the heading | Delete the warm-up line |
| 30 | Diff-anchored writing | "this was added to replace the previous approach" | Describe the thing as it is, not the change |
| 31 | Staccato drama | stacked one-line punchlines ("No priors. No nostalgia. The rules were gone.") | One short sentence for emphasis, then normal rhythm |
| 32 | Aphorism formulas | "X is the Y of Z", "X becomes a trap", "the currency of" | The concrete claim the formula gestures at |
| 33 | Fake-candid openers | standalone "Honestly?", "Look,", "Here's the thing" | Say the thing |

## Worked micro-examples

- Tell 3+7: "The pipeline enhances clarity, ensuring robust outcomes and showcasing best practices." → "The pipeline forces every decision to be recorded. Later stages read that record instead of guessing."
- Tell 8+9: "The handoff serves as more than a summary — it's not just documentation, it's the deliverable." → "The handoff is the deliverable."
- Tell 13+25: "No manual steps needed. The future of the workflow looks bright." → "You run one command. The workflow then maintains itself until the spec changes."

## False-positive guard

Flag clusters, not single hits. One em dash in the SOURCE text, one "however", curly quotes alone, formal vocabulary, perfect grammar — none of these prove AI on their own; over-editing legitimate prose is its own failure. Preserve the signals of a human hand: specific hard-to-fabricate details, mixed feelings, uneven sentence rhythm, genuine asides and self-corrections, era-bound references. When a watched phrase sits inside a quotation, a title, or is being discussed rather than used, leave it.

## Output

The cleaned artifacts, plus a one-line summary per artifact of what changed. Overwrite the stage files with the cleaned versions.
