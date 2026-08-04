# Brevity

A Claude Code output style. It changes how Claude talks to you in the chat.

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
Full method, raw replies and per-turn numbers in [`evals/`](evals/).

| | without | with | change |
|---|---|---|---|
| Words written to you | 2167 | 346 | **-84%** |
| Output tokens | 15682 | 6345 | **-59%** |
| Context re-read per turn | 976478 | 767873 | **-21%** |
| Cost for the session | $1.2094 | $0.8277 | **-31%** |
| Em dashes | 52 | 0 | |
| Decorative tables | 10 | 0 | |
| Banned words | 2 | 0 | |

The style adds about 2400 tokens to the system prompt. The numbers above are
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

The plugin rarely changes the answer. It changes how much text surrounds it.

## Install

Not published yet. Test it locally:

```bash
git clone https://github.com/pehcastro/brevity
claude --plugin-dir ./brevity
```

It applies on its own. You do not pick it in `/config`. Every session with the
plugin enabled starts with the style on.

To turn it off, disable the plugin:

```
/plugin disable brevity
```

NOTE: the plugin sets `force-for-plugin`, so while it is enabled it overrides
the `outputStyle` you set in your own settings. Disable the plugin to get your
setting back.

### See which style is active

A plugin cannot set your status line, so this is opt in. `statusline/with-style.js`
reads the active style and adds it to whatever status line you already run.

If you have no status line yet, add this to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "node /path/to/brevity/statusline/with-style.js"
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
    "command": "node /path/to/brevity/statusline/with-style.js --prefix --label 'output mode: ' -- 'your existing command here'"
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
output-styles/brevity.md      the style. Loads into the system prompt.
skills/corpus/reference.md    ~150 worked bad/good examples. Loads on demand.
skills/corpus/CHANGES.md      what the audit changed and why.
reference.md                  the original unaudited collection.
evals/                        the benchmark, and every raw reply behind it.
```

The style is always in context. The corpus is not: Claude reads it only when a
reply is about to go wrong.

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

- The style reaches the main conversation only. Claude Code gives a subagent its
  own system prompt, so the style does not load there. The style handles this by
  telling Claude to paste a short rule block into any subagent prompt whose
  output a person will read, and to rewrite a subagent's result rather than
  paste it. That is an instruction, not a guarantee.
- The style loads once at session start. Changes need `/clear` or a new session.
- Code, command output, error text, and quotations are exempt.
- A confirmation before an action you cannot reverse is exempt. The style will
  not suppress that question.

## Licence

MIT.
