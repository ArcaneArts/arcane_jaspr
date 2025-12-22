---
title: Colors
description: Reference for background, text, and border color enums
layout: docs
---

# Colors

These enums provide semantic color values that adapt to the current theme.

## Background

Background color presets.

### Core Backgrounds

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `transparent` | `transparent` | Transparent background |
| `background` | `--arcane-background` | Page background |
| `backgroundSecondary` | `--arcane-background-secondary` | Secondary background |
| `backgroundTertiary` | `--arcane-background-tertiary` | Tertiary background |

### Surface & Card

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `surface` | `--arcane-surface` | Surface background |
| `surfaceVariant` | `--arcane-surface-variant` | Alternate surface |
| `card` | `--arcane-card` | Card background |
| `cardHover` | `--arcane-card-hover` | Card hover state |
| `cardAlt` | `--arcane-card-alt` | Alternate card |

### Interactive

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `input` | `--arcane-input` | Input field background |
| `navbar` | `--arcane-navbar` | Navigation bar |

### Semantic

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `primary` | `--arcane-primary` | Primary brand |
| `secondary` | `--arcane-secondary` | Secondary brand |
| `tertiary` | `--arcane-tertiary` | Tertiary brand |
| `accent` | `--arcane-accent` | Accent color |
| `accentContainer` | `--arcane-accent-container` | Accent container |

### Status

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `success` | `--arcane-success` | Success state |
| `successContainer` | `--arcane-success-container` | Success container |
| `warning` | `--arcane-warning` | Warning state |
| `error` | `--arcane-error` | Error state |
| `info` | `--arcane-info` | Info state |

### Special

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `overlay` | Overlay color | Modal/dialog overlay |
| `tooltip` | `--arcane-tooltip` | Tooltip background |
| `code` | `--arcane-code-background` | Code block background |
| `white` | `#ffffff` | Pure white |
| `black` | `#000000` | Pure black |
| `muted` | `--arcane-muted` | Muted background |
| `brandPrimary` | Brand color | Brand primary |
| `brandSecondary` | Brand color | Brand secondary |
| `destructive` | `--arcane-error` | Destructive actions |

### Glass Effects

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `glassTint` | `rgba(255, 255, 255, 0.05)` | Subtle glass tint |
| `glassHeader` | `rgba(255, 255, 255, 0.03)` | Glass header effect |
| `glassOverlay` | `rgba(255, 255, 255, 0.08)` | Glass overlay effect |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    background: Background.surface,
    padding: PaddingPreset.lg,
    borderRadius: Radius.lg,
  ),
  children: [...],
)
```

## TextColor

Text color presets.

### Primary Text

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `primary` | `--arcane-text` | Primary text |
| `secondary` | `--arcane-text-secondary` | Secondary text |
| `muted` | `--arcane-muted` | Muted text |
| `mutedForeground` | `--arcane-muted-foreground` | Muted foreground |
| `subtle` | `--arcane-text-subtle` | Subtle text |
| `faint` | `--arcane-text-faint` | Faint text |

### Semantic Text

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `accent` | `--arcane-accent` | Accent colored text |
| `accentForeground` | `--arcane-accent-foreground` | Text on accent |
| `success` | `--arcane-success` | Success text |
| `successForeground` | `--arcane-success-foreground` | Text on success |
| `warning` | `--arcane-warning` | Warning text |
| `warningForeground` | `--arcane-warning-foreground` | Text on warning |
| `error` | `--arcane-error` | Error text |
| `errorForeground` | `--arcane-error-foreground` | Text on error |
| `info` | `--arcane-info` | Info text |
| `infoForeground` | `--arcane-info-foreground` | Text on info |

### On-Surface Text

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `onPrimary` | `--arcane-on-primary` | Text on primary |
| `onSecondary` | `--arcane-on-secondary` | Text on secondary |
| `onBackground` | `--arcane-on-background` | Text on background |
| `onSurface` | `--arcane-on-surface` | Text on surface |
| `onSurfaceVariant` | `--arcane-on-surface-variant` | Text on surface variant |
| `cardForeground` | `--arcane-card-foreground` | Text on card |
| `inputForeground` | `--arcane-input-foreground` | Text in input |
| `tooltipForeground` | `--arcane-tooltip-foreground` | Text in tooltip |

### Fixed Colors

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `white` | `#ffffff` | Pure white |
| `black` | `#000000` | Pure black |
| `inherit` | `inherit` | Inherit from parent |

### Brand Colors

| Value | Description |
|-------|-------------|
| `brandPrimary` | Brand primary color |
| `brand` | Main brand color |
| `brandSecondary` | Brand secondary color |

### Neon Colors (Gaming)

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `neonPink` | `--arcane-neon-pink` | Neon pink |
| `neonCyan` | `--arcane-neon-cyan` | Neon cyan |
| `neonPurple` | `--arcane-neon-purple` | Neon purple |
| `neonGreen` | `--arcane-neon-green` | Neon green |
| `neonOrange` | `--arcane-neon-orange` | Neon orange |

### Special

| Value | Description |
|-------|-------------|
| `star` | Rating star color |

### Usage

```dart
ArcaneText(
  'Error message',
  styles: const ArcaneStyleData(
    textColor: TextColor.error,
  ),
)

// Accent link
ArcaneLink(
  href: '/docs',
  styles: const ArcaneStyleData(
    textColor: TextColor.accent,
  ),
  child: ArcaneText('Learn more'),
)
```

## BorderColor

Border color presets.

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `standard` | `--arcane-border` | Default border |
| `subtle` | `--arcane-border-subtle` | Subtle border |
| `medium` | Medium opacity | Medium visibility |
| `light` | Light opacity | Light visibility |
| `ring` | `--arcane-ring` | Focus ring |
| `accent` | `--arcane-accent` | Accent border |
| `success` | `--arcane-success` | Success border |
| `warning` | `--arcane-warning` | Warning border |
| `error` | `--arcane-error` | Error border |
| `info` | `--arcane-info` | Info border |
| `transparent` | `transparent` | No border |
| `outline` | `--arcane-outline` | Outline color |
| `outlineVariant` | `--arcane-outline-variant` | Outline variant |

## NeonColor

Neon/gaming color palette.

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `pink` | `--arcane-neon-pink` | Neon pink |
| `cyan` | `--arcane-neon-cyan` | Neon cyan |
| `purple` | `--arcane-neon-purple` | Neon purple |
| `green` | `--arcane-neon-green` | Neon green |
| `orange` | `--arcane-neon-orange` | Neon orange |

## GameColor

Game-themed brand colors.

| Value | CSS Variable | Description |
|-------|-------------|-------------|
| `minecraft` | `--arcane-minecraft` | Minecraft green |
| `rust` | `--arcane-rust` | Rust orange |
| `ark` | `--arcane-ark` | ARK blue |
| `valheim` | `--arcane-valheim` | Valheim gold |
| `cs2` | `--arcane-cs2` | CS2 orange |
| `terraria` | `--arcane-terraria` | Terraria green |

## Color Class

For custom colors, use the `Color` class:

```dart
// From ARGB
final color = Color.fromARGB(255, 16, 185, 129);

// From RGBO
final colorWithOpacity = Color.fromRGBO(16, 185, 129, 0.5);

// Properties
color.alpha    // Alpha component
color.red      // Red component
color.green    // Green component
color.blue     // Blue component
color.opacity  // Opacity (0.0 - 1.0)

// CSS output
color.css      // "rgba(16, 185, 129, 1)"
color.hex      // "#10b981"

// Modifications
color.withOpacity(0.5)
color.withAlpha(128)
color.lighten(0.1)
color.darken(0.1)
color.spin(30)  // Hue rotation

// Luminance
color.computeLuminance()
```

## Colors Palette

Predefined color palettes are available:

### Gray Scales

```dart
Colors.gray50   // Lightest gray
Colors.gray100
Colors.gray200
Colors.gray300
Colors.gray400
Colors.gray500
Colors.gray600
Colors.gray700
Colors.gray800
Colors.gray900
Colors.gray950  // Darkest gray
```

Similar palettes exist for:
- `slate` - Blue-tinted grays
- `zinc` - Neutral grays (Supabase default)

### Primary Colors

Each has 50-950 variants:
- `red`
- `orange`
- `amber`
- `yellow`
- `lime`
- `green`
- `emerald`
- `teal`
- `cyan`
- `sky`
- `blue`
- `indigo`
- `violet`
- `purple`
- `fuchsia`
- `pink`
- `rose`

### Usage

```dart
ArcaneDiv(
  styles: ArcaneStyleData(
    raw: {
      'background': Colors.emerald500.css,
      'color': Colors.white.css,
    },
  ),
  children: [...],
)
```
