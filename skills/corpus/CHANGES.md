# Audit changes

The original collection is at the repository root as `reference.md`. It fixed
the `Bad` column but never checked the `Good` column. Jargon survived into the
corrected text.

This file records every `Good` line the audit changed.

## Banned words removed

| Section | Was | Now |
|---|---|---|
| Do not acknowledge the request | Dispatched phase 1 to the backend agent. | Sent phase 1 to the backend agent. |
| Do not acknowledge the request | Porting as-is, copying files directly, surfacing it locally. | Copying the source unchanged. Showing it locally. |
| Do not tell the reader that a point matters | The pipeline ran end to end. | The pipeline finished. |
| Do not tell the reader that a point matters | The pipeline ran end to end on real data: | The pipeline finished on real data: |
| Do not tell the reader that a point matters | Fix dispatched. The chain works end to end; the parse discarded the 18 outputs. | Fix sent. The chain finishes, but the parse discarded the 18 outputs. |
| Do not repeat work the reader watched | Nothing moves in production until the signals ticket lands. | ...until the signals ticket is merged. |
| Do not repeat work the reader watched | The fake proves the wiring, not the thing itself. | The fake proves the connection, not the behavior. |
| Do not praise | Phase 1 landed. Two deviations, both fine. | Phase 1 done. Two deviations, both fine. |
| Do not praise | Worker resilience done. | Worker recovery done. |
| Do not write a scorecard | Parse fix landed: per-item drop, tolerant field. | Parse fix done: per-item drop, tolerant field. |
| Do not write a scorecard | All suites green. The pipeline and both screens are verified. | All suites pass. The pipeline and both screens work. |
| Do not report that you wait | 3 agents, disjoint paths. | 3 agents, no shared files. |
| Do not repeat tool output | 18 net-new items persisted. | 18 new items saved. |
| Do not hedge | Tests prove wiring, not quality. | Tests prove the connection, not the quality. |
| Do not hedge | One overshoot left: the daily cycle still authors one a day. | One item left: the daily cycle still writes one a day. |
| Do not repeat the request back | Dispatching the writer to document the shipped features against the code. | Sending the writer to document the released features against the code. |
| Do not repeat the request back | Diagnosing the generation rate. | Checking the rate. |
| Do not agree with the reader | Generation and publishing are wrongly coupled. | ...are wrongly connected. |
| Do not agree with the reader | Reframed as a surface with providers. | Changed to a page with providers. |
| Do not offer more work | Everything's green. Nothing committed. | All tests pass. Nothing committed. |

## Project words removed

These words meant something inside one repository and nothing outside it.

| Was | Now |
|---|---|
| The hang is in the pacing sleep. | The task stops in the delay that sets the rate. |
| The bug is the unbounded sleep in the pacing helper. | The bug is a delay with no time limit in the rate control. |
| Not wedged. Discovery is genuinely slow: 20+ paced lookups per seed. | Not stuck. Discovery is slow: more than 20 rate-limited lookups per seed. |
| The block is a 25-hour-old lock file. | A 25-hour-old lock file blocks them. |
| Pushing the chain to completion. | Running the chain to the end. |

## Safety words

The original invented its own labels. The audit replaced them with the three
labels from ASD-STE100.

| Was | Now |
|---|---|
| ATTENTION: | NOTE: |
| DESTRUCTIVE: it deletes the target directory first. | CAUTION: this deletes the target directory first. |
| UNTESTED: the other mode. | NOTE: nobody tested the other mode. |
| OVERSHOOT: the daily cycle still authors one a day. | NOTE: the daily cycle still writes one a day. |
| WARNING: (for a risk of data loss) | CAUTION: |

WARNING is now reserved for a risk to a person. CAUTION covers damage to
equipment, data, or a system. NOTE covers everything else.

## Structure

- "Too short" moved from last to first, and is now "Keep the information".
  Readers who saw 18 sections of "cut" before reaching it were overcorrecting.
- Section titles changed from nouns to instructions. "Preamble" gave no
  instruction. "Do not acknowledge the request" does.
- Added a note that an action you cannot reverse is an exception to "Do not ask
  a question that is not a question".
