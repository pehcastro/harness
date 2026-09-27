# Recess

Version 1.1. Web product UI: dashboards, workspaces, review tools, settings. Default mode: dark. Light is the paired implementation below, not an inverted dark palette.

Read this file and [recipes.md](./recipes.md) when the user selects **Recess**. No screenshots, source repository, or product knowledge are required. The user's prompt may be only: `Apply nkz-taste, style recess.`

## Contract

Reproduce these values and constructions; do not reinterpret the style. Its identity is a charcoal inset workspace, almost-black outer frames, slightly lighter working faces, fine inner edges, compact Manrope typography, blue actions, and restrained square dithering. It is not merely a blue shadcn theme.

Fix the visual system; adapt the product's information and behavior. Do not copy example record counts, labels, domain concepts, routes, or brand names. Preserve functionality and permissions. Exact pixels require the same content, viewport, fonts, and rendering environment; this contract fixes the design decisions, not those external inputs.

**Required:** the palette, fonts, geometry, layer formulas, and control treatments below. **Conditional:** metric footers only with useful context; dithering only on summary faces and the login art pane; a side rail only when it supports the current task. **Not part of this style:** hero gradients, glowing borders, glass cards, pill-shaped everything, floating card hover lifts, or a staggered entrance on every page.

## Tokens

Install the following in the target project's central token source. Use the `rx-` namespace or an exact semantic mapping. Do not approximate with the closest existing shadcn color. A rem is 16 CSS pixels. Load Manrope Variable and JetBrains Mono Variable before assessing layout; fallback fonts are only for loading/failure.

```css
.recess-theme {
  color-scheme: dark;
  --rx-canvas: oklch(.15 .004 286);
  --rx-surface: oklch(.21 .006 286);
  --rx-raised: oklch(.255 .007 286);
  --rx-muted: oklch(.274 .006 286);
  --rx-input: oklch(1 0 0 / 15%);
  --rx-ink: oklch(.985 0 0);
  --rx-ink-muted: oklch(.705 .015 286);
  --rx-ink-subtle: oklch(.60 .014 286);
  --rx-ink-tertiary: oklch(.50 .012 286);
  --rx-border: oklch(1 0 0 / 10%);
  --rx-border-strong: oklch(1 0 0 / 18%);
  --rx-primary: oklch(.62 .19 264);
  --rx-primary-fg: oklch(.985 .01 255);
  --rx-action-fill: oklch(.54 .19 264);
  --rx-success-text: var(--rx-success); --rx-warning-text: var(--rx-warning);
  --rx-danger-text: var(--rx-danger); --rx-info-text: var(--rx-info);
  --rx-backdrop: rgb(0 0 0 / 48%); --rx-backdrop-blur: 3px;
  --rx-success: oklch(.70 .13 152); --rx-success-soft: oklch(.30 .06 152);
  --rx-warning: oklch(.80 .13 78); --rx-warning-soft: oklch(.32 .06 78);
  --rx-danger: oklch(.70 .19 22); --rx-danger-soft: oklch(.32 .09 22);
  --rx-info: oklch(.68 .13 250); --rx-info-soft: oklch(.31 .06 250);
  --rx-chart-1: oklch(.68 .16 264); --rx-chart-2: oklch(.72 .12 152);
  --rx-chart-3: oklch(.80 .12 78); --rx-chart-4: oklch(.70 .14 300);
  --rx-chart-5: oklch(.72 .09 210);
  --rx-sidebar: oklch(.205 .006 286);
  --rx-recess: color-mix(in srgb, var(--rx-surface) 78%, var(--rx-canvas));
  --rx-face: color-mix(in srgb, var(--rx-surface) 93%, var(--rx-ink));
  --rx-line: color-mix(in srgb, var(--rx-ink) 11%, transparent);
  --rx-highlight: color-mix(in srgb, var(--rx-ink) 5%, transparent);
  --rx-face-fill: linear-gradient(125deg, color-mix(in srgb, var(--rx-face) 97%, var(--rx-ink)), var(--rx-face));
  --rx-workspace-fill: linear-gradient(135deg, color-mix(in srgb, var(--rx-surface) 92%, var(--rx-ink)), color-mix(in srgb, var(--rx-surface) 97%, var(--rx-ink)));
  --rx-face-shadow: inset 0 1px 0 var(--rx-highlight), 0 0 0 1px color-mix(in srgb, var(--rx-canvas) 50%, transparent), 0 2px 3px color-mix(in srgb, var(--rx-canvas) 25%, transparent);
  --rx-font: 'Manrope Variable', ui-sans-serif, system-ui, sans-serif;
  --rx-mono: 'JetBrains Mono Variable', ui-monospace, monospace;
  --rx-r-xs: 4px; --rx-r-sm: 6px; --rx-r-md: 8px; --rx-r-lg: 12px;
  --rx-r-frame: 16px; --rx-frame: 5px; --rx-panel-inset: 3px;
  --rx-space-1: 4px; --rx-space-2: 8px; --rx-space-3: 12px;
  --rx-space-4: 16px; --rx-space-5: 20px; --rx-space-6: 24px; --rx-space-8: 32px;
  --rx-sidebar-width: 256px; --rx-topbar-height: 56px;
  --rx-page-max: 1320px; --rx-settings-max: 1080px; --rx-reader-max: 72ch;
  --rx-ease: cubic-bezier(.22, 1, .36, 1);
  --rx-hover: 120ms; --rx-state: 180ms;
  font-family: var(--rx-font); line-height: 1.5;
  color: var(--rx-ink); background: var(--rx-canvas);
}
.recess-theme[data-mode="light"] {
  color-scheme: light;
  --rx-canvas: oklch(.975 .004 95);
  --rx-surface: oklch(1 0 0);
  --rx-raised: oklch(.962 .005 95);
  --rx-muted: oklch(.967 .001 286);
  --rx-input: oklch(.92 .004 286);
  --rx-ink: oklch(.19 .006 286);
  --rx-ink-muted: oklch(.55 .016 286);
  --rx-ink-subtle: oklch(.63 .015 286);
  --rx-ink-tertiary: oklch(.72 .012 286);
  --rx-border: oklch(.92 .004 286); --rx-border-strong: oklch(.86 .005 286);
  --rx-primary: oklch(.488 .243 264.4);
  --rx-action-fill: var(--rx-primary);
  --rx-success-text: oklch(.43 .09 150); --rx-warning-text: oklch(.43 .08 74);
  --rx-danger-text: oklch(.43 .16 27); --rx-info-text: oklch(.43 .10 250);
  --rx-backdrop: rgb(20 22 28 / 32%);
  --rx-success: oklch(.58 .13 150); --rx-success-soft: oklch(.95 .035 150);
  --rx-warning: oklch(.70 .15 74); --rx-warning-soft: oklch(.95 .05 80);
  --rx-danger: oklch(.577 .245 27.3); --rx-danger-soft: oklch(.94 .045 25);
  --rx-info: oklch(.58 .14 250); --rx-info-soft: oklch(.95 .03 250);
  --rx-chart-1: oklch(.55 .20 264); --rx-chart-2: oklch(.60 .13 150);
  --rx-chart-3: oklch(.70 .15 74); --rx-chart-4: oklch(.56 .16 300);
  --rx-chart-5: oklch(.62 .10 210);
  --rx-sidebar: oklch(.985 .002 106);
  --rx-recess: color-mix(in srgb, var(--rx-canvas) 92%, var(--rx-ink));
  --rx-face: var(--rx-surface); --rx-highlight: #fff;
  --rx-line: color-mix(in srgb, var(--rx-ink) 12%, transparent);
  --rx-workspace-fill: var(--rx-canvas);
  --rx-face-fill: linear-gradient(135deg, var(--rx-surface), color-mix(in srgb, var(--rx-surface) 98%, var(--rx-ink)));
  --rx-face-shadow: inset 0 0 0 1px var(--rx-line), 0 1px 3px #0000000a;
}
```

Keep the root font at 100% (normally 16px); set body text to 14px in the application container, never on html. Use border-box sizing and zero body margin. Rem geometry follows user font scaling.

For an app-wide application, put the theme class and mode on html so portals inherit tokens. For one page, put them on that page wrapper and a dedicated portal root; do not theme html. Scoped applications retain the host root font and use equivalent px geometry if it differs from 16px. Exclude embedded third-party previews.

Load the variable Manrope and JetBrains Mono font files through the project's font pipeline, with their real family names mapped to these tokens. Pin the font dependency or asset revision in the lockfile; do not assess fidelity while fallback fonts are showing.

### Type and geometry

Values are CSS px. Declare these as named tokens/type utilities centrally, not scattered overrides. Do not let a primitive's default typography or border radius win the cascade.

| Role | Size / line height | Weight | Tracking |
|---|---|---|---|
| Page title | 22 / 28 | 600 | -.015em |
| Large display (auth only) | 30 / 36 | 600 | -.02em |
| Section heading | 17 / 24 | 600 | -.01em |
| Card heading | 15 / 22 | 600 | -.005em |
| Body | 14 / 21 | 400 | 0 |
| Strong body | 14 / 21 | 500 | 0 |
| Control label | 13 / 18 | 500 | 0 |
| Caption | 12 / 16 | 500 | .01em |
| Metadata | 11 / 16 | 500 | .01em |
| Identifier | 13 / 20, mono | 450 | 0 |
| Summary value | 30.4 / 34.96, mono | 700 | -.06em |

Use tabular numerals for metrics, dates, counts, and costs. Body and controls use ink or ink-muted; subdued tones are for optional metadata, never required instructions. Test contrast against the actual composited face. Use ink-muted as the default for readable metadata; ink-subtle and ink-tertiary are decorative roles. If a text pair fails the skill's contrast floor, promote it to ink-muted or ink. Primary buttons use action-fill and tags use semantic text tokens, which are distinct from decorative accent colors. This is an allowed role correction, not permission to restyle the theme.

## Surface construction

There are three constructions. Choose one per information group. Do not nest all three.

1. **Framed face:** a 5px recess border, 16px outer radius, continuous face. Lists, standalone forms, readers. Children use separators, not more framed cards.
2. **Panel:** a 3px recessed surround, a quiet header on that surround, then one raised face. Charts, grouped settings, contextual information. Header belongs outside the face. No footer unless needed.
3. **Summary tile:** a short raised face with a recessed footer for useful context. Only summary metrics use this composition.

The following CSS is the canonical construction, not illustrative pseudocode. Add it to the central component/style layer; rename selectors only. Apply geometry/type tokens from above.

```css
.rx-frame {
  min-width: 0; border: var(--rx-frame) solid var(--rx-recess);
  border-radius: var(--rx-r-frame); background: var(--rx-face-fill);
  box-shadow: inset 0 0 0 1px var(--rx-line), inset 0 2px 0 var(--rx-highlight), 0 1px 0 var(--rx-highlight);
}
.rx-panel { min-width: 0; overflow: hidden; padding: var(--rx-panel-inset); border-radius: .9rem; background: var(--rx-recess); box-shadow: inset 0 1px 0 var(--rx-highlight); }
.rx-panel-head { display: flex; align-items: center; justify-content: space-between; gap: .75rem; padding: .7rem .9rem .8rem; }
.rx-panel-face { min-width: 0; display: flex; flex-direction: column; gap: .75rem; padding: .9rem; border: 1px solid var(--rx-line); border-radius: .75rem; background: var(--rx-face-fill); box-shadow: var(--rx-face-shadow); }
.rx-summary { min-width: 0; overflow: hidden; padding: 3px 3px 0; border-radius: 1rem; background: var(--rx-recess); }
.rx-summary-face { position: relative; overflow: hidden; min-height: 106px; padding: 1rem; border: 1px solid var(--rx-line); border-radius: .85rem; background: linear-gradient(135deg,color-mix(in srgb,var(--rx-face) 97%,var(--rx-ink)),var(--rx-face)); box-shadow: inset 0 1px 0 var(--rx-highlight), 0 0 0 1px color-mix(in srgb,var(--rx-canvas) 50%,transparent), 0 3px 5px color-mix(in srgb,var(--rx-canvas) 35%,transparent); }
.rx-summary-foot { display: flex; align-items: center; justify-content: space-between; gap: .5rem; padding: .65rem 1rem; color: var(--rx-ink-muted); font-size: .7rem; }
.rx-tabs { display: flex; width: fit-content; max-width: 100%; overflow-x: auto; padding: 4px; gap: 4px; border-radius: .8rem; border: 1px solid color-mix(in srgb,var(--rx-ink) 7%,transparent); background: var(--rx-recess); }
.rx-tab { flex: 0 0 auto; min-height: 32px; padding: 4px 12px; border: 0; border-radius: .55rem; background: transparent; color: var(--rx-ink-muted); }
.rx-tab[aria-selected="true"] { color: var(--rx-ink); background: linear-gradient(130deg,var(--rx-raised),var(--rx-face)); box-shadow: inset 0 0 0 1px var(--rx-line), inset 0 2px 0 var(--rx-highlight), 0 2px 3px color-mix(in srgb,var(--rx-canvas) 40%,transparent); }
.recess-theme[data-mode="light"] :is(.rx-frame,.rx-panel-face,.rx-summary-face) { background: var(--rx-face-fill); box-shadow: var(--rx-face-shadow); }
```

Do not set `overflow:hidden` on a form container that must show focus rings or non-portalled popups. Clip texture locally. A border radius alone does not require clipping.

## Controls

Keep shadcn/Base UI/Radix behavior. Style their primitives; use no browser-native select, date popup, radio, checkbox, confirmation, or alert UI. Inputs and textareas retain semantic HTML inside the styled primitives. Use one icon family: Remix Icon line icons, 16px controls, 20px navigation/section marks.

- Button: 36px high, 12px horizontal padding, 6px gap, 12px radius, label type. Small 32px, icon 36px square. Touch coarse pointers: 44px minimum hit area. Preserve label width while loading. Disabled opacity .5.
- Primary: primary-fg text; fill `linear-gradient(to bottom, color-mix(in srgb, action-fill 94%, ink), action-fill)`; 1px border mixing action-fill 85%/ink 15%; inset 1px highlight at ink 12% and outer `0 1px 2px` at canvas 25%.
- Outline/secondary: ink text; border token; fill `linear-gradient(135deg, color-mix(in srgb, raised 96%, ink), raised)`; inset 1px highlight at ink 7%, outer `0 1px 2px` at canvas 30%. Ghost: transparent until hover. No pill buttons.
- Fields: 36px minimum height, 12px horizontal padding, 8px radius, 1px border. Textarea minimum 96px, 12px padding, vertical resize. Dark fill input; light fill surface. Label 14px, help 12px; gaps 8px within a field and 20px between fields.
- Hover: edge shifts to ink 22%/transparent; ghost fill muted. Press: inset `0 1px 3px` canvas 30%; at most 1px downward travel, never on popup triggers. Focus: visible 2px primary outline with 2px offset; verify contrast on adjacent surfaces.
- Tags: 11px text, 16px line height, 6px horizontal/2px vertical padding, pill radius. Semantic `*-text` over matching `*-soft` background, optional 6px dot. Never chart colors for warnings. Do not duplicate `Pending` with a second `Needs review` badge.
- Dialog: 448px default width, max `calc(100vw - 32px)`, 5px recess border, 19.2px radius, 24px content padding; face-to-surface gradient at 130deg, inset 1px line, `0 20px 70px #0004` shadow. Header/footer separated by 1px line and 16px spacing. Body scrolls at `calc(100dvh - 32px)`. Backdrop uses backdrop token and backdrop-blur token; disable blur for reduced transparency. Height cap includes header, footer, borders, and padding; only the flexible body scrolls. Close at top right; trap focus and return it to the trigger.

In formulas above, names mean their `--rx-*` variables inside `var()`, not literal CSS color keywords.

## Dither: deterministic, decorative

The summary face establishes `position:relative; overflow:hidden`; the login art pane may use a separately clipped decorative layer as described in recipes.md. Place an aria-hidden, pointer-events-none SVG of 136 x 190px at left 88%, top 71%, transform `translate(-50%,-50%)`, opacity .49, color ink-subtle. No rotation. Never put it behind readable text or on every card.

Exact generator: columns=floor(136/6)=22; rows=floor(190/6)=31. For index i in [0,681], col=i%22, row=floor(i/22), nx=(col+.5)/22, noise=((i*37+row*17+13*23)%101)/100. Skip noise > .74. Draw a 4x4 square at x=(col+.5)*6-2, y=(row+.5)*6-2. Square opacity=(.05+.95*nx)*(.2+.8*noise). Fill currentColor; radius 0. The SVG's .49 opacity multiplies the square opacity. No random(), blur, grain image, or animated seed.

## Motion and stability

Use 120ms for hover and 180ms for state feedback with the specified easing. Animate opacity/transform only for entry/exit; hover may transition color, border and shadow. No whole-route exit/entry wrapper, no opacity reset on loader completion, no animation on every table row. Keep the route container mounted. Reserve layout for asynchronous panels; show a matching skeleton only after 350ms, replace once, preserve prior data on refresh. Respect reduced motion by disabling travel and entry fades. See [recipes.md](./recipes.md) for the composition contract and checks.

## Floating controls

Select and menu popovers use face fill, 1px line, 12px radius, 4px padding, and face shadow plus `0 8px 24px` canvas at 25%. Items are at least 32px high with 8px horizontal padding, 6px radius, 13/18 label type; active item uses raised fill and ink. Match select trigger width, cap menu width to viewport minus 32px. Checkboxes and radios are 16px visual controls with 24px minimum pointer hit area (44px touch), strong-border edge, selected action-fill, and primary-fg mark. Error fields use danger-text, a 1px danger-text edge, and a visible message. Focus always uses the specified outline. No additional entry animation for keyboard openings.
