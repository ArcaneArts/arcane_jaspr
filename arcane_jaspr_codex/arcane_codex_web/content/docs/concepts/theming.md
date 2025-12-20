---
title: Theming
description: Learn how to configure and customize the Arcane UI theme system
layout: docs
---

# Theming

Arcane Jaspr includes a powerful theme system built on CSS custom properties. The theme controls colors, accent colors, border radius, shadows, and more.

## ArcaneApp

Every Arcane application must be wrapped in an `ArcaneApp` component which provides the theme context.

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';

ArcaneApp(
  theme: ArcaneTheme.supabase(
    accent: AccentTheme.emerald,
    themeMode: ThemeMode.dark,
  ),
  child: YourApp(),
)
```

## ArcaneTheme

The `ArcaneTheme` class configures the visual appearance of your application.

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `accent` | `AccentTheme` | `emerald` | The accent color theme |
| `themeMode` | `ThemeMode` | `dark` | Light, dark, or system mode |
| `radius` | `double` | `0.5` | Border radius scaling (0.0-1.0) |
| `surfaceOpacity` | `double` | `0.8` | Glass effect opacity for dark mode |
| `surfaceOpacityLight` | `double` | `0.9` | Glass effect opacity for light mode |
| `surfaceBlur` | `double` | `8.0` | Blur radius for glass surfaces |
| `scaling` | `double` | `1.0` | Global scaling factor |
| `contrast` | `double` | `0.0` | Contrast adjustment (-1.0 to 1.0) |
| `spin` | `double` | `0.0` | Hue spin in degrees |

### Creating a Theme

Use the `ArcaneTheme.supabase()` factory for the default Supabase-inspired design:

```dart
ArcaneTheme.supabase(
  accent: AccentTheme.emerald,
  themeMode: ThemeMode.dark,
  radius: 0.5,
)
```

### Customizing the Theme

You can modify any aspect using `copyWith()`:

```dart
final theme = ArcaneTheme.supabase(accent: AccentTheme.cyan);

final customTheme = theme.copyWith(
  radius: 0.75,
  surfaceOpacity: 0.9,
);
```

### Switching Accents

Create a new theme with a different accent:

```dart
final newTheme = theme.withAccent(AccentTheme.violet);
```

## AccentTheme

The `AccentTheme` enum provides four accent color options:

| Value | Primary (Dark) | Primary (Light) | Description |
|-------|---------------|-----------------|-------------|
| `emerald` | `#10b981` | `#059669` | Green/teal accent (default) |
| `cyan` | `#06b6d4` | `#0891b2` | Blue/cyan accent |
| `violet` | `#8b5cf6` | `#7c3aed` | Purple accent |
| `amber` | `#f59e0b` | `#d97706` | Orange/amber accent |

### Accent Colors

Each accent provides multiple color variants:

```dart
AccentTheme.emerald.primaryDark   // Primary color for dark mode
AccentTheme.emerald.primaryLight  // Primary color for light mode
AccentTheme.emerald.hoverDark     // Hover state for dark mode
AccentTheme.emerald.hoverLight    // Hover state for light mode
AccentTheme.emerald.containerDark // Container color for dark mode
AccentTheme.emerald.containerLight // Container color for light mode
```

## ThemeMode

The `ThemeMode` enum controls the color scheme:

| Value | Description |
|-------|-------------|
| `system` | Follow the system preference |
| `light` | Force light mode |
| `dark` | Force dark mode |

### Getting Brightness

```dart
final brightness = themeMode.brightness; // Brightness.light or Brightness.dark
```

## Accessing the Theme

### From Context

```dart
@override
Component build(BuildContext context) {
  final theme = ArcaneTheme.of(context);
  final colorScheme = theme.colorScheme;

  return ArcaneDiv(
    styles: ArcaneStyleData(
      raw: {
        'color': colorScheme.primary.css,
      },
    ),
    children: [...],
  );
}
```

### Using the Extension

```dart
final theme = context.arcaneTheme;
final colorScheme = context.colorScheme;
```

## CSS Variables

ArcaneTheme generates 70+ CSS custom properties that you can use throughout your application:

### Color Variables

```css
--arcane-accent           /* Primary accent color */
--arcane-accent-hover     /* Accent hover state */
--arcane-accent-container /* Accent container background */
--arcane-background       /* Page background */
--arcane-surface          /* Surface/card background */
--arcane-card             /* Card background */
--arcane-border           /* Border color */
--arcane-text             /* Primary text color */
--arcane-muted            /* Muted text color */
```

### Status Variables

```css
--arcane-success          /* Success color */
--arcane-warning          /* Warning color */
--arcane-error            /* Error/destructive color */
--arcane-info             /* Info color */
```

### Radius Variables

```css
--arcane-radius           /* Base radius */
--arcane-radius-sm        /* Small radius */
--arcane-radius-md        /* Medium radius */
--arcane-radius-lg        /* Large radius */
--arcane-radius-xl        /* Extra large radius */
--arcane-radius-full      /* Full/pill radius */
```

### Shadow Variables

```css
--arcane-shadow-xs        /* Extra small shadow */
--arcane-shadow           /* Default shadow */
--arcane-shadow-lg        /* Large shadow */
--arcane-shadow-xl        /* Extra large shadow */
```

### Transition Variables

```css
--arcane-transition-fast  /* 150ms transition */
--arcane-transition       /* 200ms transition */
--arcane-transition-slow  /* 300ms transition */
```

## Using CSS Variables in Styles

You can reference these variables in your `ArcaneStyleData`:

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    raw: {
      'background': 'var(--arcane-surface)',
      'border': '1px solid var(--arcane-border)',
      'color': 'var(--arcane-text)',
      'border-radius': 'var(--arcane-radius-md)',
    },
  ),
  children: [...],
)
```

## Theme Toggle

Use `ArcaneThemeToggle` to let users switch between light and dark mode:

```dart
ArcaneThemeToggle(
  onToggle: (isDark) {
    // Update your theme state
  },
)
```

Or the simple version:

```dart
ArcaneThemeToggleSimple()
```
