#!/bin/sh
# Where the two hooks share per-session state.
#
# lint.sh appends the word count of every reply. remind.sh reads the recent ones
# back and tells the model what it has actually been doing. That is the point:
# drift is not the model forgetting the rules, it is the model reading its own
# long replies earlier in the transcript and treating them as the house style.
# A number it cannot argue with breaks that loop; repeating the rule does not.
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
