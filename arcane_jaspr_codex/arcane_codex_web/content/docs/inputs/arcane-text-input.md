---
title: ArcaneTextInput
description: Single-line text input field with validation and styling
layout: docs
component: text-input
---

# ArcaneTextInput

A styled text input field for single-line text entry. Supports labels, placeholders, validation, and various input types.

## Basic Usage

```dart
ArcaneTextInput(
  label: 'Email',
  placeholder: 'Enter your email',
  onChanged: (value) {
    print('Value: $value');
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String?` | `null` | Field label |
| `placeholder` | `String?` | `null` | Placeholder text |
| `value` | `String?` | `null` | Current value |
| `onChanged` | `ValueChanged<String>?` | `null` | Change handler |
| `onSubmit` | `ValueChanged<String>?` | `null` | Submit handler (Enter key) |
| `type` | `String` | `'text'` | Input type (text, email, password, etc.) |
| `isDisabled` | `bool` | `false` | Disable the input |
| `isReadOnly` | `bool` | `false` | Read-only mode |
| `isRequired` | `bool` | `false` | Mark as required |
| `error` | `String?` | `null` | Error message |
| `hint` | `String?` | `null` | Hint text below input |
| `prefix` | `Component?` | `null` | Prefix element |
| `suffix` | `Component?` | `null` | Suffix element |
| `maxLength` | `int?` | `null` | Maximum character length |
| `autofocus` | `bool` | `false` | Auto-focus on mount |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Input Types

Specify the HTML input type:

```dart
// Email
ArcaneTextInput(
  label: 'Email',
  type: 'email',
  placeholder: 'name@example.com',
)

// Password
ArcaneTextInput(
  label: 'Password',
  type: 'password',
  placeholder: 'Enter password',
)

// Number
ArcaneTextInput(
  label: 'Quantity',
  type: 'number',
  placeholder: '0',
)

// URL
ArcaneTextInput(
  label: 'Website',
  type: 'url',
  placeholder: 'https://',
)

// Phone
ArcaneTextInput(
  label: 'Phone',
  type: 'tel',
  placeholder: '+1 (555) 000-0000',
)
```

## Labels and Hints

### With Label

```dart
ArcaneTextInput(
  label: 'Username',
  placeholder: 'Choose a username',
  onChanged: (value) {},
)
```

### With Hint

```dart
ArcaneTextInput(
  label: 'Password',
  type: 'password',
  hint: 'Must be at least 8 characters',
  onChanged: (value) {},
)
```

### Required Field

```dart
ArcaneTextInput(
  label: 'Email',
  isRequired: true,
  placeholder: 'Required field',
  onChanged: (value) {},
)
```

## Validation and Errors

### Error State

```dart
ArcaneTextInput(
  label: 'Email',
  value: 'invalid-email',
  error: 'Please enter a valid email address',
  onChanged: (value) {},
)
```

### Dynamic Validation

```dart
String? emailError;

ArcaneTextInput(
  label: 'Email',
  error: emailError,
  onChanged: (value) {
    setState(() {
      if (!value.contains('@')) {
        emailError = 'Invalid email format';
      } else {
        emailError = null;
      }
    });
  },
)
```

## Prefix and Suffix

### Prefix Icon

```dart
ArcaneTextInput(
  label: 'Search',
  prefix: ArcaneDiv(
    styles: const ArcaneStyleData(
      padding: PaddingPreset.horizontalSm,
      textColor: TextColor.muted,
    ),
    children: [ArcaneText('🔍')],
  ),
  placeholder: 'Search...',
)
```

### Suffix Button

```dart
ArcaneTextInput(
  label: 'Password',
  type: showPassword ? 'text' : 'password',
  suffix: ArcaneIconButton(
    icon: ArcaneText(showPassword ? '👁' : '👁‍🗨'),
    onPressed: () => setState(() => showPassword = !showPassword),
  ),
)
```

### Currency Prefix

```dart
ArcaneTextInput(
  label: 'Amount',
  type: 'number',
  prefix: ArcaneDiv(
    styles: const ArcaneStyleData(
      padding: PaddingPreset.horizontalSm,
      textColor: TextColor.muted,
    ),
    children: [ArcaneText('\$')],
  ),
  placeholder: '0.00',
)
```

## States

### Disabled

```dart
ArcaneTextInput(
  label: 'Disabled Field',
  value: 'Cannot edit',
  isDisabled: true,
)
```

### Read-Only

```dart
ArcaneTextInput(
  label: 'Read Only',
  value: 'View only value',
  isReadOnly: true,
)
```

## Events

### On Change

```dart
ArcaneTextInput(
  label: 'Name',
  onChanged: (value) {
    setState(() => name = value);
  },
)
```

### On Submit

```dart
ArcaneTextInput(
  label: 'Search',
  onSubmit: (value) {
    performSearch(value);
  },
)
```

## Examples

### Login Form

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.lg,
    maxWidth: MaxWidth.form,
  ),
  children: [
    ArcaneTextInput(
      label: 'Email',
      type: 'email',
      placeholder: 'name@company.com',
      isRequired: true,
      onChanged: (value) => email = value,
    ),
    ArcaneTextInput(
      label: 'Password',
      type: 'password',
      placeholder: 'Enter password',
      isRequired: true,
      hint: 'Minimum 8 characters',
      onChanged: (value) => password = value,
    ),
    ArcaneButton.primary(
      label: 'Sign In',
      fullWidth: true,
      onPressed: handleLogin,
    ),
  ],
)
```

### Search with Clear Button

```dart
ArcaneTextInput(
  placeholder: 'Search...',
  value: searchQuery,
  prefix: ArcaneText('🔍'),
  suffix: searchQuery.isNotEmpty
      ? ArcaneIconButton(
          icon: ArcaneText('×'),
          onPressed: () => setState(() => searchQuery = ''),
        )
      : null,
  onChanged: (value) => setState(() => searchQuery = value),
  onSubmit: performSearch,
)
```

### Character Counter

```dart
ArcaneTextInput(
  label: 'Bio',
  maxLength: 160,
  value: bio,
  hint: '${bio.length}/160 characters',
  onChanged: (value) => setState(() => bio = value),
)
```

## Related Components

- [ArcaneTextArea](/arcane_jaspr/docs/inputs/arcane-text-area) - Multi-line text input
- [ArcaneSearch](/arcane_jaspr/docs/inputs/arcane-search) - Dedicated search input
- [ArcaneSelect](/arcane_jaspr/docs/inputs/arcane-select) - Dropdown selection
