---
title: Design Tokens
description: Reference for all Arcane UI design tokens
layout: docs
---

# Design Tokens

Arcane Jaspr uses a comprehensive design token system for consistent styling. These tokens are available as both Dart constants and CSS custom properties.

## Colors (ArcaneColors)

All colors are available as CSS variables with the `--arcane-` prefix.

### Brand & Accent Colors

| Token | CSS Variable | Description |
|-------|--------------|-------------|
| `accent` | `--arcane-accent` | Primary accent color |
| `accentHover` | `--arcane-accent-hover` | Accent hover state |
| `accentContainer` | `--arcane-accent-container` | Accent container background |
| `accentForeground` | `--arcane-accent-foreground` | Text on accent background |

### Status Colors

| Token | CSS Variable | Description |
|-------|--------------|-------------|
| `success` | `--arcane-success` | Success state |
| `successForeground` | `--arcane-success-foreground` | Text on success |
| `successHover` | `--arcane-success-hover` | Success hover |
| `successContainer` | `--arcane-success-container` | Success container |
| `warning` | `--arcane-warning` | Warning state |
| `error` | `--arcane-error` | Error/destructive state |
| `errorForeground` | `--arcane-error-foreground` | Text on error |
| `info` | `--arcane-info` | Info state |
| `infoForeground` | `--arcane-info-foreground` | Text on info |

### Surface Colors

| Token | CSS Variable | Description |
|-------|--------------|-------------|
| `background` | `--arcane-background` | Page background |
| `backgroundSecondary` | `--arcane-background-secondary` | Secondary background |
| `backgroundTertiary` | `--arcane-background-tertiary` | Tertiary background |
| `surface` | `--arcane-surface` | Surface/card background |
| `surfaceVariant` | `--arcane-surface-variant` | Alternate surface |
| `card` | `--arcane-card` | Card background |
| `cardForeground` | `--arcane-card-foreground` | Text on cards |
| `cardHover` | `--arcane-card-hover` | Card hover state |
| `cardAlt` | `--arcane-card-alt` | Alternate card |
| `input` | `--arcane-input` | Input background |
| `inputForeground` | `--arcane-input-foreground` | Input text |
| `navbar` | `--arcane-navbar` | Navigation bar |

### Text Colors

| Token | CSS Variable | Description |
|-------|--------------|-------------|
| `onBackground` | `--arcane-on-background` | Text on background |
| `onSurface` | `--arcane-on-surface` | Text on surface |
| `onSurfaceVariant` | `--arcane-on-surface-variant` | Secondary text |
| `muted` | `--arcane-muted` | Muted text |
| `mutedForeground` | `--arcane-muted-foreground` | Muted foreground |
| `textSubtle` | `--arcane-text-subtle` | Subtle text |
| `textFaint` | `--arcane-text-faint` | Faint text |

### Border Colors

| Token | CSS Variable | Description |
|-------|--------------|-------------|
| `border` | `--arcane-border` | Default border |
| `borderSubtle` | `--arcane-border-subtle` | Subtle border |
| `ring` | `--arcane-ring` | Focus ring |

### Special Colors

| Token | CSS Variable | Description |
|-------|--------------|-------------|
| `tooltip` | `--arcane-tooltip` | Tooltip background |
| `tooltipForeground` | `--arcane-tooltip-foreground` | Tooltip text |
| `codeBackground` | `--arcane-code-background` | Code block background |

### Neon Colors (Gaming)

| Token | CSS Variable | Description |
|-------|--------------|-------------|
| `neonPink` | `--arcane-neon-pink` | Neon pink |
| `neonCyan` | `--arcane-neon-cyan` | Neon cyan |
| `neonPurple` | `--arcane-neon-purple` | Neon purple |
| `neonGreen` | `--arcane-neon-green` | Neon green |
| `neonOrange` | `--arcane-neon-orange` | Neon orange |

## Spacing (ArcaneSpacing)

Consistent spacing scale for margins, padding, and gaps.

| Token | Value | Use Case |
|-------|-------|----------|
| `xs` | 4px | Tight spacing |
| `sm` | 8px | Small spacing |
| `md` | 16px | Default spacing |
| `lg` | 24px | Large spacing |
| `xl` | 32px | Extra large |
| `xxl` | 48px | Section spacing |
| `xxxl` | 64px | Large sections |
| `huge` | 96px | Hero sections |
| `massive` | 128px | Full sections |

### Special Spacing

| Token | Value | Use Case |
|-------|-------|----------|
| `sectionY` | 80px | Vertical section padding |
| `heroY` | 120px | Hero section padding |

## Typography (ArcaneTypography)

### Font Sizes

| Token | Value | Use Case |
|-------|-------|----------|
| `xs` | 12px | Small labels |
| `sm` | 14px | Secondary text |
| `md` | 15px | Default text |
| `base` | 16px | Body text |
| `lg` | 18px | Large text |
| `xl` | 20px | Subheadings |
| `xl2` | 24px | Headings |
| `xl3` | 32px | Large headings |
| `xl4` | 40px | Hero headings |
| `xl5` | 48px | Display text |
| `hero` | 56px | Hero text |
| `mega` | 72px | Mega display |

### Font Weights

| Token | Value | Description |
|-------|-------|-------------|
| `normal` | 400 | Regular weight |
| `w500` | 500 | Medium weight |
| `w600` | 600 | Semi-bold |
| `bold` | 700 | Bold |

### Font Families

| Token | Value | Use Case |
|-------|-------|----------|
| `sans` | System sans-serif | Body text |
| `heading` | System sans-serif | Headings |
| `mono` | Fira Code, JetBrains Mono | Code |

## Border Radius (ArcaneRadius)

| Token | Value | Description |
|-------|-------|-------------|
| `none` | 0 | No radius |
| `xs` | 4px | Extra small |
| `sm` | 6px | Small (theme-reactive) |
| `md` | 8px | Medium (theme-reactive) |
| `lg` | 12px | Large (theme-reactive) |
| `xl` | 16px | Extra large |
| `xxl` | 24px | Very large |
| `full` | 9999px | Pill shape |
| `circle` | 50% | Circle |

## Layout (ArcaneLayout)

### Max Widths

| Token | Value | Use Case |
|-------|-------|----------|
| `card` | 400px | Cards |
| `form` | 480px | Forms |
| `narrowText` | 560px | Narrow text |
| `text` | 640px | Text content |
| `narrow` | 768px | Narrow layouts |
| `content` | 1024px | Main content |
| `container` | 1280px | Page container |
| `full` | 1440px | Full width |

## Z-Index (ArcaneZIndex)

Semantic z-index layers for proper stacking.

| Token | Value | Use Case |
|-------|-------|----------|
| `below` | -1 | Below content |
| `base` | 0 | Base layer |
| `dropdown` | 1000 | Dropdown menus |
| `sticky` | 1020 | Sticky elements |
| `fixed` | 1030 | Fixed elements |
| `fab` | 1035 | Floating action buttons |
| `modalBackdrop` | 1040 | Modal backdrop |
| `modal` | 1050 | Modal dialogs |
| `popover` | 1060 | Popovers |
| `tooltip` | 1070 | Tooltips |
| `toast` | 1080 | Toast notifications |

## Effects (ArcaneEffects)

### Shadows

| Token | Description |
|-------|-------------|
| `none` | No shadow |
| `xs` | Extra small shadow |
| `sm` | Small shadow |
| `md` | Medium shadow |
| `lg` | Large shadow |
| `xl` | Extra large shadow |
| `card` | Card shadow |
| `glowAccent` | Accent glow |
| `glowSuccess` | Success glow |
| `glowError` | Error glow |

### Transitions

| Token | Duration | Description |
|-------|----------|-------------|
| `fast` | 150ms | Quick transitions |
| `normal` | 200ms | Default transitions |
| `slow` | 300ms | Slow transitions |

## Using Tokens

### In Dart

```dart
// Using spacing
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.lg,  // Uses ArcaneSpacing.lg
    gap: Gap.md,                // Uses ArcaneSpacing.md
  ),
)

// Using colors
ArcaneDiv(
  styles: const ArcaneStyleData(
    background: Background.surface,
    textColor: TextColor.primary,
  ),
)
```

### In CSS

```css
.my-component {
  padding: var(--arcane-spacing-lg);
  background: var(--arcane-surface);
  color: var(--arcane-text);
  border-radius: var(--arcane-radius-md);
  box-shadow: var(--arcane-shadow);
}
```

### Direct Access

```dart
// Access color values directly
final accentColor = ArcaneColors.accent;  // CSS variable reference

// Access spacing values
final spacing = ArcaneSpacing.lg;  // "24px"

// Access typography
final fontSize = ArcaneTypography.lg;  // "18px"
```
