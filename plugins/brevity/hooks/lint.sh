#!/bin/sh
# Stop hook. Checks the reply that was just written and records the verdict for
# the next turn. It asks for nothing in this turn.
#
# It cannot ask for a rewrite, and this is the reason. Assistant text streams to
# the terminal as the model produces it, so a Stop hook runs after the reader has
# already read the reply. No hook can suppress or replace it: MessageDisplay is
# the only event that sees assistant text and the documentation calls it
# display-only. A rewrite here shows the reader two replies, the long one and the
# short one, which is worse than the long one alone.
# See https://code.claude.com/docs/en/hooks
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

    # Fenced code is exempt from every check, and so is the TLDR at the end.
    # The TLDR is the compressed version of the reply, so counting it would
    # punish the rule that asks for it.
    body = ""; infence = 0; intldr = 0
    m = split(msg, L, "\n")
    for (j = 1; j <= m; j++) {
      if (L[j] ~ /^[ \t]*```/) { infence = 1 - infence; continue }
      if (infence == 0 && L[j] ~ /^[ \t]*(\*\*)?TLDR(\*\*)?[ \t]*:?[ \t]*$/) { intldr = 1; continue }
      if (infence == 0 && intldr == 1) continue
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
    if (words > 120) msgs = add(msgs, "it ran " words " words, past the caps, unless the reader had asked you to explain, compare or summarise")
    if (emdash > 0)  msgs = add(msgs, "it used " emdash " em dash(es)")
    if (bold > 3)    msgs = add(msgs, "it used " bold " bold phrases against a cap of 3")
    if (nbanned > 0) msgs = add(msgs, "it used banned status words: " blist)
    if (scorecard)   msgs = add(msgs, "it printed stacked test or typecheck counts, which is a scorecard")
    if (opener)      msgs = add(msgs, "it opened by agreeing with the reader instead of stating the fact")

    # Two columns separated by a tab: the word count, then the verdict, empty
    # when the reply broke nothing. remind.sh reads both on the next prompt.
    if (STATE != "") print words "\t" msgs >> STATE

    if (msgs == "") {
      if (LOG != "") print words "	clean" >> LOG
    } else {
      if (LOG != "") print words "	" msgs >> LOG
    }

    # Always empty. Anything this hook asks for arrives after the reader has
    # read the reply, so it can only add a second one.
    print "{}"
  }

  function add(acc, s) { return acc (acc == "" ? "" : "; ") s }
'
