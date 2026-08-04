---
title: Installation
description: Add the harness marketplace to Claude Code and install a plugin.
order: 2
updated: 2026-08-04
---

Adding a marketplace registers the catalog so you can browse it. It doesn't
install anything on its own. You then install the plugins you want, one at a
time.

## Add the marketplace and install Brevity

````steps
# Add the marketplace

Run this inside Claude Code. It registers the catalog and installs nothing yet.

```
/plugin marketplace add pehcastro/harness
```

# Install the plugin

The marketplace is named `pehcastro` and the plugin is named `brevity`, which is
why the install reads `brevity@pehcastro`.

```
/plugin install brevity@pehcastro
```

# Restart

An output style loads once, when a session starts. Restart Claude Code, or run
`/reload-plugins`, before you see any change.

# Check it worked

```
/plugin list
```

You should see `brevity@pehcastro` with status `enabled`.
````

## Try it without installing

Clone the repository and point Claude Code at the plugin directory. This lasts
for one session and writes nothing to your settings.

```bash
git clone https://github.com/pehcastro/harness
claude --plugin-dir ./harness/plugins/brevity
```

## Turning a plugin off

Disabling is enough. You don't need to uninstall.

```
/plugin disable brevity@pehcastro
```

> [!WARNING]
> Brevity sets `force-for-plugin`, so while it's enabled it overrides the
> `outputStyle` in your own settings, including Explanatory, Learning, and any
> custom style you wrote. Disabling the plugin gives your setting back. See
> [limits](/brevity/limits).

## If the install fails

The marketplace catalog can go stale. Refresh it, then install again.

```
/plugin marketplace update pehcastro
```

If Claude Code reports that `/plugin` isn't available, your version is too old.
Check it with `claude --version`.

## Next steps

- [What Brevity does](/brevity/overview)
- [How it works](/brevity/how-it-works)
- [Add your own plugin](/marketplace/adding-a-plugin)
