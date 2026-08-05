# Changelog

Versioned by commit SHA while the rules are still changing, so every push is an
update. An explicit version returns at 1.0.0 once they settle.

## Unreleased

### Added

- `CHANGELOG.md`.

### Changed

- Version is the git commit SHA rather than a pinned `0.1.0`. Pinning meant a
  pushed rule fix reached nobody, because Claude Code uses the version string as
  its cache key.

## 0.1.0

First working version.

### Rules

- 93 banned terms across status words, consultant words, self-praise, openers,
  closers and hedges.
- 17 banned behaviors, from preamble through to unrequested offers.
- ASD-STE100 Simplified Technical English for replies longer than about three
  sentences.
- `WARNING`, `CAUTION` and `NOTE` replace softened warnings. `CAUTION` is
  mandatory before anything that cannot be undone.
- Three rules protect information from the cutting rules: keep the information,
  say what you changed, and correct a wrong premise before acting on it.

### Packaging

- Claude Code output style with `force-for-plugin`, so it applies without a
  `/config` step.
- Generated rule files for Cursor, Windsurf, Cline, GitHub Copilot and
  `AGENTS.md`, all built from `rules/core.md` by `build.sh`.
- A corpus skill holding 154 worked examples, loaded on demand rather than every
  turn.
- An optional POSIX `sh` status line wrapper that shows the active output style.

### Tested

- A 10-turn session measured with and without the plugin: 84% fewer words, 59%
  fewer output tokens, 31% lower cost.
- A hard suite of 10 scenarios where the rules could do harm rather than save
  words. It found the em dash rule failing on list labels, and the two missing
  rules about changes and wrong premises.
