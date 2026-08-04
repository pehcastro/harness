#!/usr/bin/env bash
# Runs one end-to-end Claude Code session and saves every reply.
#
#   ./run.sh brevity --plugin   session with the plugin loaded
#   ./run.sh control              session with no plugin
#
# The session loads no user settings. Only the plugin under test is active, so
# other plugins on the machine cannot change the result.
set -u

LABEL="${1:?usage: run.sh <label> [--plugin]}"; shift
PLUGIN=""
[ "${1:-}" = "--plugin" ] && PLUGIN="--plugin-dir $(cd "$(dirname "$0")/.." && pwd)"

EVALS="$(cd "$(dirname "$0")" && pwd)"
OUT="$EVALS/runs/$LABEL"
WORK="${BREVITY_WORKDIR:-/f/localhost/claude-workbench}/$LABEL"

rm -rf "$OUT" "$WORK"
mkdir -p "$OUT" "$WORK"

FLAGS="--setting-sources project,local --permission-mode acceptEdits"
FLAGS="$FLAGS --allowedTools Read,Write,Edit,Glob,Grep,Bash --output-format json $PLUGIN"

grep -v '^#' "$EVALS/prompts.txt" | grep '|' | while IFS='|' read -r n prompt; do
  [ -z "$n" ] && continue
  cont=""; [ "$n" != "01" ] && cont="-c"
  echo "### turn $n" >&2
  ( cd "$WORK" && claude -p "$prompt" $cont $FLAGS < /dev/null ) \
    > "$OUT/t$n.json" 2> "$OUT/t$n.err"
  node -e '
    const fs=require("fs");
    const j=JSON.parse(fs.readFileSync(process.argv[1],"utf8"));
    fs.writeFileSync(process.argv[2], j.result ?? "");
  ' "$OUT/t$n.json" "$OUT/t$n.txt" 2>/dev/null || cp "$OUT/t$n.json" "$OUT/t$n.txt"
  echo "    $(wc -w < "$OUT/t$n.txt") words" >&2
done

echo "saved to $OUT" >&2
