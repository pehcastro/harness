# harness

A Claude Code plugin marketplace. Add it once, then install what you want.

**Docs: [harness.nkz.md](https://harness.nkz.md)**

```
/plugin marketplace add pehcastro/harness
```

## Plugins

### [brevity](plugins/brevity)

Makes the agent say less, and say it straight. Short replies, no jargon, no
preamble, no status theater.

```
/plugin install brevity@pehcastro
```

Measured over one 10-turn session, run with and without: 84% fewer words, 59%
fewer output tokens, 31% lower cost. The rules also ship for Cursor, Windsurf,
Cline, Copilot, and anything that reads `AGENTS.md`. See
[plugins/brevity](plugins/brevity) for the numbers and the method.

## Layout

```
.claude-plugin/marketplace.json    the catalog
plugins/<name>/                    one directory per plugin
```

Each plugin holds its own `.claude-plugin/plugin.json`, its own README, and its
own tests.

## Adding a plugin here

Create `plugins/<name>/` with a `.claude-plugin/plugin.json`, then add an entry
to `plugins` in `.claude-plugin/marketplace.json` with
`"source": "./plugins/<name>"`.

Write the path in full. `metadata.pluginRoot` with a bare directory name is in
the docs, but Claude Code 2.1.221 rejects it with "This plugin uses a source type
your Claude Code version does not support".

Check it before you push:

```bash
claude plugin validate ./plugins/<name> --strict
```

## Licence

MIT.
