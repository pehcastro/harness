#!/bin/sh
# Stop hook. Checks the reply that was just written and asks for a rewrite when
# it breaks a countable rule.
#
# This is the part that is not a suggestion. Word counts, banned terms, em
# dashes and bold runs are counted by this script, not judged by the model.
# Measured on a 424-reply session, rules a machine can count held at 98 to 100%
# while rules needing judgement failed: 26% of replies ran over length.
#
# Only mechanical checks belong here. Anything needing judgement stays in the
# rules, because a linter that is wrong teaches the model to ignore it.
#
# POSIX sh and awk. No node, no jq.
#
# Set BREVITY_LINT_LOG to a file path to record every verdict, one line per
# turn, as "words<TAB>verdict". Used by the benchmark to count how often the
# hook fires. Unset by default, so a normal session writes nothing.

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$DIR/state.sh"

INPUT=$(cat)
SID=$(brevity_session_id "$INPUT")
STATE=$(brevity_state_file "$SID")

BREVITY_LINT_LOG="${BREVITY_LINT_LOG:-}"
export BREVITY_LINT_LOG STATE

printf '%s' "$INPUT" | awk '
  { doc = doc $0 "\n" }

  END {
    LOG   = ENVIRON["BREVITY_LINT_LOG"]
    STATE = ENVIRON["STATE"]

    # Tolerate any spacing around the colon: producers differ.
    if (match(doc, /"stop_hook_active"[ \t]*:[ \t]*true/)) { print "{}"; exit }

    if (!match(doc, /"last_assistant_message"[ \t]*:[ \t]*"/)) { print "{}"; exit }
    rest = substr(doc, RSTART + RLENGTH)

    # walk to the unescaped closing quote
    msg = ""; i = 1; n = length(rest)
    while (i <= n) {
      c = substr(rest, i, 1)
      if (c == "\\") { msg = msg substr(rest, i, 2); i += 2; continue }
      if (c == "\"") break
      msg = msg c; i++
    }

    gsub(/\\n/, "\n", msg)
    gsub(/\\t/, " ", msg)
    gsub(/\\"/, "\"", msg)

    # fenced code is exempt from every check
    body = ""; infence = 0
    m = split(msg, L, "\n")
    for (j = 1; j <= m; j++) {
      if (L[j] ~ /^[ \t]*```/) { infence = 1 - infence; continue }
      if (infence == 0) body = body L[j] "\n"
    }

    words = 0
    w = split(body, W, /[ \t\n]+/)
    for (j = 1; j <= w; j++) if (W[j] != "") words++

    emdash = gsub(/\342\200\224/, "", body)

    bold = 0; tmp = body
    while (match(tmp, /\*\*[^*]+\*\*/)) { bold++; tmp = substr(tmp, RSTART + RLENGTH) }

    low = tolower(body)

    nbanned = 0; blist = ""
    split("landed,dispatched,in flight,shipped,surfaced,north star", B, ",")
    for (j = 1; j <= 6; j++) {
      t = B[j]
      if (low ~ ("(^|[^a-z])" t "([^a-z]|$)")) {
        nbanned++
        blist = blist (blist == "" ? "" : ", ") t
      }
    }
    if (low ~ /(ci|tests|test|suite) (is |are |will be |stays )?green/) {
      nbanned++; blist = blist (blist == "" ? "" : ", ") "green (a test result)"
    }

    # A single number the reader asked for is allowed: "5 tests pass" is correct
    # output. A scorecard is several metrics stacked together, which is what the
    # rule forbids. Flag only two or more.
    metrics = 0
    if (low ~ /[0-9]+ (tests?|specs?)/)              metrics++
    if (low ~ /typecheck ?[0-9]/)                    metrics++
    if (low ~ /lint (clean|0)/)                      metrics++
    if (low ~ /[0-9]+ routes?|routes? 200/)          metrics++
    if (low ~ /(everything|all) committed|tree clean/) metrics++
    scorecard = (metrics >= 2)

    opener = 0
    if (body ~ /^[ \t\n]*(You are right|You.re right|Great question|Good catch|Exactly right|Absolutely right)/) opener = 1

    # 120, re-derived from two 72-turn runs. The old 250 came from a session
    # with no caps in the rules; once the caps existed almost nothing reached it,
    # so the check never fired. At 120 it catches 24 genuinely over-long replies
    # in a 72-turn run against 3 where the reader had asked for depth. Those 3
    # are recoverable: the message below says to keep the length if it was asked
    # for, so a wrong flag costs a sentence, not the answer.
    msgs = ""
    if (words > 120) msgs = add(msgs, "it is " words " words. If the reader asked you to explain, compare, or summarise the session, keep the length and ignore this. Otherwise cut to the cap: 40 for a status, 80 for an answer, 60 plus 15 per agent for delegated work, 150 for a session summary")
    if (emdash > 0)  msgs = add(msgs, "it has " emdash " em dash(es). Use a period, a comma, or a colon in a list")
    if (bold > 3)    msgs = add(msgs, "it has " bold " bold phrases and the cap is 3")
    if (nbanned > 0) msgs = add(msgs, "it uses banned status words: " blist)
    if (scorecard)   msgs = add(msgs, "it prints a test or typecheck count, which is a scorecard")
    if (opener)      msgs = add(msgs, "it opens by agreeing with the reader instead of stating the fact")

    if (STATE != "") print words >> STATE

    if (msgs == "") {
      if (LOG != "") print words "	clean" >> LOG
      print "{}"; exit
    }
    if (LOG != "") print words "	" msgs >> LOG

    out = "Brevity check on the reply you just wrote: " msgs ". Rewrite it shorter, keeping every fact: the location, the cause, the numbers the reader needs, and any open question. Give the rewrite only, with no apology and no explanation of the edit."

    gsub(/\\/, "\\\\", out)
    gsub(/"/, "\\\"", out)
    print "{\"hookSpecificOutput\":{\"hookEventName\":\"Stop\",\"additionalContext\":\"" out "\"}}"
  }

  function add(acc, s) { return acc (acc == "" ? "" : "; ") s }
'
