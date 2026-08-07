#!/bin/sh
# Generates every harness format from rules/core.md.
#
#   ./build.sh
#
# rules/core.md is the only file you edit. Everything below is generated, so a
# change reaches Claude Code, Cursor, Windsurf, Cline, Copilot, Codex and any
# agent that reads AGENTS.md in one step.
#
# POSIX sh. No node, no jq, no python.
set -e

cd "$(dirname "$0")"
CORE=rules/core.md
[ -f "$CORE" ] || { echo "missing $CORE" >&2; exit 1; }

DESC="Short, direct chat output. No jargon, no preamble, no status theater. Applies ASD-STE100 Simplified Technical English to long replies."

mkdir -p output-styles adapters/cursor adapters/windsurf adapters/cline adapters/copilot adapters/agents

# --- Claude Code output style -------------------------------------------------
{
  echo '---'
  echo 'name: Brevity'
  echo "description: $DESC"
  echo 'keep-coding-instructions: true'
  echo 'force-for-plugin: true'
  echo '---'
  echo
  cat "$CORE"
} > output-styles/brevity.md

# --- AGENTS.md ----------------------------------------------------------------
# Read by Codex, Amp, Jules, and a growing set of other agents.
{
  echo '# Brevity'
  echo
  echo "$DESC"
  echo
  cat "$CORE"
} > adapters/agents/AGENTS.md

# --- Cursor -------------------------------------------------------------------
{
  echo '---'
  echo "description: $DESC"
  echo 'alwaysApply: true'
  echo '---'
  echo
  cat "$CORE"
} > adapters/cursor/brevity.mdc

# --- Windsurf -----------------------------------------------------------------
{
  echo '---'
  echo 'trigger: always_on'
  echo "description: $DESC"
  echo '---'
  echo
  cat "$CORE"
} > adapters/windsurf/brevity.md

# --- Cline --------------------------------------------------------------------
{
  echo '# Brevity'
  echo
  cat "$CORE"
} > adapters/cline/brevity.md

# --- GitHub Copilot -----------------------------------------------------------
{
  echo '# Brevity'
  echo
  echo "$DESC"
  echo
  cat "$CORE"
} > adapters/copilot/copilot-instructions.md

# --- the per-turn reminder, extracted from the rules ------------------------
# The hook must not carry its own copy of the caps. It reads them from here, so
# editing rules/core.md is the only way to change what the reminder says.
{
  awk '/^## Message length/,/^## Rule order/' "$CORE" \
    | grep '^| ' | grep -v '^| Kind' | grep -v '^|---' \
    | sed 's/^| *//; s/ *| */: /; s/ *|$//' \
    | awk '{ printf "%s. ", $0 }'
  printf "Never write: "
  awk '/^## Status words/,/^## Consultant/' "$CORE" \
    | grep '^| ' | grep -v '^| Banned' | grep -v '^|---' \
    | sed 's/^| *//; s/ *|.*//' | tr '\n' ',' | sed 's/,$//; s/,/, /g'
  printf ". No em dash. No stacked test or typecheck counts. No preamble, no recap, no closing offer."
} > hooks/reminder.txt

echo "generated from $CORE:"
for f in output-styles/brevity.md hooks/reminder.txt adapters/agents/AGENTS.md \
         adapters/cursor/brevity.mdc adapters/windsurf/brevity.md \
         adapters/cline/brevity.md adapters/copilot/copilot-instructions.md; do
  printf '  %-46s %s lines\n' "$f" "$(wc -l < "$f" | tr -d ' ')"
done
