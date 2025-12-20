---
title: ArcaneRichText
description: Compose styled text with multiple spans
layout: docs
---

# ArcaneRichText

A component for composing rich text with multiple styled spans, enabling complex inline formatting.

## Basic Usage

```dart
ArcaneRichText(
  children: [
    ArcaneTextSpan(text: 'Hello '),
    ArcaneTextSpan(
      text: 'World',
      styles: const ArcaneStyleData(fontWeight: FontWeight.bold),
    ),
    ArcaneTextSpan(text: '!'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<ArcaneTextSpan>` | `[]` | Text spans |
| `styles` | `ArcaneStyleData?` | `null` | Container styling |

## ArcaneTextSpan Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | required | Span text |
| `styles` | `ArcaneStyleData?` | `null` | Span styling |

## Examples

### Bold and Italic

```dart
ArcaneRichText(
  children: [
    ArcaneTextSpan(text: 'This is '),
    ArcaneTextSpan(
      text: 'bold',
      styles: const ArcaneStyleData(fontWeight: FontWeight.bold),
    ),
    ArcaneTextSpan(text: ' and this is '),
    ArcaneTextSpan(
      text: 'italic',
      styles: const ArcaneStyleData(fontStyle: FontStyle.italic),
    ),
    ArcaneTextSpan(text: '.'),
  ],
)
```

### Colored Text

```dart
ArcaneRichText(
  children: [
    ArcaneTextSpan(text: 'Status: '),
    ArcaneTextSpan(
      text: 'Active',
      styles: const ArcaneStyleData(
        textColor: TextColor.success,
        fontWeight: FontWeight.semibold,
      ),
    ),
    ArcaneTextSpan(text: ' • Last updated: '),
    ArcaneTextSpan(
      text: '2 hours ago',
      styles: const ArcaneStyleData(textColor: TextColor.muted),
    ),
  ],
)
```

### Code in Text

```dart
ArcaneRichText(
  children: [
    ArcaneTextSpan(text: 'Use '),
    ArcaneTextSpan(
      text: 'setState()',
      styles: const ArcaneStyleData(
        fontFamily: FontFamily.mono,
        background: Background.surface,
        padding: PaddingPreset.xs,
        borderRadius: Radius.sm,
      ),
    ),
    ArcaneTextSpan(text: ' to trigger a rebuild.'),
  ],
)
```

### Link in Text

```dart
ArcaneRichText(
  children: [
    ArcaneTextSpan(text: 'Read our '),
    ArcaneTextSpan(
      text: 'documentation',
      styles: const ArcaneStyleData(
        textColor: TextColor.primary,
        textDecoration: TextDecoration.underline,
        cursor: Cursor.pointer,
      ),
    ),
    ArcaneTextSpan(text: ' for more details.'),
  ],
)
```

### User Mention

```dart
ArcaneRichText(
  children: [
    ArcaneTextSpan(
      text: '@john_doe',
      styles: const ArcaneStyleData(
        textColor: TextColor.primary,
        fontWeight: FontWeight.medium,
        cursor: Cursor.pointer,
      ),
    ),
    ArcaneTextSpan(text: ' commented on your post.'),
  ],
)
```

### Price Display

```dart
ArcaneRichText(
  styles: const ArcaneStyleData(
    display: Display.flex,
    alignItems: AlignItems.baseline,
  ),
  children: [
    ArcaneTextSpan(
      text: '\$',
      styles: const ArcaneStyleData(
        fontSize: FontSize.lg,
        textColor: TextColor.muted,
      ),
    ),
    ArcaneTextSpan(
      text: '99',
      styles: const ArcaneStyleData(
        fontSize: FontSize.xl3,
        fontWeight: FontWeight.bold,
      ),
    ),
    ArcaneTextSpan(
      text: '.99',
      styles: const ArcaneStyleData(
        fontSize: FontSize.lg,
        textColor: TextColor.muted,
      ),
    ),
    ArcaneTextSpan(
      text: '/mo',
      styles: const ArcaneStyleData(
        fontSize: FontSize.sm,
        textColor: TextColor.muted,
      ),
    ),
  ],
)
```

### Terms Agreement

```dart
ArcaneRichText(
  styles: const ArcaneStyleData(fontSize: FontSize.sm),
  children: [
    ArcaneTextSpan(text: 'By signing up, you agree to our '),
    ArcaneTextSpan(
      text: 'Terms of Service',
      styles: const ArcaneStyleData(
        textColor: TextColor.primary,
        cursor: Cursor.pointer,
      ),
    ),
    ArcaneTextSpan(text: ' and '),
    ArcaneTextSpan(
      text: 'Privacy Policy',
      styles: const ArcaneStyleData(
        textColor: TextColor.primary,
        cursor: Cursor.pointer,
      ),
    ),
    ArcaneTextSpan(text: '.'),
  ],
)
```

### Keyboard Shortcut

```dart
ArcaneRichText(
  children: [
    ArcaneTextSpan(text: 'Press '),
    ArcaneTextSpan(
      text: '⌘',
      styles: const ArcaneStyleData(
        fontFamily: FontFamily.mono,
        background: Background.surface,
        padding: PaddingPreset.xs,
        borderRadius: Radius.sm,
        border: Border.subtle,
      ),
    ),
    ArcaneTextSpan(text: ' + '),
    ArcaneTextSpan(
      text: 'K',
      styles: const ArcaneStyleData(
        fontFamily: FontFamily.mono,
        background: Background.surface,
        padding: PaddingPreset.xs,
        borderRadius: Radius.sm,
        border: Border.subtle,
      ),
    ),
    ArcaneTextSpan(text: ' to open the command palette'),
  ],
)
```

### Activity Feed Item

```dart
ArcaneRichText(
  children: [
    ArcaneTextSpan(
      text: 'Sarah',
      styles: const ArcaneStyleData(fontWeight: FontWeight.semibold),
    ),
    ArcaneTextSpan(text: ' merged pull request '),
    ArcaneTextSpan(
      text: '#123',
      styles: const ArcaneStyleData(
        textColor: TextColor.primary,
        fontFamily: FontFamily.mono,
      ),
    ),
    ArcaneTextSpan(text: ' into '),
    ArcaneTextSpan(
      text: 'main',
      styles: const ArcaneStyleData(
        fontFamily: FontFamily.mono,
        background: Background.surface,
        padding: PaddingPreset.xs,
        borderRadius: Radius.sm,
      ),
    ),
  ],
)
```

## Related Components

- [ArcaneText](/docs/typography/arcane-text) - Simple text
- [ArcaneSpan](/docs/typography/arcane-span) - Inline spans
- [ArcaneParagraph](/docs/typography/arcane-paragraph) - Paragraph text
