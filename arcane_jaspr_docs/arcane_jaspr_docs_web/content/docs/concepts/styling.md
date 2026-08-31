---
title: Styling
description: Learn how to style components using ArcaneStyleData
layout: kb
component: styling
---

# Styling

Arcane Jaspr uses `ArcaneStyleData` for declarative, type-safe styling. This approach provides autocomplete, compile-time checking, and consistent design tokens.

## ArcaneStyleData

The `ArcaneStyleData` class is the foundation of all styling in Arcane Jaspr. It converts typed properties into CSS.

### Basic Usage

```dart
ArcaneBox(
  style: const ArcaneStyleData(
    display: Display.flex,
    padding: PaddingPreset.lg,
    gap: Gap.md,
    background: Background.surface,
    borderRadius: Radius.md,
  ),
  children: [...],
)
```

### Using Custom Values

Some layout properties accept a named custom value while keeping the supported
CSS property explicit:

```dart
ArcaneBox(
  style: const ArcaneStyleData(
    display: Display.flex,
    gridColumnsCustom: 'repeat(3, minmax(0, 1fr))',
    gapCustom: 'clamp(12px, 2vw, 24px)',
  ),
  children: [...],
)
```

`ArcaneStyleData` intentionally has no raw property map and no custom shadow,
filter, or animation fields. `backgroundCustom` accepts flat colors and tokens;
literal gradient functions are rejected.

## Static Presets

ArcaneStyleData provides static presets for common layouts:

### Row Layout

```dart
ArcaneBox(
  style: ArcaneStyleData.row,  // Flex row with center alignment
  children: [...],
)
```

### Row with Space Between

```dart
ArcaneBox(
  style: ArcaneStyleData.rowSpaced,  // Flex row with space-between
  children: [...],
)
```

### Column Layout

```dart
ArcaneBox(
  style: ArcaneStyleData.column,  // Flex column
  children: [...],
)
```

### Centered Content

```dart
ArcaneBox(
  style: ArcaneStyleData.flexCenter,  // Centered on both axes
  children: [...],
)
```

### Full Size

```dart
ArcaneBox(
  style: ArcaneStyleData.fullSize,  // 100% width and height
  children: [...],
)
```

### Absolute Fill

```dart
ArcaneBox(
  style: ArcaneStyleData.absoluteFill,  // Absolute position, inset 0
  children: [...],
)
```

## Merging Styles

Combine multiple style data objects with `merge()`:

```dart
final baseStyles = const ArcaneStyleData(
  padding: PaddingPreset.md,
  borderRadius: Radius.md,
);

final activeStyles = const ArcaneStyleData(
  background: Background.accent,
  textColor: TextColor.onPrimary,
);

ArcaneBox(
  styles: isActive ? baseStyles.merge(activeStyles) : baseStyles,
  children: [...],
)
```

## Copying Styles

Create modified copies with `copyWith()`:

```dart
final styles = const ArcaneStyleData(
  padding: PaddingPreset.md,
  background: Background.surface,
);

final modifiedStyles = styles.copyWith(
  padding: PaddingPreset.lg,
);
```

## Converting to CSS

### As Styles Object

```dart
final jaspStyles = styleData.toStyles();
```

### As CSS Map

```dart
final cssMap = styleData.toMap();
// Returns Map<String, String>
```

## Key Properties

### Layout Properties

| Property | Type | Description |
|----------|------|-------------|
| `display` | `Display` | Display mode (flex, grid, block, etc.) |
| `position` | `Position` | Positioning (relative, absolute, fixed, etc.) |
| `flexDirection` | `FlexDirection` | Flex direction |
| `flexWrap` | `FlexWrap` | Flex wrapping |
| `alignItems` | `AlignItems` | Cross-axis alignment |
| `justifyContent` | `JustifyContent` | Main-axis alignment |
| `flexGrow` | `int` | Flex grow factor |
| `flexShrink` | `int` | Flex shrink factor |

### Spacing Properties

| Property | Type | Description |
|----------|------|-------------|
| `padding` | `PaddingPreset` | Padding preset |
| `margin` | `MarginPreset` | Margin preset |
| `gap` | `Gap` | Flex/grid gap |

### Sizing Properties

| Property | Type | Description |
|----------|------|-------------|
| `width` | `Size` | Width preset |
| `height` | `Size` | Height preset |
| `maxWidth` | `MaxWidth` | Maximum width |
| `minHeight` | `String` | Minimum height |
| `widthCustom` | `String` | Custom width value |
| `heightCustom` | `String` | Custom height value |

### Typography Properties

| Property | Type | Description |
|----------|------|-------------|
| `fontSize` | `FontSize` | Font size |
| `fontWeight` | `FontWeight` | Font weight |
| `fontFamily` | `FontFamily` | Font family |
| `lineHeight` | `LineHeight` | Line height |
| `letterSpacing` | `LetterSpacing` | Letter spacing |
| `textColor` | `TextColor` | Text color |
| `textDecoration` | `TextDecoration` | Text decoration |
| `textTransform` | `TextTransform` | Text transform |

### Visual Properties

| Property | Type | Description |
|----------|------|-------------|
| `background` | `Background` | Background color |
| `borderRadius` | `Radius` | Border radius |
| `border` | `BorderPreset` | Border style |
| `shadow` | `Shadow` | Box shadow |
| `opacity` | `Opacity` | Opacity |

### Effects Properties

| Property | Type | Description |
|----------|------|-------------|
| `transition` | `Transition` | CSS transition |
| `transform` | `Transform` | CSS transform |
| `cursor` | `Cursor` | Mouse cursor |
| `overflow` | `Overflow` | Overflow behavior |

## Example: Card Styling

```dart
ArcaneBox(
  style: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    padding: PaddingPreset.lg,
    gap: Gap.md,
    background: Background.card,
    borderRadius: Radius.md,
    border: BorderPreset.subtle,
    shadow: Shadow.md,
    transition: Transition.allFast,
  ),
  children: [
    Text.heading2('Card Title'),
    Text.body('Card content goes here.'),
  ],
)
```

## Example: Interactive Button

```dart
ArcaneBox(
  style: ArcaneStyleData(
    display: Display.inlineFlex,
    alignItems: AlignItems.center,
    justifyContent: JustifyContent.center,
    padding: PaddingPreset.buttonMd,
    background: isHovered ? Background.accentContainer : Background.accent,
    textColor: TextColor.onPrimary,
    borderRadius: Radius.md,
    cursor: Cursor.pointer,
    transition: Transition.allFast,
    fontWeight: FontWeight.w500,
  ),
  children: [Text('Click Me')],
)
```

## Example: Responsive Layout

```dart
ArcaneBox(
  style: const ArcaneStyleData(
    display: Display.grid,
    gap: Gap.lg,
    padding: PaddingPreset.xl,
    gridColumnsCustom: 'repeat(auto-fit, minmax(300px, 1fr))',
  ),
  children: [
    // Grid items...
  ],
)
```
