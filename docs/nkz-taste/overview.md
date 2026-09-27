---
title: What Taste does
description: A skill for designing and building product UI on native mobile and web.
order: 1
updated: 2026-09-27
---

Taste is a skill for UI work on native mobile (iOS-first, Expo / React Native)
and web (products and landing pages). Claude loads it when you build, refactor,
polish, or review a screen, component, flow, or page.

## Install

```bash
/plugin marketplace add pehcastro/harness
/plugin install nkz-taste@pehcastro
```

To call it by name, type `/nkz-taste`.

Other agents (Cursor, Codex, and more) can install the skill alone with the
[skills CLI](https://github.com/vercel-labs/skills):

```
npx skills add pehcastro/harness --skill nkz-taste
```

## Four layers

The skill answers four questions, in this order. A good answer to a later
question cannot rescue a bad answer to an earlier one.

| Layer | Question |
|---|---|
| Product | Should this exist, and what is its one job? |
| Craft | Does it work for everyone, in every state? |
| Direction | What should it look like, and why this and not the default? |
| Feel | Does it look, behave, and move well? |

Most UI work fails at Product and gets polished at Feel. The skill starts at
Product.

## What it enforces

- Seventeen always-rules that apply to every surface on every platform.
- A blocking pre-flight checklist: four states per data view, contrast, target
  sizes, keyboard access, motion limits.
- Tokens only. When a rule needs a value your project lacks, the skill flags it
  as a new pattern and lets you decide.

## Styles

A named style is an exact visual contract plus layout recipes. Selecting one
lets the skill install its tokens centrally. `recess` is the first style.
