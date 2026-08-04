---
title: Adding a plugin
description: How to add a new plugin to the harness marketplace, and the gotchas worth knowing first.
order: 1
updated: 2026-08-04
---

A plugin is a directory under `plugins/` with a manifest. Adding one means
creating that directory and listing it in the catalog.

## Repository layout

```
.claude-plugin/marketplace.json    the catalog
plugins/<name>/                    one directory per plugin
  .claude-plugin/plugin.json       the manifest
  README.md
docs/                              this site
petit.config.json
```

## Add one

````steps
# Create the directory

```bash
mkdir -p plugins/my-plugin/.claude-plugin
```

# Write the manifest

Save this as `plugins/my-plugin/.claude-plugin/plugin.json`.

```json
{
  "name": "my-plugin",
  "displayName": "My plugin",
  "description": "One sentence shown in the plugin browser.",
  "version": "0.1.0",
  "author": { "name": "pehcastro", "url": "https://github.com/pehcastro" },
  "license": "MIT"
}
```

# Add the components

Put them at the plugin root, not inside `.claude-plugin/`. Claude Code discovers
`skills/`, `agents/`, `hooks/hooks.json`, `output-styles/`, and `commands/`
automatically.

# List it in the catalog

Add an entry to `plugins` in `.claude-plugin/marketplace.json`.

```json
{
  "name": "my-plugin",
  "source": "./plugins/my-plugin",
  "description": "One sentence shown in the plugin browser.",
  "version": "0.1.0"
}
```

# Validate before pushing

```bash
claude plugin validate ./plugins/my-plugin --strict
```

You want `✔ Validation passed`.

# Test the install

```bash
claude plugin marketplace add .
claude plugin install my-plugin@pehcastro
```
````

## Gotchas

These cost time when you hit them without warning.

```accordion
# Write the source path in full

The documentation says `metadata.pluginRoot` lets you write a bare directory
name as the source. Claude Code 2.1.221 rejects that:

  ✘ This plugin uses a source type your Claude Code version does not support.

Write `"source": "./plugins/my-plugin"` instead. That works.

# Only plugin.json goes in .claude-plugin

Every other directory belongs at the plugin root. Putting `skills/` inside
`.claude-plugin/` means Claude Code never finds it.

# Set an explicit version

Without a `version`, the plugin is pinned to the git commit SHA, so every commit
counts as a new version for everyone who installed it. Set the field and bump it
deliberately.

# Test in a throwaway config

Installing writes to your real settings. To test without touching them, point
`CLAUDE_CONFIG_DIR` somewhere temporary first. Note that a fresh config has no
credentials, so you can install and list, but you can't run a session.

# force-for-plugin overrides the user

An output style with `force-for-plugin: true` overrides whatever `outputStyle`
the user chose, with no warning at install time. Use it only when the plugin
exists to change output, and document it.
```

## Documenting it here

Each plugin gets its own category in the sidebar. Create `docs/<plugin>/` and
add an entry to `sidebar` in `petit.config.json`:

```json
{ "label": "My plugin", "path": "./docs/my-plugin" }
```

Follow the page order Brevity uses: what it does, how it works, reference,
benchmarks, limits. Set `order` in each page's frontmatter to control the
sidebar sequence.

## Testing claims before you publish them

If a page claims a number, a harness in the repository should produce it.
Brevity's lives in `plugins/brevity/evals` and is worth copying: a prompt list, a
runner that executes both arms with `--setting-sources project,local` so no other
plugin interferes, and a checker.

> [!TIP]
> Write scenarios where your plugin could cause harm, not only where it looks
> good. Brevity's hard suite found three real defects, and two of them became
> rules.

## Next steps

- [What Brevity does](/brevity/overview), as a worked example
- [Benchmarks](/brevity/benchmarks) for the testing approach
