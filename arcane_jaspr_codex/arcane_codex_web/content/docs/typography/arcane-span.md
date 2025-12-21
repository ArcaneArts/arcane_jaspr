---
title: ArcaneSpan
description: Inline text span for styled text fragments
layout: docs
component: span
---

# ArcaneSpan

An inline text component for styling portions of text within a larger block.

## Basic Usage

```dart
ArcaneSpan(text: 'highlighted text')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | required | Span text |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Examples

### Inline Styling

```dart
ArcaneDiv(
  children: [
    ArcaneText('This is '),
    ArcaneSpan(
      text: 'important',
      styles: const ArcaneStyleData(
        fontWeight: FontWeight.bold,
        textColor: TextColor.primary,
      ),
    ),
    ArcaneText(' information.'),
  ],
)
```

### Highlighted Text

```dart
ArcaneDiv(
  children: [
    ArcaneText('Use the '),
    ArcaneSpan(
      text: 'ArcaneButton',
      styles: const ArcaneStyleData(
        fontFamily: FontFamily.mono,
        background: Background.surface,
        padding: PaddingPreset.xs,
        borderRadius: Radius.sm,
      ),
    ),
    ArcaneText(' component for actions.'),
  ],
)
```

### Color Variations

```dart
ArcaneRow(
  gap: Gap.sm,
  children: [
    ArcaneSpan(
      text: 'Success',
      styles: const ArcaneStyleData(textColor: TextColor.success),
    ),
    ArcaneSpan(
      text: 'Warning',
      styles: const ArcaneStyleData(textColor: TextColor.warning),
    ),
    ArcaneSpan(
      text: 'Error',
      styles: const ArcaneStyleData(textColor: TextColor.destructive),
    ),
  ],
)
```

### Status Text

```dart
ArcaneDiv(
  children: [
    ArcaneText('Status: '),
    ArcaneSpan(
      text: isOnline ? 'Online' : 'Offline',
      styles: ArcaneStyleData(
        textColor: isOnline ? TextColor.success : TextColor.muted,
        fontWeight: FontWeight.medium,
      ),
    ),
  ],
)
```

### Price with Currency

```dart
ArcaneRow(
  crossAxisAlignment: AlignItems.baseline,
  children: [
    ArcaneSpan(
      text: '\$',
      styles: const ArcaneStyleData(
        fontSize: FontSize.lg,
        textColor: TextColor.muted,
      ),
    ),
    ArcaneSpan(
      text: '99',
      styles: const ArcaneStyleData(
        fontSize: FontSize.xl3,
        fontWeight: FontWeight.bold,
      ),
    ),
    ArcaneSpan(
      text: '.99',
      styles: const ArcaneStyleData(
        fontSize: FontSize.lg,
        textColor: TextColor.muted,
      ),
    ),
    ArcaneSpan(
      text: '/mo',
      styles: const ArcaneStyleData(
        fontSize: FontSize.sm,
        textColor: TextColor.muted,
      ),
    ),
  ],
)
```

### Keyboard Shortcuts

```dart
ArcaneDiv(
  children: [
    ArcaneText('Press '),
    ArcaneSpan(
      text: '⌘',
      styles: const ArcaneStyleData(
        fontFamily: FontFamily.mono,
        background: Background.surface,
        padding: PaddingPreset.xs,
        borderRadius: Radius.sm,
        border: Border.subtle,
      ),
    ),
    ArcaneText(' + '),
    ArcaneSpan(
      text: 'K',
      styles: const ArcaneStyleData(
        fontFamily: FontFamily.mono,
        background: Background.surface,
        padding: PaddingPreset.xs,
        borderRadius: Radius.sm,
        border: Border.subtle,
      ),
    ),
    ArcaneText(' to search'),
  ],
)
```

### Link-like Span

```dart
ArcaneDiv(
  children: [
    ArcaneText('Read our '),
    ArcaneSpan(
      text: 'documentation',
      styles: const ArcaneStyleData(
        textColor: TextColor.primary,
        textDecoration: TextDecoration.underline,
        cursor: Cursor.pointer,
      ),
    ),
    ArcaneText(' to learn more.'),
  ],
)
```

### Badge-like Span

```dart
ArcaneDiv(
  children: [
    ArcaneText('Version '),
    ArcaneSpan(
      text: '2.0.0',
      styles: const ArcaneStyleData(
        background: Background.accent,
        textColor: TextColor.onPrimary,
        padding: PaddingPreset.xs,
        borderRadius: Radius.sm,
        fontSize: FontSize.xs,
        fontWeight: FontWeight.medium,
      ),
    ),
    ArcaneText(' released!'),
  ],
)
```

## Related Components

- [ArcaneText](/arcane_jaspr/docs/typography/arcane-text) - Basic text display
- [ArcaneInlineCode](/arcane_jaspr/docs/typography/arcane-inline-code) - Inline code formatting
- [ArcaneRichText](/arcane_jaspr/docs/typography/arcane-rich-text) - Rich text composition
