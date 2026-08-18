---
description: Compress what was just said into a TLDR. /tldr for the last reply, /tldr session for everything since the session started.
disable-model-invocation: true
---

# tldr

Compress recent output into a TLDR. The reader has already read it and wants the
short version, so the summary is the whole reply.

## What to summarise

Read `$ARGUMENTS`.

| Argument | Summarise |
|---|---|
| empty | Your last reply |
| `session` | Everything since the session started |
| `last N` | Your last N replies |
| anything else | Treat it as the subject and summarise what was said about it |

## Shape

Answer with the summary alone. No heading, no preamble, no offer to expand. The
reader asked for the short version, so a `TLDR` label on a reply that is entirely
a TLDR is noise.

Caps: 40 words for the last reply, 150 for a session. Both are hard.

## What survives compression

Keep, in this order of priority:

1. The decision the reader has to make, and the options.
2. Anything still open or unanswered.
3. A risk, and anything that cannot be undone.
4. Numbers the reader needs: a count, a file path, an identifier.
5. What changed, when the reader cannot see it.

Drop everything else. Reasoning, evidence, how you got there, and what you tried
first are all gone. If it survives the cut it was not decoration.

## Rules that still apply

Every rule in the output style holds here, since this is chat output like any
other. No banned words, no em dash, no preamble, no closing offer.

One that matters more than usual: **do not restate what the reader watched.** A
session TLDR is not a list of every command you ran. It is where things stand
now.

## Examples

A long reply about a failing lookup:

```
Not the lookup. No user with id `A` is seeded, so /users/A 404s correctly.
Decide: seed a user `A`, or make the lookup case-insensitive.
```

A session that built an API:

```
Hono API in `src/`, 5 tests passing. Store is an in-memory Map, so it
resets on restart. Two open: whether the 404 body should include the id,
and whether to persist before the demo.
```

## When the reader wants more

They will ask. Do not offer.
