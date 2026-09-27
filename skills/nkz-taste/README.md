# Taste

A skill for designing and building product UI, for native mobile (iOS-first,
Expo / React Native) and web (products and landing pages).

It works in four layers, in this order:

| Layer | Question |
|---|---|
| Product | Should this exist, and what is its one job? |
| Craft | Does it work for everyone, in every state? |
| Direction | What should it look like, and why this and not the default? |
| Feel | Does it look, behave, and move well? |

A good answer to a later layer cannot rescue a bad answer to an earlier one.

## Install

```
/plugin marketplace add pehcastro/harness
/plugin install nkz-taste@pehcastro
```

Claude loads it on its own when you build, refactor, polish, or review a screen,
component, flow, or page. To call it by name, type `/nkz-taste`.

Other agents (Cursor, Codex, and more) can install the skill alone with the
[skills CLI](https://github.com/vercel-labs/skills):

```
npx skills add pehcastro/harness --skill nkz-taste
```

## What is inside

- `SKILL.md`: the router, the seventeen always-rules, and a blocking pre-flight
  checklist.
- `references/`: product, craft, direction, AI tells, mobile and web design,
  interactions, animations, and the laws behind the rules.
- `styles/`: named styles with exact visual contracts and layout recipes.
  `recess` is the first.

The skill uses your project tokens. It does not invent values inline. When a
rule needs a value your project lacks, it flags it as a new pattern for you to
decide on.

## Licence

MIT.
