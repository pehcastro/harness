#!/bin/sh
# Adds the active output style to any status line.
#
# Claude Code sends the status line command a JSON object on stdin. That object
# carries output_style.name, but most status lines ignore it. This script reads
# the name, passes the same JSON to the status line you already use, and adds
# the name to what that status line prints.
#
# POSIX sh. No node, no jq, no python. Works anywhere Claude Code runs a shell.
#
# In ~/.claude/settings.json:
#
#   "statusLine": {
#     "type": "command",
#     "command": "sh /path/to/with-style.sh -- <your existing command>"
#   }
#
# With no inner command it prints the style on its own.
#
# Options, before the -- separator:
#   --prefix          put the style above the inner output, not below
#   --label X         text before the name. Default "style: "
#   --hide-default    print nothing while the style is Default

PREFIX=0
HIDE_DEFAULT=0
LABEL='style: '

while [ $# -gt 0 ]; do
  case "$1" in
    --prefix) PREFIX=1; shift ;;
    --hide-default) HIDE_DEFAULT=1; shift ;;
    --label) LABEL="$2"; shift 2 ;;
    --) shift; break ;;
    *) shift ;;
  esac
done

INPUT=$(cat)

# Pull output_style.name out of the JSON. Tolerates whitespace between tokens
# and any key order. Falls back to Default when the key is absent.
NAME=$(printf '%s' "$INPUT" | tr -d '\n' | sed -n \
  's/.*"output_style"[[:space:]]*:[[:space:]]*{[^}]*"name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
[ -z "$NAME" ] && NAME=Default

BADGE="$LABEL$NAME"
[ "$HIDE_DEFAULT" = 1 ] && [ "$NAME" = Default ] && BADGE=''

if [ $# -eq 0 ]; then
  [ -n "$BADGE" ] && printf '%s\n' "$BADGE"
  exit 0
fi

# stderr is dropped. A status line that prints errors corrupts the display.
BODY=$(printf '%s' "$INPUT" | "$@" 2>/dev/null)

if [ -z "$BADGE" ]; then
  printf '%s\n' "$BODY"
elif [ "$PREFIX" = 1 ]; then
  printf '%s\n%s\n' "$BADGE" "$BODY"
else
  printf '%s\n%s\n' "$BODY" "$BADGE"
fi
