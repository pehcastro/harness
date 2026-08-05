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
/brevity/installation
```

## Keeping the catalog current

Claude Code caches the catalog. If an install reports that a plugin isn't found,
refresh it and try again:

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

- [Install Brevity](/brevity/installation)
- [What Brevity does](/brevity/overview)
- [Add your own plugin](/marketplace/adding-a-plugin)
