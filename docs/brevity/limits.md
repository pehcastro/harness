---
title: Limits and configuration
description: What Brevity cannot do, why it has no settings, and how to show the active style in your status line.
order: 8
updated: 2026-08-07
---

This page covers what Brevity doesn't do. Read it before you install, because
one of these behaviors changes settings you may already care about.

## Configuration

There is none, on purpose.

Claude Code plugins can declare `userConfig`, which prompts you for values when
the plugin is enabled. Those values reach hook commands, MCP and LSP configs,
skills, and agents. They don't reach an output style: `${user_config.KEY}` stays
literal in a style file.

That was verified by putting a plain word in the same position, which the model
obeyed, and then the substitution form, which it didn't.

So a setting could be stored, but nothing would read it. The only real choice
would be which style you select, and `force-for-plugin` overrides that
selection. Brevity ships as one style, always on, with nothing to configure.

If you want a variant, such as the banned words without the Simplified Technical
English rules, edit `plugins/brevity/rules/core.md` and run `./build.sh`.

## It overrides your output style

> [!DANGER]
> While Brevity is enabled it overrides the `outputStyle` in your settings,
> including Explanatory, Learning, and any custom style you wrote. This is
> tested, not assumed.

Disabling the plugin gives your setting back:

```
/plugin disable brevity@pehcastro
```

## Limits that apply everywhere

These hold regardless of which agent you run the rules in.

- The rules are an instruction to a language model, not a filter on its output.
  A model can ignore them. The [benchmarks](/docs/brevity/benchmarks) measure how
  often it doesn't.
- Code, command output, error text, and quotations are exempt.
- A confirmation before an irreversible action is exempt. The rules don't
  suppress that question.
- The corpus of worked examples loads on demand in Claude Code only. On other
  agents you get the rules without the examples.

## Limits specific to Claude Code

Two behaviors come from how Claude Code loads an output style.

The style reaches the main conversation only. Claude Code gives a subagent its
own system prompt, so the style doesn't load there. Brevity handles this by
telling the main agent to paste a short rule block into any subagent prompt whose
output a person will read, and to rewrite a subagent's result rather than paste
it. That's an instruction, not a guarantee.

The style also loads once, at session start. Changing it needs `/clear` or a new
session.

## Reply length still grows

Over a long session replies get longer, and no version of this plugin stops that
completely. Measured over 140 turns, the rules alone grew 1.28x from the first
fifth to the last. With the hooks reporting the model its own recent average, the
figure was 0.96x, which is flat within the noise of a single run.

So the rules decide where the climb starts, and the hooks flatten it. Neither
removes it. On a very long session, expect replies to be longer at the end than
at the beginning.

## Untested areas

Being explicit about what hasn't been checked is more useful than implying
everything has.

- Behaviour after a context compaction. Sessions up to 140 turns are measured,
  but not what a compaction does to the rules.
- Every result is one run per arm. The same configuration drifted 2.62x over 72
  turns and 1.28x over 140, so trust the ordering of the arms rather than any
  single number.
- Plan mode. Plans are structured by nature, and the rules push against
  structure.
- Whether short replies become annoying in daily use. The benchmarks count
  words, not whether you had to ask a follow-up.
- The Cursor, Windsurf, Cline, and Copilot files. Generated and format-checked,
  never loaded in those tools.

## Next steps

- [Benchmarks](/docs/brevity/benchmarks)
- [Other agents](/docs/brevity/other-agents)
