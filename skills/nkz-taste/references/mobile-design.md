---
name: mobile-design
description: Tasteful interface design for NATIVE mobile apps (iOS-first, Expo / React Native). Premium, app-store-grade UI built on touch, gesture, haptics, sheets, and safe areas, not hover, tables, or sidebars. Use when designing screens, components, navigation, or full interface systems for a phone. For browser/desktop products use web-design.md. Produces calm, inevitable, physical-feeling interfaces that read as premium without decoration.
---

> **Part of [nkz-taste](../SKILL.md).** Frame the surface with [product.md](./product.md) before you design it. The states, forms, accessibility, and microcopy floor is [craft.md](./craft.md), and it is never optional. This file covers feel only. Aesthetic direction is [direction.md](./direction.md); the defaults to avoid reaching for are [ai-tells.md](./ai-tells.md).


> **Platform: NATIVE MOBILE.** iOS-first, Expo / React Native. For browser/desktop, use [Web Design](./web-design.md). Motion lives in [Animations → Mobile](./animations.md), behavior in [Interactions → Mobile](./interactions.md). Shared philosophy in [SKILL.md](../SKILL.md).

# Tasteful Mobile Design

Same goal as web: interfaces that feel **inevitable, calm, and coherent**. Different substrate. A phone is a small, held, touched, one-thumb surface with no cursor, no hover, no keyboard by default, a notch, a home indicator, and an OS with strong opinions. Premium on mobile = the app feels **physical and native**, not a website in a frame.

If the interface requires explanation, the design failed. If it fights the platform, it feels cheap.

---

# Core Philosophy

**Design removes friction from the thumb.**

The user holds the device in one hand and reaches with one thumb. They are walking, distracted, in sunlight, on cellular. The screen is the whole world, there is no second window, no tab strip, no "elsewhere."

Premium feel comes from three things web cannot give you:

- **Touch**, direct manipulation. The user pushes the pixels, not a proxy cursor.
- **Motion**, everything is alive and physical (springs, not cuts). See [Animations](./animations.md).
- **Haptics**, the device answers in the hand. See [Interactions](./interactions.md).

Color and decoration are still secondary. Layout, spacing, motion, and feedback carry the product.

---

# What Does NOT Transfer From Web

Before applying any web design instinct, kill these:

1. **No hover.** Hover does not exist. Every affordance must read as tappable at rest, and every press must answer instantly (scale + haptic). Never hide state or actions behind hover.
2. **No dense tables.** A spreadsheet on a phone is a failure. Convert tables to stacked cards, rows, or disclosure.
3. **No persistent sidebars.** Navigation is bottom tabs, a stack, or a sheet, not a left rail.
4. **No tiny targets.** Mouse precision is gone. See touch targets below.
5. **No layout that assumes a wide viewport.** Design for ~390pt wide, single column, vertical scroll first.
6. **No "click."** It is a tap, a press, a long-press, a swipe, a drag, a pan.

---

# The Rules of Tasteful Mobile Design

## Layout & Safe Areas

1. **Respect the safe area, always.** Top notch / dynamic island and bottom home indicator are sacred. Content and especially interactive elements must sit inside the safe area; only backgrounds bleed past it.

2. **Design edge-to-edge, pad inward.** Backgrounds, images, and color fields run to the physical edges. Text and controls are inset (typically 16-20pt horizontal).

3. **One primary column.** Phones scroll vertically. Resist multi-column. If you need columns, you probably need a different screen.

4. **Anchor primary actions to the bottom.** The thumb lives at the bottom third. Put the main CTA in a bottom bar or pinned footer, not the top.

5. **Top is for orientation, bottom is for action.** Title / back / context up top (harder to reach, lower frequency); commit actions down low.

6. **Layout must survive the keyboard.** When the keyboard opens it eats ~40% of the screen. Inputs must stay visible (keyboard-aware scroll / avoidance). Never let the keyboard cover the field being typed into.

7. **Layout must survive rotation and device sizes.** From small phones to large; from notch to no-notch. Use flexible layout, not fixed pixel positions.

## Spacing System

8. **Use a consistent spacing scale**, same discipline as web: 4 / 8 / 12 / 16 / 20 / 24 / 32 / 48.

9. **Screen gutters are typically 16-20pt.** Pick one and hold it across every screen so content edges align as the user moves between screens.

10. **Spacing between groups > spacing within groups.** Whitespace is still the primary hierarchy tool. Phones have less room, spend it deliberately, do not cram.

11. **Vertical rhythm rules.** The user scans top-to-bottom with a thumb on the scroll. Consistent vertical spacing makes scrolling feel calm.

## Touch Targets & Reachability

12. **Minimum touch target 44×44pt (iOS) / 48dp (Android).** Visual size can be smaller, but the tappable area cannot. Expand hit area with padding/insets if the glyph is small.

13. **Space targets apart.** Adjacent tap targets need gaps so the thumb does not mis-hit. Crowded controls feel cheap and frustrate.

14. **Keep frequent actions in the thumb arc.** The reachable zone is the bottom and center. Top corners are a stretch, reserve them for low-frequency controls (back, settings).

15. **Bigger is calmer.** Generous targets and generous spacing read as confident and premium. Tiny, tight controls read as a cramped web port.

## Visual Hierarchy

16. **One screen, one job.** A phone screen should have a single obvious primary task. Secondary actions recede or move into a sheet / menu.

17. **The primary element is obvious in one second**, through size, position (often bottom), and weight, before color.

18. **Required text stays readable, emphasis is rare.** Use subdued text for secondary information, and verify contrast on the actual surface.

19. **Progressive disclosure over density.** Phones cannot show everything. Reveal detail on tap (sheet, push, expand) instead of packing it in.

## Color & Surfaces

20. **Color communicates meaning, not decoration.** primary → main action, accent → highlight, destructive → danger, muted → secondary. One accent.

21. **Surfaces feel layered, not colorful.** Background → card → sheet → modal as ascending elevation. Premium apps lean quiet and tonal, not rainbow.

22. **Light AND dark mode are both first-class.** Native users live in dark mode. Design tokens, never hardcoded colors. The layout must hold without color (the grayscale test).

23. **Mind contrast in real conditions**, outdoor sunlight, low brightness, OLED blacks. Muted does not mean illegible.

## Typography

24. **Typography defines hierarchy**, same as web, but tuned for a held screen.

25. **Body text ~16-17pt.** Smaller feels cramped at arm's length. Labels ~12-13pt, headings 20-28pt, large display reserved for hero / onboarding moments.

26. **Respect Dynamic Type / font scaling where it matters.** Users set system font size for a reason; do not trap text at a fixed tiny size in core reading flows.

27. **Limit font families** (one primary, optionally one mono/numeric). Use a tabular/mono face for numbers that update (timers, counters) so they do not jitter.

## Shape & Depth

28. **Pick one radius philosophy and commit.** Mobile skews friendly, 8-16pt is common; cards and sheets often share a radius. Sheets typically have a larger top radius (16-24pt).

29. **Depth is shallow and purposeful.** Soft, low shadows or subtle tonal elevation. Heavy drop shadows everywhere read as dated/cheap. Let elevation mean "this floats above" (sheet, FAB, menu).

30. **Borderless by default.** Prefer surface contrast and spacing over outlines to separate regions. A one-sided accent border is an anti-pattern, use a dot, icon, or eyebrow for tone instead.

## Consistency & Stability

31. **Consistency is the strongest signal of quality**, a control behaves identically on every screen.

32. **Layout stays anchored.** Tapping must not shift unrelated content. Prefer sheets/overlays over reflow. Reserve space for async content with skeletons of the final dimensions so the screen does not pop-in and jump.

33. **Preserve scroll position.** Returning to a list lands where the user left it. Losing scroll position feels broken.

---

# Mobile Component Patterns

The native toolbox replaces web's cards/sidebars/tables. Reach for these, in roughly this order, before inventing layout.

## Navigation

- **Bottom tabs** for 3-5 top-level destinations. Persistent, thumb-reachable, the spine of most apps. Use native tabs where possible so they feel like the OS.
- **Stack (push/pop)** for drilling into detail. Back is a left-edge swipe AND a top-left button; never only one.
- **Modal screens** for self-contained, dismissable tasks (compose, create, full-screen flows). Slide up from bottom, dismiss down.
- Never bury primary navigation in a hamburger if it can be a tab.

## Sheets (the workhorse)

Bottom sheets are the native answer to popovers, dropdowns, and side panels.

- Use for: pickers, quick actions, contextual detail, short forms, confirmation with options.
- Snap points: a sheet should know its sizes (peek / half / full). Make peek show enough to be useful.
- A drag handle (grabber) signals "drag me." Dragging down dismisses; tapping the backdrop dismisses.
- Scrollable content inside a sheet must scroll without fighting the sheet's own drag gesture.
- Prefer a sheet over a new full screen when the task is short and the user should keep context.

## Lists

- **Virtualize long lists** (FlatList-style). Never map hundreds of rows into a ScrollView, it jank and leaks memory.
- Stable keys, fixed or measured row heights for smooth scroll.
- Pull-to-refresh for refreshable feeds; infinite scroll / load-more for paginated data.
- Swipe actions on rows (delete, archive) are native and discoverable with a slight reveal hint.
- Show a real empty state (illustration + one line + one action), never a blank screen.

## Inputs & Forms

- Right keyboard for the field (numeric, email, decimal). The keyboard is part of the design.
- Keyboard-aware layout so the active field and its submit button stay visible.
- Inline validation that does not shift layout; preserve input on error.
- For numbers/scales, prefer native-feeling pickers, steppers, or wheels over free text where it fits.

## Feedback Surfaces

- **Toasts / snackbars** slide from an edge for transient confirmation; pair undo with destructive actions instead of a confirm dialog when possible.
- **Skeletons** (shimmer at final dimensions) for loading, not blank-then-pop.
- **Haptics** accompany meaningful state changes, see [Interactions](./interactions.md).

## Media & Charts

- Use a real image component with caching/placeholders; reserve aspect-ratio space so images do not reflow on load.
- Charts/visuals should be touch-interactive where it adds value (scrub, tap-for-detail) and degrade gracefully to static.

---

# Premium Polish (what separates app-store-grade from a web port)

What makes a mobile app *feel* expensive is the accumulation of small native-correct details:

- **Motion follows the task.** Use springs for direct manipulation and occasional transitions. Routine updates can be instant; preserve feedback and respect reduced motion. (See [Animations](./animations.md).)
- **The device answers in the hand.** Key actions have haptics. Silence after a tap feels dead.
- **Gestures are first-class.** Swipe-back, drag-to-dismiss, pull-to-refresh, swipe-row, the user manipulates content directly.
- **Continuity.** Splash → first screen has no flash or jump. Navigation transitions are smooth and directional (push slides in from the right, modal up from the bottom).
- **System chrome is themed.** Status bar style and the OS navigation/home area match the screen's mode (light/dark) and do not clash.
- **Optical alignment.** Icons and glyphs are optically centered, not just mathematically. Trailing actions and leading icons sit in fixed-width slots so rows align down the column.
- **It respects the OS.** It feels like it belongs on the platform, native gestures, native back behavior, native keyboard, native share. A premium app borrows the platform's trust.
- **Restraint.** No gratuitous bounce, no rainbow, no decoration for its own sake. Calm and inevitable.

---

# Anti-Patterns

Avoid:

- hover-dependent affordances (there is no hover)
- tap targets under 44pt; crowded, mis-hittable controls
- content under the notch or home indicator
- dense tables and persistent sidebars ported from web
- hamburger menus hiding primary navigation
- instant hard cuts where a spring transition belongs
- blank loading screens that pop-in and shift layout
- ignoring dark mode, font scaling, or the keyboard
- heavy drop shadows everywhere; one-sided accent borders
- decoration that competes with the single screen task

---

# Decision Heuristics

When designing a mobile screen, ask:

1. What is the single primary task of this screen?
2. Can the thumb reach the primary action without shifting grip?
3. Does this belong as a push, a modal, or a sheet?
4. What happens when the keyboard opens?
5. Does it hold in dark mode and at larger font sizes?
6. What does the device say back (haptic) and how does it move (spring)?
7. What can be removed or deferred behind a tap?

If removing something does not harm the task, remove it.

---

# Design Test

A premium mobile screen passes these:

- Can a new user understand it in five seconds?
- Is every action one-thumb reachable, or intentionally not?
- Does it hold without color (grayscale test)?
- Does it hold in dark mode?
- Does nothing important sit under the notch or home indicator?
- Does it survive the keyboard opening?
- Does it feel native, springs, haptics, swipe-back, not like a website in a frame?

If yes, the screen is structurally sound and reads as premium.

---

# Final Principle

Premium mobile design is not decoration and not a shrunk-down website.

It is **making a held, touched, one-thumb surface feel physical, native, and inevitable.**
