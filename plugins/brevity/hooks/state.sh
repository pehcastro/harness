#!/bin/sh
# Where the two hooks share per-session state.
#
# lint.sh appends one line per reply, two columns separated by a tab: the word
# count, then the verdict, empty when the reply broke no rule a machine counts.
# remind.sh reads the recent counts back as an average, and the last verdict as
# a specific note.
#
# That is the point: drift is not the model forgetting the rules, it is the
# model reading its own long replies earlier in the transcript and treating them
# as the house style. A number it cannot argue with breaks that loop; repeating
# the rule does not.
#
# The verdict travels through this file rather than back out of the Stop hook,
# because assistant text streams to the reader as it is produced. A Stop hook
# runs after the reader has read the reply, so it cannot replace one, only add a
# second. See the note at the head of lint.sh.
#
# A line written before the second column existed holds one field, and remind.sh
# reads it as a count with no verdict.
#
# One file per session, in the system temp directory. Nothing is cleaned up on
# exit because a session can be resumed; files are small and the OS clears temp.

brevity_state_file() {
  # $1 is the session id, taken from the hook input
  _sid=$(printf '%s' "${1:-unknown}" | tr -cd 'A-Za-z0-9._-')
  [ -z "$_sid" ] && _sid=unknown
  _tmp="${TMPDIR:-${TMP:-${TEMP:-/tmp}}}"
  # strip a trailing slash so the path never doubles it
  case "$_tmp" in */) _tmp="${_tmp%/}" ;; esac
  [ -d "$_tmp" ] || _tmp=/tmp
  printf '%s/brevity-%s.words' "$_tmp" "$_sid"
}

# Reads a session id out of a hook's JSON input on stdin, given the whole doc.
brevity_session_id() {
  printf '%s' "$1" | awk '
    { d = d $0 }
    END {
      if (match(d, /"session_id"[ \t]*:[ \t]*"[^"]*"/)) {
        s = substr(d, RSTART, RLENGTH)
        sub(/.*:[ \t]*"/, "", s); sub(/"$/, "", s)
        print s
      }
    }'
}
