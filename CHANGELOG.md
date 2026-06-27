# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [x.x.x]

### Fixed

- Server-side rendering crash in the form-field widgets (`ArcaneStringField`, `ArcaneBoolField`, `ArcaneColorField`, `ArcaneDateField`, `ArcaneTimeField`, `ArcaneEnumField`). `ArcaneField` now guards its asynchronous value load to the client (`kIsWeb`), so SSR renders the loading placeholder instead of throwing a build-phase `setState` assertion. Client behavior is unchanged.

### Changed

- Internal: deduplicated the `arcane_jaspr_shadcn`, `arcane_jaspr_neon`, and `arcane_jaspr_neubrutalism` renderer implementations into shared base classes under `lib/core/rendering/base/`. Public renderer class names and rendered HTML output are unchanged (verified byte-identical across all three themes via golden snapshots). Removed the per-package `control_styles.dart`.

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
