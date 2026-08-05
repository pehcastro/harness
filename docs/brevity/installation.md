---
title: Installation
description: Install Brevity, verify it loaded, and show the active style in your status line.
order: 2
updated: 2026-08-04
---

Brevity is an output style. Claude Code reads it once, when a session starts, so
installing it changes nothing until you restart or reload.

This page assumes you've already
[added the marketplace](/docs/getting-started/add-the-marketplace).

## Install

````steps
# Install the plugin

The marketplace is named `pehcastro` and the plugin is named `brevity`, which is
why this reads `brevity@pehcastro`.

```
/plugin install brevity@pehcastro
```

# Restart or reload

An output style loads at session start. Until you restart Claude Code or run
`/reload-plugins`, nothing changes.

```
/reload-plugins
```

# Check it worked

```
/plugin list
```

You'll see `brevity@pehcastro` with status `enabled`.
````

There's no `/config` step. Brevity sets `force-for-plugin`, so it applies on its
own once enabled.

> [!DANGER]
> While Brevity is enabled it overrides the `outputStyle` in your settings,
> including Explanatory, Learning, and any custom style you wrote. This is
> tested, not assumed. Disabling the plugin gives your setting back.

## Keeping it updated

Brevity carries no `version` field while its rules are still changing, so its
version is the git commit SHA and every push to the repository is an update.

Updates aren't automatic unless you enable them. To pull the current version:

```
/plugin marketplace update pehcastro
/plugin update brevity@pehcastro
```

Restart afterwards. See
[staying current](/docs/getting-started/add-the-marketplace#staying-current) for
auto-update and why it's off by default.

## Try it without installing

Cloning and pointing Claude Code at the directory lasts one session and writes
nothing to your settings. Use this to evaluate it before committing.

```bash
git clone https://github.com/pehcastro/harness
claude --plugin-dir ./harness/plugins/brevity
```

## Turn it off

Disabling is enough. You don't need to uninstall.

```
/plugin disable brevity@pehcastro
```

## Show the active style in your status line

Nothing in the interface tells you which output style is active. Claude Code
sends `output_style.name` on stdin to every status line command, and most status
lines ignore it.

The plugin ships a wrapper that reads the name and adds it to whatever you
already run. A plugin can't set your status line, so this is opt in.

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

## Using it outside Claude Code

The rules carry no code, so they work in Cursor, Windsurf, Cline, GitHub
Copilot, and anything that reads `AGENTS.md`. See
[other agents](/docs/brevity/other-agents).

## Next steps

- [What Brevity does](/docs/brevity/overview)
- [How it works](/docs/brevity/how-it-works)
- [Limits](/docs/brevity/limits)
