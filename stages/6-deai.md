# Stage 6 — De-AI

Strip AI-writing tells from every user-facing artifact of this run: the final prompt's prose sections, the spec, the shape rationale, the handoff narrative. Rewrite, never merely delete — the cleaned text covers everything the original covered. Preserve meaning and register. Do not touch code blocks, quoted material, proper names, or the structural templates.

## Process

1. Scan the artifact against the pattern table below.
2. Draft rewrite.
3. Self-audit: "what still reads as AI-generated?" — answer in two or three bullets.
4. Final rewrite addressing them. Hard rule: the final text contains no em dashes and no en dashes; replace each with a period, comma, colon, or parentheses.

## Pattern table

| # | Tell | Cue words / shape | Fix |
|---|------|-------------------|-----|
| 1 | Significance inflation | "pivotal", "testament", "marks a shift", "broader trend" | State the fact; cut the meaning-making |
| 2 | -ing appendages | trailing "highlighting…", "ensuring…", "showcasing…" | End the sentence; new sentence with a real claim or nothing |
| 3 | Promotional tone | "vibrant", "nestled", "stunning", "renowned", "must-visit" | Neutral description with a concrete detail |
| 4 | Vague attribution | "experts argue", "observers note", "industry reports" | Name the source or drop the claim |
| 5 | AI vocabulary clusters | "delve", "crucial", "landscape", "tapestry", "underscore", "foster", "intricate" | Plain synonyms; one occurrence is fine, clusters are not |
| 6 | Copula avoidance | "serves as", "stands as", "boasts", "features" | is / are / has |
| 7 | Negative parallelism | "not just X, but Y"; tailing "no guessing" fragments | State the positive claim once |
| 8 | Rule of three | every list magically has three items | Use the real number of items |
| 9 | Synonym cycling | protagonist / main character / central figure / hero | Repeat the word or use a pronoun |
| 10 | False ranges | "from X to Y" where X, Y share no scale | List the actual items |
| 11 | Bold overuse & header-colon lists | "**Performance:** improved…" bullets | Prose, or plain list items |
| 12 | Title Case Headings | every word capitalized | Sentence case |
| 13 | Emojis as decoration | 🚀 in headings/bullets | Remove |
| 14 | Chatbot artifacts | "I hope this helps", "Would you like…", "Certainly!" | Delete |
| 15 | Hedging stacks | "could potentially possibly" | One qualifier, or none |
| 16 | Filler phrases | "in order to", "it is important to note that" | "to", delete the frame |
| 17 | Generic upbeat closer | "the future looks bright", "exciting times ahead" | End on a concrete fact or next step |
| 18 | Signposting | "let's dive in", "here's what you need to know" | Start with the content |
| 19 | Staccato drama | stacked one-line punchlines for effect | One short sentence for emphasis, then normal rhythm |
| 20 | Aphorism formulas | "X is the Y of Z", "X becomes a trap" | The concrete claim the formula gestures at |
| 21 | Fake-candid openers | standalone "Honestly?", "Look," before a routine point | Say the thing |

## False-positive guard

Flag clusters, not single hits. One em dash in the source, one "however", curly quotes alone — none of these prove anything, and over-editing legitimate prose is its own failure. Preserve signals of a human hand: specific hard-to-fabricate details, mixed feelings, uneven sentence rhythm, genuine asides. When a watched phrase sits inside a quotation or is being discussed rather than used, leave it.

## Output

The cleaned artifacts, plus a one-line summary per artifact of what changed. Overwrite the stage files with the cleaned versions.
