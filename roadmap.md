# arcane_jaspr Feature Roadmap

> **Current Version:** 2.5.0
> **Components:** 150+ | **Lines of Code:** 36,000+ | **Themes:** 20

---

## shadcn/ui Parity Checklist

Reference: https://ui.shadcn.com/docs/components

| shadcn Component | arcane_jaspr Status | Notes |
|-----------------|---------------------|-------|
| Accordion | ✅ `ArcaneAccordion` | Full feature parity |
| Alert | ✅ `ArcaneAlert` | 4 variants |
| Alert Dialog | ⚠️ Partial | Have `ArcaneDialog`, need async alert |
| Aspect Ratio | ❌ Missing | Add `ArcaneAspectRatio` |
| Avatar | ✅ `ArcaneAvatar` | With fallback |
| Badge | ✅ `ArcaneBadge` | Multiple variants |
| Breadcrumb | ✅ `ArcaneBreadcrumbs` | 4 separator styles |
| Button | ✅ `ArcaneButton` | 8+ variants |
| Calendar | ❌ Missing | Priority for date picker |
| Card | ✅ `ArcaneCard` | With sections |
| Carousel | ⚠️ Basic | Have `ArcaneCardCarousel`, need full features |
| Chart | ❌ Missing | Consider charting library integration |
| Checkbox | ✅ `ArcaneCheckbox` | Full feature |
| Collapsible | ✅ `ArcaneExpander` | Standalone collapsible |
| Combobox | ❌ Missing | Priority input component |
| Command | ❌ Missing | Command palette (Cmd+K) |
| Context Menu | ❌ Missing | Right-click menu |
| Data Table | ✅ `ArcaneDataTable` | Sortable, selectable |
| Date Picker | ❌ Missing | Requires Calendar first |
| Dialog | ✅ `ArcaneDialog` | With confirm variant |
| Drawer | ✅ `ArcaneDrawer` | All 4 sides |
| Dropdown Menu | ✅ `ArcaneDropdownMenu` | Full feature |
| Empty | ✅ `ArcaneEmptyState` | With icon and action |
| Form | ⚠️ Basic | Have field system, need full Form wrapper |
| Hover Card | ✅ `ArcaneHovercard` | With delays |
| Input | ✅ `ArcaneTextInput` | With prefix/suffix |
| Input Group | ❌ Missing | Grouped inputs |
| Input OTP | ❌ Missing | OTP code input |
| Item | ⚠️ Partial | Various item components |
| Kbd | ✅ `ArcaneKbd` | With combo support |
| Label | ✅ `ArcaneLabel` | HTML wrapper |
| Menubar | ❌ Missing | Horizontal menu bar |
| Native Select | ✅ `ArcaneSelect` | Native HTML select |
| Navigation Menu | ⚠️ Partial | Have `ArcaneHeader`, need full nav menu |
| Pagination | ✅ `ArcanePagination` | Multiple styles |
| Popover | ✅ `ArcanePopover` | Click/hover triggers |
| Progress | ✅ `ArcaneProgressBar` | With variants |
| Radio Group | ✅ `ArcaneRadioGroup` | 4 variants (NEW) |
| Resizable | ❌ Missing | Resizable panels |
| Scroll Area | ✅ `ArcaneScrollArea` | With virtual scroll (NEW) |
| Select | ✅ `ArcaneSelector` | Searchable, multi-select |
| Separator | ✅ `ArcaneSeparator` | Multiple styles (NEW) |
| Sheet | ✅ `ArcaneDrawer` | Same as drawer |
| Sidebar | ✅ `ArcaneSidebar` | Collapsible |
| Skeleton | ✅ `ArcaneSkeleton` | Loading placeholder |
| Slider | ✅ `ArcaneSlider` | With step markers |
| Sonner/Toast | ✅ `ArcaneToaster` | Full Sonner-style (NEW) |
| Spinner | ✅ `ArcaneLoader` | Animation |
| Switch | ✅ `ArcaneToggleSwitch` | Full feature |
| Table | ✅ `ArcaneStaticTable` | Basic table |
| Tabs | ✅ `ArcaneTabs` | Multiple styles |
| Textarea | ✅ `ArcaneTextArea` | With resize control |
| Toggle | ✅ `ArcaneToggleButton` | With groups |
| Toggle Group | ✅ `ArcaneToggleButtonGroup` | Full feature |
| Tooltip | ✅ `ArcaneTooltip` | Basic positioning |
| Typography | ✅ `ArcaneHeadline`, etc. | Full typography |

### Additional arcane_jaspr Components (beyond shadcn)

| Component | Description |
|-----------|-------------|
| `ArcaneMutableText` | Inline editable text (NEW) |
| `ArcaneVirtualScroll` | Virtualized list for performance (NEW) |
| `ArcaneTimeline` | Vertical event timeline |
| `ArcaneStepper` | Multi-step wizard |
| `ArcaneTreeView` | Hierarchical tree structure |
| `ArcaneRatingStars` | Star rating display |
| `ArcaneMeter` | Gauge/meter component |
| `ArcaneStatusIndicator` | Online/offline indicators |
| `ArcaneAnimatedCounter` | Number animation |
| `ArcaneGradientText` | Gradient text effect |
| `ArcaneGlass` | Glassmorphism container |
| `ArcaneAuthProvider` | Firebase auth integration |
| 11 OAuth buttons | GitHub, Google, Apple, etc. |
| 20 built-in themes | With customization |

**Summary:** 42/54 shadcn components (78%), plus 15+ unique components

---

## Executive Summary

arcane_jaspr is a mature, feature-rich component library with exceptional type-safe styling via `ArcaneStyleData`. The library excels at theming (20 presets), OAuth integration (11 providers), and static site support. Key gaps exist in responsive design, form validation, and advanced interactive patterns.

---

## Priority 1: Critical Gaps (High Impact)

### 1.1 Responsive Design API

**Problem:** No media query support in `ArcaneStyleData`. Developers must use raw CSS or manual conditionals for responsive layouts.

**Solution:** Add breakpoint-aware styling system.

```dart
// Proposed API
ArcaneStyleData(
  display: Display.flex,
  // Mobile-first responsive variants
  responsive: ResponsiveStyles(
    sm: ArcaneStyleData(flexDirection: FlexDirection.column),
    md: ArcaneStyleData(flexDirection: FlexDirection.row),
    lg: ArcaneStyleData(gap: Gap.xl),
  ),
)

// Or chained API
ArcaneStyleData()
  .column()
  .md((s) => s.row())
  .lg((s) => s.gap(Gap.xl))
```

**Features to Add:**
- [ ] `Breakpoint` enum: `xs` (<640), `sm` (640+), `md` (768+), `lg` (1024+), `xl` (1280+), `2xl` (1536+)
- [ ] `ResponsiveStyles` class for breakpoint-specific overrides
- [ ] Media query generation in `toStyles()`
- [ ] Container query support (future CSS standard)
- [ ] Responsive padding/margin shorthand presets
- [ ] Responsive typography scale
- [ ] Responsive visibility helpers (`hideOn`, `showOn`)

**Impact:** Unblocks modern responsive web development without raw CSS hacks.

---

### 1.2 Form Validation Framework

**Problem:** No unified validation system. Each input handles errors differently with no schema support.

**Solution:** Schema-based validation library with async support.

```dart
// Proposed API
final formSchema = ArcaneFormSchema({
  'email': [
    Required('Email is required'),
    Email('Invalid email format'),
  ],
  'password': [
    Required('Password is required'),
    PasswordPolicy.standard(),
    Async((value) => checkPasswordPwned(value)),
  ],
  'confirmPassword': [
    Required('Please confirm password'),
    Match('password', 'Passwords must match'),
  ],
});

ArcaneForm(
  schema: formSchema,
  onSubmit: (values) => handleSubmit(values),
  child: Column([
    ArcaneTextField(name: 'email'),
    ArcanePasswordField(name: 'password'),
    ArcanePasswordField(name: 'confirmPassword'),
  ]),
)
```

**Features to Add:**
- [ ] `ArcaneFormSchema` - Schema definition class
- [ ] `ArcaneForm` - Form wrapper with state management
- [ ] Built-in validators: `Required`, `Email`, `MinLength`, `MaxLength`, `Pattern`, `Match`, `Range`, `Url`, `Phone`
- [ ] `PasswordPolicy` validator (already exists, integrate into schema)
- [ ] Async validation support with debouncing
- [ ] Field dependencies and conditional validation
- [ ] Form submission states (idle, submitting, success, error)
- [ ] Auto-scroll to first error
- [ ] Form-level error summary component
- [ ] Unsaved changes detection
- [ ] Draft auto-save

**Impact:** Dramatically improves form development experience.

---

### 1.3 Missing Input Components

**Problem:** Several common input types are missing.

**Components to Add:**
- [ ] `ArcaneTextarea` - Multi-line text input with auto-resize, character counter
- [ ] `ArcaneDatePicker` - Date selection with calendar popup
- [ ] `ArcaneTimePicker` - Time selection
- [ ] `ArcaneDateTimePicker` - Combined date/time
- [ ] `ArcaneDateRangePicker` - Date range selection
- [ ] `ArcaneRadioGroup` - Radio button group with proper ARIA
- [ ] `ArcaneMultiSelect` - Multiple selection with checkboxes
- [ ] `ArcaneCombobox` - Searchable select with custom input
- [ ] `ArcanePhoneInput` - Phone number with country code
- [ ] `ArcaneCurrencyInput` - Currency formatting
- [ ] `ArcanePasswordStrengthMeter` - Visual password strength indicator
- [ ] `ArcaneInputMask` - Input masking (phone, SSN, credit card, dates)

**Impact:** Completes the input component set for common form patterns.

---

## Priority 2: High Value Additions

### 2.1 Advanced Dialog System

**Current State:** Basic Dialog, Confirm, TextDialog, Toast exist.

**Improvements:**
- [ ] `ArcaneDrawer` / `ArcaneSheet` - Slide-out panel (left, right, top, bottom)
- [ ] `ArcaneAlertDialog` - Async alert with promise return
- [ ] `ArcanePromptDialog` - Text input dialog with validation
- [ ] `ArcaneFullScreenDialog` - Full-screen modal
- [ ] Dialog size presets: `sm`, `md`, `lg`, `xl`, `full`
- [ ] Nested dialog handling with z-index management
- [ ] Dialog transitions: fade, slide, scale
- [ ] Focus trap for accessibility
- [ ] Click-outside-to-close control

**Toast System Improvements:**
- [ ] Toast queue management with stacking
- [ ] Auto-dismiss with configurable duration
- [ ] Action buttons in toasts
- [ ] Toast grouping (collapse similar toasts)
- [ ] Toast positions: all 8 corners + center variants
- [ ] Toast progress indicator

---

### 2.2 Navigation Enhancements

**Components to Add:**
- [ ] `ArcaneTabNav` - Navigation-style tabs (vs content tabs)
- [ ] `ArcaneStepper` - Multi-step wizard navigation
- [ ] `ArcaneCommandPalette` - Command/search palette (Cmd+K pattern)
- [ ] `ArcaneMegaMenu` - Multi-column dropdown mega menu
- [ ] `ArcaneContextMenu` - Right-click context menu
- [ ] `ArcaneSkipLink` - Skip to main content link
- [ ] `ArcaneStickyNav` - Scroll-aware sticky navigation

**Improvements:**
- [ ] Sidebar: Add collapse animation, resize handle, floating mode
- [ ] Breadcrumbs: Add overflow handling, home icon, separator customization
- [ ] Pagination: Add page size selector, total items display, jump to page
- [ ] Mobile menu: Add gesture support, backdrop blur, nested submenus

---

### 2.3 Enhanced Data Display

**Components to Add:**
- [ ] `ArcaneVirtualList` - Virtualized list for large datasets
- [ ] `ArcaneVirtualTable` - Virtualized data table
- [ ] `ArcaneMasonryGrid` - Pinterest-style masonry layout
- [ ] `ArcaneImageGallery` - Gallery with lightbox
- [ ] `ArcaneComparisonTable` - Feature comparison table
- [ ] `ArcaneKanbanBoard` - Kanban drag-drop board
- [ ] `ArcaneStatCard` - Stat display with trend indicator
- [ ] `ArcaneMetricCard` - KPI display with sparkline

**DataTable Improvements:**
- [ ] Column resizing
- [ ] Column reordering (drag-drop)
- [ ] Row expansion with nested content
- [ ] Row grouping
- [ ] Column pinning (freeze columns)
- [ ] Export to CSV/Excel
- [ ] Server-side pagination integration
- [ ] Filter UI components
- [ ] Bulk actions toolbar
- [ ] Saved views

**Timeline Improvements:**
- [ ] Horizontal timeline variant
- [ ] Alternating layout
- [ ] Collapsible timeline sections
- [ ] Timeline with filtering

---

### 2.4 Carousel & Gallery System

**Problem:** Basic carousel exists but lacks essential features.

**Features to Add:**
- [ ] Navigation arrows (prev/next)
- [ ] Dot indicators with position feedback
- [ ] Autoplay with pause on hover
- [ ] Swipe/touch gesture support
- [ ] Keyboard navigation (arrow keys)
- [ ] Infinite loop option
- [ ] Multiple slides visible
- [ ] Variable slide widths
- [ ] Fade transition variant
- [ ] Thumbnail navigation
- [ ] Lightbox integration
- [ ] Lazy image loading

**New Components:**
- [ ] `ArcaneCarousel` - Full-featured carousel
- [ ] `ArcaneLightbox` - Image lightbox modal
- [ ] `ArcaneImageZoom` - Hover/click zoom for images

---

## Priority 3: Developer Experience

### 3.1 Style System Improvements

**ArcaneStyleData Ergonomics:**

```dart
// Current: Verbose
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.md,
    padding: PaddingPreset.lg,
  ),
)

// Proposed: Fluent Builder
ArcaneDiv(
  styles: ArcaneStyles.flex.column.gap(md).padding(lg).build(),
)

// Or Static Presets
ArcaneDiv(styles: Styles.card)  // Pre-composed for common patterns
ArcaneDiv(styles: Styles.formField)
ArcaneDiv(styles: Styles.navItem)
```

**Improvements:**
- [ ] `ArcaneStyles` fluent builder API
- [ ] Pre-composed style presets: `card`, `formField`, `navItem`, `hero`, `section`, etc.
- [ ] Style inheritance helpers
- [ ] Style debugging mode (visualize boxes, spacing)
- [ ] Style documentation generator

**New Style Properties:**
- [ ] `aspectRatio` - Aspect ratio container
- [ ] `gradient` - Linear/radial gradient backgrounds
- [ ] `filter` - CSS filters (blur, brightness, etc.)
- [ ] `textShadow` - Text shadow effects
- [ ] `clipPath` - Shape clipping
- [ ] `scrollBehavior` - Smooth scroll
- [ ] `scrollSnapType` / `scrollSnapAlign` - Scroll snapping
- [ ] `containerType` / `containerName` - Container queries
- [ ] `focusRing` - Focus indicator presets

---

### 3.2 Component Composition System

**Problem:** Creating component variants requires copying code.

**Solution:** Composition primitives and variant system.

```dart
// Variant definition
final ButtonVariants = ArcaneVariants<ArcaneButton>(
  base: ArcaneButton.medium,
  variants: {
    'icon': (b) => b.copyWith(padding: PaddingPreset.sm, iconOnly: true),
    'pill': (b) => b.copyWith(borderRadius: Radius.full),
    'loading': (b) => b.copyWith(loading: true, disabled: true),
  },
);

// Usage
ButtonVariants.icon(onPressed: () {}, icon: Icons.add)
ButtonVariants.pill(onPressed: () {}, child: Text('Subscribe'))
```

**Features:**
- [ ] `ArcaneVariants` - Type-safe variant system
- [ ] `composeStyles()` - Merge multiple style definitions
- [ ] Component `copyWith` on all components
- [ ] Default slot system for composition

---

### 3.3 Theme System Enhancements

**Current:** 20 themes with customization via `radius`, `surfaceOpacity`, `primaryOpacity`.

**Improvements:**
- [ ] Runtime theme switching without rebuild
- [ ] Theme builder API for custom themes
- [ ] Theme export/import (JSON)
- [ ] Per-component theme overrides
- [ ] High contrast mode
- [ ] Reduced motion support
- [ ] Color scheme generator from brand color
- [ ] Theme preview component

**New Themes:**
- [ ] `forest` - Green nature theme
- [ ] `ocean` - Blue ocean theme
- [ ] `sunset` - Orange/pink gradient theme
- [ ] `monochrome` - Black & white theme
- [ ] `neon` - Bright neon accents
- [ ] `pastel` - Soft pastel colors

---

## Priority 4: Accessibility (A11y)

### 4.1 ARIA & Screen Reader Support

**Current:** Basic ARIA attributes present on some components.

**Improvements:**
- [ ] Audit all components for ARIA compliance
- [ ] Add `aria-invalid`, `aria-required` to all form inputs
- [ ] Add `aria-live` regions for dynamic content
- [ ] Add `aria-busy` for loading states
- [ ] Proper `role` attributes on all interactive components
- [ ] Screen reader announcements for state changes
- [ ] Landmark roles: `navigation`, `main`, `complementary`, `contentinfo`

---

### 4.2 Keyboard Navigation

**Current:** Accordion, Tabs, TreeView have keyboard nav.

**Improvements:**
- [ ] Full arrow key navigation for all lists and menus
- [ ] Home/End key support
- [ ] Page Up/Down for long lists
- [ ] Focus trap for dialogs and popovers
- [ ] Roving tabindex for component groups
- [ ] Escape key handling for dismissible components
- [ ] Tab order management utilities
- [ ] Visible focus indicators (focus ring presets)

---

### 4.3 Visual Accessibility

**Features to Add:**
- [ ] High contrast mode theme
- [ ] Focus indicator customization per theme
- [ ] Color contrast ratio checker (design-time)
- [ ] `prefers-reduced-motion` support
- [ ] `prefers-color-scheme` auto-detection
- [ ] Font size scaling support
- [ ] Skip link component
- [ ] Accessible icon components (with labels)

---

## Priority 5: Authentication System

### 5.1 Auth UI Improvements

**Current:** Login, Signup, ForgotPassword cards with 11 OAuth providers.

**Components to Add:**
- [ ] `ArcaneEmailVerificationCard` - Email verification flow
- [ ] `ArcaneResetPasswordCard` - Password reset (post-email)
- [ ] `ArcaneProfileCard` - User profile view/edit
- [ ] `ArcaneAccountSettingsCard` - Account settings
- [ ] `ArcaneTwoFactorSetupCard` - 2FA setup flow
- [ ] `ArcaneTwoFactorVerifyCard` - 2FA code entry
- [ ] `ArcaneOAuthLinkingCard` - Link social accounts
- [ ] `ArcaneSessionsCard` - Active sessions management
- [ ] `ArcaneDeleteAccountCard` - Account deletion flow

**Auth Flow Improvements:**
- [ ] Multi-step signup wizard
- [ ] Progressive profiling
- [ ] Social account linking
- [ ] Session management UI
- [ ] Login history view
- [ ] Security alerts component

---

### 5.2 Auth Service Enhancements

**Current:** Firebase-only with OAuth and email/password.

**Improvements:**
- [ ] Auth provider abstraction layer (for non-Firebase)
- [ ] Anonymous auth support with account linking
- [ ] Token refresh management
- [ ] Retry logic for failed operations
- [ ] Offline authentication state handling
- [ ] Session timeout management
- [ ] Device recognition
- [ ] Rate limiting UI feedback

**New Providers (via abstraction):**
- [ ] Supabase auth adapter
- [ ] Auth0 adapter
- [ ] Custom JWT adapter

---

## Priority 6: Advanced Patterns

### 6.1 Interactive Components

**Components to Add:**
- [ ] `ArcaneDragDrop` - Drag and drop primitives
- [ ] `ArcaneSortableList` - Reorderable list
- [ ] `ArcaneResizable` - Resizable container
- [ ] `ArcaneSplitPane` - Split pane layout
- [ ] `ArcaneInfiniteScroll` - Infinite scroll wrapper
- [ ] `ArcanePullToRefresh` - Pull to refresh (mobile)
- [ ] `ArcaneGesture` - Touch gesture handling
- [ ] `ArcaneClipboard` - Copy to clipboard with feedback
- [ ] `ArcaneShare` - Native share API integration

---

### 6.2 Data Fetching Patterns

**Components to Add:**
- [ ] `ArcaneFetcher` - Data fetching wrapper with states
- [ ] `ArcaneRefreshable` - Pull-to-refresh wrapper
- [ ] `ArcanePolling` - Auto-refresh at interval
- [ ] `ArcaneOptimistic` - Optimistic update wrapper
- [ ] `ArcanePaginated` - Pagination state management
- [ ] `ArcaneSearchResults` - Search with debounce

---

### 6.3 Layout Patterns

**Components to Add:**
- [ ] `ArcaneAspectRatio` - Aspect ratio container
- [ ] `ArcaneParallax` - Parallax scrolling section
- [ ] `ArcaneSticky` - Sticky positioning wrapper
- [ ] `ArcaneStickyHeader` - Sticky header on scroll
- [ ] `ArcaneResponsiveContainer` - Breakpoint-aware container
- [ ] `ArcaneOffscreen` - Render off-screen (performance)

---

## Priority 7: Developer Tooling

### 7.1 Documentation & Examples

- [ ] Component playground (interactive examples)
- [ ] Copy-paste code snippets
- [ ] Props documentation generator
- [ ] Theme preview gallery
- [ ] Icon browser
- [ ] Color palette explorer
- [ ] Spacing/sizing visualizer

---

### 7.2 Development Tools

- [ ] Visual style debugger (show boxes, margins, padding)
- [ ] Accessibility audit overlay
- [ ] Performance profiler
- [ ] Bundle size analyzer
- [ ] Component usage analytics

---

### 7.3 Testing Utilities

- [ ] Component test helpers
- [ ] Accessibility test matchers
- [ ] Snapshot testing utilities
- [ ] Visual regression testing setup
- [ ] E2E test helpers

---

## Priority 8: Performance

### 8.1 Optimization Features

- [ ] Lazy component loading
- [ ] Image optimization (lazy, srcset, blur placeholder)
- [ ] Virtual scrolling for all list components
- [ ] Tree-shakeable theme imports
- [ ] Fallback script splitting (load only needed scripts)
- [ ] CSS extraction and optimization
- [ ] Font subsetting helpers

---

### 8.2 Bundle Size Reduction

- [ ] Modular imports (`import 'package:arcane_jaspr/button.dart'`)
- [ ] Theme tree-shaking (import only used themes)
- [ ] Icon tree-shaking
- [ ] Dead code elimination helpers
- [ ] Minimal core bundle option

---

## Component Inventory Checklist

### Existing (150+)
- [x] Button, IconButton, FAB, ToggleButton
- [x] TextInput, Search, Select, Selector, Checkbox, Toggle, Slider, RangeSlider
- [x] NumberInput, ColorInput, TagInput, FileUpload
- [x] Card, Alert, Badge, Chip, Avatar, Divider
- [x] DataTable, Timeline, TreeView, RatingStars
- [x] Skeleton, EmptyState, ProgressBar, Meter, Loader
- [x] Dialog, Confirm, Toast, Tooltip, Popover, Hovercard
- [x] Sidebar, Header, Breadcrumbs, Dropdown, Pagination
- [x] Tabs, Accordion, Expander
- [x] Section, Container, Gutter, Grid layouts
- [x] Screen, NavigationScreen, DashboardLayout
- [x] Auth components (Login, Signup, ForgotPassword)
- [x] OAuth buttons (11 providers)
- [x] HTML wrappers (Div, Button, Input, etc.)

### Missing (To Add)
- [ ] Textarea
- [ ] DatePicker, TimePicker, DateRangePicker
- [ ] RadioGroup
- [ ] MultiSelect
- [ ] Combobox
- [ ] PhoneInput, CurrencyInput, InputMask
- [ ] Drawer/Sheet
- [ ] AlertDialog, PromptDialog
- [ ] Stepper
- [ ] CommandPalette
- [ ] ContextMenu
- [ ] MegaMenu
- [ ] Carousel (full-featured)
- [ ] Lightbox
- [ ] VirtualList, VirtualTable
- [ ] MasonryGrid
- [ ] KanbanBoard
- [ ] ImageGallery
- [ ] DragDrop, SortableList
- [ ] Resizable, SplitPane
- [ ] InfiniteScroll
- [ ] AspectRatio
- [ ] SkipLink

---

## API Consistency Improvements

### Naming Standardization
- [ ] Standardize all components to `Arcane*` prefix
- [ ] Use consistent callback naming: `onX` (onPressed, onChange, onSubmit)
- [ ] Standardize size props: always `size` enum, not `InputSizeStyle`
- [ ] Standardize style props: always `style` or `variant`

### Pattern Standardization
- [ ] All components support `copyWith()`
- [ ] All interactive components support `disabled`
- [ ] All form inputs support `name`, `label`, `helperText`, `errorText`
- [ ] All dismissible components support `onClose`
- [ ] All components support `styles` for ArcaneStyleData overrides

---

## Deprecation & Migration

### Planned Deprecations
- [ ] `ButtonVariant` enum → `ButtonStyle` presets
- [ ] Raw string styles → ArcaneStyleData enum properties

### Migration Guides Needed
- [ ] v2.x → v3.x responsive API migration
- [ ] Form validation migration
- [ ] Theme system updates

---

## Version Targets

### v2.6.0 - Inputs & Forms
- Textarea component
- DatePicker, TimePicker
- RadioGroup, MultiSelect
- Form validation framework (basic)

### v2.7.0 - Responsive Design
- Breakpoint enum system
- ResponsiveStyles in ArcaneStyleData
- Responsive visibility helpers
- Responsive typography

### v2.8.0 - Navigation & Dialogs
- Stepper navigation
- Drawer/Sheet component
- CommandPalette
- Enhanced Toast system

### v2.9.0 - Data Display
- VirtualList, VirtualTable
- Enhanced DataTable (resize, reorder, export)
- ImageGallery, Lightbox
- Carousel full rewrite

### v3.0.0 - Major Release
- Responsive API (breaking change if needed)
- Form system (complete)
- Style builder API
- Component composition system
- Accessibility audit complete
- New documentation site

---

## Notes

- All new components should follow `Arcane*` naming convention
- All components must include:
  - Full ARIA accessibility
  - Keyboard navigation where applicable
  - Dark/light mode support
  - Documentation with examples
  - Unit tests
- Prefer composition over inheritance
- Maintain backwards compatibility where possible
- Document all breaking changes

---

*Last Updated: 2024-12-24*
