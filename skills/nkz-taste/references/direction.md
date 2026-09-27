---
name: direction
description: Aesthetic direction. How to decide what a surface should look like before you build it: read the brief, set the intensity dials, write a four-part design plan (palette, type, layout, signature), and critique it against the defaults you would otherwise reach for. Read when starting anything new, and always for marketing, landing, portfolio, or brand-facing work.
---

> **Part of [nkz-taste](../SKILL.md).** [product.md](./product.md) decides what the surface is for. This file decides what it looks like. [web-design.md](./web-design.md) and [mobile-design.md](./mobile-design.md) execute it. [ai-tells.md](./ai-tells.md) is the list of choices to avoid making by reflex.

# Direction

**When a named style is selected:** load its `style.md` and `recipes.md` through [the style catalog](../SKILL.md#named-styles). Its palette, typography, layout grammar, signature, and motion are pinned brief constraints. Use this file only for decisions the style leaves open. Skip fresh palette proposals, intensity changes, novelty critiques, and package substitutions that would override it. Accessible primitives remain implementation choices, not replacement themes. Without a selected style, follow the full process below.

Work here the way a studio works when its reputation is that no two of its clients look alike. That reputation is not earned by talent. It is earned by refusing the first answer, every time, on purpose.

The failure mode is not ugliness. Ugly work gets rejected and then fixed. The failure mode is competence with no opinion: a page that is correctly spaced, correctly contrasted, correctly responsive, and interchangeable with four hundred others. Nobody rejects that page. It simply does nothing for the product it belongs to.

Every brief pins some axes down and leaves others open. The pinned ones you follow exactly. The open ones are the entire job, and the difficulty is that an open axis always has an obvious answer sitting on it, and taking that answer feels from the inside exactly like deciding.

## 1. Read the brief

Before any dial or any code, work out what is actually being asked for.

**Signals to read:**

- **What kind of surface.** Landing (SaaS, consumer, agency, event), portfolio, product UI, editorial, redesign. Each has a different center of gravity.
- **The vibe words the person used.** "Minimal", "calm", "Linear-like", "Awwwards", "brutalist", "premium", "playful", "serious B2B", "editorial", "dark tech". These are the brief.
- **References.** Links, screenshots, products named, competitors named. A reference is worth more than a paragraph of description.
- **The audience.** A procurement committee, a design-conscious consumer, a recruiter scanning for thirty seconds. The audience picks the aesthetic, not your preference.
- **Assets that already exist.** Logo, colors, type, photography. On a redesign these are input, not suggestions.
- **Constraints that override taste.** Accessibility-critical audiences, regulated industries, public sector, children, trust-first commerce. These beat every aesthetic instinct.

**Then commit to a reading, in one sentence, before you generate anything.** Four parts: the surface, the audience, the language, and the direction you are leaning toward. Writing it down is what makes it arguable, and an argument now is far cheaper than an argument after the build.

> A B2B landing page for engineers evaluating a tool, restrained and dense, leaning on system type and almost no motion.

> A solo designer portfolio for hiring managers who will give it thirty seconds, editorial and type-led, leaning on scroll-driven reveals and one custom face.

> A checkout flow for first-time buyers on phones, trust-first and plain, leaning on the platform conventions rather than against them.

**If the reading genuinely forks, ask one question.** Not a list of four. One, naming the two directions, so the answer is a word. If you can infer it from what you already have, do not ask at all: state the reading and move.

## 2. Set the dials

Three numbers, 1 to 10, set from the read. Every later decision about layout, motion, and density is gated by them. State them out loud.

- **VARIANCE.** 1 is perfect symmetry, 10 is deliberate asymmetry and chaos.
- **MOTION.** 1 is static, 10 is cinematic and physics-driven.
- **DENSITY.** 1 is a gallery wall, 10 is a cockpit.

| The read says | VARIANCE | MOTION | DENSITY |
|---|---|---|---|
| Minimal, calm, editorial, Linear-like | 5-6 | 3-4 | 2-3 |
| Premium consumer, luxury, brand-led | 7-8 | 5-7 | 3-4 |
| Playful, experimental, agency, Awwwards | 9-10 | 8-10 | 3-4 |
| Landing or marketing, unspecified | 7 | 6 | 4 |
| Developer portfolio | 6 | 5 | 4 |
| Product UI, dashboard, tool | 3-5 | 2-4 | 5-8 |
| Trust-first, public sector, regulated | 3-4 | 2-3 | 4-5 |
| Redesign, preserve the brand | match existing | +1 | match |
| Redesign, overhaul | +2 | +2 | match |

**What the dials mean in practice:**

- **VARIANCE 1-3:** symmetrical grid, equal columns, centered alignment.
- **VARIANCE 4-7:** deliberate offsets, mixed aspect ratios, left-aligned headings over centered content.
- **VARIANCE 8-10:** fractional grids, masonry, large intentional voids, overlap.
- **MOTION 1-3:** hover and press states only.
- **MOTION 4-7:** entrance transitions, scroll reveals, hover physics.
- **MOTION 8-10:** scroll-driven choreography, pinning, parallax.
- **DENSITY 1-3:** huge section gaps, generous everything.
- **DENSITY 4-7:** normal application spacing.
- **DENSITY 8-10:** tight, hairlines instead of cards, monospace numerals.

Two rules that follow. **High VARIANCE collapses to a single column below the tablet breakpoint,** always. And **a claimed MOTION above 4 must actually move**: a static page that says MOTION 7 is broken. If you cannot build working motion in the scope available, set the dial to 3 and build a clean static page. Never half-build motion that breaks.

## 3. Where a real design system belongs

If the brief maps to an established system, install the official package. Do not rebuild its CSS by hand, and do not import its tokens and then override most of them.

| The brief reads as | Reach for |
|---|---|
| Microsoft, enterprise SaaS | Fluent UI |
| Google-flavored product | Material 3 / Material Web |
| IBM-style enterprise analytics | Carbon |
| Shopify app surfaces | Polaris (required) |
| Atlassian-style product | Atlaskit |
| GitHub-style devtool or community | Primer, or Primer Brand for marketing |
| UK public service | GOV.UK Frontend (expected, sometimes required) |
| US public sector | USWDS |
| Accessible React foundation | Radix Themes |
| Modern product where you own the components | shadcn/ui, never in its default state |
| Fast local-business or agency MVP | Bootstrap |
| Native iOS or Android | Apple HIG or Material directly |

**One system per project.** Never two component libraries in the same tree.

When the brief is an **aesthetic** rather than a system (glassmorphism, bento, brutalist, editorial, dark tech, mesh gradient, kinetic type), there is no official package. Build it with native CSS and the project's existing conventions, and say in a comment that it is an interpretation rather than an official material. Apple's Liquid Glass in particular has no web package: any web version is a `backdrop-filter` approximation and must be labeled as one.

## 4. Write the plan before the code

Four parts. Short. This is the artifact you critique in step 5, so it must be concrete enough to be wrong.

**Palette.** Four to six named values. Say what each is for. One accent, and it stays the accent on every section of the page. Keep saturation restrained unless the brief demands otherwise.

**Type.** Two or three roles: a display face used with restraint, a body face that complements it, and a utility or mono face if data or captions need one. Set the scale, the weights, and the tracking. **The type treatment should itself be memorable**, not a neutral delivery mechanism for the words.

**Layout.** One sentence per section plus an ASCII wireframe. Wireframes are fast, and comparing two of them takes seconds. Do this before writing any markup.

**Signature.** The one element this page will be remembered by. Name it. If you cannot name it, the design has no center and you are about to build a competent template.

## 5. Critique the plan against your own defaults

This is the step that does the work, and it is the step that gets skipped.

Right now, generated design clusters into a few recognizable looks:

1. A warm cream background near `#F4F1EA` with a high-contrast serif display and a terracotta accent.
2. A near-black background with one bright acid-green or vermilion accent.
3. A broadsheet layout with hairline rules, zero border radius, and dense columns.
4. Purple or blue gradient glow, centered hero over a dark mesh, three equal feature cards, neutral grotesque body face.

Every one of these is legitimate for some brief. The problem is that they appear regardless of the brief, which means they are habits rather than choices.

**So run this test on the plan you just wrote.** Imagine a neighboring brief: the same page for a different product in a different industry. Would your palette, your type pairing, and your layout come out the same? If yes, that part of the plan is a default wearing a costume. Change it and say what you changed and why.

Two specific traps, because they recur hardest:

- **Serif is not a synonym for premium.** "Creative brief, therefore serif display" is the most predictable move available. Unless the brief names a serif, or the direction is genuinely editorial, luxury, publication, or heritage and you can say why *this* serif suits *this* brand, use a characterful sans display. Sans display faces are not boring, they are default for the same reason black is default in clothing. And if you emphasize a word inside a headline, use italic or bold of the same family. Dropping a serif word into a sans headline is amateur.
- **The warm-craft palette is not a synonym for artisanal.** Cream background, brass or clay or oxblood accent, espresso near-black text. Every generated cookware, wellness, and heritage-goods page uses it, so the brand disappears into the category. Rotate: cold silver and chrome, deep forest with bone and amber, true off-black with warm tan, saturated cobalt against a single neutral, olive with brick, or monochrome with one bright pop.

The general form of both: **when the brief leaves an axis free, do not spend that freedom on the most probable answer.**

Only after the plan survives this critique do you write code, and then you follow the plan exactly.

## 6. The hero makes one claim

The top of the page argues something. Find the most characteristic thing in the subject and lead with it, in whatever form it wants: a sentence, a photograph, a working demo, a single number, something the visitor can touch. A large statistic over a small label, three supporting figures beside it, and a soft gradient behind all of it is the opening that fits any product, which is exactly why it argues nothing.

Dig into the subject for the material. Its tools, its raw inputs, its finished artifacts, the words the people inside it actually use. A ceramics workshop and a payroll system are not two subjects that need different color palettes. They are two subjects containing completely different objects, and the objects are where a page stops being generic.

## 7. Structure carries meaning, or it goes

Numbering, eyebrows, dividers, and labels should encode something true. Numbered markers (01 / 02 / 03) belong on content that is genuinely a sequence, a real process, or a dated timeline where the order tells the reader something. Everywhere else they are decoration pretending to be information.

Same for eyebrows, those small uppercase wide-tracked labels above section headings. One above every section produces the same templated rhythm on every page. The headline alone is usually enough, and the section's position on the page already tells the reader what it is.

## 8. Spend your boldness in one place

Let the signature element be the one memorable thing, and keep everything around it quiet and disciplined. Maximalist directions need elaborate execution; minimal directions need precision in spacing, type, and detail. Elegance is executing the chosen direction well, not choosing a safe one.

Not taking a risk is itself a risk. Take one you can justify in a sentence.

Then, before you deliver, look at the finished thing and take one element out. There is always one, and it is rarely the one you would have picked while building.

## 9. Words are part of the direction

Copy makes a design feel as templated as the design does. [craft.md](./craft.md) covers interface microcopy. This is about voice.

- **Write from the reader's side of the screen.** Name things by what people control and recognize, never by how the system is built. A person manages notifications, not webhook configuration.
- **Be specific rather than clever.** Specificity is the only reliable way to sound real.
- **Keep one register per page.** Do not mix technical monospace precision, editorial prose, and marketing punch in one composition unless the brand genuinely does.
- **Do not invent precision.** A number like 4.1× or 92% either comes from real data, is clearly labeled as an example, or does not appear. Faked engineering precision is a lie the brand did not tell.
- **Re-read every visible string before delivering.** Headlines, buttons, captions, alt text, footer, errors. Flag anything grammatically broken, anything with an unclear referent, any forced metaphor, and any phrase that reads as trying to sound thoughtful. Replace each one with a plain functional sentence. Boring copy beats cute-and-wrong.

## 10. Deliver

State the read, the dials, the four-part plan, what you changed after the critique and why, and the one risk you took. Then the trade-offs and any new tokens the project needs.
