---
name: product
description: The product decision layer. Frame a surface before designing it: name the job, the one action, the flow around it, and what to cut. Covers surface archetypes, the subtraction pass, the lifecycle arc, and how to push back on a request that asks for the wrong thing. Read this first, on every task, before any design or animation file.
---

> **Read this before anything else.** Design, interaction, and animation answer *how*. This file answers *what* and *whether*. A wrong answer here cannot be polished away.

# The product layer

For an explicitly selected style or visual-only restyle, preserve supplied content, routes, features, and working behavior. Review the product frame to understand hierarchy, not to impose feature cuts. The selected style supplies visual tokens and surface construction; its intentional frames are not redundant decoration. Product changes beyond the requested scope remain proposals.

Most UI is over-designed and under-decided. The screen looks considered and does three jobs badly. The button has a beautiful press state and should not be on the page.

This file is a procedure, not a rule list. Rules tell you whether a thing is good. A procedure tells you which thing to build.

## The frame

Answer these six before you write a line. Out loud, in the proposal, so the developer can disagree cheaply.

**1. What is this surface?** Name the archetype, not the route. "Settings page" is a route. "The place a user changes one thing and leaves" is an archetype. See the table below.

**2. Whose job is it, and what is that job?** One sentence, in the user's words, describing what they came to do. Not "manage flows". Rather "find out whether last night's run passed". If you cannot write the sentence, you do not know what to build yet, and that is the finding to report.

**3. What is the one primary action?** Choose the dominant action when the task has one. A monitoring or reading surface may instead prioritize a fact and need no primary button. Related actions can remain secondary; do not split a useful dashboard or invent an action just to satisfy this rule.

**4. What happens immediately before and immediately after?** Every screen has neighbours. Where did the user come from, what did they already type, and what do they expect to see next. Carry that context forward instead of asking again. A surface designed in isolation is why users re-enter the same value three times.

**5. What is the failure case?** What goes wrong most often for a real user here, and what does the interface do about it. Design that path now, not after QA finds it.

**6. What are you cutting?** Identify unnecessary additions, if any. Keeping all requested elements is a valid outcome; never manufacture a cut. See *The subtraction pass*.

## Surface archetypes

The archetype tells you which layer dominates and which reference files to load. Pick one. A surface that matches two archetypes is two surfaces.

| Archetype | The job | What dominates | Failure mode |
|---|---|---|---|
| **Capture** (signup, create, compose) | Give the system something | Forms, states, accessibility, microcopy | Too many fields, validation that punishes typing |
| **Decide** (pricing, plan picker, confirm) | Choose between options | Hierarchy, comparison, a recommended default | Too many options, no default, no clear difference |
| **Monitor** (dashboard, run list, status) | Find out whether something is fine | Information architecture, scanning, density | Everything emphasized, no answer to "am I fine" |
| **Inspect** (detail, report, record) | Understand one thing deeply | Hierarchy, progressive disclosure, structure | Flat wall of fields, no primary fact |
| **Operate** (editor, authoring, canvas) | Do sustained work | Interaction, keyboard, undo, state persistence | Modal interruptions, lost work, no undo |
| **Persuade** (landing, marketing, empty state) | Believe something and act | Design and animation, one message, one CTA | Five CTAs, motion for its own sake |
| **Configure** (settings, preferences) | Change one thing and leave | Grouping, findability, defaults | A dump of every toggle in one column |

Two consequences worth stating. A **Monitor** surface must answer its question above the fold without interaction: if the user has to click to learn whether things are fine, it is an Inspect surface pretending. And a **Persuade** surface earns its motion, while every other archetype should feel motionless.

## The subtraction pass

Run this after you have a draft and before you polish it. It is the highest-value ten minutes in the whole loop, and the one most often skipped.

Go element by element and ask:

1. **Does this serve the stated job?** If not, delete it. Not "move it to a tab". Delete it.
2. **Would the user notice if it were gone?** If not, delete it. Decorative dividers, redundant labels, icons next to text that already says it, an extra border with no grouping or style purpose. A frame and face prescribed by the selected style form one surface and stay together.
3. **Is this a choice the system could make?** Every option you offer is a decision you moved onto the user. Detect the timezone. Pre-select the safe plan. Infer the format. Ask only what you truly cannot know.
4. **Is this the third variant of the same thing?** Use one coherent vocabulary. Primary, secondary, ghost, and destructive buttons can all be justified; a selected style may define multiple constructions for different purposes.
5. **Does this belong on a later screen?** Progressive disclosure is not hiding. Showing everything at once is not honesty, it is refusing to prioritize.

Then check the count. If a view has more than about seven top-level groups, or a nav has more than about seven items, chunk or push the rest behind a menu.

**A feature that is not built has no bugs, no states, no accessibility debt, and no maintenance.** Subtraction is the cheapest quality improvement available.

## The flow, not the screen

A screen is a frame in a film. Design the film.

- **Write the path.** List the steps from intent to done, as sentences. "Opens the app → sees last night's run failed → taps it → sees which step broke → sees the screenshot." Every noun in that path is something the interface must provide, and anything not in the path is a candidate for the cut list.
- **Count the steps and cut one.** There is nearly always one that a default, an inference, or a merge can remove.
- **Carry state forward.** Filters, selections, drafts, scroll position, the value they typed two screens ago. Users cannot hold values across screens and should never be asked to.
- **Never lose work.** Back does not destroy input. A failed submit returns the form filled. A crash returns a draft. This single rule earns more trust than any amount of visual polish.
- **Protect focus.** In an Operate surface, every modal, confirmation, and toast is an interruption. Justify each one or remove it.

## The lifecycle arc

A product is used at different moments and most designs only cover one of them. Design all six.

1. **First run.** The user has no data and no idea what this is. The empty state is your onboarding, and it is often the only onboarding anyone reads. One sentence explaining what belongs here, and one primary action to create it.
2. **Sparse.** One or two items. Layouts tuned for fifty items look broken with two. Check it.
3. **Habitual.** The daily case. This is what to optimize for speed and muscle memory, and it is not the case the design was mocked with.
4. **Dense.** Hundreds of items, long names, missing fields, foreign characters. Pagination, virtualization, truncation with a way to see the full value.
5. **Failure.** Offline, timeout, permission denied, rate limited, malformed. Distinct messages and distinct recovery paths per category, because "an error occurred" tells the user nothing they can act on.
6. **Success.** The moment the job is done. People judge an experience by its peak and its ending, and the ending is nearly always a bare toast. Invest here: confirm clearly what happened, show the result, offer the obvious next step.

## Choosing between options

When you are weighing two designs and both defensible, decide in this order and stop at the first one that separates them:

1. **Which does the stated job with fewer steps?**
2. **Which has fewer failure modes?**
3. **Which matches what the user already knows** from other products and from the rest of this codebase? Novelty is a cost paid by every user, and it is worth paying only where it is the point.
4. **Which has fewer elements?**
5. **Which is easier to reverse** if it turns out to be wrong?

Only then consider which looks better. If you reach step 5 without separation, the choice does not matter. Pick one, say you flipped a coin, and move on.

## Pushing back

You are not a rule follower. When the request asks for the wrong thing, say so in two sentences, then build the best version you can.

Push back when:

- **The request names a solution and hides the problem.** "Add a filter dropdown" often means "I cannot find my thing." A search, a better default sort, or fewer items may serve the actual job better. Ask what the user was trying to find.
- **The screen is being asked to do two jobs.** Say which two, and propose the split.
- **The request adds an option that a default could absorb.** Propose the default.
- **The request is polish on a broken frame.** Animating a screen that does the wrong job is the most expensive way to be wrong. Name the frame problem first.
- **The request implies a value the design system does not have.** Flag the new pattern instead of inventing it.

How to push back: state the concern in a sentence or two, state what you are doing about it, and keep building. Do not stop and wait unless proceeding either way would waste the work. If the developer reaffirms the original request, that is their call. Build it in full and say you noted the concern.

## Anti-patterns

- **The dashboard reflex.** Every request becomes a grid of cards with numbers on them. Ask what decision the numbers support. A number nobody acts on is decoration.
- **The settings dump.** Every option that had no home ends up here in one flat column. Group by what the user is trying to change, not by which subsystem owns the flag.
- **The modal reflex.** A modal stops everything and loses context. Use inline expansion, a side panel, or a route unless the interaction genuinely must block.
- **The empty state as apology.** "No data" is a wasted first impression. It is the highest-attention moment in the product's life.
- **Designing for the demo.** The mock has three perfect items with short names. Real data has one item, or four hundred, with a name that wraps to three lines.
- **Feature creep by adjacency.** "While we are in here." Every addition needs its own frame, or it does not go in.

## Redesigns

A redesign is a different task from a new build, and misreading which one you are in is the largest single cause of bad redesign work.

**Detect the mode first.**

- **Greenfield.** No existing surface, or a full overhaul already agreed. Frame it from scratch.
- **Preserve.** Modernize without breaking the brand or the traffic. Audit first, extract the existing tokens, evolve.
- **Overhaul.** New visual language over existing content. Treat the visuals as greenfield, the content and structure as fixed.

Selecting a named style resolves the visual direction: apply its complete contract while retaining product behavior. If the remaining scope is ambiguous, ask once: *does this preserve the existing brand, or start visually from scratch?*

**Audit before you touch anything.** Write down what exists: the brand tokens, the page tree and navigation, which content blocks are doing real work and which are filler, the signature interactions worth keeping, the patterns worth retiring, and the current intensity of the design (see [direction.md](./direction.md) dials). That reading is your starting point, not the baseline for a new build.

For anything public, also record the search baseline: which pages rank, the titles and descriptions, the structured data, the share cards. **Losing search traffic is the most common way a redesign fails**, and it fails silently for weeks.

**Never change these without asking:**

- URLs and route slugs.
- Anchor ids that existing links point at.
- Primary navigation labels.
- Form field names and order, which break both analytics and password managers.
- The logo or wordmark.
- Legal, consent, and cookie copy.

**Without a selected style, apply the levers in order, and stop when the brief is satisfied.** Typography first: it gives the largest visual change for the least risk. Then spacing and rhythm. Then color, usually by desaturating and unifying the neutrals while keeping the brand accent. Then a motion layer on the components that already exist. Then recomposing the hero and the two or three sections that matter most. Full block replacement only when a block is genuinely unsalvageable.

**Choosing evolution over rebuild:** if the structure, the content, and the search position are sound, the first four levers give most of the value at a fraction of the risk. Rebuild when the visual debt is structural: no system, broken structure, broken mobile. Treat it as greenfield only when the brand itself is changing.

**Do not regress what already works.** Existing focus states, alt text, keyboard paths, and contrast are wins. A redesign that loses them is a downgrade wearing new type.
