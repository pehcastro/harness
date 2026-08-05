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

[Docs](https://harness.nkz.md/docs/brevity/overview) ·
[Installation](https://harness.nkz.md/docs/brevity/installation) ·
[Benchmarks](https://harness.nkz.md/docs/brevity/benchmarks)

Measured over one 10-turn session, run with and without: 84% fewer words, 59%
fewer output tokens, 31% lower cost. The rules also ship for Cursor, Windsurf,
Cline, Copilot, and anything that reads `AGENTS.md`. See
[plugins/brevity](plugins/brevity) for the numbers and the method.

## Staying current

Auto-update is off for this marketplace until you turn it on. Claude Code
defaults every third-party marketplace to off, and nothing a plugin author
writes can change that for you.

To update by hand:

```
/plugin marketplace update pehcastro
/plugin update <plugin>@pehcastro
```

To enable background updates, add `"autoUpdate": true` beside `source` in your
`extraKnownMarketplaces` entry, or use `/plugin` and pick **Enable auto-update**
on the Marketplaces tab. See
[staying current](https://harness.nkz.md/docs/getting-started/add-the-marketplace#staying-current).

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
