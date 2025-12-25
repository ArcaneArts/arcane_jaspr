---
title: ArcaneMutableText
description: Inline editable text component with click-to-edit functionality
layout: docs
component: mutable-text
---

# ArcaneMutableText

An inline editable text component that allows users to click (or double-click) to edit text content directly. Perfect for inline editing in tables, forms, or any context where you want to edit text without navigating away.

## Basic Usage

```dart
ArcaneMutableText(
  value: 'Click to edit',
  onChanged: (newValue) {
    print('New value: $newValue');
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `String` | required | The current text value |
| `onChanged` | `ValueChanged<String>?` | `null` | Called when editing completes |
| `placeholder` | `String?` | `null` | Placeholder when empty |
| `trigger` | `EditTrigger` | `click` | How to activate edit mode |
| `maxLength` | `int?` | `null` | Maximum character limit |
| `showCharCount` | `bool` | `false` | Show character counter |
| `validator` | `String? Function(String)?` | `null` | Validation function |
| `textStyles` | `Map<String, String>?` | `null` | Custom text styles |
| `inputStyles` | `Map<String, String>?` | `null` | Custom input styles |

## Edit Triggers

Control how users activate edit mode:

```dart
// Click to edit (default)
ArcaneMutableText(
  value: 'Single click',
  trigger: EditTrigger.click,
  onChanged: (v) => handleChange(v),
)

// Double-click to edit
ArcaneMutableText(
  value: 'Double click',
  trigger: EditTrigger.doubleClick,
  onChanged: (v) => handleChange(v),
)

// Explicit button trigger
ArcaneMutableText(
  value: 'Button trigger',
  trigger: EditTrigger.button,
  onChanged: (v) => handleChange(v),
)
```

## With Validation

```dart
ArcaneMutableText(
  value: email,
  validator: (value) {
    if (!value.contains('@')) {
      return 'Invalid email';
    }
    return null;
  },
  onChanged: (v) => setState(() => email = v),
)
```

## With Character Limit

```dart
ArcaneMutableText(
  value: bio,
  maxLength: 280,
  showCharCount: true,
  onChanged: (v) => setState(() => bio = v),
)
```

## Accessibility

- Supports keyboard navigation (Enter to save, Escape to cancel)
- Proper ARIA labels for screen readers
- Focus management during edit mode
