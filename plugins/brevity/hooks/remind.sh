#!/bin/sh
# UserPromptSubmit hook.
#
# Three escalating steps, cheapest first.
#
# 1. Always: restate the caps. The text comes from hooks/reminder.txt, which
#    build.sh generates from rules/core.md, so this file holds no copy of the
#    rules and the two cannot drift apart.
#
# 2. When recent replies run long: report the measured average. A 72-turn
#    benchmark showed replies growing about 2.5 times from the first fifth to
#    the last whether or not a hook repeated the rules. Repeating a rule moved
#    the level and left the slope alone, because drift is not forgetting: the
#    model reads its own long replies earlier in the transcript and treats them
#    as the house style. A number about its own behaviour is harder to ignore
#    than another instruction.
#
# 3. When they run very long: tell it to re-read the full rules. They are
#    already in the system prompt, but that sits at position 0 and its pull
#    fades as the transcript grows. Reading the file puts them back at the end
#    of the context, where attention is strongest. It costs a tool call and a
#    few thousand tokens, so it only happens when step 2 has not worked.
#
# POSIX sh and awk. No node, no jq.

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$DIR/state.sh"

INPUT=$(cat)
SID=$(brevity_session_id "$INPUT")
FILE=$(brevity_state_file "$SID")
# Claude Code sets CLAUDE_PLUGIN_ROOT in the form the Read tool understands on
# this platform. Fall back to a relative path only when it is absent.
if [ -n "${CLAUDE_PLUGIN_ROOT:-}" ]; then
  RULES_PATH="${CLAUDE_PLUGIN_ROOT}/rules/core.md"
else
  RULES_PATH=$(CDPATH= cd -- "$DIR/.." && pwd)/rules/core.md
fi

RULES=""
[ -f "$DIR/reminder.txt" ] && RULES=$(cat "$DIR/reminder.txt")
[ -z "$RULES" ] && RULES="Brevity is active. Keep replies to the caps: 40 words for a status, 80 for an answer, 60 plus 15 per agent for delegated work."

FEEDBACK=""
if [ -f "$FILE" ]; then
  export RULES_PATH
  FEEDBACK=$(awk '
    { w[NR] = $1 }
    END {
      if (NR < 3) exit
      start = NR - 4; if (start < 1) start = 1
      n = 0; s = 0
      for (i = start; i <= NR; i++) { s += w[i]; n++ }
      avg = int(s / n)
      if (avg <= 60) exit
      printf "Your last %d replies averaged %d words. ", n, avg
      if (avg > 150) {
        printf "They are drifting well past every cap. Read %s now, then answer inside the caps. ", ENVIRON["RULES_PATH"]
      } else if (avg > 100) {
        printf "That is over the caps and rising. Bring this one back inside them. "
      } else {
        printf "That is over the cap for a status. "
      }
    }' "$FILE")
fi

printf '%s%s' "$FEEDBACK" "Brevity is active and does not expire. $RULES" | awk '
  { line = line $0 }
  END {
    gsub(/\\/, "\\\\", line)
    gsub(/"/, "\\\"", line)
    printf "{\"hookSpecificOutput\":{\"hookEventName\":\"UserPromptSubmit\",\"additionalContext\":\"%s\"}}\n", line
  }'
