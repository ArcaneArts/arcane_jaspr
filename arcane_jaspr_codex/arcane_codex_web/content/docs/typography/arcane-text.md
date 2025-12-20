---
title: ArcaneText
description: Basic text display component with styling
layout: docs
component: text
---

# ArcaneText

The fundamental text component for displaying styled text content.

## Basic Usage

```dart
ArcaneText('Hello World')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | required | Text content |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## With Styling

```dart
ArcaneText(
  'Styled text',
  styles: const ArcaneStyleData(
    fontSize: FontSize.lg,
    fontWeight: FontWeight.semibold,
    textColor: TextColor.primary,
  ),
)
```

## Font Sizes

```dart
// Extra small
ArcaneText('Extra Small', styles: const ArcaneStyleData(fontSize: FontSize.xs))

// Small
ArcaneText('Small', styles: const ArcaneStyleData(fontSize: FontSize.sm))

// Base (default)
ArcaneText('Base', styles: const ArcaneStyleData(fontSize: FontSize.base))

// Large
ArcaneText('Large', styles: const ArcaneStyleData(fontSize: FontSize.lg))

// Extra large
ArcaneText('Extra Large', styles: const ArcaneStyleData(fontSize: FontSize.xl))

// 2XL
ArcaneText('2XL', styles: const ArcaneStyleData(fontSize: FontSize.xl2))

// 3XL
ArcaneText('3XL', styles: const ArcaneStyleData(fontSize: FontSize.xl3))
```

## Font Weights

```dart
ArcaneText('Light', styles: const ArcaneStyleData(fontWeight: FontWeight.light))
ArcaneText('Normal', styles: const ArcaneStyleData(fontWeight: FontWeight.normal))
ArcaneText('Medium', styles: const ArcaneStyleData(fontWeight: FontWeight.medium))
ArcaneText('Semibold', styles: const ArcaneStyleData(fontWeight: FontWeight.semibold))
ArcaneText('Bold', styles: const ArcaneStyleData(fontWeight: FontWeight.bold))
```

## Text Colors

```dart
// Default
ArcaneText('Default', styles: const ArcaneStyleData(textColor: TextColor.default_))

// Muted
ArcaneText('Muted', styles: const ArcaneStyleData(textColor: TextColor.muted))

// Primary/Accent
ArcaneText('Primary', styles: const ArcaneStyleData(textColor: TextColor.primary))

// Success
ArcaneText('Success', styles: const ArcaneStyleData(textColor: TextColor.success))

// Warning
ArcaneText('Warning', styles: const ArcaneStyleData(textColor: TextColor.warning))

// Destructive
ArcaneText('Error', styles: const ArcaneStyleData(textColor: TextColor.destructive))
```

## Examples

### Label with Value

```dart
ArcaneRow(
  gap: Gap.sm,
  children: [
    ArcaneText(
      'Status:',
      styles: const ArcaneStyleData(
        textColor: TextColor.muted,
      ),
    ),
    ArcaneText(
      'Active',
      styles: const ArcaneStyleData(
        textColor: TextColor.success,
        fontWeight: FontWeight.medium,
      ),
    ),
  ],
)
```

### Price Display

```dart
ArcaneRow(
  crossAxisAlignment: AlignItems.end,
  gap: Gap.xs,
  children: [
    ArcaneText(
      '\$99',
      styles: const ArcaneStyleData(
        fontSize: FontSize.xl2,
        fontWeight: FontWeight.bold,
      ),
    ),
    ArcaneText(
      '/month',
      styles: const ArcaneStyleData(
        fontSize: FontSize.sm,
        textColor: TextColor.muted,
      ),
    ),
  ],
)
```

### Truncated Text

```dart
ArcaneText(
  'This is a very long text that should be truncated when it exceeds the container width',
  styles: const ArcaneStyleData(
    textOverflow: TextOverflow.ellipsis,
    whiteSpace: WhiteSpace.nowrap,
    overflow: Overflow.hidden,
  ),
)
```

### Capitalization

```dart
// Uppercase
ArcaneText(
  'uppercase text',
  styles: const ArcaneStyleData(
    textTransform: TextTransform.uppercase,
    letterSpacing: LetterSpacing.wide,
  ),
)

// Capitalize
ArcaneText(
  'capitalize each word',
  styles: const ArcaneStyleData(
    textTransform: TextTransform.capitalize,
  ),
)
```

### Link Style

```dart
ArcaneText(
  'Click here',
  styles: const ArcaneStyleData(
    textColor: TextColor.primary,
    textDecoration: TextDecoration.underline,
    cursor: Cursor.pointer,
  ),
)
```

## Related Components

- [ArcaneHeading](/docs/typography/arcane-heading) - Section headings
- [ArcaneParagraph](/docs/typography/arcane-paragraph) - Paragraph text
- [ArcaneSpan](/docs/typography/arcane-span) - Inline text spans
