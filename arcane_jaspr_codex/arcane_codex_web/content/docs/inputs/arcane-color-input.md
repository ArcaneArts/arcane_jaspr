---
title: ArcaneColorInput
description: Color picker input with presets
layout: docs
component: color-input
---

# ArcaneColorInput

A color picker component with swatch display, hex input, and preset color options.

## Basic Usage

```dart
ArcaneColorInput(
  value: '#10b981',
  onChanged: (color) {
    setState(() => selectedColor = color);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `String` | required | Current color (hex) |
| `onChanged` | `ValueChanged<String>?` | `null` | Color change callback |
| `style` | `ColorInputStyle` | `withInput` | Visual style |
| `size` | `ColorInputSize` | `md` | Size variant |
| `label` | `String?` | `null` | Label text |
| `presets` | `List<String>?` | `null` | Preset color swatches |
| `showAlpha` | `bool` | `false` | Show alpha channel |
| `disabled` | `bool` | `false` | Disable interaction |

## Style Variants

```dart
// Swatch only
ArcaneColorInput(
  value: color,
  style: ColorInputStyle.swatch,
  onChanged: onChanged,
)

// With input (default)
ArcaneColorInput(
  value: color,
  style: ColorInputStyle.withInput,
  onChanged: onChanged,
)

// Inline
ArcaneColorInput(
  value: color,
  style: ColorInputStyle.inline,
  onChanged: onChanged,
)
```

## With Label

```dart
ArcaneColorInput(
  value: primaryColor,
  label: 'Primary Color',
  onChanged: (c) => setState(() => primaryColor = c),
)
```

## Custom Presets

```dart
ArcaneColorInput(
  value: brandColor,
  presets: [
    '#3b82f6', // Blue
    '#10b981', // Green
    '#f59e0b', // Yellow
    '#ef4444', // Red
    '#8b5cf6', // Purple
  ],
  onChanged: (c) => setState(() => brandColor = c),
)
```

## Examples

### Theme Color Picker

```dart
ArcaneColumn(
  gapSize: Gap.lg,
  children: [
    ArcaneColorInput(
      value: primaryColor,
      label: 'Primary Color',
      onChanged: (c) => setState(() => primaryColor = c),
    ),
    ArcaneColorInput(
      value: secondaryColor,
      label: 'Secondary Color',
      onChanged: (c) => setState(() => secondaryColor = c),
    ),
    ArcaneColorInput(
      value: accentColor,
      label: 'Accent Color',
      onChanged: (c) => setState(() => accentColor = c),
    ),
  ],
)
```

### Brand Colors Panel

```dart
ArcaneSection(
  header: 'Brand Colors',
  children: [
    ArcaneRow(
      gapSize: Gap.lg,
      children: [
        ArcaneColorInput(
          value: brandPrimary,
          label: 'Primary',
          size: ColorInputSize.lg,
          presets: brandPresets,
          onChanged: (c) => setState(() => brandPrimary = c),
        ),
        ArcaneDiv(
          styles: ArcaneStyleData(
            widthCustom: '100px',
            heightCustom: '100px',
            borderRadius: Radius.lg,
            raw: {'background': brandPrimary},
          ),
          children: [],
        ),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneTextInput](/arcane_jaspr/docs/inputs/arcane-text-input) - Text input
- [ArcaneSlider](/arcane_jaspr/docs/inputs/arcane-slider) - Slider input
