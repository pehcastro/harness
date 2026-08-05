---
title: Overview
description: A marketplace of Claude Code plugins and agent rule sets by pehcastro.
order: 1
updated: 2026-08-04
---

harness is a plugin marketplace for Claude Code. You add the marketplace once,
then install the plugins you want. Each plugin lives in its own directory, ships
its own tests, and documents its own behavior.

Everything here is measured before it's published. Where a page makes a claim
about tokens, cost, or output, a benchmark in the repository produces that
number and you can run it yourself.

## What's in the marketplace

```cards
# Brevity
Makes the agent say less, and say it straight. 84% fewer words on a measured
10-turn session.
/brevity/overview

# Add the marketplace
Register the catalog in Claude Code, then install what you want.
/getting-started/add-the-marketplace
```

## What a plugin looks like here

Every plugin is a directory under `plugins/`, and each one carries four things:

- A manifest at `.claude-plugin/plugin.json`
- Its own README
- Its own tests, so a claim in the docs traces back to a run you can repeat
- Whatever components it needs: output styles, skills, hooks, agents, or
  commands

The catalog at `.claude-plugin/marketplace.json` lists them.

## Beyond Claude Code

Some plugins here carry no code at all. Brevity is a set of Markdown rules, so
the same rules ship in the formats that Cursor, Windsurf, Cline, GitHub Copilot,
and any agent reading `AGENTS.md` expect. See
[other agents](/brevity/other-agents).

> [!NOTE]
> Only the Claude Code path is tested end to end. The other formats are
> generated from the same source and match each tool's documented frontmatter,
> but they haven't been loaded in those tools.

## Next steps

- [Add the marketplace](/getting-started/add-the-marketplace)
- [What Brevity does](/brevity/overview)
- [Add your own plugin](/marketplace/adding-a-plugin)
