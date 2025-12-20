---
title: ArcaneInlineCode
description: Inline code text formatting
layout: docs
---

# ArcaneInlineCode

An inline code component for displaying code snippets within text content.

## Basic Usage

```dart
ArcaneInlineCode(code: 'npm install')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `code` | `String` | required | Code text |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Examples

### In Paragraph

```dart
ArcaneParagraph(
  children: [
    ArcaneText('Use the '),
    ArcaneInlineCode(code: 'ArcaneButton'),
    ArcaneText(' component for clickable actions.'),
  ],
)
```

### Variable Names

```dart
ArcaneDiv(
  children: [
    ArcaneText('Set '),
    ArcaneInlineCode(code: 'isDarkMode'),
    ArcaneText(' to '),
    ArcaneInlineCode(code: 'true'),
    ArcaneText(' to enable dark theme.'),
  ],
)
```

### Command Reference

```dart
ArcaneDiv(
  children: [
    ArcaneText('Run '),
    ArcaneInlineCode(code: 'dart pub get'),
    ArcaneText(' to install dependencies.'),
  ],
)
```

### Function Names

```dart
ArcaneDiv(
  children: [
    ArcaneText('Call '),
    ArcaneInlineCode(code: 'setState()'),
    ArcaneText(' to trigger a rebuild.'),
  ],
)
```

### File Paths

```dart
ArcaneDiv(
  children: [
    ArcaneText('Edit the '),
    ArcaneInlineCode(code: 'lib/main.dart'),
    ArcaneText(' file to change the entry point.'),
  ],
)
```

### Property List

```dart
ArcaneColumn(
  gap: Gap.sm,
  children: [
    ArcaneRow(
      gap: Gap.sm,
      children: [
        ArcaneInlineCode(code: 'label'),
        ArcaneText('- The button text'),
      ],
    ),
    ArcaneRow(
      gap: Gap.sm,
      children: [
        ArcaneInlineCode(code: 'onPressed'),
        ArcaneText('- Callback when clicked'),
      ],
    ),
    ArcaneRow(
      gap: Gap.sm,
      children: [
        ArcaneInlineCode(code: 'isDisabled'),
        ArcaneText('- Disable the button'),
      ],
    ),
  ],
)
```

### Keyboard Shortcuts

```dart
ArcaneDiv(
  children: [
    ArcaneText('Press '),
    ArcaneInlineCode(code: 'Ctrl+S'),
    ArcaneText(' to save, or '),
    ArcaneInlineCode(code: 'Ctrl+Shift+S'),
    ArcaneText(' to save as.'),
  ],
)
```

### Type Annotations

```dart
ArcaneDiv(
  children: [
    ArcaneText('The '),
    ArcaneInlineCode(code: 'value'),
    ArcaneText(' property accepts '),
    ArcaneInlineCode(code: 'String?'),
    ArcaneText(' (nullable string).'),
  ],
)
```

### Error Messages

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.md,
    background: Background.destructive,
    borderRadius: Radius.md,
  ),
  children: [
    ArcaneText('Error: '),
    ArcaneInlineCode(code: 'undefined is not a function'),
  ],
)
```

### Documentation Note

```dart
ArcaneBox(
  background: Background.info,
  children: [
    ArcaneRow(
      gap: Gap.sm,
      crossAxisAlignment: AlignItems.start,
      children: [
        span([text('💡')]),
        ArcaneDiv(
          children: [
            ArcaneText('Tip: Use '),
            ArcaneInlineCode(code: 'const'),
            ArcaneText(' with '),
            ArcaneInlineCode(code: 'ArcaneStyleData'),
            ArcaneText(' for better performance.'),
          ],
        ),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneCodeSnippet](/docs/typography/arcane-code-snippet) - Block code with highlighting
- [ArcanePre](/docs/typography/arcane-pre) - Preformatted text
- [ArcaneSpan](/docs/typography/arcane-span) - Inline text spans
