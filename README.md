# arcane_jaspr

A comprehensive Dart/Jaspr UI component library implementing the Arcane design system for web applications. Components render to semantic HTML with CSS styling, with built-in Firebase authentication support.

## Installation

```yaml
dependencies:
  arcane_jaspr: ^2.0.0
```

## Quick Start

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';

class App extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return ArcaneApp(
      theme: ArcaneTheme.supabase(
        accent: AccentTheme.emerald,
        themeMode: ThemeMode.dark,
      ),
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

## Components

### Input Components

```dart
// Buttons
ArcaneButton.primary(label: 'Primary', onPressed: () {})
ArcaneButton.secondary(label: 'Secondary', onPressed: () {})
ArcaneButton.outline(label: 'Outline', onPressed: () {})
ArcaneButton.ghost(label: 'Ghost', onPressed: () {})
ArcaneButton.destructive(label: 'Delete', onPressed: () {})

// Icon button
ArcaneIconButton(
  icon: span([Component.text('\u2699')]),
  tooltip: 'Settings',
  onPressed: () {},
)

// Text inputs
ArcaneTextInput(
  label: 'Email',
  placeholder: 'Enter email...',
  onChanged: (value) {},
)

ArcaneTextArea(
  rows: 5,
  placeholder: 'Enter description...',
  onChanged: (value) {},
)

// Selection
ArcaneSelect<String>(
  value: selectedValue,
  options: [
    ArcaneSelectOption(value: 'a', label: 'Option A'),
    ArcaneSelectOption(value: 'b', label: 'Option B'),
  ],
  onChanged: (value) {},
)

ArcaneCheckbox(
  label: 'Accept terms',
  checked: accepted,
  onChanged: (value) {},
)

ArcaneToggleSwitch(
  value: enabled,
  onChanged: (value) {},
)

ArcaneSlider(
  value: 50,
  min: 0,
  max: 100,
  onChanged: (value) {},
)
```

### Layout Components

```dart
// Flex layouts
ArcaneRow(children: [...])
ArcaneColumn(children: [...])
ArcaneCenter(child: ...)

// Containers
ArcaneContainer(maxWidth: MaxWidth.lg, child: ...)
ArcaneCard(child: ...)
ArcaneSection(header: 'Title', children: [...])

// Positioning
ArcaneStack(children: [...])
ArcanePositioned(top: '10px', left: '20px', child: ...)

// Spacing
ArcanePadding(padding: PaddingPreset.lg, child: ...)
ArcaneGutter.medium()
ArcaneSpacer()

// Tabs
ArcaneTabs(tabs: [
  ArcaneTab(label: 'Tab 1', content: ...),
  ArcaneTab(label: 'Tab 2', content: ...),
])
```

### Typography

```dart
ArcaneHeadline('Main Title')
ArcaneSubheadline('Subtitle')
ArcaneHeading(level: 2, text: 'Section Title')
ArcaneParagraph(child: ArcaneText('Body text...'))
ArcaneCodeSnippet(code: 'print("Hello");', language: 'dart')
ArcaneInlineCode('variable')
```

### View Components

```dart
ArcaneAvatar(imageUrl: 'https://...', size: 48)
ArcaneBadge(label: 'New', variant: BadgeVariant.success)
ArcaneChip(label: 'Tag', onRemove: () {})
ArcaneDivider()
ArcaneProgressBar(value: 0.75)
ArcaneLoader()
ArcaneSkeleton(width: 200, height: 20)
ArcaneEmptyState(message: 'No items found')
ArcaneTooltip(message: 'Help text', child: ...)
ArcaneAccordion(items: [...])
```

### Navigation

```dart
ArcaneHeader(title: 'App Name', trailing: [...])
ArcaneSidebar(children: [...])
ArcaneBottomNav(items: [...], selectedIndex: 0)
ArcaneDropdownMenu(trigger: ..., items: [...])
```

### Feedback

```dart
ArcaneDialog(
  title: 'Confirm',
  child: Component.text('Are you sure?'),
  actions: [...],
  onClose: () {},
)

ArcaneAlertBanner(
  message: 'Operation successful',
  variant: AlertVariant.success,
)

ArcaneToast(message: 'Saved!')
```

## Styling System

Use `ArcaneStyleData` for type-safe CSS:

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
    transition: Transition.allFast,
  ),
  children: [...],
)
```

Or use raw CSS:

```dart
div(
  styles: Styles(raw: {
    'backdrop-filter': 'blur(10px)',
    'custom-property': 'value',
  }),
  [...],
)
```

### CSS Custom Properties

| Property | Description |
|----------|-------------|
| `--arcane-primary` | Primary brand color |
| `--arcane-accent` | Accent color |
| `--arcane-background` | Page background |
| `--arcane-surface` | Card/container surface |
| `--arcane-surface-variant` | Alternate surface |
| `--arcane-on-surface` | Text on surface |
| `--arcane-outline` | Border color |
| `--arcane-error` | Error color |
| `--arcane-success` | Success color |
| `--arcane-warning` | Warning color |

## Authentication

Built-in Firebase authentication with OAuth:

```dart
// 1. Wrap app with provider
ArcaneAuthProvider(
  serverApiUrl: 'https://api.example.com',
  redirectOnLogin: '/dashboard',
  redirectOnLogout: '/login',
  child: App(),
)

// 2. Protect routes
AuthGuard(
  redirectTo: '/login',
  child: DashboardScreen(),
)

// 3. Guest-only routes
GuestGuard(
  redirectTo: '/dashboard',
  child: LoginScreen(),
)

// 4. Pre-built auth UI
ArcaneLoginCard(
  methods: const [AuthMethod.email, AuthMethod.github, AuthMethod.google],
  signupRoute: '/signup',
  forgotPasswordRoute: '/forgot-password',
)

ArcaneSignupCard(
  methods: const [AuthMethod.email, AuthMethod.github],
  loginRoute: '/login',
  passwordPolicy: PasswordPolicy.strong,
  termsUrl: '/terms',
  privacyUrl: '/privacy',
)

// 5. Auth context access
if (context.isAuthenticated) {
  final user = context.currentUser;
}

context.signInWithGitHub();
context.signInWithGoogle();
context.signOut();
```

### Social Sign-in Buttons

```dart
GithubSignInButton(onPressed: () => context.signInWithGitHub())
GoogleSignInButton(onPressed: () => context.signInWithGoogle())
AppleSignInButton(onPressed: () => context.signInWithApple())
```

### Auth Layouts

```dart
AuthSplitLayout(
  brandingContent: AuthBrandingPanel(
    tagline: 'Build amazing apps',
    description: 'The complete solution.',
    features: ['Feature 1', 'Feature 2'],
  ),
  formContent: ArcaneLoginCard(...),
)
```

### Password Policies

```dart
// Presets
PasswordPolicy.weak    // 6+ chars
PasswordPolicy.medium  // 8+ chars, uppercase, number
PasswordPolicy.strong  // 8+ chars, upper, lower, number, special

// Custom
PasswordPolicy(
  minLength: 10,
  requireUppercase: true,
  requireLowercase: true,
  requireNumber: true,
  requireSpecialChar: true,
)

// Validation
String? error = policy.validate(password);
bool isValid = policy.isValid(password);
```

## Theming

```dart
// Preset themes
ArcaneTheme.supabase(accent: AccentTheme.emerald)
ArcaneTheme.vercel()
ArcaneTheme.stripe()

// Custom theme
ArcaneTheme(
  mode: ThemeMode.dark,
  colorScheme: ContrastedColorScheme.emerald,
  radius: 'md',
  surfaceOpacity: 0.95,
)

// Color scheme presets
ContrastedColorScheme.blue
ContrastedColorScheme.green
ContrastedColorScheme.purple
ContrastedColorScheme.emerald
```

## Project Structure

```
lib/
├── arcane_jaspr.dart       # Main barrel export
├── component/
│   ├── auth/               # Auth UI (login, signup, forgot password)
│   ├── button/             # Social sign-in buttons
│   ├── dialog/             # Modals, toasts
│   ├── feedback/           # Alerts, loaders
│   ├── form/               # Form fields, wrappers
│   ├── html/               # HTML element wrappers
│   ├── input/              # Buttons, inputs, toggles
│   ├── layout/             # Containers, grids, layouts
│   ├── navigation/         # Sidebar, header, nav
│   ├── screen/             # Full-page screens
│   └── view/               # Display components
├── provider/
│   ├── auth_provider.dart  # Auth context provider
│   └── auth_guard.dart     # Route protection guards
├── service/
│   ├── auth_service.dart   # Firebase Auth via JS interop
│   └── auth_state.dart     # Auth models
└── util/
    ├── appearance/         # Colors, schemes, themes
    ├── style_types/        # ArcaneStyleData enums
    ├── tokens/             # Design tokens
    └── auth/               # Password policy
```

## Testing

```bash
# Run tests (requires Chrome for web APIs)
dart test -p chrome
```

## Documentation

See the [ArcaneCodex documentation site](arcane_jaspr_codex/) for full API reference and examples.

## Dependencies

- `jaspr: ^0.22.0` - Core web framework
- `web: ^1.1.1` - Web APIs
- `http: ^1.6.0` - HTTP client

## License

MIT License
