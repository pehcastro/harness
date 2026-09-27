# Recess recipes

Read [style.md](./style.md) first. These recipes compose its exact surfaces around the receiving product's own content. Choose the relevant recipes; do not build every example. All dimensions below belong in the central layout/component layer, not scattered page overrides. Base rem is 16px.

## 1. Application frame

Desktop structure: a 256px sidebar beside `minmax(0,1fr)` workspace, both inside a 100svh shell. The sidebar can collapse to 48px. Keep its identity block and account block fixed; only navigation scrolls. The workspace has an 8px outer inset, 12px radius, the workspace fill, and a 56px header with a quiet bottom border. Header padding is 24px horizontally, 16px on small screens. Breadcrumbs are left, search and utility controls right.

Main content scrolls independently below the header. Its wrapper is centered, width 100%, max-width 1320px including padding; horizontal padding 24px desktop/16px small, vertical padding 20px. Normal page group gap is 16px. Settings use max-width 1080px. Do not vertically center ordinary short pages.

At widths below 768px, use a drawer up to 288px wide, limited to viewport minus 32px, instead of the persistent sidebar. The main workspace fills available width. Compact breadcrumbs and search before allowing them to squeeze the page title. Restore the same accessible navigation inside the drawer.

Sidebar: 12px header padding; brand block uses raised fill and 8px radius. Navigation groups use 8px vertical/12px horizontal padding. Items are 33.6px high with 6.4px radius; text is 14px, icons 20px. Group captions are 10.5px, uppercase, tracking .04em. Current item uses raised fill, ink text, and a restrained inset edge; inactive items use ink-muted. On touch, provide 44px hit targets. Never encode selection only in text color.

Scroll fade: when scrollTop > 1px, mask transparent through 4px and reach opaque at 40px from the top. When more than 1px remains below, mirror that mask at the bottom. Otherwise that edge is fully opaque. Recompute on scroll, resize, and content changes. Mask only the scrolling navigation, never its fixed header/footer.

## 2. Page header and overview

Page header: title and short description in one left-aligned stack; one primary action at the right, aligned to the title. Stack actions below at narrow widths. Title uses the 22/28 scale. Description is 13px with 18px line height, ink-muted, 4px below the title. Content starts 16px after the header.

Summary row: use summary tiles only for actual top-level counts. Two metrics mean two columns; four mean four columns at 1024px and above, two from 640px, one below. Gap 16px. Labels sit above values; optional context stays in the recessed footer. Decorative dither uses the exact generator in style.md and stays clear of text. No made-up deltas or redundant arrow when nothing is actionable.

Below summaries, use a wide analytical panel and a narrower contextual column when content merits it: `minmax(0,1.8fr) minmax(304px,1fr)` at 1280px and above, otherwise one column. Do not force an empty second column.

Entity previews: two columns at 1024px and above, one below; 16px gap. Use a panel with identity and meaningful state in its recessed header. Put up to four comparable metrics in the face, then one separator and a compact context/action row. Metrics use real values with units and reporting period. Keep unavailable values distinct from zero. Long names wrap; status cannot displace identity.

## 3. Lists and tables

One framed face contains the whole table. Header is 36px minimum, 12px ink-muted text. Cells have 16px horizontal padding. Single-line rows are at least 44px; two-line rows use 12px vertical padding and a 4px title/context gap. Separate rows with the line token; no individual row cards.

A starting column allocation for activity lists is:

```css
.rx-activity-columns {
  grid-template-columns: minmax(240px, 1fr) 144px 80px 104px 96px 20px;
  column-gap: 16px;
}
```

Use the same allocation for header and rows. Columns represent identity/activity, date, duration, quantity, state, and navigation affordance; remove genuinely absent fields and redistribute centrally. Identity includes a title and useful source/context line. Numerical columns align right. Do not enlarge one title column until everything else is crushed against the edge.

Use an inline-size container query on the table region. Below 820px of actual container width (including its frame/padding), move secondary date/source information under the identity and reduce to identity, important state/value, and action. If comparison requires every column, retain a semantic table inside a bounded horizontal scroller instead. On phones use 12px cell padding and allow titles two or more lines; essential context must remain available without hover.

## 4. Detail, reading, and decision

The detail header is one panel: a quiet context label in the recess; title, short description, and a compact metadata row in the face. Separate metadata with a hairline and 12px top spacing. Allow wrapping. Use concise status, location, and version only when relevant. Do not repeat the title as another metadata field or place those fields in a competing properties card.

At 1280px and above, body layout is `minmax(0,1fr) 304px`, gap 24px. The side column begins with the decision/actions panel; supporting explanation follows as one grouped panel. Below that breakpoint, stack and place the main action near the header so it does not disappear after a long document.

Reader: framed face, 24px padding, text measure max 72ch, centered within it. Preserve all meaningful body content and heading levels from the source. Heading-only extraction is not a preview. In a dedicated review workspace, cap the reader at `min(68svh,760px)` with internal scrolling; on a normal article page, prefer page scrolling. Label source/preview modes with the actual tabs primitive and the recessed tab styling.

Annotations: under the reader, use a panel headed with the note count. Each note gets a subdued quoted excerpt, a 2px primary-tinted left rule, then the user's note in ink; separate notes with hairlines. Keep edit/remove controls attached to their note. The submission action belongs in the panel footer with a short consequence, not in a separate oversized banner.

After a decision, replace the decision panel's state and actions. Published content offers its live destination. Discarded content shows a calm discarded state and a restore action when supported. Success feedback is compact and semantic; never leave a second identical discard button active beneath a success banner. Implement only actions supported by the product.

## 5. Settings and forms

Use the 1080px wrapper. Put category navigation directly below the page header using recessed tabs; wrap or scroll that single navigation row on small screens. Categories reflect actual settings, not one tab per field. Keep category selection addressable when the app supports route/search state.

Within a category, sections may use a 208px label/explanation rail beside `minmax(0,1fr)` at 1024px and above; below that, place the label above the panel. Gap 20px. Do not add a second outer card around the entire settings page. Separate sections by 16px.

A simple identity edit uses label, field, and save action in one panel. On desktop, pair a flexible input with an auto-width save button; on phones stack the action. Multi-field forms use 20px field gaps, two equal columns only when both fields fit comfortably, otherwise one. Help text follows its field and wraps independently of the character count. Textareas use at least 96px height.

Tag editor: label/help above, chips wrapping with 8px gaps, add field plus button on a separate row 12px below. Chips use the tag geometry; the enclosing face stays continuous. Do not introduce a black rectangle inside the face. Long chips wrap text, with a separate accessible remove target.

Choice groups: label and description above the options, never as an overlapping legend on the frame. Each option is a styled radio primitive plus title/help, 16px padding and 12px gap between options; selected edge is primary, background primary mixed 6% into face. Dangerous settings use a small semantic label and explicit consequences, not an entire red page section. Sticky save bars must reserve space beneath the final field and never cover its help text.

## 6. Dialogs, search, and editors

Use the 448px dialog geometry in style.md for a focused create/edit form. A multi-column editor may use 768px; search uses 640px. Always cap width at viewport minus 32px. Keep the header and footer outside a flexible scrolling body; total dialog height, including padding, cannot exceed viewport minus 32px. Style the backdrop independently from the face. One recessed surround, one face, no extra decorative card per field.

Search: input at the top, grouped results in the body, keyboard hints in a quiet footer. Results use 12px padding and a stable icon/title/context grid. Highlight the current keyboard result with raised fill and inset edge. Group labels are captions. Query changes retain focus and do not replay dialog entry. Distinguish initial suggestions, searching, no matches, and error.

Editor workspace: at 1024px and above use a 280px member/file list and `minmax(0,1fr)` editor, gap 20px. Give both the same height `clamp(360px,calc(100svh - 240px),760px)`; keep filters/toolbars fixed and scroll each content body. On smaller screens, stack with normal page flow and a bounded editor. Edit and preview occupy the same slot. Syntax highlighting uses semantic token roles and a real editor/highlighter, while maintaining selection and editing behavior. Never color the text by replacing it with a non-editable imitation.

## 7. Login

At 1024px and above, split into two equal panes within the same canvas, 24px inset/gap. The left pane uses a large framed face, brand at the top, one short product statement near the bottom, and a restrained field of the style's square dither. For this pane, use one 272 x 380px SVG with viewBox 0 0 136 190, the same square generator, opacity .24, left 85%, top 32%, translate(-50%,-50%), and no rotation. Clip at the pane edge; keep the statement in the bottom third clear of texture. Do not add photography or additional texture fields.

The right pane centers a form up to 448px wide. Use the same labels, fields, buttons, errors, and surface construction as dialogs. On smaller screens remove the art pane, retain the brand above the form, and use 16px page padding. Password reset and invitation acceptance reuse this structure with task-specific copy. Do not invent marketing claims to fill the left pane.

## 8. Charts and asynchronous states

A chart is a panel: label/actions in the recessed header, value/date range above the plot in the face, optional source/reporting context below a separator. Use the chart tokens, quiet grid lines, tabular axis labels, and truthful scales. Pixel columns are optional: quantize vertical units consistently against the visible axis and retain exact values in accessible text/tooltips. Decorative dither is never chart data. Use other chart types when they represent the data better.

Loading uses the same layout and surface geometry as its destination. Show skeletons after 350ms, not immediately for a fast response. Keep headings/navigation in place, retain loaded data during refresh, and replace the skeleton once. An empty state occupies the relevant face with one useful next action. Partial failure stays in the affected panel. Do not fade the entire page in after loading or animate every child separately.

## Fidelity checks

Before declaring a faithful reproduction:

- Verify actual loaded Manrope and JetBrains Mono fonts, not only font-family declarations.
- Inspect computed canvas, recess, face, input, text, and overlay colors in dark and light mode. Dark faces sit above a darker recess; light faces sit above a shaded recess.
- Measure sidebar 256px, header 56px, wrapper 1320/1080px including padding, frame 5px, panel surround 3px, and tab inset 4px at desktop reference width.
- Verify summary value type, deterministic texture, and the three distinct surface constructions. Do not replace all of them with one generic card.
- Check 320, 390, 768, 1280, and 1600px widths, long content, empty/error/loading states, open menus/dialogs, focus rings, and reduced motion.
- State any deliberate adaptation. Without identical content, viewport, font files, and rendering environment, do not claim pixel-identical output; the contract makes the design decisions reproducible.
