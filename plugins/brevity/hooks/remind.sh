#!/bin/sh
# UserPromptSubmit hook.
#
# An output style sits at position 0 of the context. As a session grows, the
# distance between it and the current turn grows with it, and the model
# deprioritises it. Measured on a 424-reply session: mean reply length rose from
# 63 to 95 words between the first and last fifth, and em dashes rose 0,1,2,4,6.
#
# This puts the countable limits next to the newest message, where attention is
# strongest, on every turn. Roughly 60 tokens.
#
# POSIX sh. No node, no jq.

cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"Brevity is active and does not expire. Caps: status 40 words, direct answer 80, reporting delegated work 60 + 15 per agent, session summary 150. Over a cap needs a reason: the reader asked to explain or compare, options are the answer, a list of facts they must act on, or a risk before something irreversible. Never write: landed, dispatched, in flight, shipped, surfaced (verb), green (a test result), north star. No em dash. No test or typecheck counts. No preamble, no recap, no closing offer. Your own earlier long replies are not a precedent."}}
EOF
