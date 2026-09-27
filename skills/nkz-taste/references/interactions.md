---
name: interaction
description: Tasteful interface interaction patterns. Defines how interfaces respond to user input, feedback, loading, errors, state. Web framing (clicks, hover, keyboard) plus a Mobile section for native Expo / React Native (touch, gesture, haptics, no hover). Pair with web-design.md or mobile-design.md.
---

> **Part of [nkz-taste](../SKILL.md).** Frame the surface with [product.md](./product.md) before you design it. The states, forms, accessibility, and microcopy floor is [craft.md](./craft.md), and it is never optional. This file covers feel only. Aesthetic direction is [direction.md](./direction.md); the defaults to avoid reaching for are [ai-tells.md](./ai-tells.md).
>
> **Overlap:** rules 7, 13-17 below (loading, errors, destructive actions) are stated in more depth in [craft.md](./craft.md) as C1-C13 and C48. Where the two differ, craft.md wins.


> **Platforms:** the 30 principles below are mostly universal, but framed for mouse + keyboard (hover, focus ring, command palette). For native (Expo / React Native), the translation, touch targets, haptics, gestures, no hover, is in [Mobile Interaction](#mobile-interaction-expo--react-native).

# Tasteful Interface Interaction

This skill defines how interfaces behave when users interact with them.

Good interaction design makes interfaces feel **responsive, predictable, and forgiving**.

Users should never wonder:

- "Did that work?"
- "Can I click this?"
- "What just happened?"

The interface must answer these questions immediately.

---

# Core Philosophy

**Every user action deserves feedback.**

When users interact with an interface, something must happen:

- visual feedback
- state change
- loading indicator
- confirmation
- error message

Silence creates uncertainty.

---

# The 30 Rules of Tasteful Interaction

## Affordance

1. Clickable elements must look clickable.

2. Hover states should hint at interactivity.

3. Disabled elements should clearly appear inactive.

4. Use the chosen control geometry; hit targets meet craft.md C37 (24px pointer minimum, 44px touch minimum).

---

## Feedback

5. Every action should produce immediate feedback.

6. Button presses should visually respond instantly.

7. Content loading indicators use the selected style's delay, or about 200ms without one. Immediate action feedback is separate.

8. Avoid leaving users uncertain whether an action worked.

---

## Responsiveness

9. Interfaces should respond within 100ms to user input.

10. Immediate visual feedback is more important than completing the operation.

11. Use optimistic UI when possible.

12. If something takes time, communicate progress.

---

## Error Handling

13. Errors should be clear and actionable.

14. Never blame the user.

15. Preserve user input when errors occur.

---

## Destructive Actions

16. Irreversible destructive actions require confirmation; reversible actions can offer undo.

17. Prefer undo over confirmation when possible.

18. Dangerous actions should be visually distinct.

---

## Keyboard & Power Users

19. Common actions should support keyboard shortcuts.

20. Focus states must be visible.

21. Command palettes improve complex interfaces.

---

## State Communication

22. Interfaces should always communicate current state.

23. Loading states should never block unrelated actions.

24. Users should know whether something is saving, loading, or complete.

---

## Trust & Predictability

25. Interfaces should behave consistently.

26. The same action should always produce the same result.

27. Avoid surprising behavior.

---

## Forgiveness

28. Allow users to undo mistakes when possible.

29. Preserve work whenever possible.

30. Prevent errors instead of reacting to them.

---

# Mobile Interaction (Expo / React Native)

On a phone there is no cursor, no hover, and no keyboard until summoned. Feedback that web gives through hover and focus, mobile gives through **touch state, motion, and haptics**. "Interaction without feedback is not interaction" becomes literal: the device must answer in the hand.

## Touch replaces click + hover

1. **No hover, every affordance reads as tappable at rest.** You cannot reveal interactivity on hover. State, actions, and affordances are visible before touch.
2. **Press state is mandatory and instant.** On press-in: compress (`scale 0.97`) + optional opacity dip. This is the web "active" state promoted to the primary signal. See [Animations → Mobile](./animations.md).
3. **Touch targets ≥ 44×44pt (iOS) / 48dp (Android).** Web's "32px tall" is too small for a thumb. Expand hit area beyond the visible glyph when needed.
4. **Space targets apart** so the thumb does not mis-hit neighbors.

## Haptics: the device answers

Haptics are the native superpower web lacks. Use them as confirmation, not decoration. A consistent vocabulary:

- **Light tap**, routine taps, toggles, selection committed, small affordances.
- **Medium / heavier**, a meaningful commit or confirmation (save, send, add).
- **Selection tick**, scrolling through discrete values: pickers, wheels, segmented controls. One tick per value crossed.
- **Success / warning / error notification**, the *outcome* of an operation (saved ✓, validation failed ✗). Pair with visual, never haptic-only.

Rules:
- Haptic accompanies a state change, not every finger movement. Buzzing constantly desensitizes and feels cheap.
- Be consistent: the same action fires the same haptic everywhere.
- Respect the system setting, if the OS/user disables haptics, do not fight it.
- Never use haptics as the *only* feedback (accessibility), always pair with visual/motion.

## Gestures

Direct manipulation is expected on native. Make the common ones work and discoverable:

- **Swipe-back** to pop a screen (left-edge). Always available alongside the back button.
- **Drag-to-dismiss** sheets and modals (pull down). Backdrop tap also dismisses.
- **Pull-to-refresh** on refreshable lists.
- **Swipe row actions** (delete/archive) with a slight reveal hint so they are discoverable.
- Gesture motion tracks the finger 1:1 and is interruptible; release springs to a snap point using velocity + threshold. See [Animations → Mobile](./animations.md).
- Do not hide *only* path to an action behind a gesture, gestures are accelerators, with a visible fallback.

## Responsiveness & state

- **Respond within ~100ms; tap feedback is immediate** even if the operation is async. Optimistic UI where safe.
- **Loading: skeletons at final dimensions**, not spinners or blank-then-pop. No layout jump.
- **Offline / poor network is normal on mobile.** Communicate connection state, queue and retry, preserve user input. Never lose work to a dropped request.
- **Keyboard is part of the interaction.** Right keyboard per field; keep the active field and its submit visible; dismiss on scroll/tap-away.

## Errors, destructive actions, forgiveness

- Same principles as web: clear, actionable, never blame the user, preserve input.
- **Prefer undo (toast) over a confirm dialog** for destructive actions where reversible, it keeps flow and is very native.
- Destructive actions visually distinct (color + position), and confirmed when irreversible.

## What drops from web on mobile

- Hover states, focus-ring styling, and command palettes (`Cmd+K`), not applicable to touch.
- Keyboard shortcuts as the primary power-user path, replaced by gestures and well-placed controls.

## Mobile interaction checklist

- [ ] Every interactive element has immediate press feedback, with haptics only where appropriate?
- [ ] All touch targets ≥ 44pt with breathing room?
- [ ] Swipe-back and drag-to-dismiss work where expected?
- [ ] Haptic vocabulary consistent and paired with visual feedback?
- [ ] Loading uses skeletons, no layout jump?
- [ ] Handles offline / slow network without losing input?
- [ ] Keyboard never covers the active field?

---

# Final Principle

Good interaction design makes the interface feel **alive and cooperative**.

The system should feel like it is working *with* the user, not against them. On mobile, "alive" is literal, it moves, it answers in the hand, and it follows the thumb.
