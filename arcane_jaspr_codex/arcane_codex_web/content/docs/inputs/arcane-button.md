---
title: ArcaneButton
description: Interactive button component with multiple variants and sizes
layout: docs
---

# ArcaneButton

A versatile button component for user interactions. Supports multiple variants, sizes, icons, and loading states.

## Basic Usage

```dart
ArcaneButton(
  label: 'Click Me',
  onPressed: () {
    print('Button clicked!');
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Button text label |
| `onPressed` | `VoidCallback?` | `null` | Click handler. Null disables the button |
| `size` | `ButtonSize` | `medium` | Button size |
| `variant` | `ButtonVariant` | `secondary` | Visual variant |
| `icon` | `Component?` | `null` | Leading icon |
| `trailingIcon` | `Component?` | `null` | Trailing icon |
| `isLoading` | `bool` | `false` | Show loading spinner |
| `isDisabled` | `bool` | `false` | Disable the button |
| `fullWidth` | `bool` | `false` | Expand to full width |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Variants

ArcaneButton provides named constructors for common variants:

### Primary Button

High-emphasis button for primary actions.

```dart
ArcaneButton.primary(
  label: 'Save Changes',
  onPressed: () {},
)
```

### Secondary Button

Medium-emphasis button for secondary actions.

```dart
ArcaneButton.secondary(
  label: 'Cancel',
  onPressed: () {},
)
```

### Destructive Button

For dangerous or destructive actions.

```dart
ArcaneButton.destructive(
  label: 'Delete Account',
  onPressed: () {},
)
```

### Ghost Button

Minimal button with no background.

```dart
ArcaneButton.ghost(
  label: 'Learn More',
  onPressed: () {},
)
```

### Outline Button

Bordered button with transparent background.

```dart
ArcaneButton.outline(
  label: 'View Details',
  onPressed: () {},
)
```

### Link Button

Text-only button styled as a link.

```dart
ArcaneButton.link(
  label: 'Terms & Conditions',
  onPressed: () {},
)
```

## Sizes

Control button size with `ButtonSize`:

```dart
// Extra small
ArcaneButton(
  label: 'XS',
  size: ButtonSize.xsmall,
  onPressed: () {},
)

// Small
ArcaneButton(
  label: 'Small',
  size: ButtonSize.small,
  onPressed: () {},
)

// Medium (default)
ArcaneButton(
  label: 'Medium',
  size: ButtonSize.medium,
  onPressed: () {},
)

// Large
ArcaneButton(
  label: 'Large',
  size: ButtonSize.large,
  onPressed: () {},
)
```

### ButtonSize Values

| Value | Description |
|-------|-------------|
| `xsmall` | Extra small, compact |
| `small` | Small button |
| `medium` | Default size |
| `large` | Large button |

## Icons

Add icons before or after the label:

### Leading Icon

```dart
ArcaneButton.primary(
  icon: span([text('→')]),
  label: 'Continue',
  onPressed: () {},
)
```

### Trailing Icon

```dart
ArcaneButton(
  label: 'Download',
  trailingIcon: span([text('↓')]),
  onPressed: () {},
)
```

### Both Icons

```dart
ArcaneButton(
  icon: span([text('←')]),
  label: 'Navigate',
  trailingIcon: span([text('→')]),
  onPressed: () {},
)
```

## States

### Loading State

Show a loading spinner:

```dart
ArcaneButton.primary(
  label: 'Saving...',
  isLoading: true,
  onPressed: () {},
)
```

### Disabled State

Disable interaction:

```dart
ArcaneButton(
  label: 'Disabled',
  isDisabled: true,
  onPressed: () {},
)

// Or pass null to onPressed
ArcaneButton(
  label: 'Also Disabled',
  onPressed: null,
)
```

### Full Width

Expand to container width:

```dart
ArcaneButton.primary(
  label: 'Full Width Button',
  fullWidth: true,
  onPressed: () {},
)
```

## Custom Styling

Override default styles:

```dart
ArcaneButton(
  label: 'Custom',
  styles: const ArcaneStyleData(
    borderRadius: Radius.full,
    shadow: Shadow.glowAccent,
  ),
  onPressed: () {},
)
```

## Examples

### Form Submit Button

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.md,
    justifyContent: JustifyContent.flexEnd,
  ),
  children: [
    ArcaneButton.ghost(
      label: 'Cancel',
      onPressed: () => Navigator.pop(context),
    ),
    ArcaneButton.primary(
      label: isSubmitting ? 'Saving...' : 'Save',
      isLoading: isSubmitting,
      onPressed: isSubmitting ? null : handleSubmit,
    ),
  ],
)
```

### Button Group

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.sm,
  ),
  children: [
    ArcaneButton.outline(label: 'Day', onPressed: () {}),
    ArcaneButton.primary(label: 'Week', onPressed: () {}),
    ArcaneButton.outline(label: 'Month', onPressed: () {}),
  ],
)
```

### Destructive Action with Confirmation

```dart
ArcaneButton.destructive(
  icon: span([text('🗑')]),
  label: 'Delete Project',
  onPressed: () {
    showConfirmDialog(
      title: 'Delete Project?',
      message: 'This action cannot be undone.',
      onConfirm: deleteProject,
    );
  },
)
```

### Icon-Only Button

For icon-only buttons, use `ArcaneIconButton` instead:

```dart
ArcaneIconButton(
  icon: span([text('×')]),
  onPressed: () {},
)
```

## Related Components

- [ArcaneIconButton](/docs/inputs/arcane-icon-button) - Icon-only buttons
- [ArcaneCloseButton](/docs/inputs/arcane-close-button) - Close/dismiss button
- [ArcaneFAB](/docs/inputs/arcane-fab) - Floating action button
- [ArcaneToggleButton](/docs/inputs/arcane-toggle-button) - Toggle button
