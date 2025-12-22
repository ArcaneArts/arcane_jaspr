---
title: ArcaneKbd
description: Keyboard key display for shortcuts
layout: docs
component: kbd
---

# ArcaneKbd

A keyboard key component for displaying keyboard shortcuts and key combinations.

## Basic Usage

```dart
ArcaneKbd('⌘')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `keyText` | `String` | required | Key label |
| `style` | `KbdStyle` | `raised` | Visual style |
| `size` | `KbdSize` | `md` | Size variant |

## Style Variants

```dart
// Raised (default)
ArcaneKbd('K', style: KbdStyle.raised)

// Flat
ArcaneKbd('K', style: KbdStyle.flat)

// Outline
ArcaneKbd('K', style: KbdStyle.outline)
```

## Size Variants

```dart
// Small
ArcaneKbd('K', size: KbdSize.sm)

// Medium (default)
ArcaneKbd('K', size: KbdSize.md)

// Large
ArcaneKbd('K', size: KbdSize.lg)
```

## Key Combinations

Use the `combo` factory for displaying multiple keys:

```dart
ArcaneKbd.combo(['⌘', 'K'])
```

## Examples

### Shortcut Display

```dart
ArcaneRow(
  gapSize: Gap.sm,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    ArcaneText('Save:'),
    ArcaneKbd('⌘'),
    ArcaneText('+'),
    ArcaneKbd('S'),
  ],
)
```

### Search Shortcut

```dart
ArcaneRow(
  gapSize: Gap.sm,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    ArcaneText('Quick search'),
    ArcaneKbd.combo(['⌘', 'K']),
  ],
)
```

### Keyboard Shortcuts Panel

```dart
ArcaneColumn(
  gapSize: Gap.md,
  children: [
    ArcaneRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArcaneText('Save'),
        ArcaneKbd.combo(['Ctrl', 'S']),
      ],
    ),
    ArcaneRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArcaneText('Copy'),
        ArcaneKbd.combo(['Ctrl', 'C']),
      ],
    ),
    ArcaneRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArcaneText('Paste'),
        ArcaneKbd.combo(['Ctrl', 'V']),
      ],
    ),
    ArcaneRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArcaneText('Undo'),
        ArcaneKbd.combo(['Ctrl', 'Z']),
      ],
    ),
  ],
)
```

### Inline Help

```dart
ArcaneParagraph(
  children: [
    ArcaneText('Press '),
    ArcaneKbd('Esc'),
    ArcaneText(' to close the dialog.'),
  ],
)
```

## Common Keys

```dart
// Modifier keys
ArcaneKbd('⌘')    // Command
ArcaneKbd('Ctrl') // Control
ArcaneKbd('Alt')  // Alt
ArcaneKbd('⇧')    // Shift

// Arrow keys
ArcaneKbd('↑')
ArcaneKbd('↓')
ArcaneKbd('←')
ArcaneKbd('→')

// Special keys
ArcaneKbd('Enter')
ArcaneKbd('Tab')
ArcaneKbd('Esc')
ArcaneKbd('Space')
```

## Related Components

- [ArcaneTooltip](/arcane_jaspr/docs/view/arcane-tooltip) - Tooltip with shortcuts
- [ArcaneText](/arcane_jaspr/docs/typography/arcane-text) - Text component
