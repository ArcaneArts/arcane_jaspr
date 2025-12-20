---
title: ArcaneFieldWrapper
description: Layout wrapper for form field styling
layout: docs
component: field-wrapper
---

# ArcaneFieldWrapper

A layout wrapper component that provides consistent styling and spacing for form fields.

## Basic Usage

```dart
ArcaneFieldWrapper(
  child: ArcaneTextInput(
    label: 'Email',
    name: 'email',
  ),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Component` | required | Field content |
| `fullWidth` | `bool` | `true` | Full width layout |
| `spacing` | `FieldSpacing` | `normal` | Vertical spacing |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Spacing Options

```dart
// Compact spacing
ArcaneFieldWrapper(
  spacing: FieldSpacing.compact,
  child: ArcaneTextInput(label: 'Compact'),
)

// Normal spacing (default)
ArcaneFieldWrapper(
  spacing: FieldSpacing.normal,
  child: ArcaneTextInput(label: 'Normal'),
)

// Relaxed spacing
ArcaneFieldWrapper(
  spacing: FieldSpacing.relaxed,
  child: ArcaneTextInput(label: 'Relaxed'),
)
```

## Full Width

```dart
// Full width (default)
ArcaneFieldWrapper(
  fullWidth: true,
  child: ArcaneTextInput(label: 'Full Width'),
)

// Auto width
ArcaneFieldWrapper(
  fullWidth: false,
  child: ArcaneTextInput(label: 'Auto Width'),
)
```

## Examples

### Form with Wrapped Fields

```dart
ArcaneForm(
  onSubmit: handleSubmit,
  child: ArcaneColumn(
    children: [
      ArcaneFieldWrapper(
        child: ArcaneTextInput(
          label: 'Username',
          name: 'username',
          required: true,
        ),
      ),
      ArcaneFieldWrapper(
        child: ArcaneTextInput(
          label: 'Email',
          name: 'email',
          type: TextInputType.email,
          required: true,
        ),
      ),
      ArcaneFieldWrapper(
        child: ArcaneTextInput(
          label: 'Password',
          name: 'password',
          type: TextInputType.password,
          required: true,
        ),
      ),
      ArcaneButton.primary(
        label: 'Create Account',
        type: ButtonType.submit,
      ),
    ],
  ),
)
```

### Inline Fields

```dart
ArcaneRow(
  gap: Gap.md,
  children: [
    ArcaneFieldWrapper(
      fullWidth: false,
      child: ArcaneTextInput(
        label: 'First Name',
        name: 'firstName',
      ),
    ),
    ArcaneFieldWrapper(
      fullWidth: false,
      child: ArcaneTextInput(
        label: 'Last Name',
        name: 'lastName',
      ),
    ),
  ],
)
```

### Compact Form

```dart
ArcaneCard(
  child: ArcaneColumn(
    children: [
      ArcaneHeading(text: 'Quick Settings', level: 4),
      ArcaneFieldWrapper(
        spacing: FieldSpacing.compact,
        child: ArcaneSelect(
          label: 'Language',
          name: 'language',
          options: languages,
        ),
      ),
      ArcaneFieldWrapper(
        spacing: FieldSpacing.compact,
        child: ArcaneSelect(
          label: 'Timezone',
          name: 'timezone',
          options: timezones,
        ),
      ),
      ArcaneFieldWrapper(
        spacing: FieldSpacing.compact,
        child: ArcaneToggleSwitch(
          label: 'Dark Mode',
          name: 'darkMode',
        ),
      ),
    ],
  ),
)
```

### Mixed Spacing

```dart
ArcaneColumn(
  children: [
    // Section header
    ArcaneHeading(text: 'Account Details', level: 3),

    // Normal spacing for main fields
    ArcaneFieldWrapper(
      spacing: FieldSpacing.normal,
      child: ArcaneTextInput(
        label: 'Display Name',
        name: 'displayName',
      ),
    ),
    ArcaneFieldWrapper(
      spacing: FieldSpacing.normal,
      child: ArcaneTextArea(
        label: 'Bio',
        name: 'bio',
        rows: 3,
      ),
    ),

    // Relaxed spacing before section break
    ArcaneFieldWrapper(
      spacing: FieldSpacing.relaxed,
      child: ArcaneDivider(),
    ),

    // Section header
    ArcaneHeading(text: 'Preferences', level: 3),

    // Compact spacing for toggles
    ArcaneFieldWrapper(
      spacing: FieldSpacing.compact,
      child: ArcaneToggleSwitch(label: 'Email notifications', name: 'email'),
    ),
    ArcaneFieldWrapper(
      spacing: FieldSpacing.compact,
      child: ArcaneToggleSwitch(label: 'Push notifications', name: 'push'),
    ),
  ],
)
```

### Responsive Grid Layout

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.grid,
    raw: {
      'grid-template-columns': 'repeat(auto-fit, minmax(200px, 1fr))',
      'gap': 'var(--spacing-md)',
    },
  ),
  children: [
    ArcaneFieldWrapper(
      child: ArcaneTextInput(label: 'First Name', name: 'firstName'),
    ),
    ArcaneFieldWrapper(
      child: ArcaneTextInput(label: 'Last Name', name: 'lastName'),
    ),
    ArcaneFieldWrapper(
      child: ArcaneTextInput(label: 'Email', name: 'email'),
    ),
    ArcaneFieldWrapper(
      child: ArcaneTextInput(label: 'Phone', name: 'phone'),
    ),
  ],
)
```

### With Custom Styling

```dart
ArcaneFieldWrapper(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.md,
    backgroundColor: BackgroundColor.secondary,
    borderRadius: Radius.md,
  ),
  child: ArcaneColumn(
    gap: Gap.sm,
    children: [
      ArcaneText(
        'Promo Code',
        styles: const ArcaneStyleData(fontWeight: FontWeight.w500),
      ),
      ArcaneRow(
        gap: Gap.sm,
        children: [
          ArcaneTextInput(
            name: 'promoCode',
            placeholder: 'Enter code',
          ),
          ArcaneButton.secondary(
            label: 'Apply',
            onPressed: applyPromoCode,
          ),
        ],
      ),
    ],
  ),
)
```

### Nested Field Groups

```dart
ArcaneFieldWrapper(
  spacing: FieldSpacing.relaxed,
  child: ArcaneCard(
    child: ArcaneColumn(
      gap: Gap.md,
      children: [
        ArcaneHeading(text: 'Billing Address', level: 4),
        ArcaneRow(
          gap: Gap.md,
          children: [
            ArcaneFieldWrapper(
              spacing: FieldSpacing.compact,
              fullWidth: false,
              child: ArcaneTextInput(label: 'City', name: 'city'),
            ),
            ArcaneFieldWrapper(
              spacing: FieldSpacing.compact,
              fullWidth: false,
              child: ArcaneSelect(label: 'State', name: 'state', options: states),
            ),
            ArcaneFieldWrapper(
              spacing: FieldSpacing.compact,
              fullWidth: false,
              child: ArcaneTextInput(label: 'ZIP', name: 'zip'),
            ),
          ],
        ),
      ],
    ),
  ),
)
```

## Related Components

- [ArcaneField](/docs/forms/arcane-field) - Field with label and validation
- [ArcaneForm](/docs/forms/arcane-form) - Form container
- [ArcaneInputGroup](/docs/forms/arcane-input-group) - Grouped inputs
