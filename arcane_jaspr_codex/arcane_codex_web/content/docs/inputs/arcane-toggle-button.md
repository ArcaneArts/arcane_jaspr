---
title: ArcaneToggleButton
description: Button that toggles between on and off states
layout: docs
---

# ArcaneToggleButton

A button that toggles between active and inactive states, useful for toolbar buttons and feature toggles.

## Basic Usage

```dart
ArcaneToggleButton(
  isSelected: isActive,
  label: 'Bold',
  onChanged: (selected) {
    setState(() => isActive = selected);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isSelected` | `bool` | `false` | Current toggle state |
| `onChanged` | `ValueChanged<bool>?` | `null` | State change handler |
| `label` | `String?` | `null` | Button label |
| `icon` | `Component?` | `null` | Button icon |
| `size` | `ToggleButtonSize` | `medium` | Button size |
| `isDisabled` | `bool` | `false` | Disable interaction |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## With Icon

```dart
ArcaneToggleButton(
  isSelected: isBold,
  icon: span([text('B')]),
  onChanged: (v) => setState(() => isBold = v),
)
```

## With Label

```dart
ArcaneToggleButton(
  isSelected: showPreview,
  label: 'Preview',
  onChanged: (v) => setState(() => showPreview = v),
)
```

## With Icon and Label

```dart
ArcaneToggleButton(
  isSelected: isBookmarked,
  icon: span([text('⭐')]),
  label: 'Bookmark',
  onChanged: (v) => setState(() => isBookmarked = v),
)
```

## Sizes

```dart
// Small
ArcaneToggleButton(
  isSelected: isActive,
  label: 'Small',
  size: ToggleButtonSize.small,
  onChanged: (v) => setState(() => isActive = v),
)

// Medium (default)
ArcaneToggleButton(
  isSelected: isActive,
  label: 'Medium',
  size: ToggleButtonSize.medium,
  onChanged: (v) => setState(() => isActive = v),
)

// Large
ArcaneToggleButton(
  isSelected: isActive,
  label: 'Large',
  size: ToggleButtonSize.large,
  onChanged: (v) => setState(() => isActive = v),
)
```

## Examples

### Text Formatting Toolbar

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.xs,
    padding: PaddingPreset.sm,
    background: Background.surface,
    borderRadius: Radius.md,
  ),
  children: [
    ArcaneToggleButton(
      isSelected: isBold,
      icon: span([text('B')]),
      size: ToggleButtonSize.small,
      onChanged: (v) => setState(() => isBold = v),
    ),
    ArcaneToggleButton(
      isSelected: isItalic,
      icon: span([text('I')]),
      size: ToggleButtonSize.small,
      onChanged: (v) => setState(() => isItalic = v),
    ),
    ArcaneToggleButton(
      isSelected: isUnderline,
      icon: span([text('U')]),
      size: ToggleButtonSize.small,
      onChanged: (v) => setState(() => isUnderline = v),
    ),
    ArcaneToggleButton(
      isSelected: isStrikethrough,
      icon: span([text('S')]),
      size: ToggleButtonSize.small,
      onChanged: (v) => setState(() => isStrikethrough = v),
    ),
  ],
)
```

### View Mode Toggle

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.sm,
  ),
  children: [
    ArcaneToggleButton(
      isSelected: viewMode == 'grid',
      icon: span([text('⊞')]),
      label: 'Grid',
      onChanged: (v) {
        if (v) setState(() => viewMode = 'grid');
      },
    ),
    ArcaneToggleButton(
      isSelected: viewMode == 'list',
      icon: span([text('☰')]),
      label: 'List',
      onChanged: (v) {
        if (v) setState(() => viewMode = 'list');
      },
    ),
  ],
)
```

### Feature Toggle

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    justifyContent: JustifyContent.spaceBetween,
    alignItems: AlignItems.center,
    padding: PaddingPreset.md,
    background: Background.surface,
    borderRadius: Radius.lg,
  ),
  children: [
    ArcaneDiv(
      children: [
        ArcaneText('Auto-save'),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            fontSize: FontSize.sm,
            textColor: TextColor.muted,
          ),
          children: [ArcaneText('Automatically save changes')],
        ),
      ],
    ),
    ArcaneToggleButton(
      isSelected: autoSave,
      icon: span([text(autoSave ? '✓' : '✗')]),
      onChanged: (v) => setState(() => autoSave = v),
    ),
  ],
)
```

## Related Components

- [ArcaneToggleButtonGroup](/arcane_jaspr/docs/inputs/arcane-toggle-button-group) - Group of toggle buttons
- [ArcaneToggleSwitch](/arcane_jaspr/docs/inputs/arcane-toggle-switch) - Switch-style toggle
- [ArcaneCheckbox](/arcane_jaspr/docs/inputs/arcane-checkbox) - Checkbox toggle
