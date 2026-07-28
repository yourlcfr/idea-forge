#!/usr/bin/env bash
# Invariant linter for idea-forge. Catches the self-collision class of defect
# that three training rounds kept reintroducing. Run before every commit.
set -u
cd "$(dirname "$0")/.."
fail=0
err() { echo "FAIL: $1"; fail=1; }

# 1. Every stages/*.md path referenced in SKILL.md must exist.
for ref in $(grep -o 'stages/[0-9a-z-]*\.md' SKILL.md | sort -u); do
  [ -f "$ref" ] || err "SKILL.md references missing file: $ref"
done

# 2. Every "§ <heading>" cross-reference must resolve to a real heading in the named file.
#    Convention checked: `stages/<file>.md` § <heading text up to em-dash/end>.
grep -o 'stages/[0-9a-z-]*\.md` § [^.]*' SKILL.md | while IFS= read -r line; do
  file=$(echo "$line" | grep -o 'stages/[0-9a-z-]*\.md')
  head=$(echo "$line" | sed 's/.*§ //' | sed 's/ as .*//' | sed 's/ *$//')
  grep -q "^#.*$head" "$file" || echo "FAIL: SKILL.md § reference not found: '$head' in $file"
done | grep FAIL && fail=1

# 3. The handoff file has exactly one canonical name.
grep -rn 'handoff\.md' SKILL.md stages/ | grep -v '08-handoff' && err "unnumbered handoff.md reference"

# 4. Wording that previous rounds killed must stay dead.
for phrase in 'single paste-ready block' 'Two fenced blocks' 'one-subagent compliance test' '§ Missing context' 'ask at most three more'; do
  grep -rn "$phrase" SKILL.md stages/ && err "resurrected dead phrase: $phrase"
done

# 5. No em/en dash inside fenced code blocks of stage templates (the tahap-6 collision).
awk '/^```/{f=!f;next} f && /—|–/ {print FILENAME": "$0; found=1} END{exit found}' stages/2-draft.md || err "em/en dash inside a 2-draft template fence"

# 6. Stage count integrity: SKILL.md must define exactly stages 1..8.
n=$(grep -c '^### [1-8]\.' SKILL.md)
[ "$n" -eq 8 ] || err "expected 8 stage headings in SKILL.md, found $n"

# 7. Interview monopoly: no stage file may instruct asking the user (stages 2,4,5,6,7 never interview).
grep -rn 'ask the user\|ask (if critical)\|ask at most' stages/2-draft.md stages/4-shape.md stages/5-optimize.md stages/6-deai.md stages/7-package.md | grep -vi 'never ask\|not interview\|Stage 1/3\|Stage 3\|without asking' && err "a non-interview stage instructs asking the user"

if [ "$fail" -eq 0 ]; then echo "OK: all invariants hold"; else exit 1; fi
