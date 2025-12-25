---
title: ArcaneCodeWindow
description: Code display with macOS-style window chrome
layout: docs
component: code-window
---

# ArcaneCodeWindow

A code display component with macOS-style window chrome (traffic light buttons) for showcasing code snippets.

## Basic Usage

```dart
ArcaneCodeWindow(
  title: 'main.dart',
  code: '''
void main() {
  print('Hello, World!');
}
''',
)
```

## Properties

### ArcaneCodeWindow

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `code` | `String` | required | Code content |
| `title` | `String?` | `null` | Window title |
| `style` | `CodeWindowStyle` | `dark` | Window style |
| `showButtons` | `bool` | `true` | Show traffic light buttons |
| `codeColor` | `String?` | `null` | Custom code color |

### ArcaneCodeSnippet

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `code` | `String` | required | Code content |
| `language` | `String?` | `null` | Language label |
| `mono` | `bool` | `true` | Use monospace font |

## Styles

```dart
// Dark (default)
ArcaneCodeWindow(
  code: 'console.log("Hello");',
  style: CodeWindowStyle.dark,
)

// Light
ArcaneCodeWindow(
  code: 'console.log("Hello");',
  style: CodeWindowStyle.light,
)

// Terminal
ArcaneCodeWindow.terminal(
  title: 'Terminal',
  code: '\$ npm install\n\$ npm run dev',
)
```

## Examples

### Code Example

```dart
ArcaneCodeWindow(
  title: 'app.tsx',
  code: '''
import React from 'react';

export function App() {
  return <h1>Hello World</h1>;
}
''',
)
```

### Terminal Commands

```dart
ArcaneCodeWindow.terminal(
  title: 'Terminal',
  code: '''
\$ dart pub get
Resolving dependencies...
Got dependencies!

\$ dart run
Hello, World!
''',
)
```

### Simple Code Snippet

```dart
ArcaneCodeSnippet(
  language: 'dart',
  code: 'print("Hello, World!");',
)
```

### Installation Instructions

```dart
ArcaneColumn(
  gapSize: Gap.md,
  children: [
    ArcaneCodeWindow.terminal(
      title: 'Install',
      code: '\$ dart pub add arcane_jaspr',
    ),
    ArcaneCodeWindow(
      title: 'main.dart',
      code: "import 'package:arcane_jaspr/arcane_jaspr.dart';",
    ),
  ],
)
```

## Related Components

- [ArcaneCodeSnippet](/docs/typography/arcane-code-snippet) - Inline code snippet
- [ArcaneCodeBlock](/docs/typography/arcane-pre) - Code block
