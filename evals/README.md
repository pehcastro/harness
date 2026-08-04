# Evals

Every claim in the top-level README comes from a run in this directory. The raw
replies are here. Re-run them yourself with `run.sh`.

## Method

One realistic 10-turn Claude Code session, run twice: once with the plugin, once
without. Same prompts, same model, same empty working directory, same order.
The session builds a small Hono API in TypeScript, installs it, tests it, and
then asks the model to explain, decide, delete and summarize.

Each turn targets a rule in the output style. `prompts.txt` lists which.

Both runs use `--setting-sources project,local`, which loads no user settings.
No other plugin on the machine can affect the result. The plugin under test
loads through `--plugin-dir`.

```bash
./run.sh control                # no plugin
./run.sh brevity --plugin     # plugin loaded
./check.sh runs/brevity        # banned words, em dashes, tables
node metrics.js runs/brevity runs/control
```

## Result

| | control | brevity | change |
|---|---|---|---|
| Words written to the user | 2167 | 346 | **-84.0%** |
| Output tokens | 15682 | 6345 | **-59.5%** |
| Context re-read per turn | 976478 | 767873 | **-21.4%** |
| Cost for the session | $1.2094 | $0.8277 | **-31.6%** |
| Banned words | 2 | 0 | |
| Em dashes | 52 | 0 | |
| Decorative tables | 10 | 0 | |

Output tokens fall less than words because output tokens also count reasoning
and tool calls, and the plugin does not change how much work the model does.
Only what it says about the work.

The context number is the part that compounds. Short replies make a short
transcript, and every later turn re-reads that transcript. The saving grows with
session length.

The style itself costs about 2400 tokens in the system prompt, every session.
The table above is the net figure, with that cost included.

## Per-turn word count

| Turn | What it tests | control | brevity |
|---|---|---|---|
| 01 | scaffold a project | 114 | 18 |
| 02 | add an endpoint | 106 | 14 |
| 03 | add tests | 253 | 36 |
| 04 | install and run | 252 | 25 |
| 05 | "Where are we?" | 182 | 34 |
| 06 | small fix | 138 | 13 |
| 07 | a question with an obvious answer | 212 | 14 |
| 08 | explain routing (should be long) | 295 | 39 |
| 09 | delete a directory | 140 | 22 |
| 10 | "summarize the session" | 475 | 131 |

Turn 08 is the only turn that is allowed to run long, and turn 10 is the only
turn where the user asked for a summary. Those two are the longest replies in
the run. The style did not flatten everything to one length.

## Side by side

Turn 06, a one-line change to a 404 body. Both runs made the same change and
both ran the tests.

```
control (138 words)
  Fixed and verified — 5/5 tests pass.

  Changes in `src/app.ts`:
  - `GET /users/:id` miss → `{error:'not found'}` (was `'user not found'`)
  - Added `app.notFound()` → `{error:'not found'}` with 404, which replaces
    Hono's default plain-text `404 Not Found` for every unmatched path

  In `src/app.test.ts`: updated the miss assertion, added a body assertion to
  the `/users/` case, and added a new test for an arbitrary unmatched route
  (`/nope`) that checks status, `content-type: application/json`, and body.

  Note that the two 404s are now indistinguishable to a client [...a further
  paragraph of design advice nobody asked for]

brevity (3 words)
  5 tests pass.
```

Turn 07, "should I use a database or keep the Map? This is a throwaway demo".
Both runs reached the same answer. Only the length differs.

```
control (212 words)
  Keep the Map.

  For a throwaway demo it's the right call on every axis that matters: zero
  setup, no connection lifecycle to babysit, tests run in 15ms with no fixtures
  or teardown, and anyone cloning it runs `npm install && npm run dev` with
  nothing else installed. A database buys you persistence and query power — [...]

  The one thing to know is the failure mode you'd hit if this stops being
  throwaway: [...]

brevity (14 words)
  Keep the Map. A throwaway demo does not need a database, and swapping later
  is a small change since the reads go through one Map.
```

This is the honest shape of the result. The plugin rarely changes the answer.
It changes how much text surrounds the answer.

Turn 09, a delete request against a directory that does not exist:

```
brevity  There is no tests directory. The only test file is
           `src/app.test.ts`. Delete that file (and the `test` script plus
           vitest from package.json)?
```

The style did not suppress the question. An action you cannot reverse is an
exception to the rule against asking, and the model kept the exception.

## What the evals changed in the plugin

`runs/brevity-before-emdash-fix/` is the first run. It had 6 em dashes, all
of them separating a label from a description in a list:

```
- `src/app.ts` — routes: GET /health, GET /users/:id
```

The rule said "do not write an em dash, write a period or a comma". Neither
fits a list label, so the model kept the dash. The rule now names the list case
and says to use a colon. The next run had 0 em dashes.

## Limits

- One session, one model, one project type. Not a statistical result.
- `duration_ms` is not reported. The two runs shared a machine.
- The word count measures what the user reads. It does not measure whether the
  user then had to ask a follow-up question. Turn 08 lost 54 words between run 1
  and run 2 with no loss of content, but that was judged by reading, not
  measured.
- `check.sh` catches banned words, em dashes and tables. It cannot catch a
  preamble, a hedge, or a recap. Those were found by reading every reply.
