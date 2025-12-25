---
title: ArcaneTextArea
description: Multi-line text input for longer content
layout: docs
component: text-area
---

# ArcaneTextArea

A multi-line text input for longer text content like descriptions, comments, and messages.

## Basic Usage

```dart
ArcaneTextArea(
  label: 'Description',
  placeholder: 'Enter a description...',
  onChanged: (value) {
    setState(() => description = value);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String?` | `null` | Field label |
| `placeholder` | `String?` | `null` | Placeholder text |
| `value` | `String?` | `null` | Current value |
| `onChange` | `void Function(String)?` | `null` | Change handler |
| `rows` | `int` | `4` | Number of visible rows |
| `cols` | `int?` | `null` | Number of visible columns (affects initial width) |
| `disabled` | `bool` | `false` | Disable input |
| `required` | `bool` | `false` | Mark as required |
| `error` | `String?` | `null` | Error message |
| `helperText` | `String?` | `null` | Helper text below input |
| `resize` | `TextAreaResize` | `vertical` | Resize direction |
| `minWidth` | `String?` | `null` | Minimum width (e.g., '200px') |
| `maxWidth` | `String?` | `null` | Maximum width (e.g., '600px') |
| `minHeight` | `String?` | `null` | Minimum height (e.g., '100px') |
| `maxHeight` | `String?` | `null` | Maximum height (e.g., '400px') |
| `fullWidth` | `bool` | `true` | Whether to fill container width |
| `style` | `InputStyle?` | `null` | Input style preset |

## Row Configuration

Control the visible height:

```dart
// Small (2 rows)
ArcaneTextArea(
  label: 'Short note',
  rows: 2,
  onChanged: (v) {},
)

// Default (4 rows)
ArcaneTextArea(
  label: 'Description',
  rows: 4,
  onChanged: (v) {},
)

// Large (8 rows)
ArcaneTextArea(
  label: 'Full content',
  rows: 8,
  onChanged: (v) {},
)
```

## Resize Behavior

```dart
// Vertical only (default)
ArcaneTextArea(
  label: 'Notes',
  resize: TextAreaResize.vertical,
  onChanged: (v) {},
)

// Horizontal only
ArcaneTextArea(
  label: 'Code',
  resize: TextAreaResize.horizontal,
  onChanged: (v) {},
)

// Both directions
ArcaneTextArea(
  label: 'Flexible',
  resize: TextAreaResize.both,
  onChanged: (v) {},
)

// No resize
ArcaneTextArea(
  label: 'Fixed',
  resize: TextAreaResize.none,
  onChange: (v) {},
)
```

## Size Constraints

Control minimum and maximum dimensions when resizing:

```dart
// Constrained vertical resize
ArcaneTextArea(
  label: 'Notes',
  resize: TextAreaResize.vertical,
  minHeight: '100px',
  maxHeight: '400px',
  onChange: (v) {},
)

// Constrained horizontal resize
ArcaneTextArea(
  label: 'Wide content',
  resize: TextAreaResize.horizontal,
  minWidth: '300px',
  maxWidth: '800px',
  fullWidth: false,
  onChange: (v) {},
)

// Both directions with full constraints
ArcaneTextArea(
  label: 'Flexible editor',
  resize: TextAreaResize.both,
  minWidth: '200px',
  maxWidth: '100%',
  minHeight: '80px',
  maxHeight: '500px',
  onChange: (v) {},
)
```

## Character Limit

```dart
ArcaneTextArea(
  label: 'Bio',
  maxLength: 500,
  value: bio,
  hint: '${bio.length}/500 characters',
  onChanged: (v) => setState(() => bio = v),
)
```

## Validation

```dart
ArcaneTextArea(
  label: 'Message',
  value: message,
  isRequired: true,
  error: message.isEmpty ? 'Message is required' : null,
  onChanged: (v) => setState(() => message = v),
)
```

## Examples

### Comment Form

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.md,
  ),
  children: [
    ArcaneTextArea(
      placeholder: 'Write a comment...',
      rows: 3,
      value: comment,
      onChanged: (v) => setState(() => comment = v),
    ),
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        justifyContent: JustifyContent.flexEnd,
      ),
      children: [
        ArcaneButton.primary(
          label: 'Post Comment',
          isDisabled: comment.isEmpty,
          onPressed: postComment,
        ),
      ],
    ),
  ],
)
```

### Feedback Form

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.lg,
  ),
  children: [
    ArcaneTextInput(
      label: 'Subject',
      value: subject,
      onChanged: (v) => setState(() => subject = v),
    ),
    ArcaneTextArea(
      label: 'Message',
      placeholder: 'Describe your feedback in detail...',
      rows: 6,
      value: message,
      isRequired: true,
      hint: 'Be as specific as possible',
      onChanged: (v) => setState(() => message = v),
    ),
    ArcaneButton.primary(
      label: 'Submit Feedback',
      fullWidth: true,
      onPressed: submitFeedback,
    ),
  ],
)
```

### Code Input

```dart
ArcaneTextArea(
  label: 'JSON Configuration',
  rows: 10,
  resize: TextAreaResize.vertical,
  value: jsonConfig,
  styles: const ArcaneStyleData(
    fontFamily: FontFamily.mono,
    fontSize: FontSize.sm,
  ),
  onChanged: (v) => setState(() => jsonConfig = v),
)
```

### Read-Only Display

```dart
ArcaneTextArea(
  label: 'Terms and Conditions',
  value: termsText,
  rows: 8,
  isReadOnly: true,
  resize: TextAreaResize.none,
)
```

## Related Components

- [ArcaneTextInput](/arcane_jaspr/docs/inputs/arcane-text-input) - Single-line input
- [ArcaneForm](/arcane_jaspr/docs/forms/arcane-form) - Form container
