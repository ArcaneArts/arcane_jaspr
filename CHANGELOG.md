# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.5.0]

### Added

#### Enhanced ArcaneStyleData with New CSS Abstractions

This release significantly reduces the need for `raw:` CSS by adding type-safe enums for common CSS patterns.

**Flex Shorthand (`FlexPreset`)**
- `FlexPreset.none` - No flex (0 0 auto)
- `FlexPreset.initial` - Initial flex (0 1 auto)
- `FlexPreset.auto` - Auto flex (1 1 auto)
- `FlexPreset.expand` - Expand to fill (1 1 0%)
- `FlexPreset.fixed` - Fixed size, no shrink (0 0 auto)
- `FlexPreset.growOnly` - Grow but don't shrink (1 0 auto)
- `FlexPreset.shrinkOnly` - Shrink but don't grow (0 1 auto)
- `FlexPreset.equal` - Equal distribution (1 1 0)

**Grid Template Columns (`GridColumns`)**
- `GridColumns.one` through `GridColumns.six` - Fixed column counts
- `GridColumns.autoFitSm/Md/Lg` - Auto-fit with min widths (200px/280px/320px)
- `GridColumns.autoFillSm/Md/Lg` - Auto-fill with min widths
- `GridColumns.sidebar` - Sidebar layout (280px 1fr)
- `GridColumns.mainSidebar` - Main with sidebar (1fr 300px)
- `GridColumns.holyGrail` - Classic three-column (200px 1fr 200px)

**Grid Template Rows (`GridRows`)**
- `GridRows.one` through `GridRows.three` - Fixed row counts
- `GridRows.auto` - Auto rows
- `GridRows.headerContentFooter` - App layout (auto 1fr auto)
- `GridRows.minContent` / `GridRows.maxContent`

**Grid Utilities**
- `GridAutoFlow` enum - row, column, dense, rowDense, columnDense
- `PlaceItems` enum - start, end, center, stretch, baseline
- `PlaceContent` enum - start, end, center, stretch, spaceBetween, spaceAround, spaceEvenly

**Border Width Properties**
- `borderWidth` - All sides
- `borderLeftWidth`, `borderRightWidth`, `borderTopWidth`, `borderBottomWidth` - Individual sides
- Uses existing `BorderWidth` enum (none, hairline, thin, medium, thick, heavy)

#### New Layout Component

**ArcaneScrollRail** - Sticky scrollable sidebar that maintains position independently of page scroll
- `ArcaneScrollRail` - Base component with scroll persistence
- `ArcaneScrollRailLayout` - Complete two-column layout with scroll rail
- Features:
  - Sticky positioning relative to viewport
  - Independent scrolling from main content
  - Scroll position persistence via sessionStorage
  - Customizable width, offsets, borders
  - Custom scrollbar styling

```dart
ArcaneScrollRail(
  width: '280px',
  topOffset: '64px', // Below fixed header
  scrollPersistenceId: 'sidebar',
  children: [
    // Navigation items...
  ],
)
```

### Changed

#### Improved CSS Abstraction

Before (raw CSS):
```dart
ArcaneDiv(
  styles: ArcaneStyleData(
    flexGrow: 1,
    raw: {
      'flex': '1',
      'grid-template-columns': 'repeat(3, 1fr)',
      'border-left-width': '3px',
      'min-width': '0',
    },
  ),
)
```

After (type-safe):
```dart
ArcaneDiv(
  styles: ArcaneStyleData(
    flex: FlexPreset.expand,
    gridColumns: GridColumns.three,
    borderLeftWidth: BorderWidth.thick,
    minWidth: '0',
  ),
)
```

### Fixed

#### ArcaneHovercard and ArcanePopover

- **Hover functionality**: Fixed hover events not triggering properly on `ArcaneHovercard` and `ArcanePopover` (hover mode)
  - Root cause: Events were on separate inner divs for trigger and content, causing premature close when mouse moved between them
  - Fix: Events now placed on outer wrapper so mouse movement between trigger and content doesn't trigger close
- Removed unused `@css` styles fields that were generating analyzer warnings

#### Documentation Site (Codex)

- **Font loading**: Added Google Fonts (Inter, Fira Code) via CSS imports - fonts now load correctly on GitHub Pages
- **Base href**: Fixed asset paths for GitHub Pages subdirectory hosting at `/arcane_jaspr/`
- **Theme consistency**: Fonts now consistent between local development and production deployment

### Documentation

- Updated docs_sidebar to use `borderLeftWidth: BorderWidth.thick` instead of raw CSS
- Updated layout components to use `flex: FlexPreset.expand` instead of `raw: {'flex': '1'}`
- Added ArcaneScrollRail to component exports

## [2.4.1]

### Added

#### New View Components
- `ArcaneHovercard` - Hover-triggered floating card with rich interactive content, configurable delays, and multiple positions

### Enhanced

#### ArcanePopover
- Added `openDelay` parameter for delayed opening in hover mode
- Added `closeDelay` parameter for delayed closing in hover mode
- Both components now have feature parity with timer-based delay logic

### Documentation
- Added ArcaneHovercard documentation page
- Updated ArcanePopover documentation with delay properties
- Added demos for both components

## [2.4.0]

### Added

#### New Input Components
- `ArcaneTagInput` - Tag/chip input for collecting multiple values with add/remove functionality
- `ArcaneNumberInput` - Numeric input with increment/decrement controls and prefix/suffix support
- `ArcaneFileUpload` - File upload component with drag-and-drop support, dropzone/button/inline styles, and `helperText` parameter
- `ArcaneColorInput` - Color picker with swatch display, hex input, and preset color swatches

#### New View Components
- `ArcaneCallout` - Inline notice box for tips, warnings, and contextual information (info, success, warning, error, tip, note styles)
- `ArcaneKbd` - Keyboard shortcut display with raised, flat, and outline styles, plus `combo()` factory for key combinations
- `ArcaneMeter` - Progress meter/gauge with bar, gradient, segmented, and circular styles
- `ArcaneAlert` - Inline alert for status messages with subtle, solid, outline, and accent styles
- `ArcaneTreeView` - Hierarchical tree structure with expand/collapse, selection modes, and line/clean/compact styles
- `ArcanePopover` - Floating content panel with click/hover/manual triggers and multiple positions

#### New Navigation Components
- `ArcaneBreadcrumbs` - Navigation breadcrumb trail with chevron, slash, arrow, and dot separators
- `ArcanePagination` - Page navigation controls with outline, filled, ghost, and simple styles (uses `onPageChange` callback)

#### New Layout Components
- `ArcaneDrawer` - Slide-in side panel from any screen edge (left, right, top, bottom) with multiple sizes
- `ArcaneTabBar` - Simple inline tab bar for view switching (uses `ArcaneTabBarItem`, index-based selection)

#### SVG Abstractions
- `ArcaneSvg` - SVG wrapper component with size presets (xs, sm, md, lg, xl, xxl)
- `ArcaneSvgPath` - SVG path element with fill, stroke, and line cap/join attributes
- `ArcaneSvgCircle` - SVG circle element
- `ArcaneSvgRect` - SVG rect element with corner radius support
- `ArcaneSvgLine` - SVG line element
- `ArcaneSvgPolyline` - SVG polyline element
- `ArcaneSvgPolygon` - SVG polygon element
- `ArcaneSvgGroup` - SVG group element with transform support

#### Enhanced ArcaneIcon
- Added 30+ new icon factory constructors: `plus`, `minus`, `trash`, `edit`, `download`, `upload`, `user`, `mail`, `heart`, `star`, `lock`, `bell`, `calendar`, `folder`, `file`, `image`, `code`, `terminal`, `link`, `globe`, `info`, `warning`, `error`, `success`, `refresh`, `filter`, `moreHorizontal`, `moreVertical`, `eye`, `eyeOff`, `send`, `loader`

### Documentation
- Added comprehensive documentation for all new components in codex
- Added demos for all new components
- Updated navigation sidebar with new component entries
- Fixed documentation for `ArcanePagination` to use correct `onPageChange` callback name
- Updated inline tabs documentation to reflect `ArcaneTabBar` API

## [2.2.0]

### Added

#### Renamed HTML Components (with backwards-compatible aliases)
- `ArcaneCodeBlock` - Renamed from `ArcanePre` for clarity, with `CodeBlockStyle` enum (raw, code, minimal, inline, terminal)
- `ArcaneQuote` - Renamed from `ArcaneBlockquote`
- `ArcaneBulletList` - Renamed from `ArcaneUnorderedList`
- `ArcaneNumberedList` - Renamed from `ArcaneOrderedList`
- `ArcaneSideContent` - Renamed from `ArcaneAside`

#### New Style Enums
- `PaddingPreset.badge` - Compact padding for badge/tag elements (2px 8px)
- `PaddingPreset.inlineCode` - Padding for inline code snippets (2px 6px)
- `PaddingPreset.chip` - Padding for chip/pill elements (4px 12px)
- `Background.glassTint` - Subtle glass tint effect (rgba 5%)
- `Background.glassHeader` - Glass header effect (rgba 3%)
- `Background.glassOverlay` - Glass overlay effect (rgba 8%)
- `Background.destructive` - Alias for error background
- `MaxHeight` enum - Preset max-heights (none, sm, md, lg, codeBlock, xl, modal, screen)
- `MinWidth` enum - Preset min-widths (none, touchTarget, sm, md, lg)

### Changed
- Updated codex documentation site to use enum-based styling instead of raw CSS
- Factory constructors like `ArcaneButton.ghost()` now recommended as `ArcaneButton(style: ButtonStyle.ghost)`
- All legacy HTML component names preserved as typedefs for backwards compatibility

### Documentation
- Added new enum values to spacing documentation (badge, inlineCode, chip)
- Added Glass Effects section to colors documentation
- Added MaxHeight and MinWidth sections to display documentation

## [2.1.0]

### Added

#### Authentication System
- `ArcaneAuthProvider` - Context provider for Firebase authentication
- `AuthGuard` - Route protection for authenticated users
- `GuestGuard` - Route protection for unauthenticated users (login/signup pages)
- `JasprAuthService` - Firebase Auth service via JS interop

#### Auth UI Components
- `ArcaneLoginCard` - Complete login form with email/password and social options
- `ArcaneSignupCard` - Registration form with terms acceptance and password policy
- `ArcaneForgotPasswordCard` - Password reset request form

#### Social Sign-in Buttons
- `GithubSignInButton` - GitHub OAuth button
- `GoogleSignInButton` - Google OAuth button
- `AppleSignInButton` - Apple Sign-In button

#### Auth Layouts
- `AuthSplitLayout` - Two-column layout for auth pages (branding + form)
- `AuthBrandingPanel` - Branding content panel with tagline, features, testimonials

#### Auth Form Primitives
- `AuthInput` - Styled input for auth forms
- `AuthButton` - Submit button for auth forms
- `AuthDivider` - "or continue with" divider
- `AuthSocialRow` - Row of social sign-in buttons
- `AuthFormCard` - Card container for auth forms

#### Auth Utilities
- `PasswordPolicy` - Password validation with presets (weak, medium, strong)
- `AuthState` - Authentication state container
- `AuthUser` - Authenticated user model
- `AuthMethod` - Enum for auth methods (email, github, google, apple, anonymous)
- `AuthStatus` - Enum for auth status (unknown, loading, authenticated, unauthenticated, error)

#### Context Extensions
- `context.authState` - Access current auth state
- `context.currentUser` - Access current user
- `context.isAuthenticated` - Check authentication status
- `context.signInWithGitHub()` - Trigger GitHub OAuth
- `context.signInWithGoogle()` - Trigger Google OAuth
- `context.signInWithApple()` - Trigger Apple Sign-In
- `context.signOut()` - Sign out current user

### Changed
- Added `web: ^1.1.1` dependency for Firebase JS interop
- Added `http: ^1.6.0` dependency for auth API calls
- Updated documentation with authentication section
- Added auth demos to codex documentation site

### Documentation
- Rewrote root README with comprehensive component and auth documentation
- Created codex root README
- Expanded codex web README with detailed project structure
- Added authentication section to docs sidebar
- Added auth component demos

### Tests
- Added `auth_test.dart` with 45+ tests covering:
  - PasswordPolicy (weak, medium, strong presets and custom)
  - AuthMethod enum
  - AuthStatus enum
  - AuthUser class
  - AuthState class

## [2.0.0]

### Breaking Changes

All components now use the `Arcane*` prefix consistently. This is a breaking change that removes backwards compatibility.

**Migration Guide:**

Components have been renamed from their short names to the full `Arcane*` prefix. Examples:
- `Button` → `ArcaneButton`
- `Card` → `ArcaneCard`
- `Div` → `ArcaneDiv`
- `Heading` → `ArcaneHeading`
- `Section` → `ArcaneSection`
- `Box` → `ArcaneBox`
- `Row` → `ArcaneRow`
- `Column` → `ArcaneColumn`
- `Checkbox` → `ArcaneCheckbox`
- `Slider` → `ArcaneSlider`
- `Search` → `ArcaneSearch`
- `Toast` → `ArcaneToast`
- `Bar` → `ArcaneBar`
- `Glass` → `ArcaneGlass`
- `Screen` → `ArcaneScreen`
- ... and all other components

### Added

- `aliases.dart` - Shorthand `A*` typedefs for all components (e.g., `AButton = ArcaneButton`)
  - Import with `import 'package:arcane_jaspr/aliases.dart';`
  - Provides shorter names while keeping `Arcane*` as the primary API

### Changed

- Renamed all components to use consistent `Arcane*` prefix
- HTML element wrappers now use `Arcane*` prefix:
  - `Div` → `ArcaneDiv`
  - `Nav` → `ArcaneNav`
  - `Aside` → `ArcaneAside`
  - `Heading` → `ArcaneHeading`
  - `Paragraph` → `ArcaneParagraph`
  - `Main` → `ArcaneMain`
  - `HtmlSection` → `ArcaneHtmlSection`
  - `HtmlFooter` → `ArcaneHtmlFooter`
  - `Blockquote` → `ArcaneBlockquote`
  - `Pre` → `ArcanePre`
- Layout components renamed:
  - `Box` → `ArcaneBox`
  - `Row` → `ArcaneRow`
  - `Column` → `ArcaneColumn`
  - `Section` → `ArcaneSection`
  - `Gutter` → `ArcaneGutter`
  - `Flow` → `ArcaneFlow`
  - `ButtonPanel` → `ArcaneButtonPanel`
  - `CenterBody` → `ArcaneCenterBody`
- Input components renamed:
  - `Checkbox` → `ArcaneCheckbox`
  - `Radio` → `ArcaneRadio`
  - `Slider` → `ArcaneSlider`
  - `RangeSlider` → `ArcaneRangeSlider`
  - `ToggleSwitch` → `ArcaneToggleSwitch`
  - `Search` → `ArcaneSearch`
  - `Selector` → `ArcaneSelector`
  - `CycleButton` → `ArcaneCycleButton`
  - `FAB` → `ArcaneFAB`
  - `ThemeToggle` → `ArcaneThemeToggle`
- View components renamed:
  - `Bar` → `ArcaneBar`
  - `Glass` → `ArcaneGlass`
  - `Expander` → `ArcaneExpander`
  - `Accordion` → `ArcaneAccordion`
  - `Tooltip` → `ArcaneTooltip`
  - `Toast` → `ArcaneToast`
  - `StaticTable` → `ArcaneStaticTable`
  - `Timeline` → `ArcaneTimeline`
  - `Stepper` → `ArcaneStepper`
- Navigation components renamed:
  - `Sidebar` → `ArcaneSidebar`
  - `SidebarItem` → `ArcaneSidebarItem`
  - `BottomNavigationBar` → `ArcaneBottomNavigationBar`
  - `BottomNavItem` → `ArcaneBottomNavItem`
- Screen components renamed:
  - `Screen` → `ArcaneScreen`
  - `FillScreen` → `ArcaneFillScreen`
- Dialog/Feedback components renamed:
  - `ConfirmDialog` → `ArcaneConfirmDialog`
  - `AlertDialog` → `ArcaneAlertDialog`
- Collection components renamed:
  - `Collection` → `ArcaneCollection`
  - `ListView` → `ArcaneListView`
  - `GridView` → `ArcaneGridView`
  - `MasonryGrid` → `ArcaneMasonryGrid`
  - `CardCarousel` → `ArcaneCardCarousel`

## [1.0.0]

### Added

#### Core
- `ArcaneApp` - Main application wrapper with theme support
- `ArcaneTheme` - Theming system with Supabase-style dark-first design
- `ContrastedColorScheme` - Comprehensive color scheme with accent themes (violet, green, orange)

#### Input Components
- `ArcaneButton` - Primary button with multiple variants and sizes
- `ArcaneIconButton` - Icon-only button with hover states
- `Checkbox` - Styled checkbox input
- `CycleButton` - Button that cycles through options
- `FAB` - Floating action button
- `Search` - Search input with icon
- `Selector` - Dropdown selector component
- `Slider` - Range slider input
- `TextInput` - Text input field with validation support
- `ThemeToggle` - Dark/light mode toggle
- `ToggleSwitch` - On/off toggle switch

#### View Components
- `AnimatedCounter` - Animated number counter
- `Avatar` - User avatar with fallback initials
- `Badge` - Status badges with variants
- `Bar` - Horizontal bar component
- `ArcaneCard` - Card container with hover effects
- `CardSection` - Section within a card
- `CenterBody` - Centered content wrapper
- `Chip` - Tag/chip component
- `CodeSnippet` - Syntax-highlighted code block
- `DataTable` - Interactive data table
- `Divider` - Horizontal/vertical divider
- `Expander` - Expandable/collapsible content
- `FeatureCard` - Feature showcase card
- `GameTile` - Game server tile with status indicators
- `Glass` - Glassmorphism container
- `GradientText` - Text with gradient color
- `IntegrationCard` - Integration showcase card
- `PricingCard` - Pricing tier card
- `ProgressBar` - Progress indicator bar
- `RatingStars` - Star rating display
- `Skeleton` - Loading skeleton placeholder
- `SocialIcons` - Social media icon links
- `StatCard` - Statistics display card
- `StaticTable` - Simple static table
- `StatusIndicator` - Online/offline status dot
- `Stepper` - Multi-step progress indicator
- `TestimonialCard` - Customer testimonial card
- `Tile` - Clickable tile component
- `Timeline` - Vertical timeline display

#### Layout Components
- `ButtonPanel` - Row/column of buttons
- `Carpet` - Full-width background section
- `CTABanner` - Call-to-action banner
- `Flow` - Flexbox flow layout
- `Footer` - Page footer with links
- `Gutter` - Spacing/margin utility
- `HeroSection` - Hero banner section
- `LogoCarousel` - Scrolling logo carousel
- `RadioCards` - Radio button card selector
- `Section` - Page section wrapper
- `ArcaneTabs` - Tabbed content container

#### Navigation Components
- `BottomNavigationBar` - Mobile bottom nav
- `DropdownMenu` - Dropdown menu with items
- `Header` - Page header/navbar
- `MobileMenu` - Responsive mobile menu
- `Sidebar` - Side navigation panel

#### Screen Components
- `Screen` - Base screen wrapper
- `FillScreen` - Full-height screen
- `NavigationScreen` - Screen with navigation

#### Dialog Components
- `ArcaneDialog` - Modal dialog
- `ConfirmDialog` - Confirmation dialog
- `TextInputDialog` - Text input modal
- `Toast` - Toast notification

#### Feedback Components
- `AlertBanner` - Alert/notification banner
- `Loader` - Loading spinner
- `Tooltip` - Hover tooltip

#### Form Components
- `Field` - Form field with label
- `FieldWrapper` - Field container with validation
- `FormProvider` - Form state management
- `NewsletterForm` - Email signup form

#### Interactive Components
- `Accordion` - Collapsible accordion panels
- `BackToTop` - Scroll to top button

#### Typography
- `Headline` - Styled heading component

#### Collection Components
- `CardCarousel` - Horizontally scrolling cards
- `Collection` - Grid/list collection view

#### Design Tokens
- `ArcaneTokens` - Spacing, radius, shadows, transitions
- `CommonStyles` - Reusable style maps
- `StylePresets` - Pre-built component styles
- Button, Card, Badge, Chip, Input, FAB, IconButton, Alert, Progress, Control styles

#### Utilities
- `ArcaneStyles` - Style helper utilities
- Color utilities and extensions
