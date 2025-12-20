---
title: ArcaneCheckbox
description: Checkbox input for boolean selections
layout: docs
---

# ArcaneCheckbox

A styled checkbox component for boolean on/off selections. Supports labels, disabled states, and custom styling.

## Basic Usage

```dart
ArcaneCheckbox(
  value: isChecked,
  onChanged: (value) {
    setState(() => isChecked = value);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `bool` | `false` | Current checked state |
| `onChanged` | `ValueChanged<bool>?` | `null` | Change handler |
| `label` | `String?` | `null` | Label text |
| `isDisabled` | `bool` | `false` | Disable interaction |
| `size` | `CheckboxSize` | `medium` | Checkbox size |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## With Label

```dart
ArcaneCheckbox(
  label: 'I agree to the terms and conditions',
  value: agreedToTerms,
  onChanged: (value) {
    setState(() => agreedToTerms = value);
  },
)
```

## Sizes

```dart
// Small
ArcaneCheckbox(
  size: CheckboxSize.small,
  value: isChecked,
  onChanged: (value) {},
)

// Medium (default)
ArcaneCheckbox(
  size: CheckboxSize.medium,
  value: isChecked,
  onChanged: (value) {},
)

// Large
ArcaneCheckbox(
  size: CheckboxSize.large,
  value: isChecked,
  onChanged: (value) {},
)
```

## States

### Disabled

```dart
ArcaneCheckbox(
  label: 'Cannot change',
  value: true,
  isDisabled: true,
)
```

### Read-Only (via null handler)

```dart
ArcaneCheckbox(
  label: 'Read only',
  value: true,
  onChanged: null,
)
```

## Examples

### Settings List

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.md,
  ),
  children: [
    ArcaneCheckbox(
      label: 'Enable notifications',
      value: notifications,
      onChanged: (v) => setState(() => notifications = v),
    ),
    ArcaneCheckbox(
      label: 'Dark mode',
      value: darkMode,
      onChanged: (v) => setState(() => darkMode = v),
    ),
    ArcaneCheckbox(
      label: 'Auto-save',
      value: autoSave,
      onChanged: (v) => setState(() => autoSave = v),
    ),
  ],
)
```

### Terms Agreement

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.lg,
  ),
  children: [
    ArcaneCheckbox(
      label: 'I agree to the Terms of Service',
      value: agreedToTerms,
      onChanged: (v) => setState(() => agreedToTerms = v),
    ),
    ArcaneCheckbox(
      label: 'I agree to the Privacy Policy',
      value: agreedToPrivacy,
      onChanged: (v) => setState(() => agreedToPrivacy = v),
    ),
    ArcaneButton.primary(
      label: 'Continue',
      isDisabled: !agreedToTerms || !agreedToPrivacy,
      onPressed: handleContinue,
    ),
  ],
)
```

### Multiple Selection

```dart
class MultiSelect extends StatefulComponent {
  final List<String> options = ['Option A', 'Option B', 'Option C'];
  final Set<String> selected = {};

  @override
  Iterable<Component> build(BuildContext context) sync* {
    for (final option in options) {
      yield ArcaneCheckbox(
        label: option,
        value: selected.contains(option),
        onChanged: (checked) {
          setState(() {
            if (checked) {
              selected.add(option);
            } else {
              selected.remove(option);
            }
          });
        },
      );
    }
  }
}
```

## Related Components

- [ArcaneRadio](/docs/inputs/arcane-radio) - Single selection from options
- [ArcaneToggleSwitch](/docs/inputs/arcane-toggle-switch) - Toggle switch
- [ArcaneToggleButton](/docs/inputs/arcane-toggle-button) - Toggle button
