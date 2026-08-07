# Evals

Every number in the Brevity docs comes from a harness in this directory. Run it
and you should get the same shape of result.

Raw transcripts are not committed. They are large, specific to one machine and
one day, and stale the moment a model updates. `run-arm.sh` writes them to
`runs/`, which git ignores.

## How a run works

One arm is one Claude Code session driven prompt by prompt through a file. The
session builds a real app, so the work is real and the replies are about
something.

```bash
./run-arm.sh <label> <prompts-file> [plugin-dir]
```

Omit the plugin directory for a control arm. Every arm uses
`--setting-sources project,local`, which loads no user settings, so nothing else
installed on the machine can change the result.

```bash
./run-arm.sh control     prompts-long.txt
./run-arm.sh with-plugin prompts-long.txt ../../brevity
python analyze.py runs/control runs/with-plugin
python tokens.py  runs/control runs/with-plugin
```

`analyze.py` reports reply length, its drift across the session, and countable
violations. `tokens.py` reports what the model wrote and what it read. On a
subscription plan the dollar figure means nothing, so read the token columns.

## The suites

| File | Turns | What it is for |
|---|---|---|
| `prompts.txt` | 10 | A quick check that the plugin loads and shortens replies |
| `prompts-hard.txt` | 11 | Cases where the rules could do harm rather than save words |
| `prompts-long.txt` | 28 | A full feature build with delegation |
| `prompts-drift.txt` | 72 | Long enough for reply length to start climbing |
| `prompts-140.txt` | 140 | Long enough to tell whether anything stops the climb |

Suite length is not a detail. A 10-turn run reports a clean result for a plugin
that drifts badly at 70, which is how the first version of these rules passed
its own benchmark and then failed in real use.

## What the suites established

### Countable rules hold, judgement rules do not

Four arms, 28 turns, same prompts, same app. All four produced working apps with
passing tests, so no difference below comes from doing less work.

| | control | old rules | new rules | new rules + hooks |
|---|---|---|---|---|
| total words | 6063 | 2707 | 1705 | 1479 |
| mean reply | 216 | 96 | 60 | 52 |
| scorecards | 1 | 3 | 0 | 0 |
| em dashes | 123 | 0 | 0 | 0 |
| internal model calls | 130 | 160 | 106 | 86 |

The largest single gain came from rewriting the rules, not from adding code.
Replacing "about three sentences" with "40 words for a status" cut replies 37%
and took scorecards to zero. That matches everything else here: a rule the model
can check against itself holds, and a rule needing judgement does not. Bold runs,
tables and headings sit at or near zero in every plugin arm because each is a
number the model can count.

### Drift is real and needs a long session to see

72 turns, two arms.

| | rules only | rules + static reminder |
|---|---|---|
| mean words by fifth | 47, 106, 94, 111, 123 | 35, 82, 68, 74, 85 |
| growth, first to last fifth | 2.62x | 2.43x |

Both arms grew about two and a half times. A hook that repeated the rules every
turn moved the level down and left the slope alone. That is the signature of
self-conditioning rather than forgetting: the model reads its own long replies
earlier in the transcript and treats them as the house style here, so repeating
the rule does not contradict anything it believes.

The 28-turn suite showed no drift at all. The failure is only visible with
length.

### Reporting a measurement bends the slope

140 turns, three arms. Same rules everywhere; only the hooks differ.

| | rules only | static reminder | measured feedback |
|---|---|---|---|
| mean words by fifth | 72, 130, 99, 118, 92 | 62, 90, 68, 94, 75 | 53, 62, 69, 76, 51 |
| growth, first to last | 1.28x | 1.21x | **0.96x** |
| total words | 14364 | 10957 | 8752 |
| replies over 120 words | 44 | 21 | 3 |
| scorecards | 5 | 0 | 0 |
| linter fired | n/a | 0 of 140 | 11 of 140 |
| cost | $361 | $339 | $359 |

The third arm is the first thing that did not grow. It differs from the second
in two ways. It tells the model the average length of its own recent replies
instead of restating the rule, and its linter threshold is 120 words rather than
250. At 250 nothing ever reached the check; at 120 it fired eleven times.

Cost is flat across all three, so the difference is not bought with tokens.

## Limits

Read this before citing any number above.

- **One run per arm.** The same rules-only configuration drifted 2.62x over 72
  turns and 1.28x over 140. Same config, very different magnitude. Trust the
  ordering of the arms, not any single slope.
- **The 140-turn arms did not build identical apps.** The measured-feedback arm
  produced 147 TypeScript files and 918 passing tests against 182 and 973 for
  rules-only. All tests pass in every arm and every turn completed, but part of
  the word reduction may be marginally less work rather than less talk.
- **One model, one project type, one machine.** These are not statistical
  results.
- **Cache read is not comparable across arms.** It scales with the number of
  internal model calls, which varies with how the model chose to work. The
  28-turn and 72-turn runs disagreed on the sign of the hook's effect on it.
- **`analyze.py` reports false positives.** It once flagged `Dispatch` in a
  walkthrough of framework internals, where the word names a method. Technical
  names are exempt, so every hit needs a human read.
- **The counters cannot see a preamble, a hedge, or a recap.** Those were found
  by reading replies.

## What the suites changed in the plugin

Tests that only confirm what you already believe are not worth running. These
changed the rules five times.

| Found | Change |
|---|---|
| 6 em dashes, all separating a label from a description in a list | The rule said "write a period or a comma", which does not fit a list label. It now names the list case and says to use a colon. |
| A reply that built the wrong fix from a false premise and hid the change | Two rules added: say what you changed, and correct a wrong premise before acting on it. |
| Replies reporting delegated work averaged 178 words against 79 for everything else | A rule for reporting delegated work, with a cap that scales per agent. |
| 37 banned terms that never once appeared, and several with real technical meaning | The list was cut to the terms that actually fire, each qualified by sense. `alignment`, `robust`, `cadence` and others were removed. |
| A linter threshold of 250 words that never fired | Rederived to 120 from two long runs. |
