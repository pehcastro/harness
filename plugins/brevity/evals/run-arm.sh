#!/bin/sh
# Runs one arm of the benchmark and saves every reply plus the lint verdicts.
#
#   ./run-arm.sh <label> <prompts-file> [plugin-dir]
#
# Omit plugin-dir for the control arm. The session loads no user settings, so no
# other plugin on the machine can change the result.
set -u

LABEL="${1:?usage: run-arm.sh <label> <prompts> [plugin-dir]}"
PROMPTS="${2:?}"
PLUGDIR="${3:-}"

EVALS="$(cd "$(dirname "$0")" && pwd)"
OUT="$EVALS/runs/$LABEL"
WORK="${BREVITY_WORKDIR:-/tmp/brevity-bench}/$LABEL"

rm -rf "$OUT" "$WORK"
mkdir -p "$OUT" "$WORK"

PLUG=""
[ -n "$PLUGDIR" ] && PLUG="--plugin-dir $PLUGDIR"

# accept an absolute path or one relative to this directory
case "$PROMPTS" in
  /*|?:*) PFILE="$PROMPTS" ;;
  *)      PFILE="$EVALS/$PROMPTS" ;;
esac

# Every lint verdict for this arm lands here, one line per turn.
BREVITY_LINT_LOG="$OUT/lint.log"
export BREVITY_LINT_LOG
: > "$BREVITY_LINT_LOG"

FLAGS="--setting-sources project,local --permission-mode acceptEdits"
FLAGS="$FLAGS --allowedTools Read,Write,Edit,Glob,Grep,Bash,Task,Agent"
FLAGS="$FLAGS --output-format json $PLUG"

grep -v '^#' "$PFILE" | grep '|' | while IFS='|' read -r n prompt; do
  [ -z "$n" ] && continue
  cont=""
  [ "$n" != "01" ] && cont="-c"
  start=$(date +%s 2>/dev/null || echo 0)
  ( cd "$WORK" && claude -p "$prompt" $cont $FLAGS < /dev/null ) \
    > "$OUT/t$n.json" 2> "$OUT/t$n.err"
  end=$(date +%s 2>/dev/null || echo 0)

  # pull the reply text out of the json result
  awk 'BEGIN{RS="\x01"} {
    if (match($0, /"result"[ \t]*:[ \t]*"/)) {
      rest = substr($0, RSTART + RLENGTH); out = ""; i = 1
      while (i <= length(rest)) {
        c = substr(rest, i, 1)
        if (c == "\\") {
          d = substr(rest, i+1, 1)
          if (d == "n") out = out "\n"
          else if (d == "t") out = out "\t"
          else out = out d
          i += 2; continue
        }
        if (c == "\"") break
        out = out c; i++
      }
      print out
    }
  }' "$OUT/t$n.json" > "$OUT/t$n.txt"

  printf '  %s  %5s words  %3ss\n' "$n" "$(wc -w < "$OUT/t$n.txt" | tr -d ' ')" "$((end-start))" >&2
done

echo "saved to $OUT" >&2
