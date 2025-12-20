---
title: ArcaneField
description: Form field with label, input, and validation
layout: docs
component: field
---

# ArcaneField

A form field component that combines a label, input element, helper text, and validation message.

## Basic Usage

```dart
ArcaneField(
  label: 'Email',
  child: ArcaneTextInput(
    name: 'email',
    type: TextInputType.email,
  ),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Field label |
| `child` | `Component` | required | Input component |
| `helperText` | `String?` | `null` | Helper text below input |
| `error` | `String?` | `null` | Error message |
| `required` | `bool` | `false` | Show required indicator |
| `labelPosition` | `LabelPosition` | `top` | Label placement |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Label Positions

```dart
// Top (default)
ArcaneField(
  labelPosition: LabelPosition.top,
  label: 'Email',
  child: ArcaneTextInput(name: 'email'),
)

// Left (inline)
ArcaneField(
  labelPosition: LabelPosition.left,
  label: 'Email',
  child: ArcaneTextInput(name: 'email'),
)

// Floating
ArcaneField(
  labelPosition: LabelPosition.floating,
  label: 'Email',
  child: ArcaneTextInput(name: 'email'),
)
```

## With Helper Text

```dart
ArcaneField(
  label: 'Password',
  helperText: 'At least 8 characters with one number',
  child: ArcaneTextInput(
    name: 'password',
    type: TextInputType.password,
  ),
)
```

## With Error

```dart
ArcaneField(
  label: 'Email',
  error: emailError, // 'Please enter a valid email address'
  child: ArcaneTextInput(
    name: 'email',
    type: TextInputType.email,
    hasError: emailError != null,
  ),
)
```

## Required Field

```dart
ArcaneField(
  label: 'Full Name',
  required: true,
  child: ArcaneTextInput(name: 'fullName'),
)
```

## Examples

### Form with Fields

```dart
ArcaneForm(
  onSubmit: handleSubmit,
  child: ArcaneColumn(
    gap: Gap.lg,
    children: [
      ArcaneField(
        label: 'Full Name',
        required: true,
        child: ArcaneTextInput(
          name: 'fullName',
          placeholder: 'John Doe',
        ),
      ),
      ArcaneField(
        label: 'Email Address',
        required: true,
        helperText: 'We\'ll never share your email',
        child: ArcaneTextInput(
          name: 'email',
          type: TextInputType.email,
          placeholder: 'john@example.com',
        ),
      ),
      ArcaneField(
        label: 'Phone Number',
        helperText: 'Optional',
        child: ArcaneTextInput(
          name: 'phone',
          type: TextInputType.tel,
          placeholder: '+1 (555) 000-0000',
        ),
      ),
      ArcaneButton.primary(
        label: 'Submit',
        type: ButtonType.submit,
      ),
    ],
  ),
)
```

### Inline Label Layout

```dart
ArcaneCard(
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneField(
        labelPosition: LabelPosition.left,
        label: 'Username',
        child: ArcaneTextInput(name: 'username'),
      ),
      ArcaneField(
        labelPosition: LabelPosition.left,
        label: 'Email',
        child: ArcaneTextInput(name: 'email', type: TextInputType.email),
      ),
      ArcaneField(
        labelPosition: LabelPosition.left,
        label: 'Role',
        child: ArcaneSelect(
          name: 'role',
          options: roles,
        ),
      ),
    ],
  ),
)
```

### Validation States

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    // Default state
    ArcaneField(
      label: 'Default Field',
      child: ArcaneTextInput(name: 'default'),
    ),

    // With helper
    ArcaneField(
      label: 'With Helper',
      helperText: 'This is helper text',
      child: ArcaneTextInput(name: 'helper'),
    ),

    // Error state
    ArcaneField(
      label: 'With Error',
      error: 'This field has an error',
      child: ArcaneTextInput(name: 'error', hasError: true),
    ),

    // Required
    ArcaneField(
      label: 'Required Field',
      required: true,
      child: ArcaneTextInput(name: 'required'),
    ),
  ],
)
```

### Different Input Types

```dart
ArcaneColumn(
  gap: Gap.lg,
  children: [
    ArcaneField(
      label: 'Text Input',
      child: ArcaneTextInput(name: 'text'),
    ),
    ArcaneField(
      label: 'Text Area',
      child: ArcaneTextArea(name: 'textarea', rows: 4),
    ),
    ArcaneField(
      label: 'Select',
      child: ArcaneSelect(
        name: 'select',
        options: [
          SelectOption(value: '1', label: 'Option 1'),
          SelectOption(value: '2', label: 'Option 2'),
        ],
      ),
    ),
    ArcaneField(
      label: 'Checkbox',
      child: ArcaneCheckbox(
        label: 'I agree to the terms',
        name: 'agree',
      ),
    ),
  ],
)
```

### Complex Field Layout

```dart
ArcaneField(
  label: 'Price',
  helperText: 'Enter the item price in USD',
  child: ArcaneRow(
    gap: Gap.sm,
    children: [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          padding: PaddingPreset.md,
          backgroundColor: BackgroundColor.secondary,
          borderRadius: Radius.md,
        ),
        children: [ArcaneText('\$')],
      ),
      ArcaneTextInput(
        name: 'price',
        type: TextInputType.number,
        placeholder: '0.00',
      ),
    ],
  ),
)
```

### Grouped Fields

```dart
ArcaneColumn(
  gap: Gap.lg,
  children: [
    ArcaneHeading(text: 'Shipping Address', level: 3),
    ArcaneRow(
      gap: Gap.md,
      children: [
        ArcaneField(
          label: 'First Name',
          required: true,
          child: ArcaneTextInput(name: 'firstName'),
        ),
        ArcaneField(
          label: 'Last Name',
          required: true,
          child: ArcaneTextInput(name: 'lastName'),
        ),
      ],
    ),
    ArcaneField(
      label: 'Street Address',
      required: true,
      child: ArcaneTextInput(name: 'street'),
    ),
    ArcaneField(
      label: 'Apartment, suite, etc.',
      child: ArcaneTextInput(name: 'apt'),
    ),
    ArcaneRow(
      gap: Gap.md,
      children: [
        ArcaneField(
          label: 'City',
          required: true,
          child: ArcaneTextInput(name: 'city'),
        ),
        ArcaneField(
          label: 'State',
          required: true,
          child: ArcaneSelect(name: 'state', options: states),
        ),
        ArcaneField(
          label: 'ZIP Code',
          required: true,
          child: ArcaneTextInput(name: 'zip'),
        ),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneFieldWrapper](/docs/forms/arcane-field-wrapper) - Layout wrapper
- [ArcaneForm](/docs/forms/arcane-form) - Form container
- [ArcaneTextInput](/docs/inputs/arcane-text-input) - Text input
