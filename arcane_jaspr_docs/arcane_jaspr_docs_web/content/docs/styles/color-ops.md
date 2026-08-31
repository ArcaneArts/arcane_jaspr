---
title: Color Operations
description: Opacity and blend helpers for any CSS color string via the ArcaneColorOps extension
layout: kb
---

# Color Operations

`ArcaneColorOps` is an extension on `String` that adds opacity and blend helpers to CSS colors. It accepts hex values, theme variables, `ArcaneColor.*.css` tokens, and runtime accents.

Source: `lib/util/style_types/colors.dart`

## The problem it replaces

The historic `${color}30` hex-alpha suffix hack only works on plain hex colors. Applied to anything else it produces invalid CSS:

```dart
// Broken: 'var(--primary)30' is not a valid color.
final String faded = '${accent}30';
```

Hand-writing `color-mix(...)` works but is verbose and easy to get wrong:

```dart
// Correct but repetitive.
final String faded = 'color-mix(in srgb, var(--primary) 30%, transparent)';
```

`ArcaneColorOps` gives you both correctly and concisely.

## .opacity(double amount)

Fades a color toward transparent. `amount` is clamped to `0.0..1.0`.

```dart
'var(--primary)'.opacity(0.3);
// -> color-mix(in srgb, var(--primary) 30%, transparent)
```

It works on hex, variables, and tokens alike:

```dart
'#4CAF50'.opacity(0.15);        // color-mix(in srgb, #4CAF50 15%, transparent)
'var(--foreground)'.opacity(0.6);
Colors.emerald500.css.opacity(0.5);
```

## .on(String base, double amount)

Blends `amount` of this color over `base`, keeping alpha at `1`.

```dart
'#000'.on('var(--card)', 0.1);
// -> color-mix(in srgb, #000 10%, var(--card))
```

Use it to darken or tint a surface without introducing transparency:

```dart
'var(--primary)'.on('var(--background)', 0.08); // a faint primary wash
```

## Using it in components

The helpers return plain CSS strings for decoration colors, `styles:` raw maps, and the card family's `accentColor` fields:

```dart
Card(
  decoration: ArcaneDecoration(
    color: 'var(--primary)'.opacity(0.08),
    border: '1px solid ${'var(--primary)'.opacity(0.4)}',
  ),
  child: const Text.body('Tinted surface, valid on every color form.'),
)
```

```dart
FeatureCard(
  title: 'Fast',
  description: 'Builds in seconds.',
  accentColor: 'var(--primary)'.opacity(0.9),
)
```

## Precision

The mix percentage keeps one decimal, so small values do not quantize away and whole numbers stay clean:

```dart
'#fff'.opacity(0.125); // color-mix(in srgb, #fff 12.5%, transparent)
'#fff'.opacity(0.3);   // color-mix(in srgb, #fff 30%, transparent)
```
