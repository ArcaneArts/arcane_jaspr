# Arcane Jaspr

A [Jaspr](https://jaspr.site) web framework port of the [Arcane](https://pub.dev/packages/arcane) UI component library. Build beautiful web applications with Dart using familiar Arcane patterns.

## Overview

Arcane Jaspr brings the Arcane UI design system to the web via Jaspr. It provides a comprehensive set of pre-styled, composable components that render to semantic HTML with CSS styling.

### Key Differences from Flutter Arcane

- **HTML/CSS Output**: Components render to actual HTML elements with CSS, not Flutter widgets
- **No Fragment Shaders**: Visual effects use CSS filters, gradients, and animations instead of GLSL shaders
- **CSS-Based Theming**: Uses CSS custom properties and the `Styles` class for theming
- **Server-Side Rendering**: Full SSR support with automatic hydration

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  arcane_jaspr: ^0.0.1
```

## Quick Start

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';

class MyApp extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return ArcaneApp(
      theme: ArcaneTheme(
        themeMode: ThemeMode.dark,
        scheme: ContrastedColorScheme.blue(),
      ),
      child: Screen(
        header: Bar(titleText: 'My App'),
        child: Section(
          header: 'Welcome',
          children: [
            ArcaneCard(
              child: Component.text('Hello from Arcane Jaspr!'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Styling

### Using Styles.raw()

Arcane Jaspr provides a convenient `Styles.raw()` helper for inline CSS:

```dart
div(
  styles: Styles.raw({
    'display': 'flex',
    'gap': '16px',
    'padding': '24px',
    'background-color': 'var(--arcane-surface)',
    'border-radius': '8px',
  }),
  [
    Component.text('Content here'),
  ],
)
```

### CSS Custom Properties

The theme system injects CSS custom properties that you can use throughout your app:

| Property | Description |
|----------|-------------|
| `--arcane-primary` | Primary brand color |
| `--arcane-secondary` | Secondary color |
| `--arcane-background` | Page background |
| `--arcane-surface` | Card/container surface |
| `--arcane-surface-variant` | Alternate surface color |
| `--arcane-on-surface` | Text on surface |
| `--arcane-on-surface-variant` | Secondary text |
| `--arcane-outline` | Border color |
| `--arcane-outline-variant` | Subtle border color |
| `--arcane-error` | Error/destructive color |
| `--arcane-success` | Success color |
| `--arcane-warning` | Warning color |

## Components

### Layout Components

#### Section
Groups content with an optional header:
```dart
Section(
  header: 'Settings',
  children: [
    // Content widgets
  ],
)
```

#### Gutter
Adds consistent spacing:
```dart
Column([
  widget1,
  Gutter.small(),   // 8px
  widget2,
  Gutter.medium(),  // 16px
  widget3,
  Gutter.large(),   // 24px
  widget4,
])
```

#### Flow
Responsive flow layout with wrapping:
```dart
Flow(
  gap: 12,
  children: [
    // Items that wrap when space is limited
  ],
)
```

#### ButtonPanel
Horizontal panel for action buttons:
```dart
ButtonPanel(
  children: [
    ArcaneButton.ghost(label: 'Cancel', onPressed: () {}),
    ArcaneButton.primary(label: 'Save', onPressed: () {}),
  ],
)
```

#### RadioCards
Selectable card options:
```dart
RadioCards<String>(
  value: selectedValue,
  onChanged: (value) => setState(() => selectedValue = value),
  items: [
    RadioCardItem(value: 'option1', title: 'Option 1', subtitle: 'Description'),
    RadioCardItem(value: 'option2', title: 'Option 2', subtitle: 'Description'),
  ],
)
```

### Input Components

#### ArcaneButton
Various button styles:
```dart
ArcaneButton.primary(label: 'Primary', onPressed: () {})
ArcaneButton.secondary(label: 'Secondary', onPressed: () {})
ArcaneButton.outline(label: 'Outline', onPressed: () {})
ArcaneButton.ghost(label: 'Ghost', onPressed: () {})
ArcaneButton.destructive(label: 'Delete', onPressed: () {})
```

With icons:
```dart
ArcaneButton.primary(
  label: 'Save',
  leading: span([Component.text('\u2713')]),
  onPressed: () {},
)
```

#### ArcaneIconButton
Icon-only button:
```dart
ArcaneIconButton(
  icon: span([Component.text('\u2699')]),
  tooltip: 'Settings',
  onPressed: () {},
)
```

### View Components

#### Bar
Application header bar:
```dart
Bar(
  leading: [
    ArcaneIconButton(
      icon: span([Component.text('\u2630')]),
      tooltip: 'Menu',
      onPressed: () {},
    ),
  ],
  titleText: 'My Application',
  trailing: [
    ArcaneIconButton(
      icon: span([Component.text('\u2699')]),
      tooltip: 'Settings',
      onPressed: () {},
    ),
  ],
)
```

#### ArcaneCard
Card container:
```dart
ArcaneCard(
  padding: EdgeInsets.all(16),
  child: Component.text('Card content'),
)
```

Clickable card:
```dart
ArcaneCard(
  onTap: () => print('Card tapped'),
  child: Component.text('Click me'),
)
```

#### Glass
Glassmorphism effect container:
```dart
Glass(
  blur: 10,
  opacity: 0.8,
  child: div(
    styles: Styles.raw({'padding': '24px'}),
    [Component.text('Frosted glass content')],
  ),
)
```

#### Expander
Collapsible content section:
```dart
Expander(
  title: 'Click to expand',
  initiallyExpanded: false,
  child: div([
    Component.text('Hidden content revealed when expanded'),
  ]),
)
```

### Navigation Components

#### Sidebar
Vertical navigation panel:
```dart
Sidebar(
  header: div([Component.text('My App')]),
  children: [
    SidebarItem(
      icon: span([Component.text('\u2302')]),
      label: 'Home',
      selected: currentIndex == 0,
      onTap: () => setState(() => currentIndex = 0),
    ),
    SidebarItem(
      icon: span([Component.text('\u2605')]),
      label: 'Favorites',
      selected: currentIndex == 1,
      onTap: () => setState(() => currentIndex = 1),
    ),
  ],
)
```

#### BottomNavigationBar
Mobile-style bottom navigation:
```dart
BottomNavigationBar(
  selectedIndex: currentIndex,
  onChanged: (index) => setState(() => currentIndex = index),
  items: [
    BottomNavItem(icon: span([Component.text('\u2302')]), label: 'Home'),
    BottomNavItem(icon: span([Component.text('\u{1F50D}')]), label: 'Search'),
    BottomNavItem(icon: span([Component.text('\u2665')]), label: 'Favorites'),
  ],
)
```

#### ArcaneTabs
Tabbed content:
```dart
ArcaneTabs(
  tabs: [
    ArcaneTabItem(
      label: 'Overview',
      content: div([Component.text('Overview content')]),
    ),
    ArcaneTabItem(
      label: 'Details',
      content: div([Component.text('Details content')]),
    ),
  ],
)
```

### Dialog Components

#### ArcaneDialog
Modal dialog:
```dart
ArcaneDialog(
  title: 'Dialog Title',
  onClose: () => setState(() => showDialog = false),
  child: div([
    Component.text('Dialog content goes here'),
  ]),
  actions: [
    ArcaneButton.outline(label: 'Cancel', onPressed: () {}),
    ArcaneButton.primary(label: 'Confirm', onPressed: () {}),
  ],
)
```

#### ConfirmDialog
Pre-styled confirmation dialog:
```dart
ConfirmDialog(
  title: 'Delete Item?',
  message: 'This action cannot be undone.',
  confirmText: 'Delete',
  cancelText: 'Cancel',
  destructive: true,
  onConfirm: () => handleDelete(),
  onCancel: () => closeDialog(),
)
```

#### Toast
Toast notification:
```dart
Toast(
  message: 'Operation successful!',
  variant: ToastVariant.success,
  onClose: () => setState(() => showToast = false),
)
```

Toast variants: `success`, `error`, `warning`, `info`

### Table Components

#### StaticTable
Simple table display:
```dart
StaticTable(
  headers: ['Name', 'Email', 'Role'],
  rows: [
    [Component.text('Alice'), Component.text('alice@example.com'), Component.text('Admin')],
    [Component.text('Bob'), Component.text('bob@example.com'), Component.text('User')],
  ],
)
```

#### DataTable
Interactive data table:
```dart
DataTable(
  headers: ['Name', 'Email', 'Role'],
  data: users,
  columns: [
    DataColumn(key: 'name'),
    DataColumn(key: 'email'),
    DataColumn(key: 'role'),
  ],
  onRowTap: (row) => print('Tapped: ${row['name']}'),
)
```

## Theming

### Basic Theme Setup

```dart
ArcaneApp(
  theme: ArcaneTheme(
    themeMode: ThemeMode.dark,
    scheme: ContrastedColorScheme.blue(),
  ),
  child: // Your app
)
```

### Custom Color Scheme

```dart
ArcaneTheme(
  themeMode: ThemeMode.dark,
  scheme: ContrastedColorScheme(
    light: ColorScheme.light(
      primary: Color(0xFF6366F1),
      secondary: Color(0xFF8B5CF6),
      surface: Color(0xFFFFFFFF),
      background: Color(0xFFF8FAFC),
    ),
    dark: ColorScheme.dark(
      primary: Color(0xFF818CF8),
      secondary: Color(0xFFA78BFA),
      surface: Color(0xFF1E293B),
      background: Color(0xFF0F172A),
    ),
  ),
)
```

### Built-in Color Schemes

```dart
ContrastedColorScheme.blue()
ContrastedColorScheme.green()
ContrastedColorScheme.purple()
ContrastedColorScheme.orange()
ContrastedColorScheme.red()
```

### Theme Configuration Options

```dart
ArcaneTheme(
  themeMode: ThemeMode.dark,
  scheme: ContrastedColorScheme.blue(),
  radius: 0.5,           // Border radius scaling (0.0 - 1.0)
  surfaceOpacity: 0.8,   // Surface transparency
)
```

## Demo Application

A complete demo application is included in the `arcane_jaspr_demo` package showing all components in action.

## Documentation

- [Arcane Documentation](https://tome.arcane.art)
- [Jaspr Documentation](https://docs.jaspr.site)

## License

MIT License - See LICENSE file for details.
