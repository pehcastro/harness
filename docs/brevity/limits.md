---
title: Limits and configuration
description: What Brevity cannot do, why it has no settings, and how to show the active style in your status line.
order: 6
updated: 2026-08-04
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
  A model can ignore them. The [benchmarks](/brevity/benchmarks) measure how
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

## Untested areas

Being explicit about what hasn't been checked is more useful than implying
everything has.

- Sessions longer than 11 turns. Drift after 30 or more turns, or after a
  context compaction, isn't measured.
- Plan mode. Plans are structured by nature, and the rules push against
  structure.
- Whether short replies become annoying in daily use. The benchmarks count
  words, not whether you had to ask a follow-up.
- The Cursor, Windsurf, Cline, and Copilot files. Generated and format-checked,
  never loaded in those tools.

## Show the active style in your status line

Claude Code sends `output_style.name` on stdin to every status line command, and
most status lines ignore it. The plugin ships a wrapper that reads the name and
adds it to whatever you already run.

A plugin can't set your status line, so this is opt in.

```tabs
# No status line yet

Add this to `~/.claude/settings.json`:

  "statusLine": {
    "type": "command",
    "command": "sh /path/to/harness/plugins/brevity/statusline/with-style.sh"
  }

Output:

  style: Brevity

# You already have one

Put your existing command after the `--` separator:

  "statusLine": {
    "type": "command",
    "command": "sh /path/to/harness/plugins/brevity/statusline/with-style.sh --prefix --label 'output mode: ' -- 'your existing command'"
  }

Output:

  output mode: Brevity
  [Opus 5] harness git:(main) | Context 22% | Usage 4%
```

The script passes the same JSON through to your command on stdin, so nothing you
already display is lost. It drops your command's stderr, because a status line
that prints errors corrupts the display.

| Option | Effect |
|---|---|
| `--prefix` | Put the style above your status line instead of below |
| `--label X` | Text before the name. Default is `style: ` |
| `--hide-default` | Print nothing while the style is Default |

The script is POSIX `sh` and parses the name with `sed`. Claude Code ships as a
binary and its installer doesn't put node on your `PATH`, so the plugin assumes
no runtime.

## Next steps

- [Benchmarks](/brevity/benchmarks)
- [Other agents](/brevity/other-agents)
