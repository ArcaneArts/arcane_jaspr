---
title: ArcaneCodeBlock
description: Code and terminal output display with style presets
layout: docs
---

# ArcaneCodeBlock

A code block component with built-in style presets for displaying code, terminal output, and preformatted text.

> **Note**: This component was previously named `ArcanePre`. The old name still works as a legacy alias.

## Quick Start

Use factory constructors for common patterns:

```dart
// Code block with background, padding, border
ArcaneCodeBlock.code(
  children: [ArcaneText('const x = 42;')],
)

// Terminal style with dark background
ArcaneCodeBlock.terminal(
  children: [ArcaneText('\$ npm install')],
)
```

## Style Presets

ArcaneCodeBlock includes the `CodeBlockStyle` enum for quick styling:

| Style | Description |
|-------|-------------|
| `CodeBlockStyle.raw` | No styling - just the pre element |
| `CodeBlockStyle.code` | Background, padding, border radius, monospace font |
| `CodeBlockStyle.minimal` | Monospace font only, no background |
| `CodeBlockStyle.inline` | Compact style for inline-like usage |
| `CodeBlockStyle.terminal` | Dark background with green text |

```dart
// Using the style parameter
ArcaneCodeBlock(
  style: CodeBlockStyle.code,
  children: [ArcaneText('const greeting = "Hello";')],
)

ArcaneCodeBlock(
  style: CodeBlockStyle.terminal,
  children: [ArcaneText('\$ dart run')],
)

ArcaneCodeBlock(
  style: CodeBlockStyle.minimal,
  children: [ArcaneText('simple code')],
)
```

## Factory Constructors

### ArcaneCodeBlock.code

Pre-styled for code blocks:

```dart
ArcaneCodeBlock.code(
  children: [
    ArcaneText('''
function greet(name) {
  return `Hello, \${name}!`;
}
'''),
  ],
)
```

Includes:
- Code background (`Background.code`)
- Medium padding
- Border radius
- Monospace font
- Word wrapping

### ArcaneCodeBlock.terminal

Pre-styled for terminal/CLI output:

```dart
ArcaneCodeBlock.terminal(
  children: [
    ArcaneText('''
\$ dart pub get
Resolving dependencies...
+ arcane_jaspr 2.0.0
Changed 1 dependency!
'''),
  ],
)
```

Includes:
- Black background
- Neon green text
- Medium padding
- Border radius
- Monospace font

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | required | Content inside the pre element |
| `style` | `CodeBlockStyle` | `CodeBlockStyle.raw` | Style preset to use |
| `styles` | `ArcaneStyleData?` | `null` | Additional/override styling |
| `classes` | `String?` | `null` | CSS class names |
| `id` | `String?` | `null` | Element ID |
| `attributes` | `Map<String, String>?` | `null` | Additional HTML attributes |

## Custom Styling

Presets can be extended with the `styles` parameter:

```dart
ArcaneCodeBlock.code(
  styles: const ArcaneStyleData(
    maxHeightCustom: '200px',
    overflow: Overflow.auto,
  ),
  children: [ArcaneText(longCodeContent)],
)
```

Or use `CodeBlockStyle.raw` with full custom styling:

```dart
ArcaneCodeBlock(
  style: CodeBlockStyle.raw,
  styles: const ArcaneStyleData(
    background: Background.surfaceVariant,
    padding: PaddingPreset.lg,
    fontFamily: FontFamily.mono,
    fontSize: FontSize.sm,
    borderRadius: Radius.lg,
    border: BorderPreset.accent,
  ),
  children: [ArcaneText('Custom styled code')],
)
```

## Aliases

```dart
import 'package:arcane_jaspr/aliases.dart';

// New sensible name
ACodeBlock.code(
  children: [ArcaneText('const x = 42;')],
)

ACodeBlock(
  style: ACodeBlockStyle.terminal,
  children: [ArcaneText('\$ ls -la')],
)

// Legacy alias (still works!)
APre.code(
  children: [ArcaneText('const x = 42;')],
)
```

## Examples

### JSON Data

```dart
ArcaneCodeBlock.code(
  children: [
    ArcaneText('''
{
  "name": "arcane_jaspr",
  "version": "2.0.0",
  "description": "UI components for Jaspr"
}
'''),
  ],
)
```

### Build Log with Scroll

```dart
ArcaneCodeBlock.code(
  styles: const ArcaneStyleData(
    maxHeightCustom: '300px',
    overflow: Overflow.auto,
  ),
  children: [ArcaneText(buildLogOutput)],
)
```

### Error Stack Trace

```dart
ArcaneCodeBlock(
  style: CodeBlockStyle.code,
  styles: const ArcaneStyleData(
    background: Background.destructive,
    textColor: TextColor.onDestructive,
  ),
  children: [
    ArcaneText('''
Error: Could not find file
    at FileReader.read (file_reader.dart:42)
    at DataLoader.load (data_loader.dart:18)
    at main (main.dart:5)
'''),
  ],
)
```

## Why CodeBlockStyle?

Instead of writing raw CSS:

```dart
// Old way - lots of raw CSS
ArcaneCodeBlock(
  styles: const ArcaneStyleData(
    raw: {
      'background': 'var(--arcane-code-background)',
      'padding': '16px',
      'border-radius': '8px',
      'font-family': 'monospace',
      'white-space': 'pre-wrap',
    },
  ),
  children: [...],
)
```

Use enum-based presets:

```dart
// New way - clean and readable
ArcaneCodeBlock.code(children: [...])
// or
ArcaneCodeBlock(style: CodeBlockStyle.code, children: [...])
```

## Related Components

- [ArcaneCodeSnippet](/arcane_jaspr/docs/typography/arcane-code-snippet) - Code with copy button
- [ArcaneInlineCode](/arcane_jaspr/docs/typography/arcane-inline-code) - Inline code text
- [ArcaneText](/arcane_jaspr/docs/typography/arcane-text) - Regular text
