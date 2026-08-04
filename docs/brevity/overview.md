---
title: What Brevity does
description: An output style that makes Claude Code say less and say it straight.
order: 1
updated: 2026-08-04
---

Brevity changes how a coding agent talks to you. It doesn't change what the
agent does, what it decides, or how it writes code. It changes how much text
surrounds the answer.

Ask it to fix something and you get `Yes, fixing.` rather than a plan, four
headings, a table, and a summary of what you both just discussed.

## The difference

Both replies below come from the same prompt, the same model, and the same
project. The only difference is the plugin. Both made the identical code change
and both ran the tests.

```tabs
# Without Brevity

138 words.

Fixed and verified — 5/5 tests pass.

Changes in `src/app.ts`:
- `GET /users/:id` miss → `{error:'not found'}` (was `'user not found'`)
- Added `app.notFound()` → `{error:'not found'}` with 404, which replaces
  Hono's default plain-text `404 Not Found` for every unmatched path

In `src/app.test.ts`: updated the miss assertion, added a body assertion to the
`/users/` case, and added a new test for an arbitrary unmatched route.

Note that the two 404s are now indistinguishable to a client, and a further
paragraph of design advice nobody asked for.

# With Brevity

3 words.

5 tests pass.
```

## What you get

Measured over one 10-turn session, run twice with the same prompts and model.
The full method is in [benchmarks](/brevity/benchmarks).

| | Without | With | Change |
|---|---|---|---|
| Words written to you | 2167 | 346 | 84% fewer |
| Output tokens | 15682 | 6345 | 59% fewer |
| Context re-read per turn | 976478 | 767873 | 21% less |
| Cost for the session | $1.2094 | $0.8277 | 31% lower |

The context saving is the one that grows. Short replies make a short transcript,
and every later turn re-reads that transcript, so a long session saves more than
a short one.

## What it removes

```accordion
# Length

The default reply is one to three sentences. A longer reply needs a reason: you
asked for detail, you have to choose between options, or the answer is a list of
facts you need. "The work was hard" is not a reason.

# Jargon

93 terms never appear. `landed`, `shipped`, `dispatched`, `surfaced`,
`unblocks`, `in flight`, `green`, `end to end`, `north star`, `source of truth`,
`deep dive`, `leverage`, `robust`, `seamless`, and the rest. Each has a plain
replacement.

# Openers and closers

No "Great question." No "You're absolutely right." No "Let me know if you'd like
me to." No "Happy to help."

# Seventeen behaviors

Acknowledging the request, announcing tool calls, restating tool output,
recapping work you watched, praising its own subagents, printing test-count
scorecards, reporting that it's waiting, and offering follow-up work you didn't
ask for.
```

## What it keeps

The first rule in the file exists to stop the other rules going too far. A short
answer that makes you ask a second question is a failure, not a success.

The rules protect the location, the cause, the number you need, the constraint,
the next blocker, what changed, and the decision you have to make.

> [!WARNING]
> Confirmation before an irreversible action is explicitly exempt. Brevity will
> not shorten a delete, a force push, or a publish into silent compliance. This
> is tested. See [benchmarks](/brevity/benchmarks#hard-scenarios).

## Where the rules came from

The rules aren't a list of AI tells assembled from guesswork. They're derived
from 154 pairs of real Claude Code output, each with its correction written
beside it, collected over months of sessions.

That origin is why the rule set contains categories no general writing guide
has, such as "do not praise your own subagent" and "do not print a scorecard."

## Next steps

```cards
# How it works
The three layers, and the order they apply in.
/brevity/how-it-works

# The rules
Every banned word and behavior.
/brevity/rules

# Benchmarks
The method, the numbers, and what the tests found.
/brevity/benchmarks

# Other agents
Cursor, Windsurf, Cline, Copilot, and AGENTS.md.
/brevity/other-agents
```
