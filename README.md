# Brevity

A rule set that changes how an AI coding agent talks to you in the chat.

It ships for Claude Code, Cursor, Windsurf, Cline, GitHub Copilot, and anything
that reads `AGENTS.md`, which includes Codex. The rules are plain Markdown and
carry no code, so they work in any agent that accepts a system prompt or a rules
file. The benchmark below was measured on Claude Code.

Ask "can you fix this issue for me?" and you get:

```
Yes, fixing.
```

Not a plan, not four headings, not a table, not a summary of what was just
discussed.

## What it does

**Cuts the length.** Default reply is 1 to 3 sentences. A long reply needs a
reason, and "the work was hard" is not one.

**Bans jargon.** About 90 words never appear: `landed`, `shipped`,
`dispatched`, `surfaced`, `unblocks`, `in flight`, `green`, `end to end`,
`north star`, `source of truth`, `deep dive`, `leverage`, `robust`, `seamless`,
and the rest. Each has a plain replacement.

**Bans the openers and closers.** No "Great question". No "You're absolutely
right". No "Let me know if you'd like me to". No "Happy to help".

**Bans 17 behaviors** that produce text carrying no information: acknowledging
the request, announcing tool calls, restating tool output, recapping work you
watched, praising its own subagents, printing test-count scorecards, reporting
that it is waiting, offering unrequested follow-up work.

**Applies Simplified Technical English** when a reply does have to run long.
Active voice, one meaning per word, 20 words per sentence, complete sentences.

**Keeps the information.** The first rule in the file stops overcorrection. A
short answer that makes you ask again is a failure.

## Proof

One 10-turn Claude Code session, run twice with the same prompts and the same
model. Build a Hono API, install it, test it, fix it, explain it, summarize it.
Full method and per-turn numbers in [`evals/`](evals/).

| | without | with | change |
|---|---|---|---|
| Words written to you | 2167 | 346 | **-84%** |
| Output tokens | 15682 | 6345 | **-59%** |
| Context re-read per turn | 976478 | 767873 | **-21%** |
| Cost for the session | $1.2094 | $0.8277 | **-31%** |
| Em dashes | 52 | 0 | |
| Decorative tables | 10 | 0 | |
| Banned words | 2 | 0 | |

The style adds about 2900 tokens to the system prompt, plus 88 for the corpus
skill listing. The numbers above are
net of that cost.

The context saving compounds. Short replies make a short transcript, and every
later turn re-reads the transcript.

Turn 6 of that session was a one-line fix to a 404 body. Both runs made the same
change and both ran the tests.

```
without   Fixed and verified — 5/5 tests pass.
          [a diff, a test summary, and a paragraph of design advice
           nobody asked for]                                138 words

with      5 tests pass.                                       3 words
```

The rules rarely change the answer. They change how much text surrounds it.

## Install

```bash
git clone https://github.com/pehcastro/brevity
```

Then pick your agent.

### Claude Code

```bash
claude --plugin-dir ./brevity
```

The style applies on its own. You do not pick it in `/config`. Every session with
the plugin enabled starts with the style on. Turn it off with
`/plugin disable brevity`.

CAUTION: the plugin sets `force-for-plugin`, so while it is enabled it overrides
the `outputStyle` in your own settings, including Explanatory, Learning, and any
custom style. This is tested, not assumed. Disable the plugin to get your setting
back.

### Configuration

There is none, on purpose.

Claude Code plugins can declare `userConfig` and prompt the user for values at
enable time. Those values reach hook commands, MCP and LSP configs, skills and
agents. They do not reach an output style: `${user_config.KEY}` stays literal in
a style file. Tested by substituting a plain word in the same position, which
worked.

So a setting could be stored but nothing would read it. The only real choice
would be which style the user selects, and `force-for-plugin` overrides that
selection. Brevity is one style, always on, with nothing to configure.

If you want a variant, such as the banned words without the Simplified Technical
English rules, edit `rules/core.md` and run `./build.sh`.

### Cursor

```bash
cp brevity/adapters/cursor/brevity.mdc  <your-project>/.cursor/rules/
```

The file sets `alwaysApply: true`.

### Windsurf

```bash
cp brevity/adapters/windsurf/brevity.md  <your-project>/.windsurf/rules/
```

The file sets `trigger: always_on`.

### Cline

```bash
cp brevity/adapters/cline/brevity.md  <your-project>/.clinerules/
```

### GitHub Copilot

```bash
cp brevity/adapters/copilot/copilot-instructions.md  <your-project>/.github/
```

### Codex, Amp, and anything that reads AGENTS.md

```bash
cp brevity/adapters/agents/AGENTS.md  <your-project>/
```

Append it instead if you already have an `AGENTS.md`.

### Any other agent

`rules/core.md` is the rules with no wrapper. Paste it into whatever your agent
accepts: a system prompt, a custom instruction box, a rules file. It is plain
Markdown and runs nothing.

### See which output style is active

Claude Code only. Other agents have no equivalent.

A plugin cannot set your status line, so this is opt in. `statusline/with-style.sh`
reads the active style and adds it to whatever status line you already run.

If you have no status line yet, add this to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "sh /path/to/brevity/statusline/with-style.sh"
  }
}
```

```
style: Brevity
```

If you already run one, such as claude-hud, put your current command after `--`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "sh /path/to/brevity/statusline/with-style.sh --prefix --label 'output mode: ' -- 'your existing command here'"
  }
}
```

```
output mode: Brevity
[Opus 5] brevity git:(main) | Context 22% | Usage 4%
```

The script passes the same JSON through to your command on stdin, so nothing you
already display is lost.

| Option | Effect |
|---|---|
| `--prefix` | Put the style above your status line instead of below |
| `--label X` | Text before the name. Default `style: ` |
| `--hide-default` | Print nothing while the style is Default |

Claude Code sends `output_style.name` on stdin to every status line command, so
this works for any style, not only this one.

## What is in here

```
rules/core.md                 the rules. The only file you edit.
build.sh                      generates every format below from rules/core.md.

output-styles/brevity.md      Claude Code
adapters/agents/AGENTS.md     Codex, Amp, and others
adapters/cursor/*.mdc         Cursor
adapters/windsurf/*.md        Windsurf
adapters/cline/*.md           Cline
adapters/copilot/*.md         GitHub Copilot

skills/corpus/reference.md    ~150 worked bad/good examples. Claude Code loads
                              this on demand, not every turn.
skills/corpus/CHANGES.md      what the audit changed and why.
reference.md                  the original unaudited collection.
evals/                        the benchmark harness. Runs are not committed.
statusline/with-style.sh      optional: show the active style in your status line.
```

Edit `rules/core.md`, run `./build.sh`, and every harness format regenerates.
Do not edit the generated files; the next build overwrites them.

The rules are always in context. The corpus is not. Claude Code loads it only
when a reply is about to go wrong. Other agents have no equivalent, so on those
you get the rules alone.

## Where the rules came from

The corpus is real Claude Code output, collected over months of sessions, with
the correction written next to it. It is not a list of AI tells invented from
guesswork. That is why it contains categories no generic writing guide has, such
as "do not praise your own subagent" and "do not print a scorecard".

The original collection had a flaw: it only fixed the `Bad` column. Jargon
survived into the `Good` column. `The hang is in the pacing sleep` was the
corrected version, and it is still three jargon words. The audit rewrote the
`Good` column against the banned list. `CHANGES.md` records every line.

## Simplified Technical English

The long-message rules come from ASD-STE100, a controlled-English standard used
in aerospace maintenance documentation. 53 writing rules, about 900 approved
words.

This plugin paraphrases the writing rules. It does not include the dictionary.
The dictionary is copyright ASD, Brussels (EU trade mark 017966390) and cannot
be redistributed. For word rulings, see the free standard at
[asd-ste100.org](https://www.asd-ste100.org/).

## Limits

Applies everywhere:

- The rules are an instruction to a language model, not a filter on its output.
  A model can ignore them. The benchmark measures how often it does not.
- The corpus loads on demand on Claude Code only. On other agents you get the
  rules without the worked examples.
- Code, command output, error text, and quotations are exempt from the rules.
- A confirmation before an action you cannot reverse is exempt. The rules do not
  suppress that question.

Claude Code specific:

- The style reaches the main conversation only. Claude Code gives a subagent its
  own system prompt, so the style does not load there. The style handles this by
  telling Claude to paste a short rule block into any subagent prompt whose
  output a person will read, and to rewrite a subagent's result rather than
  paste it. That is an instruction, not a guarantee.
- The style loads once at session start. Changes need `/clear` or a new session.

## Licence

MIT.

## Dependencies

None. The style is a Markdown file that Claude Code reads. The corpus is
Markdown. Nothing runs at session start.

The optional status line script is POSIX `sh`, so it needs no node, no python
and no jq. Claude Code ships as a binary and does not install a runtime, so the
plugin does not assume one.

`evals/metrics.js` needs node, but only if you want to reproduce the token
numbers yourself. Nothing a user of the plugin runs depends on it.
