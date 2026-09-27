---
name: craft
description: The craft floor. Everything a surface must handle to be finished rather than merely built: the four states, forms, accessibility to WCAG 2.2 AA, microcopy, and real-world content. Platform-neutral with native mobile (Expo / React Native) translations throughout. Read on every task, alongside a design file.
---

> **Never optional.** Hierarchy and motion are craft you can dial up or down. This file is the floor. A surface that fails here is unfinished, not under-polished.
>
> Style lives in [web-design.md](./web-design.md) / [mobile-design.md](./mobile-design.md). Motion lives in [animations.md](./animations.md). This file owns states, forms, access, and words. Cite items as C1, C2, and so on in reviews.

# The craft floor

The following checks are grouped by concern. A selected style does not waive this floor. Install its visual contract centrally, then take every visual value from the project's token source (see SKILL.md → *Tokens*). Where web and native diverge, the native translation is marked **RN**.

## States

The single largest gap in generated UI. Most code handles success and nothing else.

**C1. Four states, every data view.** Empty, loading, error, success. All four designed, all four coded, all four using tokens. Not "we will add the error state later": later never arrives, and the error state is what a user sees on their worst day.

**C2. Empty states are onboarding.** One line saying what belongs here and why it matters, plus a relevant next step when one exists. Do not invent a create action for read-only data. No shrug icons, no "No data available." This is the highest-attention moment in the product's life.

**C3. Distinguish empty from filtered-empty from errored.** "You have no runs yet" is a different screen from "No runs match these filters" (which needs a clear-filters action) and from "Could not load runs" (which needs a retry). Collapsing all three into one message is a bug.

**C4. Skeletons over spinners for content.** Use shape-matching placeholders sized like the real content, so the layout does not jump when data lands. A spinner is appropriate for an action; use a stable placeholder for content whose structure is known.

**C5. No layout shift on load.** Reserve space for images, avatars, and variable text before they arrive. Fix the dimensions, or the skeleton was pointless.

**C6. Delay content-loading indicators.** Use the selected style's delay, or about 200ms without one. Immediate action feedback still appears within 100ms. Faster than that and the flash of a skeleton is worse than the wait. Delay the indicator, never the response.

**C7. Optimistic UI for low-risk actions.** Likes, toggles, follows, reorders update immediately and reconcile silently. On failure, roll back and say so. Never make a user wait on a round trip to see a switch move.

**C8. Never optimistic for consequential actions.** Payments, deletions, sends, and anything with a receipt show real progress and a real result. Lying about a payment is not a nice touch.

**C9. Errors say what, why, and how to fix.** Three parts, plus a recovery path. "Could not save. Your session expired. Sign in again to keep your changes." Never "Something went wrong."

**C10. Error categories get different treatments.** Offline, timeout, permission denied, rate limited, validation, and server fault are six different problems with six different recoveries. One generic handler for all of them is a design decision to help nobody.

**C11. Errors appear where the problem is.** Field errors at the field. Form errors at the submit. Page errors at the page. A toast for a field error makes the user hunt.

**C12. The success moment gets real design.** Confirm what happened, show the result, and offer the obvious next step. The end of a flow is disproportionately what people remember, and it is usually a bare toast.

**C13. Long operations show progress, not just activity.** If it exceeds a few seconds, show a determinate bar, a step count, or a running item name. An indeterminate spinner for thirty seconds reads as broken.

## Forms

**C14. Labels above inputs and an unambiguous reading order.** Default to one column. A selected recipe may use two columns for independent settings or paired fields when labels, help, and values fit. Stack at narrow widths; keep sequential forms in one column.

**C15. Never placeholder-as-label.** The label vanishes when typing starts, breaks autofill, and fails screen readers. Every input gets a real `<label htmlFor>`, or wraps its input. **RN:** a real `<Text>` label above the field, plus `accessibilityLabel`.

**C16. Right `type` and `inputmode`.** `type="email"`, `type="tel"`, `type="url"`, `inputmode="numeric"` or `"decimal"`. The wrong mobile keyboard is a small tax on every single entry. **RN:** `keyboardType`, plus `autoCapitalize="none"` on emails and usernames.

**C17. `autocomplete` on everything.** `email`, `name`, `new-password`, `current-password`, `one-time-code`, `postal-code`, `cc-number`. Saves real seconds and respects password managers. **RN:** `textContentType` and `autoComplete`.

**C18. Validate on blur, clear on change.** Validating each keystroke shows an error for every half-typed email. Clear the error the moment the value becomes valid, not on the next submit.

**C19. Never validate a field the user has not touched.** A form covered in red before any interaction is hostile.

**C20. Prevent the error instead of reporting it.** Use `min`, `max`, `step`, `pattern`, a date picker, a constrained select. A value that cannot be entered needs no error message.

**C21. Never disable submit without saying why.** A dead button with no explanation is a dead end. Either enable it and show what is missing on click, or state the requirement next to the button.

**C22. Preserve input through every failure.** A failed submit returns the form filled. Back returns the form filled. A crash returns a draft. Losing typed work is the fastest way to lose a user.

**C23. Be liberal in what you accept.** Trim whitespace, strip formatting from pasted card and phone numbers, accept several date formats, match case-insensitively. Reject only what is genuinely ambiguous.

**C24. Smart defaults absorb complexity.** Detect timezone, locale, and currency. Pre-select the safe option. Pre-fill from the last entry. Every field you can remove by inference is a field that cannot be filled in wrong.

**C25. Ask for the minimum.** Every field needs a reason it is collected now rather than later or never. Optional fields marked optional, not required ones marked required.

**C26. Format long strings in chunks.** Card numbers, phone numbers, IDs, and codes are read and verified in groups. Do it as they type.

**C27. Allow paste everywhere, especially passwords and codes.** Blocking paste breaks password managers and helps nobody. Pair one-time codes with `autocomplete="one-time-code"`.

**C28. Autofocus the first field on a single-purpose form**, and nowhere else. **RN:** be careful, an autofocus that opens the keyboard over content is worse than no autofocus.

## Accessibility (WCAG 2.2 AA)

Not a compliance exercise. Every item here also makes the product better for people with no impairment at all, in sunlight, on a train, one-handed, tired.

**C29. Body text contrast at least 4.5:1.** Large text (at least 24px, or 18.66px bold) may drop to 3:1. Check the actual token pair, do not assume.

**C30. Interactive components at least 3:1.** Input borders, icon-only buttons, focus rings, chart strokes, and toggle tracks, each against what sits next to it. A 1px hairline border that nobody can see is not a border.

**C31. Color is never the only signal.** Pair every color-encoded state with an icon, a label, a shape, or a pattern. Red and green are the same color to a meaningful share of users.

**C32. Semantic elements before divs and ARIA.** `<button>`, `<a>`, `<label>`, `<main>`, `<nav>`, `<h1>`. A div with a click handler is not a button and never will be. Reach for `role=` only when nothing native fits. **RN:** `accessibilityRole`, `accessibilityLabel`, `accessibilityState`, and `accessible` on composed rows.

**C33. Everything reachable and operable by keyboard.** Tab, Shift+Tab, Enter, Space, Arrows, Escape. Modals trap focus, return it on close, and close on Escape. Test the whole flow with the mouse unplugged.

**C34. Visible focus, always.** Never `outline: none` without a `:focus-visible` replacement of at least 2px at 3:1. Focus that is invisible is keyboard navigation that does not work.

**C35. Focus is never obscured.** Sticky headers and footers must not cover the focused element. Set `scroll-padding-top` and `-bottom` to the sticky heights.

**C36. Focus order follows visual order.** If the DOM order and visual order disagree, fix the DOM, not the tab index.

**C37. Pointer targets at least 24×24, touch targets at least 44×44.** The visual element can be smaller than its hit area: pad or use a hit slop. **RN:** `hitSlop`.

**C38. Text scales.** Layout survives the user increasing text size, and line-height at 1.5×, letter-spacing at 0.12em, word-spacing at 0.16em. **RN:** honor Dynamic Type, and never lock `allowFontScaling={false}` on content.

**C39. Reflow at 320px without page-level horizontal scroll.** A table or other inherently two-dimensional content may use a labeled, keyboard-accessible, bounded horizontal scroller. Other content and actions must reflow.

**C40. Motion is opt-out.** Honor `prefers-reduced-motion`. Replace transforms with an instant change or a short fade, and never remove the feedback entirely. **RN:** `AccessibilityInfo.isReduceMotionEnabled`.

**C41. No hover-only information.** A tooltip that appears only on hover does not exist on touch. Critical content is visible by default.

**C42. Every drag has a non-drag alternative.** Sorting, resizing, and swipe-to-delete each need a button or menu equivalent.

**C43. Accessible authentication.** No cognitive puzzles to sign in. Paste allowed. Show-password toggle. Biometric where the platform offers it.

**C44. Images have alt text, and decorative images have empty alt.** Describe the meaning, not the file. **RN:** `accessible={false}` on decorative images so they do not clutter the reader.

**C45. Announce what changed.** A live region for async results, toasts, and validation summaries. A screen reader user does not see the toast. **RN:** `AccessibilityInfo.announceForAccessibility`.

## Microcopy

Words are interface. They are also the cheapest part of the product to fix and the most often left as a placeholder.

**C46. Buttons name their outcome, not their mechanism.** "Save changes", "Create flow", "Send invite". Never "Submit", "OK", or "Confirm" alone.

**C47. Write plain words.** No jargon, no internal system names, no acronyms the user has not been taught. If a term comes from your database schema, it is the wrong term.

**C48. Say what will happen before it happens.** "This deletes 12 runs and cannot be undone" beats "Are you sure?". A confirmation that carries no information is a speed bump, not a safeguard.

**C49. Never blame the user.** "Invalid input" is an accusation. "Enter a date after today" is help.

**C50. Be specific in empty and error states.** "No results for 'flow-3'" beats "No results". The specific version tells the user what to change.

**C51. Consistent terms.** One word per concept, everywhere, including the code. A "run" in the UI is not a "job" in the toast and an "execution" in the error.

**C52. No exclamation marks, no false enthusiasm, no apology theatre.** State the fact. "Saved" is complete.

**C53. Keep numbers honest.** Round consistently, show units, use tabular figures so columns align, and never show a raw float or a millisecond timestamp to a person.

## Real content

**C54. Design with the worst realistic data.** The longest name, the missing avatar, the null field, the four-hundred-item list, the emoji, the right-to-left string. Every layout that only works with the mock is broken.

**C55. Truncate with a way to see the full value.** Tooltip, expand, or detail view. Never a hard cut with nothing behind it.

**C56. Singular and plural, and zero.** "1 run", "2 runs", "No runs". Never "1 run(s)".

**C57. Format for humans.** Relative time for recent events ("3 min ago"), absolute for old ones, and the exact value on hover or long-press. Locale-aware numbers and currency.

**C58. Long lists get pagination, virtualization, or infinite scroll.** Pick deliberately. Infinite scroll destroys the footer and the ability to return to a position, so it suits feeds and not tables.

**C59. Sorting and filtering state is visible and clearable.** The user must see why they are looking at these twelve items, and get back to all of them in one action.

**C60. Nothing is lost on refresh.** URL state for filters, tabs, and pagination on web, so a link is shareable and back works. **RN:** persist navigation and draft state across background and relaunch.

## AI surfaces

If the product streams model output, these are craft, not extras.

**C61. Stream, and make Stop a primary control.** Visible while streaming, at full affordance weight, and it aborts the underlying request rather than only hiding the UI.

**C62. Show the work as labeled steps.** Thinking, searching, calling a tool, reading a file. An opaque wait feels broken, the same wait with steps feels fast.

**C63. Model output is an editable draft.** The user can edit it, accept part of it, regenerate, or reject. Treating generated text as final output is the most common mistake in AI UI.

**C64. Cite sources inline, one click to open.** An unverifiable claim is worth less than no claim.

**C65. Distinguish AI failures.** Network, rate limit, content filter, context length, and model error each need their own message and their own recovery.
