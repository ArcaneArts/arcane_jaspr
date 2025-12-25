# Arcane Jaspr

A modern, comprehensive UI component library for [Jaspr](https://github.com/schultek/jaspr) web applications. Build beautiful, accessible interfaces with semantic HTML and CSS—no Flutter widgets required.

**Works everywhere**: Full interactivity on both hydrated Jaspr apps and static sites.

## Features

- **50+ Components** — Buttons, inputs, dialogs, navigation, data display, and more
- **One-Line Theming** — 20+ built-in themes with full customization
- **Static Site Support** — Automatic JavaScript fallbacks when hydration is unavailable
- **Type-Safe Styling** — `ArcaneStyleData` with enum-based CSS properties
- **Firebase Auth** — Built-in authentication UI with OAuth support
- **Accessible** — ARIA attributes, keyboard navigation, semantic HTML

## Installation

```yaml
dependencies:
  arcane_jaspr: ^2.5.0
```

## Quick Start

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';

class App extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return ArcaneApp(
      theme: ArcaneTheme.green,
      child: ArcaneScreen(
        header: const ArcaneBar(titleText: 'My App'),
        child: ArcaneContainer(
          child: ArcaneColumn(
            children: [
              const ArcaneHeadline('Welcome'),
              ArcaneButton.primary(
                label: 'Get Started',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Theming

Change your entire app's look with one line:

```dart
ArcaneApp(
  theme: ArcaneTheme.blue,  // or .green, .purple, .orange, etc.
  child: MyApp(),
)
```

### Available Themes

| Category | Themes |
|----------|--------|
| **Primary** | `red`, `orange`, `yellow`, `green`, `blue`, `indigo`, `purple`, `pink` |
| **Neutral** | `darkGrey`, `grey`, `lightGrey`, `white`, `black` |
| **OLED** | `oledRed`, `oledGreen`, `oledBlue`, `oledPurple`, `oledWhite` |

### Theme Customization

```dart
ArcaneApp(
  theme: ArcaneTheme.blue.copyWith(
    themeMode: ThemeMode.dark,
    radius: 0.75,           // Corner roundness
    surfaceOpacity: 0.9,    // Glass effect
  ),
  child: MyApp(),
)
```

## Components

### Buttons

```dart
ArcaneButton.primary(label: 'Primary', onPressed: () {})
ArcaneButton.secondary(label: 'Secondary', onPressed: () {})
ArcaneButton.outline(label: 'Outline', onPressed: () {})
ArcaneButton.ghost(label: 'Ghost', onPressed: () {})
ArcaneButton.destructive(label: 'Delete', onPressed: () {})
ArcaneButton.link(label: 'Link', onPressed: () {})

ArcaneIconButton(icon: ArcaneIcon.settings, onPressed: () {})
```

### Inputs

```dart
// Text
ArcaneTextInput(label: 'Email', placeholder: 'you@example.com')
ArcaneTextArea(label: 'Bio', rows: 4, resize: TextAreaResize.both)
ArcaneSearch(placeholder: 'Search...')

// Selection
ArcaneSelect(options: [...], value: selected)
ArcaneSelector(options: [...], value: selected, searchable: true)
ArcaneCheckbox(checked: true, onChanged: (_) {})
ArcaneRadio(selected: true, label: 'Option A')
ArcaneToggleSwitch(value: true, onChanged: (_) {})

// Specialized
ArcaneSlider(value: 50, min: 0, max: 100)
ArcaneRangeSlider(minValue: 20, maxValue: 80)
ArcaneNumberInput(value: 5, min: 0, max: 10)
ArcaneColorInput(value: '#10b981', label: 'Color')
ArcaneTagInput(tags: ['React', 'Vue'], placeholder: 'Add tag...')
ArcaneFileUpload(onFilesSelected: (_) {})

// Toggles
ArcaneThemeToggle(isDark: true, onChanged: (_) {})
ArcaneCycleButton(options: [...], value: 'a')
ArcaneToggleButton(value: false, label: 'Bold')
ArcaneToggleButtonGroup(options: ['S', 'M', 'L'], selectedIndex: 1)
```

### Layout

```dart
// Flex
ArcaneRow(children: [...])
ArcaneColumn(children: [...])
ArcaneCenter(child: ...)

// Containers
ArcaneContainer(maxWidth: MaxWidth.lg, child: ...)
ArcaneCard(child: ...)
ArcaneSection(header: 'Title', children: [...])

// Grid
ArcaneDiv(
  styles: ArcaneStyleData(
    display: Display.grid,
    gridColumns: GridColumns.three,
    gap: Gap.lg,
  ),
  children: [...],
)

// Spacing
ArcanePadding(padding: PaddingPreset.lg, child: ...)
ArcaneGutter.medium()
ArcaneSpacer()

// Scroll Rail (sticky sidebar)
ArcaneScrollRail(
  width: '280px',
  topOffset: '64px',
  children: [...],
)
```

### Navigation

```dart
ArcaneBar(titleText: 'App', trailing: [...])
ArcaneSidebar(children: [...])
ArcaneBottomNav(items: [...], selectedIndex: 0)
ArcaneTabs(tabs: [...])
ArcaneDropdownMenu(trigger: ..., items: [...])
ArcaneBreadcrumb(items: [...])
```

### Display

```dart
ArcaneAvatar(imageUrl: '...', size: 48)
ArcaneBadge(label: 'New', variant: BadgeVariant.success)
ArcaneChip(label: 'Tag', onRemove: () {})
ArcaneDivider()
ArcaneProgressBar(value: 0.75)
ArcaneLoader()
ArcaneSkeleton(width: 200, height: 20)
ArcaneEmptyState(message: 'No items found')
ArcaneTooltip(message: 'Help', child: ...)
ArcaneAccordion(items: [...])
ArcaneDataTable(columns: [...], rows: [...])
```

### Feedback

```dart
ArcaneDialog(title: 'Confirm', child: ..., onClose: () {})
ArcaneAlertBanner(message: 'Success!', variant: AlertVariant.success)
ArcaneToast(message: 'Saved!')
```

## Styling System

Use `ArcaneStyleData` for type-safe, enum-based CSS:

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    padding: PaddingPreset.lg,
    gap: Gap.md,
    background: Background.surface,
    borderRadius: Radius.lg,
    shadow: Shadow.md,
  ),
  children: [...],
)
```

### Flex Presets

```dart
flex: FlexPreset.expand,    // flex: 1 1 0% (fill available space)
flex: FlexPreset.none,      // flex: 0 0 auto (fixed size)
flex: FlexPreset.auto,      // flex: 1 1 auto
flex: FlexPreset.equal,     // flex: 1 1 0 (equal distribution)
```

### Grid Templates

```dart
gridColumns: GridColumns.three,        // repeat(3, 1fr)
gridColumns: GridColumns.autoFitMd,    // repeat(auto-fit, minmax(280px, 1fr))
gridColumns: GridColumns.sidebar,      // 280px 1fr
gridRows: GridRows.headerContentFooter, // auto 1fr auto
```

### Border Width

```dart
borderLeft: BorderPreset.accent,
borderLeftWidth: BorderWidth.thick,  // 3px
```

### Raw CSS Fallback

```dart
ArcaneDiv(
  styles: ArcaneStyleData(
    raw: {'backdrop-filter': 'blur(10px)'},
  ),
  children: [...],
)
```

## Static Site Support

`ArcaneApp` automatically injects JavaScript fallbacks for static sites built with `jaspr build`. All interactive components work without hydration:

```dart
// Works on both hydrated apps and static sites
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

### Supported Components

All interactive components have JavaScript fallbacks:
- Sliders, range sliders
- Color inputs, number inputs
- Checkboxes, radios, toggle switches
- Theme toggles, cycle buttons
- Dropdowns, selectors
- Tabs, accordions
- Dialogs, toasts, popovers
- And more...

## Authentication

Built-in Firebase authentication with OAuth:

```dart
// 1. Wrap app with provider
ArcaneAuthProvider(
  serverApiUrl: 'https://api.example.com',
  redirectOnLogin: '/dashboard',
  child: App(),
)

// 2. Protect routes
AuthGuard(redirectTo: '/login', child: Dashboard())

// 3. Guest-only routes
GuestGuard(redirectTo: '/dashboard', child: LoginPage())

// 4. Pre-built auth UI
ArcaneLoginCard(
  methods: [AuthMethod.email, AuthMethod.github, AuthMethod.google],
  signupRoute: '/signup',
)

// 5. Access auth state
if (context.isAuthenticated) {
  final user = context.currentUser;
}

context.signInWithGitHub();
context.signOut();
```

### Social Sign-In Buttons

```dart
GithubSignInButton(onPressed: () => context.signInWithGitHub())
GoogleSignInButton(onPressed: () => context.signInWithGoogle())
AppleSignInButton(onPressed: () => context.signInWithApple())
```

### Password Policies

```dart
PasswordPolicy.weak     // 6+ chars
PasswordPolicy.medium   // 8+ chars, uppercase, number
PasswordPolicy.strong   // 8+ chars, upper, lower, number, special

// Custom
PasswordPolicy(
  minLength: 12,
  requireUppercase: true,
  requireSpecialChar: true,
)
```

## CSS Custom Properties

All themes generate 150+ CSS variables:

```css
--arcane-accent           /* Primary accent color */
--arcane-accent-50..950   /* Full accent swatch */
--arcane-background       /* Page background */
--arcane-surface          /* Card/container surface */
--arcane-on-surface       /* Text on surface */
--arcane-border           /* Border color */
--arcane-success          /* Success states */
--arcane-warning          /* Warning states */
--arcane-error            /* Error states */
--arcane-info             /* Info states */
```

## Project Structure

```
lib/
├── arcane_jaspr.dart       # Main export
├── component/
│   ├── auth/               # Auth UI components
│   ├── button/             # Social sign-in buttons
│   ├── dialog/             # Modals, toasts, popovers
│   ├── feedback/           # Alerts, loaders, progress
│   ├── form/               # Form fields, validation
│   ├── html/               # HTML element wrappers
│   ├── input/              # Buttons, inputs, toggles
│   ├── layout/             # Containers, grids, tabs
│   ├── navigation/         # Sidebar, header, nav
│   ├── screen/             # Full-page screens
│   └── view/               # Display components
├── provider/               # Auth context, guards
├── service/                # Firebase auth service
└── util/
    ├── appearance/         # Colors, themes
    ├── interactivity/      # Static site scripts
    ├── style_types/        # ArcaneStyleData enums
    └── tokens/             # Design tokens
```

## Documentation

Full documentation with live examples: [ArcaneCodex](arcane_jaspr_codex/)

```bash
cd arcane_jaspr_codex/arcane_codex_web
jaspr serve  # http://localhost:8080
```

## Commands

```bash
dart pub get                    # Install dependencies
dart analyze lib/               # Run analyzer
dart test -p chrome             # Run tests
dart run build_runner build     # Code generation
```

## Dependencies

- `jaspr: ^0.22.0` — Core web framework
- `web: ^1.1.1` — Web APIs
- `http: ^1.6.0` — HTTP client

## License

MIT License
