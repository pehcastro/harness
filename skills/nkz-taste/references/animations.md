---
name: animations
description: Motion for product UI. When to animate at all, how fast, which curve, and the techniques that separate motion that feels designed from motion that feels added. Web mechanics (CSS, Motion) plus a native section for Expo / React Native (Reanimated, gestures, springs). Pair with web-design.md or mobile-design.md.
---

> **Part of [nkz-taste](../SKILL.md).** Frame the surface with [product.md](./product.md) before you design it. The states, forms, accessibility, and microcopy floor is [craft.md](./craft.md), and it is never optional. This file covers feel only. Aesthetic direction is [direction.md](./direction.md); the defaults to avoid reaching for are [ai-tells.md](./ai-tells.md).
>
> **Platforms:** the decision framework, timing, and easing **principles** are universal. The CSS and Motion **mechanics** are web only. For native (Expo / React Native), read [Native motion](#native-motion-expo--react-native) instead of the CSS and Motion sections.

> A selected style defines its motion budget. The examples below are options, not mandatory effects: do not add entrance fades, scroll reveals, or animated tabs when its contract excludes them. Reduced motion, input responsiveness, and layout stability still apply.

# Motion

Motion is not for moving things. It is for keeping the user oriented while things move anyway.

Nobody should notice an animation. If a user sees motion, there was too much of it. Motion exists to keep continuity, to confirm an action, and to explain a change. Nothing else.

The most common mistake in motion work is not a bad curve or a bad duration. It is animating something that should not have animated at all, and no amount of tuning fixes that.

## 1. Should this animate at all?

Ask how often the user will see it. This one question kills most bad animation before it is written.

| How often the user sees it | Decision |
|---|---|
| Hundreds of times a day (keyboard shortcuts, command palette, tab switch) | **No entrance choreography; immediate feedback remains.** |
| Dozens of times a day (hover, list navigation, filter toggle) | Remove it, or cut it to the minimum |
| Occasionally (modal, drawer, toast, page change) | Standard animation |
| Rarely or once (onboarding, first success, celebration) | Delight is allowed here |

**Never animate a keyboard-initiated action.** Someone who reached for a shortcut reached for it to save time, and any transition spends that time back. The best command palettes open with no transition at all. That looks abrupt in a screen recording and feels instant in use, and only one of those two things matters.

Then state the purpose in one sentence. Valid purposes:

- **Continuity.** The thing that was here is now there, and the eye followed it.
- **Feedback.** The interface heard the press.
- **Spatial consistency.** The toast leaves the way it arrived, so swipe-to-dismiss feels obvious.
- **Explanation.** A marketing or onboarding moment that shows how something works.
- **Preventing a jump.** Elements appearing or vanishing with no transition read as broken.

If the only answer is "it looks nice" and the user will see it often, do not animate it. If the answer is "it looks nice" and the user will see it once, that is a legitimate answer.

## 2. Duration

| Element | Duration |
|---|---|
| Press feedback | 100 to 160ms |
| Tooltips, small popovers | 125 to 200ms |
| Dropdowns, selects, menus | 150 to 250ms |
| Modals, drawers, sheets | 180 to 280ms |
| Multi-step orchestration, total | 400 to 600ms |
| Marketing and explanatory | Longer is allowed |

Rules that hold across all of it:

1. **UI motion stays under 300ms.** A 180ms dropdown feels more responsive than a 400ms one, and the content is identical.
2. **Exits are faster than entrances.** The user is waiting to do the next thing. Enter at 240ms, exit at 160ms.
3. **Nothing exceeds one second.** Past a second it is not an animation, it is a loading screen.
4. **Speed is perceived performance.** A faster spinner makes the same load feel shorter. An instant second tooltip makes the whole toolbar feel quick. This is not a trick, it is how people judge software.

## 3. Easing

```
Entering or exiting?  → ease-out
Moving between two on-screen positions?  → ease-in-out
Hover or color change?  → ease
Constant motion (marquee, indeterminate bar)?  → linear
Unsure?  → ease-out
```

**Never use `ease-in` for UI.** It starts slow, which delays movement at the exact moment the user is watching hardest. A dropdown with `ease-in` at 300ms *feels* slower than the same dropdown with `ease-out` at 300ms.

**The built-in CSS curves are too weak.** `ease-out` on its own lacks the snap that makes motion read as intentional. Use stronger custom curves:

```css
:root {
  --ease-out:     cubic-bezier(0.23, 1, 0.32, 1);      /* UI entrances, the workhorse */
  --ease-in-out:  cubic-bezier(0.77, 0, 0.175, 1);     /* on-screen movement */
  --ease-drawer:  cubic-bezier(0.32, 0.72, 0, 1);      /* iOS-like sheet, from Ionic */
  --ease-snappy:  cubic-bezier(0.16, 1, 0.3, 1);       /* short, decisive */
  --ease-bounce:  cubic-bezier(0.34, 1.56, 0.64, 1);   /* overshoot, use rarely */
}
```

Do not invent curves from scratch. [easing.dev](https://easing.dev/) and [easings.co](https://easings.co/) have stronger variants of every standard curve.

**Related elements share a curve.** A modal and its backdrop that ease differently look like two separate events.

## 4. Springs

Springs simulate physics, so they have no fixed duration. They settle. Use them for anything the user can grab.

**When a spring is right:** drag with momentum, gesture-driven motion, anything interruptible mid-flight, decorative motion that should feel alive.

**When a duration is right:** precise fades, progress, anything that must finish at a known time, anything on a dense functional surface where physicality would be noise.

The decisive advantage is interruption. A spring keeps its velocity when retargeted. A CSS keyframe restarts from zero. So an expanded item that the user dismisses mid-open reverses smoothly from wherever it is, instead of snapping.

Two ways to configure. Apple's is easier to reason about:

```js
{ type: "spring", duration: 0.5, bounce: 0.2 }          // preferred
{ type: "spring", mass: 1, stiffness: 100, damping: 10 } // more control
```

Keep bounce between 0.1 and 0.3, and spend it only on drag-to-dismiss and playful moments. Bounce on a routine menu open is the animation equivalent of an exclamation mark.

**Spring your mouse-tracking too.** Tying a rotation or offset directly to cursor position feels artificial because it has no momentum. Run the value through a spring and it feels physical. This is decoration, so it belongs on a marketing page and not on a banking chart.

## 5. What to animate

1. **Prefer transform and opacity for entry/exit.** They are commonly compositor-friendly. Brief color, border, and shadow transitions are valid for hover/press feedback; profile expensive effects.
2. **Never `width`, `height`, `top`, `left`, `margin`, or `padding`.** All three rendering stages, every frame.
3. **Never from `scale(0)`.** Objects do not grow out of a point. Start at `scale(0.95)` or higher and let opacity carry the rest of the entrance. The element has to already have a size at frame one, even a size nobody can see, or it reads as popping into existence.
4. **Movement is optional.** If the chosen direction calls for a fade-and-rise entrance, use: `opacity 0` plus `translateY(8px)` to `opacity 1` plus `translateY(0)`.
5. **Keep distances short.** 4 to 16px for micro-interactions, 20 to 40px for larger reveals. Beyond that it reads as cartoon.
6. **Animate between two definite states.** Never to or from `auto` without measuring first.

### `transform-origin` is a decision, not a default

A popover should scale out of its trigger, not out of its own center. The default `transform-origin: center` is wrong for nearly every anchored element.

```css
.popover { transform-origin: var(--transform-origin); } /* set from the trigger position */
```

**Exception: modals keep `center`.** A modal is not anchored to anything, it belongs to the viewport.

Whether one user consciously notices this does not matter. In aggregate, unseen correctness is what people mean when they say an interface feels good.

### Percentages in `translate` are self-relative

`translateY(100%)` moves an element by its own height, whatever that height turns out to be. This is how drawers hide offscreen and how toasts stack. Prefer it to hardcoded pixels: it cannot go stale when the content changes.

### `scale()` scales children

Unlike `width` and `height`, `scale` takes the text, the icons, and the padding with it. When you compress a button on press, everything inside compresses proportionally. That is what makes it read as a physical push.

## 6. Interaction states

1. **Press feedback is immediate.** Use the selected style's treatment. Without one, a tonal change or restrained compression can work. Do not scale every control, especially anchored popup triggers.
2. **Hover: instant on, about 150ms off.** Respond the moment the cursor arrives, ease out when it leaves so it does not snap.
3. **Gate hover behind a media query.** Touch devices fire hover on tap, which leaves elements stuck in a hover state. `@media (hover: hover) and (pointer: fine)`.
4. **Never animate the focus ring itself.** Animate the element. The ring is an accessibility signal and must appear instantly.
5. **Disabled means no motion.** Do not tease a hover effect on something that cannot be clicked.
6. **Tooltips delay first, then go instant.** The first tooltip waits so it does not fire accidentally. Once one is open, adjacent tooltips open with zero delay and zero animation. The toolbar feels twice as fast and the accident protection is intact.

## 7. Entrance, exit, orchestration

- **Fade and rise to enter:** `opacity 0, y 8` to `opacity 1, y 0`. The default for a reason.
- **Modals:** `scale(0.96)` plus opacity, centered origin.
- **Menus and popovers:** scale plus opacity from the trigger origin.
- **Toasts:** slide from the edge they will return to, so dismissal is obvious.
- **Scale for emphasis, translate for navigation.** Opening something important scales. Moving to a new view slides.
- **Commit to a direction.** Enter from the bottom means exit to the bottom.
- **Order matters:** backdrop, then container, then content, then actions. The most important element leads.
- **Stagger 30 to 60ms** between related items only. Keep the group to 3 to 7, or the last item waits too long. Never block interaction while a stagger plays.
- **Exit in reverse or all at once.** Never re-stagger an exit forward.

### Asymmetric timing

Slow where the user is deciding, fast where the system is responding. A hold-to-delete fills over 2 seconds with linear timing, and snaps back over 200ms with ease-out the instant the finger lifts. The same principle applies wherever a gesture has a commit point.

## 8. Techniques worth knowing

### Transitions beat keyframes for anything interruptible

A CSS transition can be retargeted mid-flight. A keyframe restarts from zero. For anything the user can trigger rapidly (adding toasts, toggling a panel, spamming a button), transitions produce visibly smoother results.

Keyframes stay correct for predetermined, non-interruptible motion: a shimmer, a marquee, a one-shot page-load sequence.

### `@starting-style` for entry, with no JavaScript

```css
.toast {
  opacity: 1;
  transform: translateY(0);
  transition: opacity 180ms var(--ease-out), transform 180ms var(--ease-out);

  @starting-style {
    opacity: 0;
    transform: translateY(100%);
  }
}
```

This replaces the `useEffect` plus `mounted` state pattern. Fall back to a `data-mounted` attribute where support is not there yet.

### Blur to rescue a crossfade

When two states crossfade and it looks wrong no matter the duration or curve, the problem is that the eye sees two overlapping objects. A small `filter: blur(2px)` during the transition blends them, and the eye reads one thing transforming instead of two things swapping.

Keep blur under 20px. It is expensive, especially in Safari.

### `clip-path` is an animation tool

`clip-path: inset(top right bottom left)` eats into an element from each side, and it animates.

- **Reveal:** `inset(0 100% 0 0)` to `inset(0 0 0 0)` wipes left to right.
- **Scroll reveal:** `inset(0 0 100% 0)` to `inset(0 0 0 0)` when the element enters the viewport.
- **Hold to confirm:** the overlay fills over 2s linear while pressed, and snaps back over 200ms on release.
- **Perfect tab color transitions:** duplicate the tab list, style the copy as active, clip the copy to the active tab, and animate the clip. Timing individual color transitions can never match this.
- **Comparison slider:** two stacked images, `inset` on the top one driven by drag position. No extra DOM, fully accelerated.

### Gestures

- **Velocity beats distance.** Do not require dragging past a threshold. Compute `abs(distance) / elapsed` and dismiss on a quick flick even if it was short. Around 0.11 is a reasonable cutoff.
- **Damp at the boundaries.** Dragging a sheet past its top should keep moving, less and less. Real things slow before they stop, they do not hit a wall.
- **Capture the pointer** once a drag starts, so leaving the element bounds does not cancel it.
- **Ignore extra touches** after a drag begins, or switching fingers teleports the element.

## 9. Performance

1. **Prefer compositor-friendly entry/exit properties.** Avoid broad repainting and profile the actual effect.
2. **CSS beats JavaScript under load.** CSS animations run off the main thread. A `requestAnimationFrame` loop drops frames exactly when the browser is busy loading, which is exactly when the user is watching. Use CSS for predetermined motion and JavaScript for dynamic, interruptible motion.
3. **Motion's shorthand props are not hardware accelerated.** `x`, `y`, and `scale` run on the main thread. Animate the full `transform` string when smoothness under load matters.
4. **Do not drive continuous values through React state.** Mouse position, scroll progress, drag offset. Every change re-renders the tree. Use motion values, or set the style directly.
5. **CSS variables inherit, so they are expensive.** Setting `--swipe-amount` on a container recalculates styles for every child. Set `transform` on the moving element instead.
6. **`will-change` goes on just before and comes off just after.** Never permanently.
7. **Never `window.addEventListener('scroll')` for animation.** Use scroll-driven CSS animations, `IntersectionObserver`, or the library's scroll primitives.
8. **`will-change`, grain, and noise belong on fixed, `pointer-events: none` layers,** never on a scrolling container. Continuous repaint destroys mobile frame rates.
9. **`transition: all` is a bug.** Name the properties.
10. **Test on a cheap Android.** The animation that is buttery on your laptop is a slideshow on a $200 phone.

## 10. Accessibility

**Reduced motion means less motion, not no feedback.** Keep opacity and color transitions that aid comprehension. Remove movement, parallax, scroll hijacking, and physics.

```css
@media (prefers-reduced-motion: reduce) {
  .element { animation: fade 200ms ease; } /* no transform-based motion */
}
```

In JavaScript, read the preference and degrade the value rather than deleting the animation:

```jsx
const reduce = useReducedMotion();
const enterX = reduce ? 0 : '-100%';
```

Infinite loops, parallax, and gesture physics all collapse to static or instant under reduced motion.

## 11. Debugging

- **Play it at a quarter speed.** Multiply the duration by 4 temporarily, or use the DevTools animation panel. At full speed you cannot see what is wrong, only that something is.
- **What to look for in slow motion:** two states visibly overlapping in a crossfade, easing that starts or stops abruptly, a wrong transform origin, properties that are meant to be in sync drifting apart.
- **Step frame by frame** in the DevTools Animations panel for coordination problems between properties.
- **Review it the next day.** You will see timing faults with fresh eyes that were invisible while building.
- **Test gestures on real hardware.** A simulator does not reproduce touch latency or finger tracking.

## 12. When not to animate

- Anything keyboard-initiated.
- Form validation errors. Change the color and the icon instantly.
- Critical errors. Never delay bad news.
- Content the user is currently reading.
- High-frequency updates: live data, timers, counters.
- Anything seen hundreds of times per session.

## 13. Cohesion

Match the motion to the personality. A playful product can overshoot. A dense professional tool stays crisp and fast.

The components people describe as feeling expensive usually break one timing convention on purpose. They run slightly slower, or settle slightly softer, than the UI around them. They get away with it because everything else agrees: the visual design, the naming, the documentation, the copy. Nothing contradicts the choice, so it reads as character.

That is the whole lesson. A duration and a curve are a voice. Pick one voice, hold it everywhere, and the one deviation you make deliberately will read as intent rather than as inconsistency.

## Checklist

- [ ] Every animation has a purpose you can state in one sentence.
- [ ] Nothing keyboard-initiated animates.
- [ ] Nothing high-frequency animates.
- [ ] Durations under 300ms for UI, exits faster than entrances.
- [ ] Custom curves, never `ease-in` on UI, never `transition: all`.
- [ ] Nothing starts from `scale(0)`.
- [ ] Anchored elements scale from their trigger, modals from center.
- [ ] Entry/exit prefers transform and opacity; other effects are justified and checked for performance.
- [ ] Interruptible motion uses transitions or springs, not keyframes.
- [ ] Hover gated behind `@media (hover: hover)`.
- [ ] Press feedback on every pressable element.
- [ ] Reduced motion handled, with feedback preserved.
- [ ] Reviewed at quarter speed where coordination is uncertain; do not block delivery on a next-day review.
- [ ] Smooth on a low-end device.

---

# Native motion (Expo / React Native)

No CSS, no Motion. Everything runs on **Reanimated** worklets on the UI thread, with **gesture-handler** for touch. Sections 1 through 4 and 6 through 13 above still apply. The mechanics change.

## What is different

- **Think in springs, not durations.** Native motion is physical. `withSpring` for anything the user triggers or drags. `withTiming` only for precise fades and progress.
- **Stay on the UI thread.** Shared values plus `useAnimatedStyle`. Never drive continuous or gesture-linked motion from React state.
- **Transform and opacity.** Same list. For size and position change, use Reanimated layout animations rather than animating layout props.
- **Reduce Motion is an OS flag, not a media query.** `AccessibilityInfo.isReduceMotionEnabled`. Still not optional.
- **No hover.** The press state is the entire "is this interactive" signal at touch time.
- **Test on real low-end hardware,** not the simulator.

## Press is the core micro-interaction

Compress on press-in, spring back on release, with a haptic. See [Interactions → Mobile](./interactions.md).

```tsx
const scale = useSharedValue(1);
const style = useAnimatedStyle(() => ({ transform: [{ scale: scale.value }] }));

<Pressable
  onPressIn={() => { scale.value = withSpring(0.97, { damping: 18, stiffness: 320 }); }}
  onPressOut={() => { scale.value = withSpring(1, { damping: 12, stiffness: 220 }); }}
>
  <Animated.View style={style}>{children}</Animated.View>
</Pressable>
```

## Spring presets

```ts
{ damping: 18, stiffness: 320 }  // snappy: press, toggles, small moves
{ damping: 15, stiffness: 180 }  // standard: sheets, cards, content settle
{ damping: 20, stiffness: 120 }  // gentle: full-screen, large travel
```

Lower damping means more overshoot. Spend it on playful moments only.

## Entrances, exits, lists

- **Layout animations** (`Layout`, `FadeIn`, `SlideInDown`) handle mount, unmount, and reflow on the UI thread. Prefer them to manual orchestration.
- **Fade and rise** stays the entrance default.
- Avoid staggering routine lists. Use stagger only for an occasional, explicitly chosen explanatory sequence.
- **Exit faster than enter.**

## Gestures are the motion

This is where premium native feel lives, and it is the part web rarely has. Drive shared values straight from the gesture for 1:1 finger tracking, then spring to a snap point on release using velocity, not just position.

- **Drag to dismiss:** follow the finger, then spring to dismissed or to rest based on velocity and threshold.
- **Bottom sheet:** `translateY` follows the drag, release springs to the nearest snap point.
- **Swipe row actions:** reveal under the finger, spring open or closed past the threshold.
- **Damp past the boundary** rather than stopping dead.

A transition the user can grab mid-flight feels alive. One that ignores the finger feels like a web page in a frame.

## Native checklist

- [ ] Springs settle without lingering wobble.
- [ ] Motion runs on the UI thread, no jank during JavaScript work.
- [ ] Gesture-linked motion tracks 1:1 and is interruptible.
- [ ] Velocity, not only distance, decides a commit.
- [ ] System Reduce Motion honored.
- [ ] Press feedback plus haptic on every interactive element.
- [ ] Smooth on a real low-end Android.
