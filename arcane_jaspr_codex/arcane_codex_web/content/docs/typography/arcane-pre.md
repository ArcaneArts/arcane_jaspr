---
title: ArcanePre
description: Preformatted text block
layout: docs
component: pre
---

# ArcanePre

A preformatted text component that preserves whitespace and uses a monospace font.

## Basic Usage

```dart
ArcanePre(
  text: '''
Line 1
Line 2
  Indented line
''',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | required | Preformatted text |
| `wrap` | `bool` | `false` | Allow text wrapping |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## With Wrapping

```dart
ArcanePre(
  wrap: true,
  text: 'This is a very long line that will wrap when it exceeds the container width instead of scrolling horizontally.',
)
```

## Examples

### ASCII Art

```dart
ArcanePre(
  text: '''
    _    ____   ____    _    _   _ _____
   / \\  |  _ \\ / ___|  / \\  | \\ | | ____|
  / _ \\ | |_) | |     / _ \\ |  \\| |  _|
 / ___ \\|  _ <| |___ / ___ \\| |\\  | |___
/_/   \\_\\_| \\_\\\\____/_/   \\_\\_| \\_|_____|
''',
)
```

### Log Output

```dart
ArcanePre(
  styles: const ArcaneStyleData(
    background: Background.dark,
    textColor: TextColor.onDark,
    padding: PaddingPreset.md,
    borderRadius: Radius.md,
  ),
  text: '''
[2024-01-15 10:30:42] INFO: Application started
[2024-01-15 10:30:43] INFO: Connected to database
[2024-01-15 10:30:44] INFO: Server listening on port 8080
[2024-01-15 10:30:45] WARN: Cache miss for key: user_123
[2024-01-15 10:30:46] INFO: Request completed in 45ms
''',
)
```

### Terminal Output

```dart
ArcaneColumn(
  gap: Gap.sm,
  children: [
    ArcaneText('Terminal Output:'),
    ArcanePre(
      styles: const ArcaneStyleData(
        background: Background.code,
        padding: PaddingPreset.md,
        borderRadius: Radius.md,
        fontSize: FontSize.sm,
      ),
      text: '''
\$ dart pub get
Resolving dependencies...
+ arcane_jaspr 1.0.0
+ jaspr 0.15.0
Changed 2 dependencies!
''',
    ),
  ],
)
```

### Data Table

```dart
ArcanePre(
  text: '''
Name            Age    City
─────────────────────────────
Alice           28     New York
Bob             34     Los Angeles
Charlie         22     Chicago
Diana           31     Houston
''',
)
```

### Diff Output

```dart
ArcanePre(
  styles: const ArcaneStyleData(
    background: Background.surface,
    padding: PaddingPreset.md,
    borderRadius: Radius.md,
    fontSize: FontSize.sm,
  ),
  text: '''
- old line to remove
+ new line to add
  unchanged line
- another removed line
+ another added line
''',
)
```

### Error Stack Trace

```dart
ArcanePre(
  styles: const ArcaneStyleData(
    background: Background.destructive,
    textColor: TextColor.onDestructive,
    padding: PaddingPreset.md,
    borderRadius: Radius.md,
    fontSize: FontSize.xs,
  ),
  text: '''
Error: Could not find file
    at FileReader.read (file_reader.dart:42)
    at DataLoader.load (data_loader.dart:18)
    at main (main.dart:5)
''',
)
```

### JSON Data

```dart
ArcanePre(
  styles: const ArcaneStyleData(
    background: Background.surface,
    padding: PaddingPreset.md,
    borderRadius: Radius.md,
  ),
  text: '''
{
  "name": "arcane_jaspr",
  "version": "1.0.0",
  "description": "UI components for Jaspr",
  "dependencies": {
    "jaspr": "^0.15.0"
  }
}
''',
)
```

### Build Output

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    ArcaneHeading(text: 'Build Log', level: HeadingLevel.h4),
    ArcanePre(
      styles: const ArcaneStyleData(
        background: Background.code,
        padding: PaddingPreset.md,
        borderRadius: Radius.md,
        maxHeightCustom: '300px',
        overflow: Overflow.auto,
      ),
      text: buildLogOutput,
    ),
  ],
)
```

## Related Components

- [ArcaneCodeSnippet](/docs/typography/arcane-code-snippet) - Syntax highlighted code
- [ArcaneInlineCode](/docs/typography/arcane-inline-code) - Inline code text
- [ArcaneText](/docs/typography/arcane-text) - Regular text
