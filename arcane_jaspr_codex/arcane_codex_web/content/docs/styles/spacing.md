---
title: Spacing
description: Reference for padding, margin, and gap enums
layout: docs
---

# Spacing

These enums provide consistent spacing throughout your application.

## Spacing

Base spacing scale used by other spacing enums.

| Value | CSS Output | Use Case |
|-------|-----------|----------|
| `none` | `0` | No spacing |
| `xs` | `4px` | Tight spacing |
| `sm` | `8px` | Small spacing |
| `md` | `16px` | Default spacing |
| `lg` | `24px` | Large spacing |
| `xl` | `32px` | Extra large |
| `xxl` | `48px` | Section spacing |
| `xxxl` | `64px` | Large sections |
| `huge` | `96px` | Hero sections |
| `massive` | `128px` | Full sections |

### Properties

```dart
Spacing.md.css    // "16px"
Spacing.md.value  // 16
```

## PaddingPreset

Preset padding configurations.

### Uniform Padding

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `none` | `0` | No padding |
| `xs` | `4px` | Extra small |
| `sm` | `8px` | Small |
| `md` | `16px` | Medium |
| `lg` | `24px` | Large |
| `xl` | `32px` | Extra large |
| `xxl` | `48px` | Double extra large |
| `xxxl` | `64px` | Triple extra large |

### Compound Padding (vertical horizontal)

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `xsMd` | `4px 16px` | Tight vertical, medium horizontal |
| `smMd` | `8px 16px` | Small vertical, medium horizontal |
| `mdLg` | `16px 24px` | Medium vertical, large horizontal |
| `lgXl` | `24px 32px` | Large vertical, extra large horizontal |
| `xsSm` | `4px 8px` | Tight compact |
| `smLg` | `8px 24px` | Small vertical, large horizontal |
| `mdXl` | `16px 32px` | Medium vertical, extra large horizontal |

### Button Padding

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `buttonSm` | `6px 12px` | Small button |
| `buttonMd` | `10px 20px` | Medium button |
| `buttonLg` | `14px 28px` | Large button |

### Semantic Padding

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `card` | `20px` | Card padding |
| `section` | `48px` | Section padding |
| `sectionY` | `80px 0` | Vertical section |
| `heroY` | `120px 0` | Hero section vertical |
| `hugeY` | `96px 0` | Huge vertical |

### Directional Padding

| Value | Description |
|-------|-------------|
| `horizontalSm` | `0 8px` |
| `horizontalMd` | `0 16px` |
| `horizontalLg` | `0 24px` |
| `horizontalXl` | `0 32px` |
| `verticalMd` | `16px 0` |
| `verticalLg` | `24px 0` |
| `topSm` | `8px 0 0 0` |
| `topMd` | `16px 0 0 0` |
| `topLg` | `24px 0 0 0` |
| `bottomMd` | `0 0 16px 0` |

### Compact Element Padding

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `badge` | `2px 8px` | Badge/tag styling |
| `inlineCode` | `2px 6px` | Inline code snippets |
| `chip` | `4px 12px` | Chip/pill elements |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.lg,
  ),
  children: [...],
)

// Button padding
ArcaneButton(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.buttonMd,
  ),
  label: 'Click Me',
)
```

## MarginPreset

Preset margin configurations.

### Uniform Margin

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `none` | `0` | No margin |
| `xs` | `4px` | Extra small |
| `sm` | `8px` | Small |
| `md` | `16px` | Medium |
| `lg` | `24px` | Large |
| `xl` | `32px` | Extra large |

### Auto Margins

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `autoX` | `0 auto` | Horizontal centering |
| `autoY` | `auto 0` | Vertical centering |
| `auto` | `auto` | All auto |

### Top Margins

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `topXs` | `4px 0 0 0` | Extra small top |
| `topSm` | `8px 0 0 0` | Small top |
| `topMd` | `16px 0 0 0` | Medium top |
| `topLg` | `24px 0 0 0` | Large top |
| `topXl` | `32px 0 0 0` | Extra large top |
| `topXxl` | `48px 0 0 0` | Double extra large top |

### Bottom Margins

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `bottomXs` | `0 0 4px 0` | Extra small bottom |
| `bottomSm` | `0 0 8px 0` | Small bottom |
| `bottomMd` | `0 0 16px 0` | Medium bottom |
| `bottomLg` | `0 0 24px 0` | Large bottom |
| `bottomXl` | `0 0 32px 0` | Extra large bottom |
| `bottomXxl` | `0 0 48px 0` | Double extra large bottom |
| `bottomXxxl` | `0 0 64px 0` | Triple extra large bottom |

### Axis Margins

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `verticalSm` | `8px 0` | Small vertical |
| `verticalMd` | `16px 0` | Medium vertical |
| `verticalLg` | `24px 0` | Large vertical |
| `verticalXl` | `32px 0` | Extra large vertical |
| `horizontalSm` | `0 8px` | Small horizontal |
| `horizontalMd` | `0 16px` | Medium horizontal |
| `horizontalLg` | `0 24px` | Large horizontal |

### Directional Margins

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `rightSm` | `0 8px 0 0` | Small right |
| `rightMd` | `0 16px 0 0` | Medium right |
| `rightLg` | `0 24px 0 0` | Large right |
| `leftSm` | `0 0 0 8px` | Small left |
| `leftMd` | `0 0 0 16px` | Medium left |
| `leftLg` | `0 0 0 24px` | Large left |

### Centered Bottom Margins

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `centerBottomMd` | `0 auto 16px auto` | Centered with medium bottom |
| `centerBottomLg` | `0 auto 24px auto` | Centered with large bottom |
| `centerBottomXl` | `0 auto 32px auto` | Centered with extra large bottom |
| `centerBottomXxl` | `0 auto 48px auto` | Centered with double extra large bottom |

### Usage

```dart
// Center a container
ArcaneDiv(
  styles: const ArcaneStyleData(
    maxWidth: MaxWidth.content,
    margin: MarginPreset.autoX,
  ),
  children: [...],
)

// Space between sections
ArcaneSection(
  styles: const ArcaneStyleData(
    margin: MarginPreset.bottomXl,
  ),
  children: [...],
)
```

## Gap

Flex/Grid gap values.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `none` | `0` | No gap |
| `xs` | `4px` | Extra small |
| `sm` | `8px` | Small |
| `md` | `16px` | Medium |
| `lg` | `24px` | Large |
| `xl` | `32px` | Extra large |
| `xxl` | `48px` | Double extra large |
| `xxxl` | `64px` | Triple extra large |

### Properties

```dart
Gap.md.css    // "16px"
Gap.md.value  // 16
```

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.md,
  ),
  children: [...],
)

// Grid gap
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.grid,
    gap: Gap.lg,
  ),
  children: [...],
)
```

## Common Patterns

### Card Layout

```dart
ArcaneCard(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.lg,
    margin: MarginPreset.bottomMd,
  ),
  children: [...],
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
    ArcaneButton(label: 'Cancel'),
    ArcaneButton.primary(label: 'Save'),
  ],
)
```

### Page Container

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    maxWidth: MaxWidth.container,
    margin: MarginPreset.autoX,
    padding: PaddingPreset.xl,
  ),
  children: [...],
)
```

### Section Spacing

```dart
ArcaneSection(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.sectionY,
  ),
  children: [...],
)
```
