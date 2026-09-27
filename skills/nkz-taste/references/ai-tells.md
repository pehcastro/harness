---
name: ai-tells
description: The catalogue of choices that mark a design as machine-generated. Concrete patterns to avoid by reflex, each with the condition under which it becomes a legitimate choice again, plus a mechanical count check to run before delivering. Read before building any marketing, landing, portfolio, or brand-facing surface, and when a page is technically correct but reads as templated.
---

> **Part of [nkz-taste](../SKILL.md).** [direction.md](./direction.md) is how to choose well. This file is the list of choices you will otherwise make without choosing.

# Tells

A tell is not a bad pattern. It is a pattern reached for by reflex, on every brief, regardless of subject. Reflex is what makes work read as generated: not any single element, but the same twelve elements arriving together on a page about kilns and a page about payroll.

**A selected style is an intentional brief constraint.** Keep its prescribed palette, frames, gradients, typography, and repeated constructions. Apply these checks to unprescribed additions; do not demand novelty or a different palette from a faithful reproduction.

**Every item here has an override.** When the brief asks for it, or when you can say in one sentence why it fits this specific subject, use it. What is forbidden is defaulting to it.

## Composition

**Three equal feature cards in a row.** The single most recognizable generated layout. Use a two-column alternation, an asymmetric grid, a bento with varied cell sizes, or a horizontal scroll instead.
*Override:* genuinely three parallel things of equal weight, and nothing else fits.

**Centered hero, every time.** Centering is the safe answer at any VARIANCE above 4. Try a split, a left-aligned block against a right-aligned asset, or an asymmetric void.
*Override:* editorial, manifesto, or launch announcements where the message is the design.

**More than two consecutive image-plus-text splits.** Alternating left-image and right-image down the page is banal by the third one. Break it with a full-width section, a vertical stack, a grid, or a different family entirely.

**The same layout family twice.** Once you use three-column-cards, or full-width-quote, or split-text-image, that family is spent. A page of eight sections should use at least four different families.

**A left-aligned giant headline with a small explainer paragraph floating in the right column.** Sections have one focused message. Stack the headline and the body vertically, capped at about 65 characters.
*Override:* the right column carries a real visual or interactive element, not filler text.

**A grid with an empty cell.** A bento has exactly as many cells as you have content for. Three items means three cells. If the last cell is blank, you planned the grid before the content.

**Every row of a long list wearing both a top and a bottom hairline.** Pick one, use it sparingly, or group the rows into two or three clusters with one divider each. A ten-row specification table with a line under every row is the laziest available layout. Alternatives: a card per item, grouped clusters with headings, scroll-snap pills, or three or four highlighted items with the rest behind a disclosure.

## Hero discipline

The hero is one moment, not a summary of the page.

- **It fits in the viewport.** Headline at most two lines, subtext at most twenty words and four lines, calls to action visible without scrolling. If the copy will not fit, the value proposition is unclear, not the rule too strict.
- **Font scale is planned with the asset, not after it.** A four-line hero headline is a font-size error, never a copy-length error. Six or more words means starting smaller.
- **Top padding stays modest.** Hero content floating halfway down the viewport reads as a layout bug. If it needs air, increase the type or the asset, not the padding.
- **At most four text elements:** an eyebrow *or* a brand strip *or* neither, the headline, the subtext, and the calls to action. Everything else moves below.
- **Not in the hero:** a tiny tagline under the buttons, a trust micro-strip, a pricing teaser, a feature list, an avatar row, a logo wall. The logo wall is its own section directly underneath.
- **No version label** (`v0.6`, `BETA`, `EARLY ACCESS`) unless the brief is genuinely about launch status.
- **No word strip across the bottom.** Three or four abstract capitalized nouns in a wide-tracked row, split by dots or slashes, naming the disciplines the studio practices. It is decoration shaped like navigation.
- **No scroll cue.** A user looking at the hero has not scrolled yet and knows what scrolling is.

## Navigation

- **One line at desktop.** If the items do not fit at tablet width, shorten the labels, drop the secondary ones, or collapse to a menu. A two-line desktop nav is broken.
- **At most about 80px tall.** A nav that eats a sixth of the viewport is a design that has not decided what matters.
- **No colored status dot before each item.** A dot means live semantic state or it means nothing.

## Labels and micro-decoration

This cluster is what makes a page feel *performed* rather than designed.

**Eyebrows.** At most one per three sections, hero included. Nine sections means three eyebrows, maximum. If a section has one, the next two do not. The alternative to an eyebrow is no eyebrow: the headline is enough, and the section's position already categorizes it.

**Section numbering.** A zero-padded index before every section heading, in monospace, usually with a slash or a dot after it. Enumerating sections is not information, it is the appearance of a system. The same goes for a counter on an image the reader can already count.

**Stage labels.** "Stage 1 / Stage 2 / Stage 3", "Phase 01", "Pass One". The step content is the label. Use the verb: Install, Configure, Release.

**The middle dot.** At most one per metadata line. It is not the default separator for everything. Use line breaks, columns, or hairlines.

**Pills and tags floated on top of images.** A small capitalized category chip in a corner of the photo, naming a discipline or an index. Let the image carry itself, or caption it below the frame where a caption belongs.

**Photo credits as decoration.** A numbered study, a roman numeral, a film format, an invented photographer name, set small under a placeholder image. It borrows the look of an archive that does not exist. Credit a real photographer for a real photo, write one functional line about what the image shows, or write nothing.

**Version footers on marketing pages.** `v1.4.2`, `Build 0048`, `last sync 4s ago · main`. That is devtool furniture, not landing-page content.

**Locale, clock, and weather strips.** A city abbreviation, a local time, and a temperature, set small in the header or footer. A real contact address in the footer is fine. An ambient readout of where the team happens to be sitting is decoration.
*Override:* a genuinely timezone-distributed team, a travel brand, or a physical venue.

**Crosshair and hairline grids drawn purely to look designed.** Lines organize real content or they go.

**Rotated vertical text.** Awwwards cliché.
*Override:* explicitly experimental briefs where it serves a real composition.

**Live scarcity counters.** A remaining-units or places-taken figure, with no real inventory behind it. Either the number comes from a real limited run or it does not appear.

**Sentences that explain the section to the reader.** A line under the heading commenting on the list that follows, on what was left out of it, or on the restraint shown in keeping it short. Heading and body already carry the section. The commentary is the page talking about itself.

## Typography

- **A neutral grotesque as the automatic body face** is the safe answer, not a choice. Pick something with a point of view unless the brief wants neutrality.
- **Serif display by reflex.** See [direction.md](./direction.md) section 5. Two faces in particular have become the recognizable generated serifs; if you reach for a serif, pick a different one and say why it fits.
- **Mixed-family emphasis.** A serif word dropped into a sans headline for visual interest. Use italic or bold of the same family.
- **Oversized headings doing the work that weight and color should do.** Scale is not hierarchy on its own.
- **Gradient fills on large headings.**
- **Italic descenders clipped by tight leading.** Any italic word containing `y g j p q` needs leading of at least 1.1 and a little bottom reserve. Check every one.

## Color and material

- **Purple or blue AI-glow.** Neon accent, gradient halo behind a button, mesh in the background. Neutral bases with one high-contrast accent instead.
*Override:* the brand is purple. Then commit to it properly, with a harmonized palette and restrained gradients.
- **Pure `#000000` and pure `#ffffff`.** Both kill depth. Use off-black and off-white.
- **Oversaturated accents.** Desaturate until the accent sits inside the neutral family.
- **Outer glows and neon shadows.** Use an inner border or a tinted shadow.
- **Pure black drop shadows on light backgrounds.** Tint the shadow toward the background hue.
- **A second accent color appearing in section seven.** One accent, locked, used identically everywhere. A warm-grey page does not suddenly grow a blue call to action.
- **Mixed corner radii.** Pick one system: all sharp, all soft, or pill for interactive. Mixed is allowed only under a stated rule followed everywhere.
- **A section that flips theme mid-page.** One theme per page. A cream section between two near-black ones reads as a different website.
*Override:* one deliberate, well-transitioned theme switch used once as a compositional device.
- **Glass on everything.** Frosted panels are a material for a purpose, not a default surface. When used, add a hairline inner border and an inner highlight so the edge reads as physical, and provide a solid fallback for reduced transparency.
- **Custom mouse cursors.** Dated, hostile to accessibility, hostile to performance.

## Imagery

A landing page or portfolio is a visual product. A page of text and gradient blobs is not minimalism, it is unfinished.

1. **Generate real images if any image tool is available.** Section-specific assets at the right aspect ratio. Do not skip this because hand-rolled CSS feels faster.
2. **Otherwise use real photography sources** with descriptive seeds or the brief's own assets.
3. **Otherwise leave labeled placeholder slots** and say plainly which images the page needs and at what size.

Never fill the gap with:

- **Fake product screenshots built from divs.** A styled rectangle pretending to be a dashboard, a task list, or a terminal is the loudest tell there is. Use a real screenshot, a generated one, an actual working mini-version of the UI, or no preview at all.
- **Fake version stamps inside fake screenshots.** `v0.6.2-rc.1`, `last sync 4s ago`.
- **Hand-drawn decorative SVG.** Icons come from an icon library. A missing glyph means a second library, not hand-written paths.
*Override:* the brief asks for a mark, or it is one simple geometric shape you are confident in.

**Even restrained designs need images.** An editorial minimal site still needs a hero image and two or three supporting ones. Generate restrained photography rather than skipping imagery.

**Logo walls use real logos.** Text wordmarks in a row are a placeholder. Use a real icon source, or, for an invented brand, generate a simple monogram as inline SVG in the page's style. Ensure they work in both themes. And the wall is logos only: no industry label under each one. The logo is the credibility, "Stripe: payments" adds nothing.

**Icons come from one family, at one stroke width.** Never two families in one tree.

## Content and data

- **Placeholder names.** "John Doe", "Sarah Chan", "Acme", "Nexus", "SmartFlow". Use realistic, locale-appropriate names and brand names that sound like they exist.
- **Placeholder avatars.** The generic user glyph. Use believable photos or deliberate styling.
- **Suspiciously round numbers.** `99.99%`, `50%`, `1234567`. Real data is uneven.
- **Invented precision.** `4.1×`, `92%`, `5.8mm`, `13.4 lb` presented as fact. Real, labeled as an example, or absent.
- **Filler verbs.** Elevate, seamless, unleash, next-gen, revolutionize, empower, supercharge. Concrete verbs only.
- **Section labels borrowed from a workshop.** Headings that recast a testimonial block, a blog index, or a client roster as notes from a bench, dispatches from somewhere, or things currently in hand. The register is meant to signal care and instead signals costume. Name the section, or drop the heading.
- **Knowing asides about the industry.** A parenthetical nodding at the competition, or at the tradition, in a tone of amused modesty. It performs a personality the rest of the copy has not earned.
- **Data dumps on a marketing page.** A twenty-row table, a thirty-item award list, a full pricing matrix. Show three to five highlights and link to the rest, or accept that the data is the product and give it its own page.
- **Quotes longer than three lines.** A landing-page quote is a snippet. Cut it. Attribution is name plus role, never a bare first name.
- **Progress bars with filled background tracks** used as comparison visuals. Dashboard furniture on a marketing page. A number with a small icon, or a thin bar with no track.

## Punctuation

**The em dash is the single most reliable tell.** It appears in generated headlines, eyebrows, buttons, body copy, captions, and attributions at a rate no human writer matches. Treat it as unavailable: use a period, a comma, a colon, parentheses, or two sentences. Ranges take a plain hyphen. Attribution takes a hyphen with spaces, or a line break.

Use real typographic quotation marks, or none. Not straight ASCII quotes.

## Mechanical check

These are countable. Run them before delivering, on the actual output.

- [ ] Count small uppercase wide-tracked labels above headings. Is the count at most one per three sections?
- [ ] Count layout families across all sections. Are there at least four in a page of eight?
- [ ] Count consecutive image-plus-text splits. Is the longest run two or fewer?
- [ ] Count horizontal marquees. Is it zero or one?
- [ ] Count accent colors in use. Is it one?
- [ ] Count corner-radius values in use. Do they follow one stated system?
- [ ] Count em dashes anywhere visible. Is it zero?
- [ ] Count calls to action by intent. Does each intent have exactly one label? ("Get in touch" and "Let's talk" and "Start a project" are one intent with three labels.)
- [ ] Does any call-to-action label wrap to two lines at desktop? Shorten the label to three words or fewer, or widen the button.
- [ ] Is every button's text readable against its own background? White on white, and ghost buttons over photography with no scrim, both fail.
- [ ] Do form inputs, placeholders, labels, focus rings, and error text all pass contrast against their section background?
- [ ] Does the page use the same palette family as the last one you built for a similar brief? If yes, change it unless the brief or selected style fixes that palette.

## The honest version of this file

None of these patterns is wrong. Numbered steps, cream backgrounds, serif displays, and centered heroes have all been correct answers many times.

What makes them tells is that they arrive together, unprompted, on every brief. So the question to ask of each one is never "is this bad", it is **"did I choose this, or did I reach for it?"** If you cannot say why it suits this subject, it was a reflex, and it goes.
