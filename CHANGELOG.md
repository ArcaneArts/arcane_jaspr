# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [x.x.x]

### Added

- **`ArcaneGallery` area controls.** Packed galleries can now set
  `minimumTileArea` and `targetTileArea` in grid cells (`columnSpan × rowSpan`).
  The packer excludes undersized candidate spans when the floor is attainable
  and uses one ratio-independent target area for every item. Galleries that
  omit both controls retain the existing aspect-derived sizing behavior.
- **Nested cards flatten by default (all four themes).** An arcane `Card` rendered inside another arcane `Card` now drops its own frame — background, border, and shadow — so stacked panels no longer read as a "card-in-card" border-in-border, most visibly under Shadcn and Neubrutalism. The inner card re-asserts a distinct frame by opting out with `decoration:`/`styles:` (which set the `data-arcane-decorated` attribute the flatten rule excludes). Implemented as pure per-theme CSS (`#arcane-root.arcane-theme-* .<theme>-card .<theme>-card:not([data-arcane-decorated])`), scoped and `!important` so it beats both inline variant styles (shadcn/neubrutalism) and the theme's own `!important` surface rules (neubrutalism); golden-neutral (the render snapshot suite excludes theme CSS by design). Note: a layout container that a host app styles as a card via its own CSS is outside the library's reach — only real nested arcane Cards flatten.
- **Web-safe theme packages + new `arcane_jaspr_kb`.** Split each theme's
  `*_kb_renderers` (which import `arcane_lexicon`, a server-side `dart:io`/`jaspr_content`
  docs package) out of the theme packages into a new opt-in `arcane_jaspr_kb` package. The
  theme packages (`arcane_jaspr_shadcn`/`_neubrutalism`/`_neon`/`_win95`) no longer depend on
  `arcane_lexicon`, so importing them in a Jaspr **client** app no longer drags `dart:io` into
  the client entry (which silently dropped `main.client.dart` and shipped a blank app). Docs
  sites now depend on `arcane_jaspr_kb` for the knowledge-base chrome renderers.
- **Theme-permeable styling (M0 foundations).** New `ArcaneDecoration` (`core/decoration/arcane_decoration.dart`) — a Flutter-`BoxDecoration`-shaped, theme-permeable surface with universal fields (color, gradient, borderRadius, border, padding, backdropFilter) plus an `Elevation` *intent* every theme maps to its own idiom (shadcn ambient blur, neubrutalism hard offset, neon glow) and a theme-specific `shadowColor` honored-or-ignored per theme. `Button` and `Card` now accept `decoration:` (semantic) and `styles: ArcaneStyleData?` (literal escape hatch that always wins). Render bases expose a concrete-default `decorationStyles(ArcaneDecoration?)` hook (returns `{}`) so themes opt in without a breaking change; the merge seam layers `theme base -> variant -> size -> decoration -> literal styles`.
- `ArcaneColorOps` extension on `String` — `.opacity(double)` and `.on(base, double)` emit `color-mix()` for any CSS color (hex, `var(--x)`, `ArcaneColor.*.css`, runtime accents), replacing raw `color-mix` strings and the fragile `${color}30` hex-alpha hack (which produces invalid CSS for `var()` colors).
- `ArcaneStyleData` gained the typed fields that previously forced `raw:` maps: single-side padding (`paddingTop`/`Right`/`Bottom`/`Left`), per-side custom border strings (`borderTopCustom`/…, which can carry a runtime color or `none`), `boxSizing` (`BoxSizing` enum), `backgroundClip` (emits standard + `-webkit-`), and `backdropFilterCustom`.
- **M1: the `styles:`/`decoration:` surface now covers all ~60 wired themed-visual components** — every actionable component across buttons, cards, feedback (Alert/Avatar/StatusBadge/Toast/Kbd/Breadcrumbs/Progress/CircularProgress/Skeleton/LoadingSpinner/EmptyState), interactive (Accordion/Disclosure/Cycle/Toggle/ToggleGroup/ToggleSwitch/Checkbox/RadioGroup/Slider/Separator), overlays (Dialog/Sheet/Drawer/Command/Floating/ContextMenu/DropdownMenu/Menubar/Toolbar), inputs (TextInput/Select/NativeSelect/OtpInput/TimePicker/DatePicker/Calendar/FieldWrapper/InputGroup), tabs/pagination, and the promo chrome (TopAnnouncementBar/PromoModal/…/SlotCounter). For overlay components the override routes to the visible panel, never the scrim; for standalone theme renderers that don't extend the shared base the merge is applied directly; components with no core render base use the 2-spread form. Calendar's per-theme style member was migrated from `dom.Styles` to `Map<String,String>` to host the seam. Every addition is golden-neutral (rendered output unchanged when the new fields are unset).
- **M2: shipped the orphaned card family + `IconBadge`.** The card props + renderer-contracts that existed as dead code (`StatCardProps`, `FeatureCardProps`, `CTACardProps`, `TestimonialCardProps`, `PricingCardProps`) now have public widgets and per-theme renderers wired into all three themes: `StatCard`/`StatCardRow`, `FeatureCard`/`IconCard`, `CtaCard`, `TestimonialCard`/`RatingStars`, and `PricingCard`/`PricingGrid`. Each renders from theme CSS variables (adapts to any palette), is permeable (`styles:`/`decoration:`), and composes via a shared render base + thin theme subclasses. New `IconBadge` component makes the ubiquitous colored-icon-circle idiom first-class.
- **M3: Flutter-parity ergonomics.** `cx(List<String?>)` class-join helper (`util/classes.dart`, exported) collapses the `_joinClasses` idiom copy-pasted across sites; `Container` gained a semantic `tag:` (`'nav'`/`'section'`/`'header'`/…) so structural markup no longer drops to raw `dom.*` — the default `div` path is byte-identical.
- **M4: card-family surface completed against a real consumer.** `CtaCard` gained `accentColor` (tints the icon chip + CTA) and `isExternal` (opens in a new tab with `rel="noopener noreferrer"` and a `↗` affordance); `PricingCard` gained `highlighted` (an accent wash + a solid, row-outranking CTA) and per-row `SpecEntry.highlight`. These are what let QualityNode's marketing pages migrate onto the library cards with zero visual change.
- **M3 breaking type cleanups (Flutter-parity, no back-compat).** `Card.padding`/`Card.borderRadius` are now typed `EdgeInsets?`/`BorderRadius?` (were raw-CSS `String?`), aligning `Card` with `ArcaneStructuredCard`. The `classes:` parameter on the arcane wrapper widgets (`ArcaneDiv`/`ArcaneSpan`/`ArcaneSection`/`ArcaneParagraph`/`ArcaneHeading`/`ArcaneLink`/`ArcaneNav`/… and the layout/HTML wrappers) now takes `List<String>?` (was `String?`), joined internally via `cx` — conditional class lists (`['card', if (active) 'is-active']`) no longer need a manual join. `ArcaneStyleData.backgroundClip` is now a typed `BackgroundClip` enum (`borderBox`/`paddingBox`/`contentBox`/`text`) instead of a raw `String?`.
- **`ArcaneGallery` — themeable media masonry.** New `component/collection/gallery.dart` + `core/props/gallery_props.dart` + shared `core/rendering/base/gallery_render_base.dart`, wired into `ComponentRenderers` via `GalleryRendererContract`, with a per-theme renderer in every theme package (`packages/*/lib/src/renderers/gallery.dart`). Each theme renders the SAME `ArcaneGalleryTile{media(aspectRatio,src?),mediaChild?,title,meta,href/onTap,overlay,footer}` list natively: win95 = titled windows on the teal desktop, shadcn = clean cards, neubrutalism = hard-shadow blocks, neon = glow. The CSS-grid base uses coarse rows (`grid-auto-rows: minColumnWidth/2`) + aspect-driven COLUMN spans (`galleryColumnSpan`: wide→2, panorama→3) + `grid-auto-flow: dense` for a variable-width mosaic, refined by an opt-in packing script (`util/interactivity/scripts/gallery/gallery_scripts.dart`, emitted via `includeFallbackScripts`). Media covers its cell (`object-fit: cover`).
- **Win95 theme: runtime accent override.** The Windows 95 theme's desktop backdrop, title-bar gradient and selection color now read `var(--w95-desktop-in, …)` / `--w95-title-a-in` / `--w95-title-b-in` / `--w95-selection-in` (plus `--primary`/`--accent`/`--ring`), falling back to the active [Win95Theme] scheme when unset. A host app can inject those `--w95-*-in` variables (scoped to `#arcane-root.arcane-theme-win95`) to re-tint the desktop + title bars from a runtime account accent live, without a rebuild — while the silver `#c0c0c0` control face and 3D bevels stay fixed across every accent.

### Fixed

- **Rounded emphasis surfaces no longer render orphaned edge accents.** Accent alerts, feature cards, testimonial cards, Neon cards, prose/knowledge-base callouts, and active rounded navigation now use a complete perimeter, fill, icon, or symmetric ring instead of a one-sided border or clipped stripe. The component docs teach the same invariant, the alert showcase exercises the accent variant, and a render/CSS contract prevents the crescent treatment from returning.
- **Confirm and alert dialogs are visible when rendered.** Their shared
  renderer now opens the underlying dialog surface instead of emitting it with
  the default closed state and `hidden` attribute.
- **`ArcaneGallery` packed tiles can no longer overlap around fragmented
  gaps.** Placement now searches through the complete occupied board and always
  includes the first wholly empty row. Its defensive fallback also appends
  below occupied cells instead of forcing a multi-cell tile into the first
  undersized gap.
- **Owner-sized `ArcaneGallery` packing no longer strands interior cells.**
  Each source-ordered tile anchors at the earliest unfilled cell while retaining
  its independent ratio-scored row and column spans. Normal masonry gutters and
  a ragged terminal edge remain unchanged; later tiles cannot skip an interior
  cell, overlap earlier art, or fall below the configured minimum.
- **Shadcn: the dropdown *panel* no longer claims the open-trigger accent fill.** `.arcane-dropdown-menu[data-state='open']` sat in the shared "open/active trigger" selector list that paints `background-color: var(--accent); color: var(--accent-foreground)`, so the popover surface was told to drop off the `--popover`/`--popover-foreground` pair every other floating surface uses. It was masked in practice by the renderer's inline `background-color: var(--popover)`, but any consumer that overrode the panel's inline styles (`styles:`/`decoration:`) inherited an accent-tinted panel instead of a popover one. Only the trigger selectors remain in the list.

- **`ArcaneGallery` tile caption is now theme-opt-in.** The render base only emits the title/meta header block when the theme opts in via `showsTileHeader` (win95 renders it as the window title bar). The card-style themes (shadcn/neubrutalism/neon) previously rendered the caption after the media, where a rounded tile clipped its bottom corners into a stray "caption strip"; they now render clean media-only tiles and expose the title to assistive tech via the tile's `aria-label`.

- **Permeability internals hardening.** Rolled the `layerStyles` "literal-wins" helper out to 20 more single-root render bases (avatar, breadcrumbs, alert, skeleton, accordion, disclosure, toggle-group, kbd, menubar, toast, slider, radio-group, sidebar, field-wrapper/input-group, separator, time-picker, cycle-button, tab-bar, spinner, calendar) — byte-identical output, so a `decoration` shorthand can no longer out-emit a literal `styles:` longhand anywhere. Removed a dead `decorationStyles` spread from the checkbox/toggle-switch renderers (no theme mapped it; universal `decoration:` fields + literal `styles:` still apply). Renamed the Calendar renderer base's abstract `styles` getter to `rootStyles` to disambiguate it from the permeable `props.styles`. Neubrutalism decorated toasts opt out of the variant-border `!important` reset via `data-arcane-decorated`, matching the card opt-out.
- **Permeability precedence hardening (quality pass).** The seam now guarantees literal `styles:` wins the cascade via a `layerStyles` helper (`lib/core/rendering/base/style_layering.dart`) that remove-then-reinserts override keys, so "later layer" == "later in the emitted CSS" — closing a Dart map key-position pitfall where a `decoration` shorthand (`background`) could beat a literal `styles:` longhand (`background-color`). Also fixed: trailing button-resets on tappable `Card`/anchor `Button` that clobbered `styles:`; StatusBadge applying its position/card-color mutations after the permeability merge; `ArcaneStyleData.merge()` silently dropping `alignItems`/`justifyContent`; `ArcaneNativeSelect`/`TextArea`/`SlotCounter` factory constructors not threading the new fields; and `ArcaneColorOps.opacity` quantizing to whole percent. Neubrutalism per-instance shadow recolor now bakes the color into the `box-shadow` (CSS custom properties resolve at the theme root, so the prior `var(--nb-shadow-color)` override never inherited), and decorated cards opt out of the theme's `!important` surface reset via a `data-arcane-decorated` attribute.
- Form controls no longer throw on every interaction under dart2js (Dart 3.11). Event handlers read DOM properties via `dynamic` member access (`(event.target as dynamic).value`, `.checked`, `.selectedIndex`, `.key`, `.stopPropagation()`), which throws `TypeError: <name> is not a function` on `package:web` extension types — silently breaking every text input, textarea, OTP input, select search, and clear button (values never reached the callbacks). Added `core/dom_value.dart` (conditional web/stub helpers using explicit `getProperty`/`callMethod` interop) and routed `text_input`/`field`/`text_input_render_base`/`otp_input_render_base`/`select_render_base` through it. The helper is conditionally imported so styled components keep compiling during off-web style extraction (where `dart:js_interop` is unavailable).
- `ArcaneApp.head` is now actually rendered. The `head: List<Widget>?` parameter was declared but never injected into the document; `ArcaneApp` now emits the supplied widgets through jaspr's cross-platform `Document.head`, so app-level `<link>`/`<script>`/`<meta>` widgets reach `<head>` during both SSR and client hydration. No change when `head` is null/empty.
- Server-side rendering crash in the form-field widgets (`ArcaneStringField`, `ArcaneBoolField`, `ArcaneColorField`, `ArcaneDateField`, `ArcaneTimeField`, `ArcaneEnumField`). `ArcaneField` now guards its asynchronous value load to the client (`kIsWeb`), so SSR renders the loading placeholder instead of throwing a build-phase `setState` assertion. Client behavior is unchanged.
- shadcn knowledge-base sidebar: pinned directly below the sticky top bar (was offset ~56px too low, leaving a gap above the nav) and made independently scrollable (`max-height` + `overflow-y: auto`) instead of requiring the whole page to scroll.
- shadcn top bar: restored `position: sticky` (it was `static`, so it scrolled off-screen) with a solid background and bottom hairline, so it stays pinned while scrolling.
- shadcn docs content layout: the content area now centers (capped at `--container-2xl` with auto margins instead of stretching edge-to-edge), and the right-hand table-of-contents column is only reserved when a TOC is actually present — TOC-less pages (e.g. component docs) now center the article instead of leaving an empty reserved column.
- shadcn docs sidebar: nested nav items (sub-folder contents) now have vertical spacing — `.sidebar-tree` was missing a `gap`, so deeply nested items packed together; added `gap: 0.25rem` so they match the top-level spacing.
- Neon docs sidebar: pinned directly below the sticky top bar (was offset by a doubled top, leaving a gap above the nav) and given its own scroll rail (`max-height` + `overflow-y: auto`) instead of scrolling with the page. The shadcn layout port had keyed this on the `.shadcn-kb-sidebar` class; the rule now targets `.neon-kb-sidebar` so it actually matches the Neon DOM.
- Theme CSS is no longer re-materialized on stylesheet cache hits. `ArcaneStylesheetCss.resolve` now takes the component CSS as a thunk (`String Function()`) invoked only on a cache miss, so the large per-theme CSS string (e.g. the Win95 theme's ~5,600 lines) is built once and skipped entirely when the Expando cache is warm. Output is byte-identical.
- Removed the last two `dynamic` public-API fields (strong-typing): `TreeNodeData.data` is now `Object?`, and the four `FileUploadProps` drag/input handlers are typed `void Function(web.Event)?` (the concrete type jaspr's events layer delivers) instead of `void Function(dynamic)?`.

### Removed

- Deleted ~1,300 lines of unreachable scaffolding that could not be distinguished from the live contract surface: the 514-line `style_presets.dart` catalog (8 preset classes, zero references — the live preset vocabulary is the `ArcaneStyleData` statics) and 11 orphan `*_props.dart` files whose widgets already ship without them (`tile`, `card_section`, `center_body`, `expander`, `glass`, `section`, `radio_cards`, `fab`, `icon_button`, `header`, plus the dead `SearchProps`/`BarProps` classes). Live symbols trapped in dead files (the `BarBackButtonMode` enum, `SearchResult`) were preserved. Verified: every deleted symbol had zero references across `lib`/`packages`/`test`/`tool`/`bin`/docs, `dart analyze` stays 0-error, and the suite holds at 42 pre-existing golden failures.
- Added a direct unit test for the `layerStyles` cascade helper (`test/unit/layer_styles_test.dart`) — the core "literal `styles:` always wins" guarantee was only exercised indirectly through Card SSR cases; 7 tests now assert later-override-wins, key-moved-to-last, null-skip, and left-to-right multi-override behavior.
- Removed 47 more orphan `*_props.dart` files (`lib/core/props/` went from 114 files to 67) — every `Props` class + `RendererContract` with zero references to any widget, render base, theme renderer, or dispatch aggregator (`ComponentRenderers`/`LayoutRenderers`). These were scaffolding for components that were never built. Verified by a per-symbol zero-reference scan (`file_upload`, `tree_view`, `timeline`, `stepper`, `tracker`, `meter`, `hero_section`, `game_tile`, `carpet`, `marquee`, `switcher`, and ~36 others, plus a `footer_props`/`footer_column_props` dead cluster). `status_indicator_props.dart` was stripped to just its live `StatusType` enum; live symbols trapped in otherwise-dead files were preserved. `dart analyze` stays 0-error and the suite holds at its 42 pre-existing golden failures.

### Changed

- **Loaders now have one theme-renderer source of truth.** Standalone spinners,
  loading buttons, authentication guards, loading toasts (including the
  JavaScript fallback), and Shadcn loading selects all resolve through
  `ComponentRenderers.loadingSpinner`, so a theme's loader updates every
  loading surface.
- **Preset `style` field renamed to `variant` (breaking, no back-compat).** The 8 components that exposed a preset-enum selector as `style:` (`ArcaneAlert`, `ArcaneKbd`, `ArcaneEmptyState`, `ArcanePagination`, `InlineHeroBanner`, `CodeBlock`, `MutableText`, `ArcaneDropdownItem`) now expose it as `variant:` — matching `Card`/`PricingCard` which already used `variant`, and eliminating the one-letter collision with the permeable `styles:` escape hatch (a typo between `style:` and `styles:` previously compiled and did the opposite thing). Enum *type* names (`AlertStyle`, `KbdStyle`, …) are unchanged; only the field/param. Rendered output is byte-identical (identifier-only change).
- **`StatCard.icon` is now `Widget?` (was `String?`, breaking).** It matches `FeatureCard`/`CtaCard`/`PricingCard` — icons are Widgets, as in Flutter. The shared `StatCardRenderBase` now places the widget directly in the icon badge instead of emitting the string as text.
- **Dropped the `onClick` alias on the `Card` family (breaking).** All nine `Card`/`ArcaneStructuredCard`/`ArcaneImageCard` constructors kept both `onTap` and `onClick` (`_onTap = onTap ?? onClick`); `onClick` is removed, leaving `onTap` (Flutter parity, no-alias rule). No call sites passed `onClick` to a card.

- Internal: deduplicated the `arcane_jaspr_shadcn`, `arcane_jaspr_neon`, and `arcane_jaspr_neubrutalism` renderer implementations into shared base classes under `lib/core/rendering/base/`. Public renderer class names and rendered HTML output are unchanged (verified byte-identical across all three themes via golden snapshots). Removed the per-package `control_styles.dart`.
- **`PricingCard` layout tuned to match real plan/hosting cards.** The spec table now renders *above* the feature list inside a bordered, rounded box (was plain rows below the features); a non-highlighted card's CTA is a neutral outline (foreground label, `--border` edge) so a `highlighted` card's solid accent CTA visibly outranks its row; and the badge pill is no longer force-uppercased — it renders the label exactly as passed.
- Neon theme: `PricingCard` and `TestimonialCard` now lift on hover (whole-card `translateY` + shadow), matching the neon card feel. Delivered from the theme layer (`neon_css.dart`) so consumers get it for free instead of stapling it into site CSS.
- `arcane_jaspr_neon` rebuilt as a dark-first "gamer" theme (replaces the prior neutralized skeleton). Distilled from the QualityNode aesthetic: the default `NeonTheme.green` is an emerald-to-cyan palette, with seven other neon variants. The palette is fully seeded from `NeonTheme` via `lightSeed`/`darkSeed` (like the shadcn and neubrutalism themes); the dark seed enables `accentGlow`, so shadows carry a neon glow. New `NeonCss` supplies a restrained, glow-and-gradient component layer (Oxanium display font, uniform accent frames, uppercase tracked badges, accent focus rings) — every rule scoped to `#arcane-root.arcane-theme-neon`, so the shadcn and neubrutalism themes are unaffected. `NeonCss` also styles the documentation knowledge-base chrome (top bar, sidebar, content grid, TOC) so the Neon docs render correctly (the bespoke Neon docs layout was retired in `arcane_lexicon`; Neon now uses the standard chrome). Neon is back in the golden snapshot tests.

## [3.3.0] - 2026-05-7

### Changed

- **Flutter-First Primary Surface**
  - `package:arcane_jaspr/arcane_jaspr.dart` now exposes a curated Flutter-shaped surface instead of re-exporting raw Jaspr and DOM APIs
  - Added `Widget`, `StatelessWidget`, `StatefulWidget`, `State`, `InheritedWidget`, `BuildContext`, `Key`, and the normal `runApp` path on the primary import
  - Moved low-level HTML wrappers and raw Jaspr escape hatches onto explicit secondary imports

- **Secondary Surface Split**
  - Added `package:arcane_jaspr/flutter.dart`
  - Added `package:arcane_jaspr/html.dart`
  - Added `package:arcane_jaspr/web.dart`
  - Updated package internals that still needed low-level access to import those surfaces explicitly

- **Developer Experience Reset**
  - Removed HTML-first wrappers from the primary docs path and rewrote the default documentation flow around the Flutter-first authoring model
  - Added plain Jaspr versus Arcane Jaspr comparison examples in the docs intro to explain the intended Flutter-like goal directly
  - Reworked the docs demo system around a central registry and generated component catalog output to keep examples and counts in sync
  - Updated the repo-owned Oracular ArcaneJaspr templates to teach the new primary surface instead of old Jaspr component base classes

### Added

- **Primary Surface Guardrails**
  - Added `tool/check_primary_surface.dart` to scan docs, demos, and templates for banned primary-surface examples such as old component base classes, `htmlFor`, and explicit generic angle-bracket usage

### Removed

- **Counter Smoke App**
  - Removed the temporary counter smoke app fixture created during the parity reset work

## [2.9.1] - Unreleased

### Changed

**Props Consolidation - Shared Type System**
- Created `lib/core/shared/size.dart` with unified `ComponentSize` enum supporting both naming conventions:
  - `sm`, `md`, `lg` (preferred)
  - `small`, `medium`, `large` (aliases pointing to same values)
- Created `lib/core/shared/variants.dart` with standardized variant enums:
  - `ColorVariant`: primary, secondary, destructive, success, warning, info
  - `StyleVariant`: solid, outline, ghost, link
- Updated 25+ props files to use shared types instead of component-specific enums
- Standardized on "destructive" naming (not "error") across all components

**ArcaneMenuItem Refactored to Sealed Classes**
- Converted `ArcaneMenuItem` from single class with boolean flags to sealed class hierarchy
- New type-safe menu item classes:
  - `MenuItemAction` - Standard clickable menu item with label, icon, shortcut
  - `MenuItemSeparator` - Visual divider between menu items
  - `MenuItemCheckbox` - Toggleable checkbox menu item
  - `MenuItemRadio` - Radio button menu item (mutually exclusive selection)
  - `MenuItemSubmenu` - Nested submenu container
  - `MenuItemLabel` - Non-interactive label/header
- All menu renderers (DropdownMenu, ContextMenu, Menubar) updated to use pattern matching
- Enables compile-time exhaustiveness checking for menu item handling

**Form Components Unified into SimpleForm**
- Merged `NewsletterForm` and `WaitlistForm` into unified `SimpleForm` component
- New `SimpleFormProps` with factory constructors:
  - `SimpleFormProps.newsletter()` - Email signup with inline layout
  - `SimpleFormProps.waitlist()` - Waitlist form with optional name collection
  - `SimpleFormProps.contact()` - Contact form with name, email, message
- New `SimpleFormField` class for flexible field definitions:
  - `SimpleFormFieldType`: text, email, password, phone, url, textarea
  - Custom validation via `validator` callback
  - Labels, placeholders, hints, and required field support
- Convenience wrapper components:
  - `ArcaneSimpleForm` - General purpose form
  - `ArcaneNewsletterForm` - Email signup (uses SimpleForm internally)
  - `ArcaneWaitlistForm` - Waitlist form (uses SimpleForm internally)
  - `ArcaneContactForm` - Contact form (uses SimpleForm internally)

### Removed

**Form Component Files Deleted**
- Removed `lib/core/props/newsletter_form_props.dart` (use `SimpleFormProps`)
- Removed `lib/stylesheets/shadcn/renderers/newsletter_form.dart` (use `simple_form.dart`)
- Removed `lib/component/form/newsletter_form.dart` (use `simple_form.dart`)

### Added

**ArcaneIcon Semantic Aliases**
- Added `ArcaneIcon.key()` alias mapping to `key-round` icon for intuitive usage in security-related UI
- Added `ArcaneIcon.map()` alias for the map icon (resolves conflict with Dart's `Map` type)

### Fixed

**Browser Scrollbar Styling**
- `ArcaneApp` now injects stylesheet CSS into the document `<head>` using `Document.head()` instead of inside the `#arcane-root` div
- `ArcaneApp` now adds the brightness class (`dark`/`light`) to the `<html>` element using `Document.html()`
- `CssGenerator` now outputs CSS variables on `html.dark`/`html.light` selectors in addition to `.dark`/`.light`, enabling scrollbar pseudo-elements to access theme variables
- Document-level scrollbars now properly inherit theme colors (`--background`, `--primary`) and match the styling of other scrollbars

### Changed

**Redesigned Light Themes for Richer Surfaces**
- `PaletteGenerator` light mode tinting increased for more visible surface contrast:
  - Secondary: 6% darken + 12% primary blend (was 4%/8%)
  - Accent: 10% darken + 18% primary blend (was 6%/12%)
  - Border: 18% darken + 10% primary blend (was 12%/6%)
  - Card: 2% darken + 5% primary blend (was 1%/3%)
  - Muted: 5% darken + 10% primary blend (was 3%/6%)
- `ShadcnTheme` pastel themes now use white backgrounds with richer tinted surfaces:
  - All pastel themes changed from tinted backgrounds to clean white (`0xFFffffff`)
  - Explicit secondary/accent colors provide visible contrast against white
  - Professional aesthetic with clearly distinguishable surface layers
- `NeonTheme` now includes bold, gaming-inspired light surface colors:
  - Each theme (green, red, blue, purple, cyan, pink, orange, rainbow) defines explicit `lightSecondary`, `lightAccent`, and `lightBorder`
  - Light surfaces are intentionally more saturated for gaming aesthetic
  - Example: green theme uses mint surfaces (`0xFFd1fae5`, `0xFFa7f3d0`, `0xFF6ee7b7`)
- `NeonStylesheet.lightSeed` updated to use explicit theme colors instead of auto-derivation

**ArcaneMap Theme Integration**
- `MapStyle` now uses CSS variables by default for theme-aware styling:
  - Default constructor uses `var(--card)`, `var(--muted)`, `var(--border)`, `var(--primary)`, etc.
  - Added `MapStyle.themed` constant (default behavior, uses CSS variables)
  - Existing `MapStyle.dark` and `MapStyle.light` still available with explicit hex colors
- Added `arcaneMapCss` constant with comprehensive styling:
  - **ShadCN (base)**: Clean map styling with theme variable integration
  - Hover effects on regions and location pins
  - Debug tooltip styling using theme colors
  - **Neon (overrides)**: Cyberpunk map effects
  - Glowing region hover effects with `drop-shadow`
  - Pulsing pin animation (`arcane-map-pin-pulse`)
  - Neon-styled debug tooltips with text shadows
- Added `data-active="true"` attribute to active regions for CSS targeting

**ArcaneFlexiCards Smooth Animation**
- Redesigned height animation to use CSS Grid `grid-template-rows` technique:
  - `0fr` to `1fr` transition provides smooth, natural height animation
  - No more abrupt "jumping" when long text is revealed
  - Footer animates smoothly alongside text content
- Text no longer "shuffles" during resize:
  - Inner content wrapper with `overflow: hidden` and `min-height: 0`
  - Opacity fades in sync with height animation
- Improved transition timing with `cubic-bezier(0.4, 0, 0.2, 1)` easing
- Non-hovered cards now shrink to `0.8x` when another card is hovered
- Added `.hovered` CSS class for additional styling hooks
- **Neon renderer enhancements**:
  - Icon glows on hover with `box-shadow`
  - Title changes to primary color with text shadow on hover
  - Card background tints toward primary on hover
  - Border glows with neon effect

**Improved TOC and Sidebar Tree Styles**
- `arcaneTocTreeLinesCss` - Complete rewrite with proper tree line visualization:
  - **ShadCN (base)**: Clean, subtle tree lines using `var(--border)` color
  - Added scrollbar styling for `.kb-toc` and `.toc-container` classes
  - Uses `::before` for horizontal branches and `::after` for vertical connectors
  - Proper last-child handling with L-bend effect (vertical line stops at center for last item)
  - Fading tree lines at deeper nesting levels
  - Single-child detection to hide unnecessary tree lines
  - Smaller, more subtle link styling (12px font, refined padding)
  - **Neon (overrides)**: Glowing tree lines with `var(--primary)` color
  - Thicker 2px lines with `box-shadow` glow effects
  - Border-left accent on links with glowing active states
  - Monospace font for headers
- `arcaneSidebarTreeStyles` - Complete rewrite matching Neon website patterns:
  - **ShadCN (base)**: Clean tree lines with subtle borders
  - Added `.sidebar-tree` container class support
  - Consistent tree line implementation using `::before`/`::after` pseudo-elements
  - Added collapsible section styles (`.sidebar-details`, `.sidebar-summary`, `.sidebar-chevron`)
  - Added animated chevron icon for expand/collapse
  - Proper `.sidebar-link` styling with hover and active states
  - Fading tree lines at deeper nesting levels
  - **Neon (overrides)**: Cyberpunk glowing tree lines
  - Thicker 2px primary-colored lines with glow effects
  - Border-left accent styling with straight left edges
  - Prominent glow on active states with inset box-shadow
  - Monospace font for section headers and summaries

### Added

**Project Conventions**
- Documented sitemap generation: Use `--sitemap-domain=<domain>` with `jaspr build`
- Documented favicon convention: Place `icon.png` in `web/assets/` directory
- Updated `ArcaneDocsLayout` to use `assets/icon.png` for favicon with apple-touch-icon support

**Documentation Components (migrated from arcane_lexicon)**
- `ArcaneDocsLayout` - Documentation-style layout with fixed header, sidebar, main content, and optional TOC
- `ArcaneToc` - Table of contents component with tree-line visual connectors
- `ArcanePageNav` - Previous/Next page navigation component for documentation
- `TocEntry` and `PageNavItem` data classes for navigation

**Content Utilities**
- `calculateReadingTime()` - Calculate estimated reading time from markdown content
- `ReadingTimeResult` class with minutes, wordCount, and formatted text getter
- `String.readingTime` extension for convenient reading time calculation

**Prose CSS Styles**
- `arcaneProseStyles` - Typography styles for markdown content (headings, paragraphs, lists, links, blockquotes, tables)
- `arcaneProseCodeStyles` - Syntax highlighting for code blocks (light/dark modes with GitHub-inspired colors)
- `arcaneCodeCopyButtonStyles` - Copy button styles for code blocks
- `arcaneCalloutStyles` - Callout/admonition block styles (note, tip, important, warning, caution)
- `arcaneSidebarTreeStyles` - Tree-line navigation styles for sidebars
- `arcaneTocTreeLinesCss` - Tree-line styles for table of contents
- `arcaneAllDocsStyles` - Combined constant with all documentation styles
- `arcaneDocsLayoutResponsiveCss` - Responsive breakpoint styles for docs layout
- `arcanePageNavCss` - Hover styles for page navigation
