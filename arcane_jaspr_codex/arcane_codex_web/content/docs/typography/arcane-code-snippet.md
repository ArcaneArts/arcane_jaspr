---
title: ArcaneCodeSnippet
description: Code block with syntax highlighting
layout: docs
component: code-snippet
---

# ArcaneCodeSnippet

A code block component with syntax highlighting and optional copy functionality for displaying code examples.

## Basic Usage

```dart
ArcaneCodeSnippet(
  code: 'print("Hello World");',
  language: 'dart',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `code` | `String` | required | Code content |
| `language` | `String?` | `null` | Language for highlighting |
| `title` | `String?` | `null` | Optional title/filename |
| `showLineNumbers` | `bool` | `true` | Display line numbers |
| `showCopyButton` | `bool` | `true` | Show copy button |
| `highlightLines` | `List<int>?` | `null` | Lines to highlight |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Supported Languages

```dart
// Dart
ArcaneCodeSnippet(code: code, language: 'dart')

// JavaScript
ArcaneCodeSnippet(code: code, language: 'javascript')

// TypeScript
ArcaneCodeSnippet(code: code, language: 'typescript')

// HTML
ArcaneCodeSnippet(code: code, language: 'html')

// CSS
ArcaneCodeSnippet(code: code, language: 'css')

// JSON
ArcaneCodeSnippet(code: code, language: 'json')

// YAML
ArcaneCodeSnippet(code: code, language: 'yaml')

// Shell/Bash
ArcaneCodeSnippet(code: code, language: 'bash')
```

## With Title

```dart
ArcaneCodeSnippet(
  title: 'main.dart',
  language: 'dart',
  code: '''
void main() {
  runApp(MyApp());
}
''',
)
```

## Without Line Numbers

```dart
ArcaneCodeSnippet(
  code: 'npm install arcane-jaspr',
  language: 'bash',
  showLineNumbers: false,
)
```

## Highlighted Lines

```dart
ArcaneCodeSnippet(
  language: 'dart',
  highlightLines: [3, 4, 5],
  code: '''
class MyApp extends StatelessComponent {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ArcaneApp(
      child: HomePage(),
    );
  }
}
''',
)
```

## Examples

### Installation Command

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    ArcaneHeading(text: 'Installation', level: HeadingLevel.h3),
    ArcaneCodeSnippet(
      language: 'bash',
      showLineNumbers: false,
      code: 'dart pub add arcane_jaspr',
    ),
  ],
)
```

### Component Example

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    ArcaneHeading(text: 'Basic Usage', level: HeadingLevel.h3),
    ArcaneCodeSnippet(
      title: 'example.dart',
      language: 'dart',
      code: '''
ArcaneButton(
  label: 'Click Me',
  onPressed: () {
    print('Button pressed!');
  },
)
''',
    ),
  ],
)
```

### Configuration File

```dart
ArcaneCodeSnippet(
  title: 'pubspec.yaml',
  language: 'yaml',
  code: '''
dependencies:
  jaspr: ^0.15.0
  arcane_jaspr: ^1.0.0

dev_dependencies:
  jaspr_builder: ^0.15.0
  build_runner: ^2.4.0
''',
)
```

### API Response

```dart
ArcaneCodeSnippet(
  title: 'response.json',
  language: 'json',
  code: '''
{
  "status": "success",
  "data": {
    "id": 123,
    "name": "John Doe",
    "email": "john@example.com"
  }
}
''',
)
```

### Multi-file Example

```dart
ArcaneTabs(
  variant: TabsVariant.boxed,
  tabs: [
    ArcaneTab(
      label: 'main.dart',
      content: ArcaneCodeSnippet(
        language: 'dart',
        code: mainDartCode,
      ),
    ),
    ArcaneTab(
      label: 'home_page.dart',
      content: ArcaneCodeSnippet(
        language: 'dart',
        code: homePageCode,
      ),
    ),
    ArcaneTab(
      label: 'styles.css',
      content: ArcaneCodeSnippet(
        language: 'css',
        code: stylesCode,
      ),
    ),
  ],
)
```

### Inline Comparison

```dart
ArcaneRow(
  gap: Gap.lg,
  children: [
    ArcaneExpanded(
      child: ArcaneColumn(
        gap: Gap.sm,
        children: [
          ArcaneText('Before'),
          ArcaneCodeSnippet(
            language: 'dart',
            code: beforeCode,
          ),
        ],
      ),
    ),
    ArcaneExpanded(
      child: ArcaneColumn(
        gap: Gap.sm,
        children: [
          ArcaneText('After'),
          ArcaneCodeSnippet(
            language: 'dart',
            code: afterCode,
          ),
        ],
      ),
    ),
  ],
)
```

## Related Components

- [ArcaneInlineCode](/docs/typography/arcane-inline-code) - Inline code text
- [ArcanePre](/docs/typography/arcane-pre) - Preformatted text
- [ArcaneTabs](/docs/layout/arcane-tabs) - Tabbed code examples
