---
title: The tldr command
description: Compress the last reply, or the whole session, into a summary you can act on.
order: 5
updated: 2026-08-07
---

Sometimes a reply is long because you asked for depth, and once you have read it
you want the short version to keep. `tldr` gives you that.

This is different from the [TLDR rule](/docs/brevity/rules), which makes a long
reply end with its own summary. The rule is automatic. The command is something
you ask for, after the fact, on whatever you choose.

## Use it

```
/brevity:tldr
```

| Argument | Summarises |
|---|---|
| none | The last reply |
| `session` | Everything since the session started |
| `last 3` | The last three replies |
| anything else | Treats it as a subject and summarises what was said about it |

The reply is the summary alone. No heading, no preamble, no offer to expand,
because a `TLDR` label on something that is entirely a TLDR is noise.

Caps are hard: 40 words for a single reply, 150 for a session.

## What survives

Compression keeps these, in this order:

1. The decision you have to make, and the options.
2. Anything still open.
3. A risk, and anything that cannot be undone.
4. Numbers you need: a count, a file path, an identifier.
5. What changed, when you cannot see it.

Everything else goes. Reasoning, evidence, and what was tried first are all
dropped. A session summary is where things stand now, not a list of the commands
that were run.

## Example

A 1633-word explanation of HTTP caching, compressed:

```
Freshness decides if the cache answers with no request. Validation decides
how cheap the check is when freshness ends. `max-age` covers all caches,
`s-maxage` covers shared ones and wins there. Hash asset filenames, give
them `max-age=31536000, immutable`, put `no-cache` plus an ETag on the HTML,
and declare `Vary` for anything that changes the body.
```

## Getting the shorter name

Claude Code namespaces every command a plugin provides, so the plugin can only
give you `/brevity:tldr`. The namespace comes from the plugin name and cannot be
turned off.

For a plain `/tldr`, copy the file into your own commands directory. Commands you
own are not namespaced.

```tabs
# Everywhere

Copy it once and it works in every project.

  mkdir -p ~/.claude/commands
  cp <clone>/plugins/brevity/commands/tldr.md ~/.claude/commands/

# One project

Copy it into the repository instead, and it travels with the project for
everyone who clones it.

  mkdir -p .claude/commands
  cp <clone>/plugins/brevity/commands/tldr.md .claude/commands/
```

> [!NOTE]
> The copy is a snapshot. Updating the plugin does not update it, so copy it
> again after an update if the command changes.

## Next steps

- [The rules](/docs/brevity/rules)
- [Enforcement](/docs/brevity/enforcement)
