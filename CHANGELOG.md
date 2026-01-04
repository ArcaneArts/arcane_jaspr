# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [x.x.x]

### Added

#### Convenience Features for Improved Developer Experience

**ArcaneStyleData Presets**
New static presets for common style patterns:
- Layout aliases: `centered`, `gridCenter`
- Spacing presets: `padded`, `paddedSm/Lg/Xs/Xl`, `spaced`, `spacedSm/Lg/Xs/Xl`
- Size shortcuts: `fullWidth`, `fullHeight`
- Overflow: `scrollable`, `scrollableY`, `scrollableX`, `clipContent`
- Flex item: `grow`, `noGrow`
- Combined layouts: `columnSpaced`, `columnTight`, `columnLoose`, `rowTight`, `rowGapped`, `rowLoose`
- Text: `truncate`, `textCenter`, `textRight`, `textLeft`
- Positioning: `stack`, `stackChild`, `fixed`, `sticky`
- Interactive: `clickable`, `nonInteractive`, `unselectable`

**ArcaneHeading `text:` Parameter**
Convenience string parameter for headings:
```dart
// Before
ArcaneHeading.h1(child: Text('Title'))

// After (both work)
ArcaneHeading.h1(text: 'Title')
ArcaneHeading.h1(child: Text('Title'))
```

**ArcaneDialog/ArcaneSheet `children:` Parameter**
Multi-child convenience for dialogs:
```dart
// Before
ArcaneDialog(
  child: ArcaneColumn(children: [item1, item2, item3]),
)

// After (both work)
ArcaneDialog(children: [item1, item2, item3])
ArcaneDialog(child: singleChild)
```

**ArcaneCard `children:` and `onClick` Parameters**
- Added `children:` parameter for multiple children without wrapping in Column
- Added `onClick` as alias for `onTap` for consistency with web conventions

**Parameter Aliases for Input Components**
- `ArcaneTextInput`: Added `onInput` alias for `onChange`
- `ArcaneTextArea`: Added `onInput` alias for `onChange`
- `ArcaneSelect`: Added `onInput` and `onSelect` aliases for `onChange`
- `ArcaneCheckbox`: Added `onToggle` alias for `onChanged`
- `ArcaneRadio`: Added `onTap` alias for `onSelected`
- `ArcaneToggleSwitch`: Added `onToggle` alias for `onChanged`

**Complete Lucide Icons Integration with ArcaneIcon Wrapper**
Full programmatic wrapping of all 1,666 Lucide icons with clean API:
- Added `jaspr_lucide` (^0.21.0) dependency for complete icon library
- **`ArcaneIcon`** wrapper class provides semantic, discoverable icon methods for ALL icons
- **`IconSize`** enum for consistent sizing: `xs` (12px), `sm` (16px), `md` (20px), `lg` (24px), `xl` (32px), `xl2` (48px)
- **`AIcon`** and **`AIconSize`** aliases in `aliases.dart`
- Generator tool at `tool/generate_icons.dart` for regeneration when jaspr_lucide updates

Usage:
```dart
ArcaneIcon.home()                    // Semantic alias for house()
ArcaneIcon.search(size: IconSize.lg) // Large size (24px)
ArcaneIcon.settings()                // Settings gear
ArcaneIcon.user()                    // User profile
ArcaneIcon.edit()                    // Semantic alias for pencil()
ArcaneIcon.close()                   // Semantic alias for x()
ArcaneIcon.delete()                  // Semantic alias for trash2()
// ... all 1,666 Lucide icons available!
```

Semantic aliases for intuitive naming:
```dart
ArcaneIcon.home()         // -> house()
ArcaneIcon.edit()         // -> pencil()
ArcaneIcon.close()        // -> x()
ArcaneIcon.delete()       // -> trash2()
ArcaneIcon.success()      // -> circleCheck()
ArcaneIcon.error()        // -> circleX()
ArcaneIcon.warning()      // -> triangleAlert()
ArcaneIcon.loading()      // -> loaderCircle()
ArcaneIcon.grid()         // -> grid3x3()
ArcaneIcon.moreHorizontal() // -> ellipsis()
// ... 70+ semantic aliases
```

Icons with Dart naming conflicts use suffix:
```dart
ArcaneIcon.keyIcon()      // Key shape (key is reserved)
ArcaneIcon.mapIcon()      // Map (map is reserved)
ArcaneIcon.factoryIcon()  // Factory building
ArcaneIcon.targetIcon()   // Crosshair target
ArcaneIcon.contrastIcon() // Contrast circle
```

### Changed

**Component File Refactoring**
Split large component files for better maintainability:
- `toast.dart` (872→590 lines): Extracted `toast_types.dart` and `toast_manager.dart`
- `selector.dart`: Extracted `selector_types.dart` (enums, option classes)
- `slider.dart`: Extracted `slider_types.dart` (SliderSize enum)
- `sheet.dart`: Extracted `sheet_types.dart` (SheetPosition, SheetSize enums)
- `mutable_text.dart`: Extracted `mutable_text_types.dart` (trigger/input/style enums)

All types are re-exported from their parent files, so imports remain unchanged.

### Documentation
- Updated ArcaneCard documentation with `children:` and `onClick` parameters
- Updated ArcaneTextInput, ArcaneCheckbox, ArcaneToggleSwitch documentation with alias info
- Updated icon documentation for jaspr_lucide usage

## [2.7.0]

### Added

#### New Input Components

**ArcaneTimePicker** - Time selection component with hour/minute columns
- 12-hour and 24-hour format support
- Configurable minute intervals (1, 5, 15, 30)
- AM/PM period selection for 12-hour format
- Size variants: `sm`, `md`, `lg`
- `TimeOfDay` class for value representation

```dart
ArcaneTimePicker(
  value: TimeOfDay(hour: 14, minute: 30),
  use24HourFormat: false,
  minuteInterval: 15,
  onChanged: (time) => print('${time.hour}:${time.minute}'),
)
```

**ArcaneFormattedInput** - Patterned input for structured data
- Pre-built patterns: `.date()`, `.time()`, `.phone()`, `.creditCard()`
- Auto-advance between segments when filled
- Backspace navigation between segments
- Arrow key navigation support

```dart
ArcaneFormattedInput.date(
  initialMonth: '01',
  initialDay: '15',
  initialYear: '2024',
  onChanged: (value) => print(value.combinedValue),
)
```

#### New Layout Components

**ArcaneSheet** - Modal sheet sliding from screen edges
- Positions: `bottom`, `top`, `end`, `start`
- Configurable width/height and max constraints
- Backdrop dismiss option
- Close button with title support

**ArcaneActionSheet** - Mobile-style action sheet
- Destructive item styling
- Cancel button at bottom
- Full-width on mobile

```dart
ArcaneSheet(
  position: SheetPosition.bottom,
  title: 'Options',
  child: content,
  onClose: () => closeSheet(),
)
```

#### New View Components

**ArcaneSwitcher** - Animated content transition
- Transition directions: `up`, `down`, `left`, `right`, `fade`
- `ArcaneKeyedSwitcher<T>` for key-based switching
- `ArcaneIndexedStack` for state-preserving indexed children

```dart
ArcaneSwitcher(
  direction: SwitcherDirection.up,
  child: currentView,
)
```

**ArcaneSurfaceCard** - Card with visual effects
- Effects: `none`, `blur`, `frosted`, `gradient`, `glass`, `ice`
- Customizable blur intensity, opacity, and blend color
- `ArcaneThumbHashCard` for placeholder backgrounds

```dart
ArcaneSurfaceCard(
  effect: SurfaceEffect.frosted,
  blurIntensity: 12,
  child: content,
)
```

**ArcaneTracker** - GitHub-style contribution/status grid
- Grid-based tracker with severity levels (fine, warning, critical, unknown)
- Configurable columns, cell size, and gap
- Optional legend display
- Cell click callbacks

**ArcaneUptimeTracker** - Uptime percentage bar chart
- Percentage bars with color coding
- Average uptime calculation
- Hover tooltips with date/percentage

```dart
ArcaneTracker.weekly(
  data: List.generate(90, (i) => TrackerData(
    level: TrackerLevel.fine,
    tooltip: 'Day ${i + 1}: 100% uptime',
  )),
)
```

**ArcaneAvatarBadge** - Status indicator badge for avatars
- Status types: `online`, `offline`, `busy`, `away`, `count`
- Positions: `topLeft`, `topRight`, `bottomLeft`, `bottomRight`
- Pulse animation option

```dart
ArcaneAvatarBadge(
  status: AvatarBadgeStatus.online,
  position: AvatarBadgePosition.bottomRight,
  pulse: true,
  child: ArcaneAvatar(...),
)
```

#### New Navigation Components

**ArcaneDotIndicator** - Carousel/page indicator dots
- Interactive mode with click callbacks
- Customizable dot size, active/inactive colors
- Gap spacing control

**ArcaneStepIndicator** - Step-based progress indicator
- Vertical and horizontal orientations
- Step labels and descriptions
- Clickable navigation for completed steps
- Size variants

```dart
ArcaneDotIndicator(
  count: 5,
  currentIndex: 2,
  interactive: true,
  onDotTap: (index) => goToPage(index),
)
```

#### New Dialog Components

**ArcaneEmailDialog** - Email input dialog with validation
- Work email requirement option
- Blocked domains configuration
- Real-time validation feedback

**ArcaneTimeDialog** - Time picker dialog
- Column-based hour/minute selection
- 12/24 hour format support
- Visual time display

**ArcaneItemPicker** - General-purpose item picker dialog
- Single and multi-select modes
- Search/filter support
- Immediate or confirm-based selection

```dart
ArcaneItemPicker<String>(
  title: 'Select Country',
  items: ['USA', 'Canada', 'UK'],
  itemBuilder: (item) => text(item),
  onSelect: (country) => handleSelection(country),
)
```

#### New Screen Components

**ArcaneChatScreen** - Full chat interface
- Chat styles: `bubbles` (WhatsApp) and `tiles` (Slack)
- Message input with auto-resize textarea
- Timestamp and avatar display
- Abstract interfaces for custom message/user types

```dart
ArcaneChatScreen(
  style: ChatStyle.bubbles,
  provider: myChatProvider,
  currentUserId: 'user123',
)
```

#### JavaScript Fallback Scripts

New JavaScript fallback scripts for static site support:
- `TimePickerScripts` - Time picker column selection
- `FormattedInputScripts` - Auto-advance and navigation between segments
- `SheetScripts` - Sheet open/close and backdrop dismiss
- `DotIndicatorScripts` - Dot and step indicator interactions
- `TrackerScripts` - Tracker cell hover and click
- `ChatScripts` - Chat input resize, send, and scroll
- `EmailDialogScripts` - Email validation and submission
- `TimeDialogScripts` - Time selection in dialogs
- `ItemPickerScripts` - Search filtering and item selection

#### Theme Enhancement: `uniformBackgrounds`

New theme option for sleek, uniform dark designs without section contrast:

- `uniformBackgrounds` boolean field on `ArcaneTheme` (default: `false`)
- When enabled, `--arcane-background-secondary` and `--arcane-background-tertiary` equal the base background
- Perfect for OLED/pure-black design aesthetics

```dart
ArcaneApp(
  theme: ArcaneTheme.oledGreen.copyWith(
    themeMode: ThemeMode.dark,
    uniformBackgrounds: true, // Uniform backgrounds
  ),
  child: ...
)
```

#### New Token: `ArcaneColors.accentGradient`

Standard gradient token for accent-colored gradients:

```dart
ArcaneColors.accentGradient
// Returns: 'linear-gradient(135deg, var(--arcane-accent) 0%, var(--arcane-secondary) 100%)'
```

#### ArcaneCtaLink Component

Call-to-action link buttons with multiple variants for different visual hierarchies:

- `ArcaneCtaLink.primary()` - Solid accent background
- `ArcaneCtaLink.secondary()` - Outline/border style
- `ArcaneCtaLink.ghost()` - Text-only style
- `ArcaneCtaLink.accent()` - Gradient background
- Sizes: `CtaLinkSize.sm`, `md`, `lg`
- `showArrow` parameter for arrow indicator

```dart
ArcaneCtaLink.primary(
  label: 'Get Started',
  href: '/signup',
  showArrow: true,
  size: CtaLinkSize.lg,
)
```

#### ArcaneSectionHeader Component

Reusable section headers with label, heading, and description:

- Uppercase accent label
- Large heading text
- Muted description
- Alignment options: `left`, `center`, `right`

```dart
ArcaneSectionHeader(
  label: 'Features',
  heading: 'Why Choose Us',
  description: 'Discover what makes us different.',
  align: SectionHeaderAlign.center,
)
```

#### ArcaneStatusBadge Component

Status indicator badges with pulse animation for system status displays:

- `ArcaneStatusBadge.success()` - Green, operational
- `ArcaneStatusBadge.warning()` - Yellow, degraded
- `ArcaneStatusBadge.error()` - Red, down
- `ArcaneStatusBadge.info()` - Blue, informational
- `ArcaneStatusBadge.offline()` - Gray, offline
- Configurable glow and pulse effects
- Size variants: `sm`, `md`, `lg`

```dart
ArcaneStatusBadge.success('All Systems Operational')
```

#### ArcaneFadeEdge Component

Gradient fade overlays for carousels and scrolling content edges:

- Directions: `.left()`, `.right()`, `.top()`, `.bottom()`
- Customizable color, width/height, and z-index
- Perfect for marquee/carousel edges

```dart
Stack([
  ScrollContent(...),
  ArcaneFadeEdge.left(color: '#09090b'),
  ArcaneFadeEdge.right(color: '#09090b'),
])
```

#### ArcaneMarquee Component

Infinite scrolling marquee/carousel with optional fade edges:

- Automatic content duplication for seamless looping
- Configurable speed via `duration`
- Optional fade edges
- Pause on hover support
- `ArcaneMarqueeReverse` for opposite direction

```dart
ArcaneMarquee(
  children: [
    for (final item in items) ItemCard(item),
  ],
  duration: '30s',
  showFadeEdges: true,
  pauseOnHover: true,
)
```

#### ArcaneFooterColumn Components

Footer columns with title and link lists, plus brand column variant:

- `ArcaneFooterColumn` - Column with title and `FooterLink` items
- `ArcaneFooterBrandColumn` - Brand section with logo, description, and optional bottom content

```dart
ArcaneFooterColumn(
  title: 'Resources',
  links: [
    FooterLink(label: 'Documentation', href: '/docs'),
    FooterLink(label: 'API Reference', href: '/api'),
  ],
)

ArcaneFooterBrandColumn(
  logo: MyLogo(),
  description: 'Premium game server hosting.',
  bottomContent: ArcaneStatusBadge.success('All Systems Operational'),
)
```

#### ArcaneStatDisplay Component

Metric/stat display with large value and label for trust indicators:

- `ArcaneStatDisplay.accent()` - Accent-colored value
- `ArcaneStatDisplay.brand()` - Brand-colored value
- `ArcaneStatRow` - Container for multiple stats
- Layouts: `vertical` (default), `horizontal`

```dart
ArcaneStatRow(
  stats: [
    ArcaneStatDisplay(value: '99.9%', label: 'Uptime SLA'),
    ArcaneStatDisplay(value: '10K+', label: 'Active Servers'),
    ArcaneStatDisplay(value: '<60s', label: 'Deploy Time'),
  ],
)
```

#### ArcaneAuthorCard Component

Author attribution card with avatar, name, and role:

- Size variants: `sm`, `md`, `lg`
- Supports avatar URL or initials fallback
- Customizable colors

```dart
ArcaneAuthorCard(
  avatarUrl: 'https://example.com/avatar.jpg',
  name: 'John Doe',
  role: 'Software Engineer',
  size: AuthorCardSize.md,
)
```

#### ArcaneCodeWindow Component

Code display with macOS-style window chrome (traffic light buttons):

- `ArcaneCodeWindow` - Full window with header and code
- `ArcaneCodeWindow.terminal()` - Terminal style with green text
- Styles: `dark`, `light`, `terminal`

```dart
ArcaneCodeWindow(
  title: 'main.dart',
  code: '''
void main() {
  print('Hello, World!');
}
''',
)
```

#### ArcaneCheckList Components

Lists with checkmark icons for features, benefits, and requirements:

- `ArcaneCheckItem` - Single item with icon and text
- `ArcaneCheckList` - List of check items
- `ArcaneCheckList.brand()` - Brand/accent colored icons
- `ArcaneCheckList.success()` - Success/green colored icons
- `ArcaneFeatureRow` - Feature row with included/excluded state
- Icon styles: `check`, `bullet`, `arrow`, `plus`, `star`

```dart
ArcaneCheckList.brand(
  items: [
    'Shared models across web and server',
    'Type-safe API calls',
    'Hot reload in development',
  ],
)

ArcaneFeatureRow(
  feature: 'Unlimited API calls',
  included: true,
)
```

#### ArcaneTimeline Redesign

Complete redesign of the timeline component with multiple layout options:

- **Layout options**: `vertical` (default), `horizontal`, and `alternating` layouts
- **Size variants**: `sm`, `md`, `lg` sizes
- **Status types**: `complete`, `current`, `pending`, `error`, and `default_`
- **Named constructors**: `ArcaneTimeline.vertical()`, `ArcaneTimeline.horizontal()`, `ArcaneTimeline.alternating()`
- **Custom icons**: Support for custom icons in timeline items
- **Rich content**: Support for custom content in timeline items via `content` property
- **Date display**: Built-in date/time display with `date` property
- **Alias**: Added `ATimeline` alias

```dart
ArcaneTimeline.alternating(
  items: [
    ArcaneTimelineItem(
      title: 'Project Started',
      date: 'Jan 1, 2024',
      status: TimelineStatus.complete,
    ),
    ArcaneTimelineItem(
      title: 'In Progress',
      status: TimelineStatus.current,
    ),
  ],
)
```

#### ArcaneSteps Component

New numbered steps component for multi-step processes (replaces ArcaneStepper):

- **Layout options**: `horizontal` (default) and `vertical` layouts
- **Size variants**: `sm`, `md`, `lg` sizes
- **Auto-status**: Use `currentStep` to automatically set step statuses
- **Clickable navigation**: Click completed steps to navigate back
- **Named constructors**: `ArcaneSteps.horizontal()`, `ArcaneSteps.vertical()`
- **Alias**: Added `ASteps` alias

```dart
ArcaneSteps(
  currentStep: 1,
  onStepTap: (index) => setState(() => _step = index),
  items: [
    ArcaneStepItem(title: 'Account', description: 'Create account'),
    ArcaneStepItem(title: 'Profile', description: 'Set up profile'),
    ArcaneStepItem(title: 'Complete', description: 'Start using app'),
  ],
)
```

### Changed

- **ArcaneStepper** deprecated in favor of `ArcaneSteps`
- **ArcaneVerticalStepper** deprecated in favor of `ArcaneSteps.vertical()`

#### Automatic Fallback Scripts for Static Sites

`ArcaneApp` now automatically injects JavaScript fallback scripts when Jaspr client hydration is unavailable (e.g., on static sites built with `jaspr build`).

- **Zero configuration**: Just use `ArcaneApp` and interactivity works on static sites
- **Hydration-aware**: Scripts detect if Jaspr hydration is active and skip themselves
- **Comprehensive coverage**: All interactive components (sliders, checkboxes, toggles, inputs, accordions, tabs, etc.)
- **Opt-out available**: Set `includeFallbackScripts: false` if not needed

```dart
// Works automatically on static sites
ArcaneApp(
  theme: ArcaneTheme.green,
  child: MyContent(),
)

// Opt out if using full Jaspr hydration
ArcaneApp(
  includeFallbackScripts: false,
  child: MyContent(),
)
```

New exports:
- `ArcaneScripts` - Contains all fallback JavaScript
- `ArcaneScriptsComponent` - Component to manually inject scripts

**Modular Script Organization**

Scripts are now organized into separate files for maintainability:
- `SliderScripts` - Range sliders
- `InputScripts` - Checkboxes, toggles, color pickers, file uploads, tag inputs, number inputs
- `ButtonScripts` - Buttons, toggle buttons, cycle buttons, theme toggles
- `NavigationScripts` - Tabs, accordions, dropdowns, selectors, tree views, pagination, chips
- `DialogScripts` - Dialogs, toasts, popovers, tooltips, drawers, mobile menus

**Complete Component Coverage**

JavaScript handlers added for all interactive components:
- Sliders and range sliders
- Color inputs with preset swatches
- Checkboxes and radio buttons
- Toggle switches and toggle buttons
- Cycle buttons (rotating options)
- Number inputs (+/- buttons)
- Tag inputs (add/remove tags)
- File uploads (dropzone and button styles)
- Theme toggles (fancy and simple)
- Tabs and accordions
- Dropdown selectors
- Tree views with expand/collapse
- Pagination controls
- Dismissible chips
- Back-to-top buttons
- Dialogs and modals
- Toasts and notifications
- Popovers and hovercards
- Tooltips
- Drawers and mobile menus

**Codex Documentation Site**
- Fixed interactive component demos on static site
- Custom layouts like `ArcaneDocsLayout` now properly inject `ArcaneScriptsComponent` for fallback interactivity

#### Redesigned ArcaneSlider

Modern shadcn-inspired slider with cleaner aesthetics:
- Thinner, more elegant track (4-8px based on size)
- Refined thumb with border accent instead of heavy shadow
- Size variants: `SliderSize.sm`, `SliderSize.md`, `SliderSize.lg`
- Optional step markers (`showSteps: true`)
- Disabled state support
- Decimal place control for value display (`valueDecimals`)
- Better hit area for easier interaction

```dart
ArcaneSlider(
  value: 50,
  size: SliderSize.md,
  step: 10,
  showSteps: true,
  onChanged: (v) => setState(() => value = v),
)
```

#### Enhanced ArcaneSearch

- `showIcon` parameter to optionally hide the search icon
- Uses `ArcaneIcon.search` (SVG) instead of emoji

#### Enhanced ArcaneSelector

Comprehensive upgrade with many new customization options:

**Size Variants**
- `SelectorSize.sm`, `SelectorSize.md`, `SelectorSize.lg` for different contexts

**Multi-Select Support**
- `multiSelect: true` to allow multiple selections
- `values` and `onMultiChanged` for multi-select state management
- `maxSelections` to limit number of selections
- `showCheckboxes` to display checkboxes in options
- `showSelectedCount` to display count badge when multiple selected
- `closeOnSelect` to control dropdown behavior after selection

**Loading State**
- `loading: true` shows spinner and loading text
- `loadingText` to customize loading message

**Form Integration**
- `required` to show required indicator asterisk
- `helperText` for additional guidance below selector
- `error` for validation error messages

**Dropdown Customization**
- `maxDropdownHeight` to control dropdown size
- `dropdownDirection` (up/down) for positioning
- `prefix` to add icon/component before value
- `searchPlaceholder` to customize search input text
- `emptyMessage` for custom "no results" text

**Enhanced Options**
- `ArcaneSelectorOption.subtitle` for secondary text
- `ArcaneSelectorOption.description` for right-side text
- `ArcaneSelectorOption.searchKeywords` for additional search terms
- `ArcaneSelectorOption.group` for option grouping
- `filterFn` for custom search filtering logic

```dart
// Multi-select with all features
ArcaneSelector<String>(
  label: 'Skills',
  required: true,
  multiSelect: true,
  searchable: true,
  values: selectedSkills,
  maxSelections: 5,
  helperText: 'Select up to 5 skills',
  options: skills.map((s) => ArcaneSelectorOption(
    value: s.id,
    label: s.name,
    subtitle: s.category,
  )).toList(),
  onMultiChanged: (v) => setState(() => selectedSkills = v),
)
```

#### Enhanced ArcaneCycleButton

- Options now embedded as data attributes for static site support
- Properly cycles through all options on click
- Added `.arcane-cycle-button-label` and `.arcane-cycle-button-indicator` classes for reliable JS targeting

#### Completely Rewritten Components for Static Site Support

The following components have been completely rewritten with proper class-based selectors and data attributes for reliable JavaScript interactivity on static sites:

**ArcaneColorInput** (Rewritten)
- Simplified, focused design with clear class structure
- Classes: `.arcane-color-input`, `.arcane-color-input-swatch`, `.arcane-color-input-native`, `.arcane-color-input-hex`, `.arcane-color-input-preset`
- Data attributes: `data-value`, `data-disabled`, `data-color` (on presets)
- Size variants via `ColorInputSize` enum (sm, md, lg)
- `showHexInput` parameter to optionally hide hex text input
- Proper synchronization between native picker, hex input, and preset swatches

```dart
ArcaneColorInput(
  value: '#10b981',
  size: ColorInputSize.md,
  label: 'Primary Color',
  onChanged: (color) => print(color),
)
```

**ArcaneThemeToggle** (Rewritten)
- Now uses `<button>` element for proper accessibility
- Classes: `.arcane-theme-toggle`, `.arcane-theme-toggle-thumb`, `.arcane-theme-toggle-sun`, `.arcane-theme-toggle-moon`
- Data attribute: `data-theme` ("dark" or "light")
- Size variants via `ThemeToggleSize` enum (sm, md, lg)
- Proper ARIA attributes (`role="switch"`, `aria-checked`, `aria-label`)
- Clean toggle animation with smooth transitions

```dart
ArcaneThemeToggle(
  isDark: true,
  size: ThemeToggleSize.md,
  onChanged: (isDark) => print(isDark),
)
```

**ArcaneThemeToggleSimple** (Rewritten)
- Inline toggle with sun/moon labels
- Classes: `.arcane-theme-toggle-simple`, `.arcane-theme-toggle-simple-track`, `.arcane-theme-toggle-simple-thumb`
- Same accessibility improvements as main toggle

**ArcaneNumberInput** (Rewritten)
- Clean stepper design with +/- buttons
- Classes: `.arcane-number-input`, `.arcane-number-input-decrement`, `.arcane-number-input-increment`, `.arcane-number-input-display`, `.arcane-number-input-value`
- Data attributes: `data-value`, `data-min`, `data-max`, `data-step`, `data-decimals`
- Size variants via `NumberInputSize` enum (sm, md, lg)
- `decimals` parameter for decimal place display
- Proper button state management (disabled when at min/max)

```dart
ArcaneNumberInput(
  value: 5,
  min: 0,
  max: 100,
  step: 1,
  size: NumberInputSize.md,
  prefix: '\$',
  onChanged: (value) => print(value),
)
```

#### Slider Start/End Indicators

Both `ArcaneSlider` and `ArcaneRangeSlider` now have visual indicators at the track boundaries:
- Start indicator (0%): Accent-colored vertical bar, more prominent
- End indicator (100%): Muted/accent-colored vertical bar
- 3px wide bars extending slightly beyond track height for visibility
- Makes slider boundaries immediately obvious to users

#### ArcaneTextArea Resize Enhancement

- Demo page now uses `resize: TextAreaResize.both` for bidirectional resizing
- Added `minWidth` and `minHeight` constraints in demo

#### JavaScript Handler Improvements

Completely rewritten JavaScript handlers in `input_scripts.dart` and `button_scripts.dart`:

**Color Input Handler**
- Targets `.arcane-color-input` container
- Synchronizes native picker, hex input, and preset swatches
- Updates `data-value` attribute for state tracking
- Proper preset border highlighting

**Number Input Handler**
- Targets `.arcane-number-input` container
- Reads min/max/step/decimals from data attributes
- Updates display and button states on value change
- Proper clamping to min/max bounds

**Theme Toggle Handler**
- Targets `.arcane-theme-toggle` and `.arcane-theme-toggle-simple`
- Updates `data-theme` attribute
- Animates thumb position and icon opacity
- Updates background colors based on theme

**Cycle Button Handler**
- Targets `.arcane-cycle-button`
- Reads options from `data-options` (pipe-delimited)
- Updates `.arcane-cycle-button-label` text
- Spins `.arcane-cycle-button-indicator` on click

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

#### New shadcn-Inspired Components

**ArcaneAspectRatio** - Container that maintains a specific aspect ratio
- Uses CSS `aspect-ratio` property with fallback
- Common presets: `.square()`, `.video()`, `.portrait()`, `.photo()`, `.golden()`, `.ultrawide()`

```dart
ArcaneAspectRatio.video(
  child: ArcaneImage(src: 'thumbnail.jpg'),
)
```

**ArcaneOtpInput** - One-time password input with separate digit fields
- Auto-advance focus on digit entry
- Backspace navigates to previous field
- Paste support (fills all fields)
- Size variants: `OtpInputSize.sm`, `md`, `lg`
- Separator support for grouped digits

```dart
ArcaneOtpInput(
  length: 6,
  onComplete: (code) => verifyCode(code),
)
```

**ArcaneCalendar** - Full calendar component for date selection
- Month navigation with previous/next buttons
- Today button for quick navigation
- Range selection mode (`CalendarMode.range`)
- Minimum/maximum date constraints
- Custom disabled dates
- Week number display option

```dart
ArcaneCalendar(
  selected: selectedDate,
  onSelect: (date) => setState(() => selectedDate = date),
  minDate: DateTime.now(),
)
```

**ArcaneDatePicker** - Date picker input with calendar dropdown
- Combines input field with calendar popup
- Date range picker variant (`.range()`)
- Clearable selection
- Custom date formatting
- Size variants: `DatePickerSize.sm`, `md`, `lg`

```dart
ArcaneDatePicker(
  value: birthDate,
  onChanged: (date) => setState(() => birthDate = date),
  label: 'Birth Date',
)
```

**ArcaneCombobox** - Autocomplete dropdown with search filtering
- Type-ahead search with custom filter function
- Keyboard navigation (arrow keys, enter, escape)
- Option descriptions and icons
- Empty state and loading support
- Size variants

```dart
ArcaneCombobox<String>(
  options: fruits.map((f) => ComboboxOption(value: f, label: f)).toList(),
  value: selectedFruit,
  onChanged: (fruit) => setState(() => selectedFruit = fruit),
  placeholder: 'Select a fruit...',
)
```

**ArcaneContextMenu** - Right-click context menu
- Appears at cursor position
- Submenus with nested items
- Separators and disabled items
- Destructive item styling
- Keyboard shortcut hints

```dart
ArcaneContextMenu(
  trigger: MyComponent(),
  items: [
    ContextMenuItem(label: 'Edit', shortcut: '⌘E', onSelect: edit),
    ContextMenuItem.separator(),
    ContextMenuItem(label: 'Delete', destructive: true, onSelect: delete),
  ],
)
```

**ArcaneMenubar** - Horizontal application menu bar
- Desktop app-style menu structure
- Hover to switch between open menus
- Submenus and nested items
- Keyboard shortcuts display

```dart
ArcaneMenubar(
  items: [
    MenubarItem(label: 'File', menu: [
      MenuItem(label: 'New', shortcut: '⌘N', onSelect: newFile),
      MenuItem(label: 'Open', shortcut: '⌘O', onSelect: openFile),
    ]),
    MenubarItem(label: 'Edit', menu: [...]),
  ],
)
```

**ArcaneResizable** - Resizable panel groups with drag handles
- Horizontal and vertical directions
- Min/max size constraints
- Collapsible panels
- Keyboard support (arrow keys)
- Visual grip indicator

```dart
ArcaneResizable(
  direction: ResizeDirection.horizontal,
  panels: [
    ResizablePanel(defaultSize: 25, minSize: 15, child: Sidebar()),
    ResizablePanel(child: MainContent()),
  ],
)
```

**ArcaneCommand** - Command palette (cmdk-style)
- Search filtering with keyboard navigation
- Command groups with headings
- Keyboard shortcut hints
- Empty state message
- Overlay with click-outside-to-close

```dart
ArcaneCommand(
  isOpen: showCommand,
  onClose: () => setState(() => showCommand = false),
  groups: [
    CommandGroup(heading: 'Actions', items: [
      CommandItem(label: 'New Document', shortcut: '⌘N', onSelect: newDoc),
    ]),
  ],
)
```

**JavaScript Fallback Scripts for New Components**

All new interactive components include static site support via `ArcaneScripts`:
- OTP inputs with auto-advance and paste handling
- Combobox search filtering and keyboard navigation
- Context menus with right-click positioning
- Menubars with hover-switch behavior
- Resizable panels with drag handling
- Command palette keyboard navigation
- Calendar day selection
- Date picker dropdown toggle

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

### Changed

#### Redesigned ArcaneTooltip Component

Complete rewrite of the tooltip system with CSS-based hover and proper JS fallbacks:

**New Design**
- Pure CSS hover-based display (no JavaScript required for hydrated apps)
- Arrow pointer that points to the trigger element
- Smooth fade and transform animations
- Support for all four positions (top, bottom, left, right)
- `ATooltip` short alias added

**JS Fallback Improvements**
- Binds to `.arcane-tooltip-trigger` elements
- Creates tooltip with arrow dynamically
- Proper opacity/visibility transitions
- Position-aware transform animations
- Also handles native `[title]` attributes

```dart
ArcaneTooltip(
  content: 'Helpful information',
  position: TooltipPosition.top,
  child: ArcaneButton.secondary(label: 'Hover me'),
)
```

#### Redesigned ArcaneToast Component

Complete rewrite of the toast notification system with simplified API and all variants working:

**Simplified API**

Standalone toasts now use direct properties instead of `ToastData`:

```dart
// Old API
ArcaneToast(
  data: ToastData(id: 'x', message: 'Hello', variant: ToastVariant.success),
  onClose: () {},
)

// New API
ArcaneToast(
  message: 'Hello',
  variant: ToastVariant.success,
  onClose: () {},
)
```

**Type Aliases**
- `AToast` - Short alias for `ArcaneToast`

Container setup with configurable position:

```dart
// Add once at app root
ArcaneToast.container(
  position: ToastPosition.topRight,  // 6 positions available
  maxVisible: 3,
  offset: 20,
)
```

**All Variants Working**
- `ToastVariant.info` - Blue accent with info icon
- `ToastVariant.success` - Green accent with checkmark icon
- `ToastVariant.warning` - Yellow/orange accent with warning triangle
- `ToastVariant.error` - Red accent with X icon
- `ToastVariant.loading` - Accent color with animated spinner

**Configurable Positioning**
- `ToastPosition.topLeft`, `topCenter`, `topRight`
- `ToastPosition.bottomLeft`, `bottomCenter`, `bottomRight`
- Position can be set on container or per-toast via global API

**Enhanced JS Fallbacks**
- Complete static site support for all toast variants
- Variant-specific SVG icons and colors in JS-created toasts
- Proper progress bar animation with hover pause/resume
- Dynamic toaster container creation with correct positioning
- MutationObserver for dynamically added toasts
- Action button support with callbacks in JS-created toasts
- Description text support in JS-created toasts

**Visual Improvements**
- Variant-specific backgrounds using design tokens (e.g., `successAlpha05`)
- Variant-specific borders (e.g., `errorAlpha30`)
- Proper SVG icons using `ArcaneIcon`
- Backdrop blur for depth effect
- Progress bar with variant-specific colors
- Smooth enter/exit animations with cubic-bezier curves

**Technical Improvements**
- Dart-native `Timer` instead of JS interop for reliability
- Proper timer cleanup in `dispose()`
- Improved accessibility with `aria-live` (assertive for errors)
- Added `aria-atomic` and proper ARIA roles

### Fixed

#### ArcaneSlider and ArcaneRangeSlider

- **Interactivity**: Fixed sliders being purely visual with no user interaction
  - Root cause: Components rendered custom visual elements but had no event handlers or native input elements
  - Fix: Added hidden native `<input type="range">` elements that overlay the visual slider and capture user input
  - Both `ArcaneSlider` and `ArcaneRangeSlider` now respond to drag/click interactions

#### ArcaneColorInput

- **Click handling**: Fixed color picker not opening when clicking the color swatch
  - Root cause: Overlapping positioned elements blocked pointer events to the hidden color input
  - Fix: Wrapped swatch in `<label>` element and added `pointer-events: none` to visual layers, ensuring clicks reach the native color picker

#### ArcaneHovercard and ArcanePopover

- **Hover functionality**: Fixed hover events not triggering properly on `ArcaneHovercard` and `ArcanePopover` (hover mode)
  - Root cause: Events were on separate inner divs for trigger and content, causing premature close when mouse moved between them
  - Fix: Events now placed on outer wrapper so mouse movement between trigger and content doesn't trigger close
- Removed unused `@css` styles fields that were generating analyzer warnings

#### Documentation Site (Codex)

- **Font loading**: Added Google Fonts (Inter, Fira Code) via CSS imports - fonts now load correctly on GitHub Pages
- **Base href**: Fixed asset paths for GitHub Pages subdirectory hosting at `/arcane_jaspr/`
- **Theme consistency**: Fonts now consistent between local development and production deployment
- **Interactive demos**: Added comprehensive JavaScript handlers for all interactive components on static site
  - **Input components**: Range sliders, color inputs with preset swatches, number input increment/decrement, tag input add/remove, select dropdowns, toggle button groups, radio buttons, cycle buttons
  - **View components**: Expanders/accordions expand/collapse, inline tabs selection, toast notifications, tree view node expand/collapse, popovers and hovercards on hover/click
  - **Navigation components**: Drawer open/close with backdrop, sidebar nav item selection, bottom nav selection

#### Enhanced Toast System (Sonner-style)

Complete rewrite of the toast system with modern patterns:

**New Components:**
- `ArcaneToast.container()` - Root toast container (place once at app root)
- `ToastManager` - Global singleton for managing toast state
- `ToastData` - Toast data model with all configuration options
- `ToastAction` - Action button configuration

**Global Toast API:**
```dart
// Simple usage via global `toast` getter
toast.success('Changes saved!');
toast.error('Something went wrong');
toast.warning('Please check your input');
toast.info('New update available');
toast.loading('Processing...');

// With options
toast.success('Profile updated', title: 'Success', description: 'Your changes have been saved.');

// Promise-based toast (loading → success/error)
toast.promise(
  saveData(),
  loading: 'Saving...',
  success: (data) => 'Saved ${data.name}!',
  error: (e) => 'Failed: ${e.message}',
);

// With action button
toast.error('Failed to save', action: ToastAction(
  label: 'Retry',
  onPressed: () => retry(),
));

// Dismiss programmatically
final id = toast.success('Saved');
toast.dismiss(id);
toast.dismissAll();
```

**Features:**
- Auto-dismiss with configurable duration (default 4s)
- Progress bar indicator for auto-dismiss
- Pause on hover
- Toast stacking with collapse/expand
- Queue management (max visible: 3)
- 6 position options (top/bottom × left/center/right)
- Loading variant with spinner animation
- Promise-based toasts for async operations
- Action buttons in toasts
- Exit animations

#### New Input Components

**ArcaneMutableText** - Inline editable text component
- Click/double-click/hover to edit triggers
- Single-line and multiline modes
- Validation support with error messages
- Character counter
- Multiple display styles: inline, subtle, underline, dashed, input
- Save on blur or explicit action
- Keyboard navigation (Enter to save, Escape to cancel)

```dart
ArcaneMutableText(
  value: 'Click to edit',
  onSave: (newValue) => updateTitle(newValue),
  displayStyle: MutableTextStyle.subtle,
  placeholder: 'Enter title...',
  required: true,
)
```

**ArcaneRadioGroup** - Radio button group with variants
- Standard radio buttons
- Card-style selection
- Button group (segmented control)
- Chip/pill style
- Horizontal, vertical, and grid layouts
- Full accessibility (ARIA, keyboard nav)
- Group-level validation

```dart
ArcaneRadioGroup<String>(
  value: selected,
  variant: RadioGroupVariant.cards,
  layout: RadioGroupLayout.grid,
  gridColumns: 3,
  options: [
    RadioOption(value: 'a', label: 'Option A', description: 'Description'),
    RadioOption(value: 'b', label: 'Option B', icon: ArcaneIcon.star()),
  ],
  onChanged: (value) => setState(() => selected = value),
)
```

#### New View Components

**ArcaneSeparator** - Visual divider/separator
- Horizontal and vertical orientations
- Multiple styles: solid, dashed, dotted, gradient, double
- Thickness presets: thin, normal, medium, thick
- Optional label or icon in center
- Decorative or semantic (with ARIA roles)

```dart
ArcaneSeparator()
ArcaneSeparator.vertical()
ArcaneSeparator.withLabel(label: 'OR')
ArcaneSeparator(style: SeparatorStyle.dashed, thickness: SeparatorThickness.medium)
```

**ArcaneDisclosure** - Native HTML disclosure widget (details/summary)
- Works on static sites without JavaScript (browser-native expand/collapse)
- Multiple visual variants: default, minimal, bordered, filled
- Optional chevron indicator
- Perfect for FAQs, collapsible sections, and navigation menus
- Unlike `ArcaneExpander`, doesn't require Jaspr hydration

```dart
// Basic usage
ArcaneDisclosure(
  summary: ArcaneText('Click to expand'),
  child: ArcaneText('Hidden content'),
)

// Variants
ArcaneDisclosure.minimal(...)  // No background/borders
ArcaneDisclosure.bordered(...) // Bordered container
ArcaneDisclosure.filled(...)   // Filled background

// Disclosure group
ArcaneDisclosureGroup(
  items: [
    ArcaneDisclosureItem(summary: ..., content: ...),
    ArcaneDisclosureItem(summary: ..., content: ...),
  ],
)
```

#### New Layout Components

**ArcaneScrollArea** - Styled scrollable container
- Custom scrollbar styling (thin, minimal, custom)
- Vertical, horizontal, or both scroll directions
- Scrollbar visibility control (always, hover, auto, hidden)
- Optional scroll shadows at edges
- Touch scrolling support

```dart
ArcaneScrollArea(
  height: '400px',
  scrollbarStyle: ScrollbarStyle.thin,
  showScrollShadows: true,
  child: LongContent(),
)
```

**ArcaneVirtualScroll** - Virtualized list for large datasets
- Only renders visible items for performance
- Fixed item height for calculation
- Configurable overscan (items to render outside viewport)
- Smooth scrolling

```dart
ArcaneVirtualScroll<User>(
  items: users,
  itemHeight: 48,
  height: '500px',
  itemBuilder: (context, user, index) => UserRow(user: user),
)
```

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
