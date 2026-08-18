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
| Stacked metrics | two or more, such as a test count beside a typecheck count |
| Opening by agreeing | first sentence |

It does not ask for a rewrite, and cannot. Assistant text streams to the
terminal as it is produced, so by the time a `Stop` hook runs you have already
read the reply. `MessageDisplay` is the only event that sees assistant text and
the documentation calls it display-only. Nothing can suppress or replace a reply
once it exists.

An earlier version returned the verdict from the hook, and the result was two
replies on screen: the long one, the hook's complaint, then a slightly shorter
one. Measured on a real session, that made those turns 139% longer to read while
the rewrite came out only 5% shorter. Worse than leaving the first alone.

So the verdict goes into the shared state file instead, and the reminder
delivers it with your next prompt:

```
Your last reply broke a rule a machine counts: it ran 139 words, past
the caps; it used banned status words: landed. Do not rewrite it and do
not mention it, the reader has already read it.
```

The correction arrives one turn late, before the next reply is written rather
than after the last one was read. The hook itself always returns an empty object
and adds nothing to the context.

> [!NOTE]
> Code inside fences is exempt from every check. A snippet containing `landed`
> or a test count is not flagged.

Two thresholds are deliberately loose:

- **120 words, not the 40 to 80 the rules ask for.** The script cannot see your
  question, so it cannot know whether you asked for depth. The verdict says so.
- **Two stacked metrics, not one number.** `5 tests pass` is correct output. A
  scorecard is several metrics piled together.

A linter that is wrong teaches the model to ignore it, so only checks that can
be right belong in it.

## What it costs

Measured over 140 turns, against the same rules with no hooks:

| | rules only | static reminder | reminder + linter |
|---|---|---|---|
| words the reader sees | 14364 | 10957 | 12008 |
| growth across the session | 1.28x | 1.21x | 0.96x |

Read those two rows together. The third arm produced the flattest session and
still put more words on screen, because that build returned the verdict from the
`Stop` hook and every flagged turn showed a second reply. The linter fired 11
times and cost about 3250 words to do it.

The linter no longer does that, so neither number describes the current build.
What carries over is the finding underneath: the reminder is worth its tokens,
and a rewrite after the fact is not.

The hook now returns an empty object on every turn, so it costs nothing at all.

## Turning them off

The hooks are part of the plugin. To run the rules without them, remove the
`hooks/` directory from your copy, or disable the plugin entirely with
`/plugin disable brevity@pehcastro`.

The rules alone still do most of the work. Rewriting them to use countable caps
was a larger gain than adding either hook.

## Next steps

- [Benchmarks](/docs/brevity/benchmarks)
- [Limits](/docs/brevity/limits)
