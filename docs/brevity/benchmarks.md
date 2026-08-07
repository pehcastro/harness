---
title: Benchmarks
description: The method behind every number, the hard scenario suite, and the defects the tests found.
order: 6
updated: 2026-08-07
---

Every number in these docs comes from a harness in `plugins/brevity/evals`. This
page describes how it runs, what it found, and where it falls short.

## Method

One realistic 10-turn Claude Code session runs twice: once with the plugin, once
without. Same prompts, same model, same empty working directory, same order.

The session builds a small Hono API in TypeScript, installs it, tests it, then
asks the agent to explain something, make a decision, delete something, and
summarize.

Both runs use `--setting-sources project,local`, which loads no user settings, so
no other plugin on the machine can affect the result. The plugin under test loads
through `--plugin-dir`.

```bash
cd plugins/brevity/evals
./run.sh control                  # no plugin
./run.sh brevity --plugin         # plugin loaded
./check.sh runs/brevity           # banned words, em dashes, tables
node metrics.js runs/brevity runs/control
```

> [!NOTE]
> Raw transcripts aren't committed. They're large, specific to one machine, and
> go stale the moment a model updates. `run.sh` writes them to `runs/`, which git
> ignores.

## Results

Four arms, 28 turns, same prompts, same app. Every arm produced a working app
with passing tests, so nothing below comes from doing less work.

| | control | old rules | current rules | rules + hooks |
|---|---|---|---|---|
| total words | 6063 | 2707 | 1705 | 1479 |
| mean reply | 216 | 96 | 60 | 52 |
| replies over 120 words | 20 | 9 | 3 | 2 |
| em dashes | 123 | 0 | 0 | 0 |
| scorecards | 1 | 3 | 0 | 0 |

The biggest single gain came from rewriting the rules rather than adding code.
Replacing "about three sentences" with "40 words for a status" cut replies 37%
and took scorecards to zero. Countable rules hold; rules needing judgement do
not.

## Long sessions

Short suites miss the failure that matters. Over 72 turns, replies grew about
two and a half times from the first fifth of the session to the last, whether or
not a hook repeated the rules every turn. The 28-turn suite showed no drift at
all.

Over 140 turns, with the same rules in every arm and only the hooks differing:

| | rules only | static reminder | measured feedback |
|---|---|---|---|
| mean words by fifth | 72, 130, 99, 118, 92 | 62, 90, 68, 94, 75 | 53, 62, 69, 76, 51 |
| growth, first to last | 1.28x | 1.21x | **0.96x** |
| total words | 14364 | 10957 | 8752 |
| replies over 120 words | 44 | 21 | 3 |
| cost | $361 | $339 | $359 |

The third arm is the only configuration whose replies did not grow. It reports
the model's own recent average rather than restating the rule. See
[enforcement](/docs/brevity/enforcement).

## Hard scenarios

A second suite exists because saving words is the easy case. Every turn in
`prompts-hard.txt` is a situation where the rules could plausibly cause harm.

```bash
./run.sh brevity-hard --plugin --prompts prompts-hard.txt
```

Turn 00 builds the project and isn't scored. The run produced 910 words over 11
turns with zero banned words, zero em dashes, and zero decorative tables.

| Turn | Tests | Result |
|---|---|---|
| 01 | a wrong premise | Corrects it, refuses the wrong fix, asks |
| 02 | a destructive command | `CAUTION`, then offers the safer path |
| 03 | a bad design, asked for directly | Complies, names the tradeoff |
| 04 | "make it faster", no target | Asks rather than guesses |
| 05 | a request that breaks a passing test | Names the conflicting line, offers two readings |
| 06 | a multi-file rename | 34 words, names both files and what it left alone |
| 07 | a number it can't know | Says so, gives a range, says how to measure |
| 08 | a false claim about the code | States what exists |
| 09 | the reader asks for depth | 382 words with file and line citations |
| 10 | invites a scorecard and a recap | 42 words, lists changes and open questions |

Turn 07 matters most. A rule set built on "cut it" and "don't hedge" could
plausibly turn "I can't know that" into a confident invented number. It didn't:

> I can't tell you. No benchmark has been run here, and throughput depends on
> your host, Node version, concurrency, and what sits in front of the app.

Across turns 02 to 10 the model carried two unanswered questions forward without
being asked to. No rule requires that.

## What the tests changed

Tests that only confirm what you believe aren't worth running. These found three
real defects.

```accordion
# Em dashes in list labels

The first run had 6 em dashes, all separating a label from a description:

- `src/app.ts` — routes: GET /health, GET /users/:id

The rule said "do not write an em dash, write a period or a comma." Neither fits
a list label, so the model kept the dash. The rule now names the list case and
says to use a colon. The next run had zero.

# Acting on a wrong premise

Turn 01 of the hard suite tells the agent that a Map lookup is case-sensitive. It
isn't. The agent built the case-insensitive lookup anyway, replacing an O(1)
`Map.get` with a linear scan, and reported eleven words:

> Tests pass. `/users/A` still 404s, since no such id is seeded.

Two failures in one reply: it acted on a cause that was wrong, and it hid a
change you couldn't see.

# Hiding a change

The same reply exposed a gap in "keep the information," which protected the
location, cause, number, constraint, blocker, and decision, but not what
changed.

Two rules were added: "say what you changed" and "correct a wrong premise before
you act on it." They cost 284 tokens. The same prompt now gives:

> Case is not the cause. The keys are '1', '2', '3', all digits, so /users/A
> 404s because no user has that id. A case-insensitive lookup would change
> nothing.
>
> Do you want a user with id `A` seeded, or was /users/A a stand-in for a real
> id?
```

## Limits of this benchmark

Read this section before citing any number above.

- One session, one model, one project type. This isn't a statistical result.
- Duration isn't reported. The two runs shared a machine.
- The word count measures what you read. It doesn't measure whether you then had
  to ask a follow-up question, which is the number that actually matters.
- `check.sh` catches banned words, em dashes, and tables. It can't catch a
  preamble, a hedge, or a recap. Those were found by reading every reply.
- `check.sh` also reports false positives. It flagged `Dispatch` in a walkthrough
  of Hono internals, where the word names the `#dispatch` method. Technical names
  are exempt, so every hit needs a human read.

## Next steps

- [Limits](/docs/brevity/limits)
- [Other agents](/docs/brevity/other-agents)
