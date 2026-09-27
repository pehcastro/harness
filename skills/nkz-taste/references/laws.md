---
name: laws
description: The psychology behind the rules. Why a rule exists, stated so you can reason about a case no rule covers, and named so you can cite it in a review. Covers the Laws of UX, including the ones no checklist item operationalizes. Read when reviewing, when explaining a decision, or when the rules do not settle a call.
---

> The other files tell you what to do. This one tells you why, which is what you need when the situation is not in the list. Cite by name in reviews: *"Hick's Law, too many options in one step"*, *"Peak-End, the success state is a bare toast"*.
>
> Sources: Nielsen Norman Group, [lawsofux.com](https://lawsofux.com/), Shneiderman, Norman, Refactoring UI, WCAG 2.2, Apple HIG, Material 3.

# Why the rules exist

## Already covered elsewhere

These laws are the reasoning behind a rule you already have. Use the name to explain the rule, then follow the pointer for the check.

| Law | In one line | Operationalized by |
|---|---|---|
| **Proximity** | Near things read as grouped | Design files, spacing |
| **Common Region** | A shared boundary groups more strongly than nearness | Design files, cards and surfaces |
| **Similarity** | Same look implies same function | Design files; C31 |
| **Von Restorff** | The one that differs is the one remembered | SKILL always-rule 2, one primary action |
| **Hick's Law** | Decision time grows with the number of choices | product.md, the frame and the subtraction pass |
| **Choice Overload** | Too many options stalls the user entirely | product.md, *Choosing between options* |
| **Miller's Law** | Working memory holds about seven items | product.md, chunk and cap navigation |
| **Chunking** | Grouped information is easier to process | C26, C53 |
| **Working Memory** | Users cannot carry a value across screens | product.md, *The flow* |
| **Tesler's Law** | Complexity is conserved: the system absorbs it or the user does | C24, smart defaults |
| **Occam's Razor** | Among equal solutions, fewest elements wins | product.md, *The subtraction pass* |
| **Doherty Threshold** | Under 400ms and the user stays in flow | SKILL always-rule 13; C7 |
| **Fitts's Law** | Time to hit a target depends on size and distance | C37; mobile-design.md, thumb zone |
| **Jakob's Law** | Users expect your product to work like the others | product.md, *Choosing between options*, step 3 |
| **Postel's Law** | Accept liberally, emit conservatively | C23 |
| **Parkinson's Law** | Work expands to fill the time given | C24, shorten time to done |
| **Peak-End Rule** | An experience is judged by its peak and its ending | C12; product.md, *The lifecycle arc* |

## Not covered by any rule

These have no checklist item, which is exactly why they get missed. Apply them by judgement.

**Zeigarnik Effect.** An unfinished task keeps its grip on attention. People return to what is visibly incomplete and forget what looks done. Use it honestly: show "3 of 5 complete" in setup, onboarding, and multi-step flows, and leave the incomplete step visible. Do not use it to manufacture anxiety about a task the user does not need to finish.

**Goal-Gradient Effect.** Motivation rises as the goal gets closer. So make the remaining distance feel short: show the step count, and start the progress above zero when a step is genuinely already done (account created, email known). Do not fake the head start.

**Serial Position Effect.** The first and last items in a series are remembered, the middle is not. Put the most important navigation items, menu entries, and list actions at the beginning and end. If something sits in the middle of a long list, assume nobody will recall it.

**Selective Attention.** Users scan for what serves their goal and filter out everything else, including anything that resembles an advertisement. A message in a banner at the top of a page, in a colored strip, or in a dismissible bar is often genuinely unseen. Put critical information in the goal path, inside the content the user came for.

**Aesthetic-Usability Effect.** People perceive attractive interfaces as more usable and forgive their small faults. This is a real effect and a real trap. It justifies investing in visual craft. It also means your own testing will under-report usability problems in a good-looking build, and that polish can hide a broken frame. Never let it substitute for the product layer.

**Law of Prägnanz.** People resolve a complex image into the simplest interpretation available. Regular shapes, consistent alignment, and a clean underlying grid let the structure be understood without effort. Visual complexity is not richness, it is work handed to the reader.

**Uniform Connectedness.** Elements that are visually connected read as more related than elements that are merely close. When proximity and a shared boundary are still not enough, connect explicitly: a segmented control, a shared container, a leading line, one background running behind a set of controls.

**Paradox of the Active User.** Users start immediately and skip the instructions, even when reading would be faster. So the happy path must be self-evident, guidance goes inline and in context rather than in a doc, and nothing important may depend on the user having read something first. A tour that must be watched is a design that failed.

**Mental Model.** Users act on what they believe your system is. Trouble comes from the gap between their model and yours. Use their vocabulary, not your schema's. Make the system's state visible so their model can correct itself. When you must introduce a genuinely new concept, teach it at the moment of use, once.

**Flow.** Sustained work needs uninterrupted attention. Every modal, confirmation, toast, tour, and auto-save indicator is a small tax on it. In an Operate surface, defend focus aggressively: preserve state, avoid blocking dialogs, and let the user finish.

**Pareto Principle.** Around 80% of use comes from 20% of the surface. Find the high-frequency path and make it fast, obvious, and keyboard-reachable. Do not let a rarely used feature take prime placement because it was hard to build.

**Cognitive Load.** Every element, label, option, and step consumes a finite resource. The interface should hold the information so the user does not have to. Reduce what is extraneous: decorative noise, redundant labels, options that a default could settle, anything the user must remember rather than read.

## Ethics

**Cognitive Bias.** Anchoring, framing, defaults, and social proof shape decisions whether or not you intend them to. Since you cannot design a neutral interface, design an honest one.

Concretely, do not build:

- A default that serves the business at the user's expense, presented as a convenience.
- A confirm button styled as the safe choice when it is the destructive one.
- A cancel path that is harder to find than the sign-up path.
- Scarcity, countdowns, or activity counts that are not true.
- Pre-ticked consent, bundled permissions, or an opt-out buried in a paragraph.
- A comparison table arranged so the recommended plan wins by omission.

The test: would the user be annoyed to learn how this decision was made? If yes, it is a dark pattern regardless of what it is called internally. Refuse it, say why, and offer the honest version.
