---
title: Add the marketplace
description: Register the harness catalog in Claude Code so you can install plugins from it.
order: 2
updated: 2026-08-04
---

Adding a marketplace registers the catalog so Claude Code can see what's in it.
It installs nothing on its own. You do this once, then install plugins
individually whenever you want them.

## Register the catalog

Run this inside Claude Code:

```
/plugin marketplace add pehcastro/harness
```

Confirm it registered:

```
/plugin marketplace list
```

You'll see `pehcastro` in the list. That's the marketplace name, and it's what
you type after the `@` when installing anything from here.

> [!NOTE]
> The marketplace is named `pehcastro` while the repository is named `harness`.
> A marketplace name is an identifier rather than a repository name, so one
> repository can hold many plugins under a single name.

## Then install what you want

Each plugin has its own installation page, because each one has its own setup
steps and its own warnings.

```cards
# Brevity
Makes the agent say less, and say it straight. Bans jargon, preamble, and status
theater.
/docs/brevity/installation
```

## Staying current

Updates don't arrive on their own. Auto-update is off for this marketplace until
you turn it on, because Claude Code defaults every third-party marketplace to
off and only Anthropic's own marketplaces to on.

That default is a trust boundary. A marketplace is code from someone else's
repository, so nothing a plugin author writes in `marketplace.json` or
`plugin.json` can enable background updates for you. It's your decision to make.

### Update by hand

Two commands, and you know exactly which version you're on:

```
/plugin marketplace update pehcastro
/plugin update brevity@pehcastro
```

Then restart Claude Code. `/plugin list` shows the version you're running.

Use this while you're following a plugin closely, because it's immediate and
predictable.

### Or turn on auto-update

Through the interface:

```
/plugin → Marketplaces → pehcastro → Enable auto-update
```

Or add one field to your `~/.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "pehcastro": {
      "source": { "source": "github", "repo": "pehcastro/harness" },
      "autoUpdate": true
    }
  }
}
```

> [!NOTE]
> Auto-update runs after a session starts, with a random delay of up to ten
> minutes, and never applies mid-session. You'll either get a prompt to run
> `/reload-plugins` or the new version loads next launch. If you need a specific
> version right now, update by hand instead.

To turn off every automatic update, including Claude Code's own, set the
`DISABLE_AUTOUPDATER` environment variable. To keep plugin updates while
stopping Claude Code from updating itself, set `FORCE_AUTOUPDATE_PLUGINS=1`
alongside it.

### How versions are decided

Brevity has no `version` field while its rules are still changing, so its
version is the git commit SHA and every push counts as an update. A plugin that
pins an explicit version only updates when its author bumps that field.

```
Version: ed6c2d82dc30
```

### If an install says the plugin isn't found

Your copy of the catalog is stale. Refresh it, then install again:

```
/plugin marketplace update pehcastro
```

## Removing the marketplace

> [!WARNING]
> Removing a marketplace uninstalls every plugin you installed from it.

```
/plugin marketplace remove pehcastro
```

## If `/plugin` isn't recognized

Your Claude Code version is too old to have the plugin system. Check it:

```bash
claude --version
```

## Next steps

- [Install Brevity](/docs/brevity/installation)
- [What Brevity does](/docs/brevity/overview)
- [Add your own plugin](/docs/marketplace/adding-a-plugin)
