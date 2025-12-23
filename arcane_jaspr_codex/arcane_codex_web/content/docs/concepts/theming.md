---
title: Theming
description: Learn how to configure and customize the Arcane UI theme system
layout: docs
component: theming
---

# Theming

Arcane Jaspr includes a powerful theme system built on CSS custom properties. A single line changes the entire appearance of your application.

## ArcaneApp

Every Arcane application must be wrapped in an `ArcaneApp` component which provides the theme context.

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';

ArcaneApp(
  theme: ArcaneTheme.green, // One line to theme your entire app!
  child: YourApp(),
)
```

## Theme Presets

Arcane provides 18 ready-to-use theme presets:

### Primary Colors

```dart
ArcaneTheme.red
ArcaneTheme.orange
ArcaneTheme.yellow
ArcaneTheme.green     // Default
ArcaneTheme.blue
ArcaneTheme.indigo
ArcaneTheme.purple
ArcaneTheme.pink
```

### Neutral/Monochromatic

```dart
ArcaneTheme.darkGrey
ArcaneTheme.grey
ArcaneTheme.lightGrey
ArcaneTheme.white
ArcaneTheme.black
```

### OLED (True Black)

Battery-saving themes with true black (#000000) backgrounds for OLED displays:

```dart
ArcaneTheme.oledRed
ArcaneTheme.oledGreen
ArcaneTheme.oledBlue
ArcaneTheme.oledPurple
ArcaneTheme.oledWhite
```

## ArcaneTheme Configuration

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `schema` | `ThemeSchema` | `GreenThemeSchema()` | The theme schema defining colors |
| `themeMode` | `ThemeMode` | `system` | Light, dark, or system mode |
| `radius` | `double` | `0.5` | Border radius scaling (0.0-1.0) |
| `surfaceOpacity` | `double` | `0.8` | Glass effect opacity for dark mode |
| `surfaceOpacityLight` | `double` | `0.9` | Glass effect opacity for light mode |
| `surfaceBlur` | `double` | `12.0` | Blur radius for glass surfaces |
| `scaling` | `double` | `1.0` | Global scaling factor |
| `spin` | `double` | `0.0` | Hue rotation in degrees |

### Customizing a Theme

Use `copyWith()` to modify any theme preset:

```dart
ArcaneApp(
  theme: ArcaneTheme.blue.copyWith(
    themeMode: ThemeMode.dark,
    radius: 0.75,              // Rounder corners
    surfaceOpacity: 0.9,       // Stronger glass effect
  ),
  child: MyApp(),
)
```

### Changing Theme Schema

Use `withSchema()` to switch to a different color scheme:

```dart
final theme = ArcaneTheme.blue.withSchema(const RedThemeSchema());
```

## Custom Theme Schema

Create your own theme by extending `ThemeSchema`:

```dart
class MyBrandTheme extends ThemeSchema {
  const MyBrandTheme();

  @override
  String get id => 'my_brand';

  @override
  String get name => 'My Brand';

  @override
  ColorSwatch get accentSwatch => Swatches.violet;

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}

// Use it
ArcaneApp(
  theme: ArcaneTheme(schema: const MyBrandTheme()),
  child: MyApp(),
)
```

## ThemeMode

The `ThemeMode` enum controls the color scheme:

| Value | Description |
|-------|-------------|
| `system` | Follow the system preference (defaults to dark) |
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
  final accentSwatch = theme.accentSwatch;

  return ArcaneDiv(
    styles: ArcaneStyleData(
      raw: {
        'color': colorScheme.primary.css,
        'background': accentSwatch[500].css,
      },
    ),
    children: [...],
  );
}
```

### Using Context Extensions

```dart
final theme = context.arcaneTheme;
final colorScheme = context.colorScheme;
final accentSwatch = context.accentSwatch;
final neutralSwatch = context.neutralSwatch;
final isDark = context.isDarkMode;
```

## Color Swatches

Each theme provides Tailwind-style color swatches with 11 shades:

```dart
theme.accentSwatch[50]   // Lightest
theme.accentSwatch[100]
theme.accentSwatch[200]
theme.accentSwatch[300]
theme.accentSwatch[400]
theme.accentSwatch[500]  // Primary
theme.accentSwatch[600]
theme.accentSwatch[700]
theme.accentSwatch[800]
theme.accentSwatch[900]
theme.accentSwatch[950]  // Darkest
```

### Available Swatches

```dart
Swatches.red
Swatches.orange
Swatches.amber
Swatches.emerald
Swatches.blue
Swatches.indigo
Swatches.violet
Swatches.pink
Swatches.zinc
Swatches.slate
Swatches.gray
Swatches.neutral
```

## CSS Variables

ArcaneTheme generates 150+ CSS custom properties that you can use throughout your application.

### Accent Swatch Variables

```css
--arcane-accent-50 through --arcane-accent-950
--arcane-accent-50-rgb through --arcane-accent-950-rgb  /* For alpha compositing */
```

### Neutral Swatch Variables

```css
--arcane-neutral-50 through --arcane-neutral-950
--arcane-neutral-50-rgb through --arcane-neutral-950-rgb
```

### Core Color Variables

```css
--arcane-accent           /* Primary accent color */
--arcane-accent-hover     /* Accent hover state */
--arcane-accent-container /* Accent container background */
--arcane-accent-foreground /* Text on accent */
--arcane-background       /* Page background */
--arcane-surface          /* Surface/card background */
--arcane-on-surface       /* Text on surface */
--arcane-border           /* Border color */
--arcane-muted            /* Muted text color */
```

### Status Color Variables

```css
--arcane-success          /* Success color */
--arcane-success-foreground
--arcane-success-container
--arcane-warning          /* Warning color */
--arcane-warning-foreground
--arcane-warning-container
--arcane-destructive      /* Error/destructive color */
--arcane-destructive-foreground
--arcane-destructive-container
--arcane-info             /* Info color */
--arcane-info-foreground
--arcane-info-container
```

### Radius Variables

```css
--arcane-radius           /* Base radius */
--arcane-radius-xs        /* Extra small radius */
--arcane-radius-sm        /* Small radius */
--arcane-radius-md        /* Medium radius */
--arcane-radius-lg        /* Large radius */
--arcane-radius-xl        /* Extra large radius */
--arcane-radius-2xl       /* Double extra large radius */
--arcane-radius-full      /* Full/pill radius */
```

### Shadow Variables

```css
--arcane-shadow-xs        /* Extra small shadow */
--arcane-shadow-sm        /* Small shadow */
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

Reference these variables in your `ArcaneStyleData`:

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    raw: {
      'background': 'var(--arcane-surface)',
      'border': '1px solid var(--arcane-border)',
      'color': 'var(--arcane-on-surface)',
      'border-radius': 'var(--arcane-radius-md)',
    },
  ),
  children: [...],
)
```

## Iterating All Themes

Access all available themes programmatically:

```dart
for (final theme in ArcaneTheme.all) {
  print('${theme.schema.name}: ${theme.schema.id}');
}
```

## Theme Properties

Check theme characteristics:

```dart
theme.isDark      // true if currently in dark mode
theme.isLight     // true if currently in light mode
theme.isOled      // true if using OLED theme (true black)
```
