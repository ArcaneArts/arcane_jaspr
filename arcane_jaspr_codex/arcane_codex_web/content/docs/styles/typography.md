---
title: Typography
description: Reference for font size, weight, family, and text styling enums
layout: docs
---

# Typography

These enums control text appearance including size, weight, family, and decoration.

## FontSize

Font size scale from extra small to mega display.

| Value | CSS Output | Use Case |
|-------|-----------|----------|
| `xs` | `12px` | Small labels, captions |
| `sm` | `14px` | Secondary text, metadata |
| `md` | `15px` | Default body text |
| `base` | `16px` | Standard body text |
| `lg` | `18px` | Emphasized text |
| `xl` | `20px` | Subheadings |
| `xl2` | `24px` | Section headings |
| `xl3` | `32px` | Page headings |
| `xl4` | `40px` | Large headings |
| `xl5` | `48px` | Display headings |
| `hero` | `56px` | Hero text |
| `mega` | `72px` | Mega display |
| `inherit` | `inherit` | Inherit from parent |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    fontSize: FontSize.xl2,
  ),
  children: [ArcaneText('Section Heading')],
)
```

## FontWeight

Font weight from normal to bold.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `normal` | `400` | Regular weight |
| `w500` | `500` | Medium weight |
| `w600` | `600` | Semi-bold |
| `bold` | `700` | Bold |

### Usage

```dart
ArcaneSpan(
  styles: const ArcaneStyleData(
    fontWeight: FontWeight.w600,
  ),
  child: ArcaneText('Semi-bold text'),
)
```

## FontFamily

Font family presets.

| Value | CSS Output | Use Case |
|-------|-----------|----------|
| `sans` | System sans-serif stack | Body text |
| `heading` | System sans-serif stack | Headings |
| `mono` | `Fira Code, JetBrains Mono, monospace` | Code |
| `inherit` | `inherit` | Inherit from parent |

### Usage

```dart
ArcaneSpan(
  styles: const ArcaneStyleData(
    fontFamily: FontFamily.mono,
    fontSize: FontSize.sm,
  ),
  child: ArcaneText('const value = 42;'),
)
```

## FontStyle

Font style (italic/normal).

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `normal` | `normal` | Normal style |
| `italic` | `italic` | Italic text |
| `oblique` | `oblique` | Oblique text |

## LineHeight

Line height scale.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `none` | `1` | No extra line height |
| `tight` | `1.1` | Tight spacing (headings) |
| `snug` | `1.25` | Slightly condensed |
| `normal` | `1.5` | Default body text |
| `relaxed` | `1.7` | Relaxed reading |
| `loose` | `2` | Very loose |

### Usage

```dart
ArcaneParagraph(
  styles: const ArcaneStyleData(
    lineHeight: LineHeight.relaxed,
  ),
  children: [ArcaneText('Long paragraph with comfortable reading spacing...')],
)
```

## LetterSpacing

Letter spacing adjustments.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `tighter` | `-0.05em` | Very tight |
| `tight` | `-0.02em` | Slightly tight |
| `normal` | `0` | Default spacing |
| `wide` | `0.05em` | Slightly wide |
| `wider` | `0.1em` | Wide |
| `widest` | `0.2em` | Very wide |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    fontSize: FontSize.xs,
    letterSpacing: LetterSpacing.wide,
    textTransform: TextTransform.uppercase,
  ),
  children: [ArcaneText('SECTION LABEL')],
)
```

## TextDecoration

Text decoration styles.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `none` | `none` | No decoration |
| `underline` | `underline` | Underlined text |
| `overline` | `overline` | Line above text |
| `lineThrough` | `line-through` | Strikethrough |

### Usage

```dart
ArcaneLink(
  href: '/docs',
  styles: const ArcaneStyleData(
    textDecoration: TextDecoration.none,
  ),
  child: ArcaneText('Link without underline'),
)
```

## TextTransform

Text case transformation.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `none` | `none` | No transformation |
| `uppercase` | `uppercase` | ALL CAPS |
| `lowercase` | `lowercase` | all lowercase |
| `capitalize` | `capitalize` | First Letter Caps |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    textTransform: TextTransform.uppercase,
  ),
  children: [ArcaneText('label')], // Renders as "LABEL"
)
```

## WhiteSpace

White space handling.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `normal` | `normal` | Collapse whitespace, wrap |
| `nowrap` | `nowrap` | Collapse whitespace, no wrap |
| `pre` | `pre` | Preserve whitespace, no wrap |
| `preWrap` | `pre-wrap` | Preserve whitespace, wrap |
| `preLine` | `pre-line` | Collapse spaces, preserve newlines |
| `breakSpaces` | `break-spaces` | Preserve all, wrap |

### Usage

```dart
ArcanePre(
  styles: const ArcaneStyleData(
    whiteSpace: WhiteSpace.pre,
    fontFamily: FontFamily.mono,
  ),
  children: [ArcaneText(codeContent)],
)
```

## WordBreak

Word breaking behavior.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `normal` | `normal` | Default behavior |
| `breakAll` | `break-all` | Break anywhere |
| `keepAll` | `keep-all` | No CJK breaks |
| `breakWord` | `break-word` | Break at word boundaries |

## TextColor

Semantic text colors. See the [Colors](/docs/styles/colors) page for the full list.

Common values:
- `primary` - Main text color
- `secondary` - Secondary text
- `muted` - Muted/disabled text
- `accent` - Accent color text
- `success` - Success text
- `warning` - Warning text
- `error` - Error text

### Usage

```dart
ArcaneText(
  'Important message',
  styles: const ArcaneStyleData(
    textColor: TextColor.accent,
    fontWeight: FontWeight.w600,
  ),
)
```

## Common Typography Patterns

### Page Heading

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    fontSize: FontSize.xl3,
    fontWeight: FontWeight.bold,
    lineHeight: LineHeight.tight,
    textColor: TextColor.primary,
    margin: MarginPreset.bottomLg,
  ),
  children: [ArcaneText('Page Title')],
)
```

### Section Label

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    fontSize: FontSize.xs,
    fontWeight: FontWeight.w600,
    textTransform: TextTransform.uppercase,
    letterSpacing: LetterSpacing.wide,
    textColor: TextColor.muted,
    margin: MarginPreset.bottomSm,
  ),
  children: [ArcaneText('Section')],
)
```

### Muted Caption

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    fontSize: FontSize.sm,
    textColor: TextColor.muted,
  ),
  children: [ArcaneText('Last updated 2 hours ago')],
)
```

### Code Inline

```dart
ArcaneSpan(
  styles: const ArcaneStyleData(
    fontFamily: FontFamily.mono,
    fontSize: FontSize.sm,
    raw: {
      'padding': '2px 6px',
      'background': 'var(--code-background)',
      'border-radius': '4px',
    },
  ),
  child: ArcaneText('npm install'),
)
```
