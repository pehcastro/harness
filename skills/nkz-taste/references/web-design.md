---
name: web-design
description: Browser UI composition, responsive behavior, surfaces, and layout stability. Use with the selected style for exact visual values, or with direction.md when no style is selected. Native mobile mechanics belong in mobile-design.md.
---

> Part of [nkz-taste](../SKILL.md). Read [product.md](./product.md) for the screen's job and [craft.md](./craft.md) for states, forms, accessibility, and copy. Native apps use [mobile-design.md](./mobile-design.md).

# Web design

## Resolve the visual source first

This file defines browser design mechanics. It is not a universal visual theme.

- **Selected style:** read its contract and recipes from [the catalog](../SKILL.md#named-styles). They supply exact tokens, type, spacing, density, radii, depth, and motion. Do not replace those values with this file's examples or library defaults.
- **Existing system, no style selected:** use its tokens and established components. Improve the requested surface without introducing a parallel theme.
- **New system, no style selected:** use [direction.md](./direction.md) to choose a coherent direction, then encode decisions centrally.

A style controls appearance; product requirements control what exists. A dashboard recipe does not require adding invented metrics, a chart, or a decision rail to every page. Adapt content and choose applicable recipes while retaining the selected visual construction. Explicit user constraints and the craft floor still apply.

## Structure and rhythm

Start with the user's task, then place navigation, heading, content, and actions on a shared grid. Related items sit closer together than separate groups. Take distances from the chosen scale; style-specific frame thicknesses and optical adjustments are deliberate exceptions to a regular spacing grid.

Constrain reading width separately from workspace width. A table may need the workspace; a paragraph does not. Use `min-width: 0` on grid/flex children, defined column allocation, and wrapping rules so real content can shrink without overflowing.

Do not fill unused space with arbitrary cards or enormous rows. Short lists can remain short. Use bounded height only when independent scrolling helps the task, such as an editor beside a member list. Avoid a scrollable shell inside an already scrollable page without that reason.

At narrow widths, change composition: collapse navigation to a drawer, stack secondary content, and let labels wrap. Choose breakpoints from the style recipe and actual content fit. Preserve essential actions and information; do not hide them merely to avoid overflow. Verify 320px, tablet widths, and a wide desktop with long names and empty data.

## Hierarchy and readable color

Use size, weight, grouping, and position before adding emphasis. Required text must remain readable: body copy is not automatically muted, and muted text is not automatically accessible. Verify the composited foreground/background pair. Use subdued roles for genuinely secondary information and promote a role when contrast fails.

Use the chosen type scale. Large values can be appropriate for a primary metric or a focused login heading; they are not reserved for marketing. Keep long-form reading comfortable and distinguish labels, values, and help text.

A palette includes canvas, recess, faces, inputs, borders, text roles, semantic states, charts, and overlays. Changing only the primary color does not apply a style. Light mode needs its own surface hierarchy; do not mechanically invert dark-mode colors. Status must have a label or icon as well as color.

## Surfaces and depth

Depth communicates containment, focus, and grouping. Use the selected style's surface construction consistently across pages, dialogs, menus, and settings.

A recessed frame around one raised face is one component, not redundant nested content. Borders, inset highlights, gradients, and shadows are valid when the contract uses them. Avoid adding further framed cards inside that face unless a separate interaction or information group requires them. Use spacing and separators for ordinary internal divisions.

Keep parent and child radii geometrically compatible according to the style. Do not flatten all radii to one number or substitute a pill because the component library defaults to one. Clip decorative layers locally; preserve focus rings and use portals for floating content where appropriate.

Without a selected style, start with a small set of surface roles and purposeful edges. Add depth only where it clarifies grouping or interaction. Do not turn this fallback into a prohibition on expressive styles.

## Components and primitives

Use the project's accessible primitives for tabs, selects, dialogs, popovers, tooltips, and disclosure. If missing, add a compatible primitive through the library's supported tooling. Preserve semantics, keyboard handling, focus management, and validation while applying the visual system. A component's stock appearance is not the design specification.

Use links for navigation, including links styled as buttons; buttons perform actions. Distinguish selected tabs, pressed buttons, current navigation, and disabled controls semantically as well as visually. Hover enhances an existing affordance and never carries essential information alone.

Dialog headers establish the task; fields form one readable body; footer actions remain reachable when the body scrolls. Keep dialogs inside the viewport, provide an accessible title and close action, trap focus, and return it to the trigger. Popovers and portalled menus inherit the selected theme. Opening one should not shift the page.

## Tables and lists

Use shared columns across all rows and headers. Do not independently distribute each row with `space-between`; different label lengths will destroy alignment. Use semantic tables for tabular data, or a deliberate shared grid for richer interactive lists.

- Text left-aligned, quantities right-aligned with tabular numerals, status in a consistent column.
- Give the identifying title space first. Add a readable second line for useful context rather than squeezing every field into one horizontal strip.
- Separate units and labels clearly. Align comparable values and use consistent date/number formatting.
- Use hover only for actionable rows. Keep nested actions independently operable, with no nested interactive elements.
- On small screens, stack secondary context or allow a bounded horizontal table scroll. Keep identifying information and actions reachable.
- Distinguish missing data from zero. Never invent chart values or precision to make a layout look finished.

## Navigation and persistent context

Keep sidebar identity and account controls outside its scroll area. Indicate overflow with a subtle edge fade only while content exists beyond that edge. At the top or bottom, remove the corresponding fade. Never fade the account controls or apply an unconditional mask that makes navigation disappear.

Derive active navigation and breadcrumbs from the current route and its parent context, including detail routes. Preserve project/workspace scope. Only show destinations the current user can access; hiding a link does not replace authorization.

## Stable loading and feedback

Keep persistent layout mounted through data updates. Reserve space with a skeleton matching the content's structure when loading lasts long enough to need it; use the selected style's delay. Preserve prior data on refresh where appropriate. Do not reset the page to transparent, stagger every row, or run both skeleton and content entrance effects.

Use overlays for transient tasks, inline disclosure for content belonging in the flow. Do not force all expansion into modals to avoid reflow. Keep the trigger anchored and expansion predictable. Motion is optional; consult [animations.md](./animations.md) and the selected style before adding it.

After a mutation, update the actual decision state and available actions. A toast alone is not a completed state. Keep errors local when the rest of the page remains usable, retain entered data, and provide a retry path.

## Review

Check layout with long content, no data, loading, partial failure, and success. Check keyboard navigation, focus near scroll edges, theme inheritance in portals, and contrast on each actual surface. Verify the selected style's computed values and constructions separately from usability. A usable page can still be an inaccurate reproduction.

Use [ai-tells.md](./ai-tells.md) to catch reflexive additions, not to erase deliberate choices required by the selected style.
