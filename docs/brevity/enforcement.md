---
title: Enforcement
description: How the two hooks work, why an instruction alone is not enough, and what each one costs.
order: 4
updated: 2026-08-07
---

The rules are an instruction. A model can ignore one, and over a long session it
increasingly does. Two hooks exist to push back, and this page explains what
they do and what they cost.

Both are POSIX `sh` and `awk`. There is no node, no jq, and no runtime to
install.

## The problem they solve

An output style sits at the start of the context window. As a session grows, the
distance between it and the current turn grows too, and its pull fades. That is
[system prompt attenuation](https://arxiv.org/html/2605.12922), and it is
measurable: over 72 turns, replies grew about two and a half times from the
first fifth of the session to the last.

The obvious fix is to repeat the rules every turn. That was tried, and it moved
the level down without changing the slope. Replies still grew at the same rate,
just from a lower start.

The reason is that drift isn't forgetting. The model reads its own long replies
from earlier in the transcript and concludes that long replies are normal in this
session. Restating a rule doesn't contradict that, because the model doesn't
believe it broke the rule. It believes 120 words is what a status looks like
here.

## What actually works

Report the measurement instead of the rule.

```
Your last 5 replies averaged 118 words. That is over the caps and rising.
```

That is a fact about the model's own behavior, not another instruction, and it
directly contradicts the belief causing the drift. Over 140 turns this was the
only configuration whose replies did not grow.

## The two hooks

### The reminder, on every turn

Runs on `UserPromptSubmit`, so its text lands next to your newest message where
attention is strongest. It escalates in three steps.

```steps
# Always

Restate the caps. Around 60 tokens.

# When recent replies average over 60 words

Add the measured average, so the model sees what it has been doing.

# When they average over 150 words

Tell it to re-read `rules/core.md`. The rules are already in the system prompt,
but reading the file puts them at the end of the context instead of the start.
This costs a tool call and a few thousand tokens, so it only happens when the
cheaper steps have not worked.
```

The caps in this text are not written by hand. `build.sh` generates
`hooks/reminder.txt` from `rules/core.md`, so there is one source for the rules
and the hook cannot fall out of step with them.

### The linter, after every reply

Runs on `Stop`, which receives the complete text of the reply that was just
written. It counts, rather than judges:

| Check | Threshold |
|---|---|
| Length | over 120 words |
| Em dashes | any |
| Bold phrases | more than 3 |
| Banned status words | any, outside code |
| Stacked metrics | two or more, such as a test count next to a typecheck count |
| Opening by agreeing | first sentence |

When something trips, it returns feedback that Claude must act on, and the reply
gets rewritten. When nothing trips it returns an empty object and adds nothing to
the context, so a compliant turn costs nothing at all.

> [!NOTE]
> Code inside fences is exempt from every check. A snippet containing `landed` or
> a test count will not be flagged.

Two thresholds are deliberately loose:

- **120 words, not the 40 to 80 the rules ask for.** The script cannot see your
  question, so it cannot know whether you asked for depth. The message says to
  keep the length if you did, so a wrong flag costs a sentence rather than the
  answer.
- **Two stacked metrics, not one number.** `5 tests pass` is correct output. A
  scorecard is several metrics piled together.

A linter that is wrong teaches the model to ignore it, so only checks that can be
right belong in it.

## What it costs

Measured over 140 turns, against the same rules with no hooks:

| | rules only | with hooks |
|---|---|---|
| total words | 14364 | 8752 |
| replies over 120 words | 44 | 3 |
| growth across the session | 1.28x | 0.96x |
| cost | $361 | $359 |

The linter fired on 11 turns of 140. On the other 129 it cost nothing.

## Turning them off

The hooks are part of the plugin. To run the rules without them, remove the
`hooks/` directory from your copy, or disable the plugin entirely with
`/plugin disable brevity@pehcastro`.

The rules alone still do most of the work. Rewriting them to use countable caps
was a larger gain than adding either hook.

## Next steps

- [Benchmarks](/docs/brevity/benchmarks)
- [Limits](/docs/brevity/limits)
