---
title: Authoring like Flutter
description: Semantic decoration interpreted by each theme, plus bounded literal overrides
layout: kb
---

# Authoring like Flutter

Arcane Jaspr lets you decorate a single component instance and have every stylesheet render it in its own idiom. You describe *intent*; the active theme decides how that intent looks. This is the permeability model, and it is what keeps app code portable across Shadcn, Neon, and Neubrutalism without branching on the theme.

Two per-instance surfaces sit on every decoratable component (`Card`, `Button`, the card family, and more):

| Surface | Type | Role | Behavior |
|---------|------|------|----------|
| `decoration:` | `ArcaneDecoration?` | **Primary** | Semantic and theme-interpreted. The theme maps intent (like elevation) to its own visual language. |
| `styles:` | `ArcaneStyleData?` | **Bounded override** | Typed literal values. Applied last without exposing arbitrary CSS maps. |

Reach for `decoration:` first. It is the surface that stays portable. Use
`styles:` only when a supported literal value must override the theme. Raw CSS,
custom filters, custom shadows, custom animations, and gradient backgrounds are
not part of this public surface.

## ArcaneDecoration

`ArcaneDecoration` is the semantic, theme-permeable surface. Its fields fall into three buckets.

Source: `lib/core/decoration/arcane_decoration.dart`

### Universal fields

Universal fields render literally and identically on every theme. They are compiled straight to CSS by `universalStyles()`.

| Field | Type | Notes |
|-------|------|-------|
| `color` | `String?` | Background color as a CSS string (hex, `var(--x)`, an `ArcaneColor.*.css` token, or a runtime accent). |
| `borderRadius` | `Radius?` | Typed bounded radius token (`Radius.xs`, `Radius.sm`, or `Radius.md`). |
| `border` | `String?` | Full CSS `border` shorthand (e.g. `'1px solid var(--border)'`). |
| `padding` | `EdgeInsets?` | Typed insets (`EdgeInsets.all`, `EdgeInsets.symmetric`, `EdgeInsets.only`). |
| `paddingCustom` | `String?` | Literal padding string. |

```dart
Card(
  decoration: const ArcaneDecoration(
    color: 'var(--card)',
    borderRadius: Radius.md,
    border: '1px solid var(--border)',
    padding: EdgeInsets.all(24),
  ),
  child: const Text.body('Universal fields look the same on every theme.'),
)
```

### The elevation intent

`elevation` is an *intent*, not a pixel value. The call site names a depth; the active theme's `decorationStyles` hook maps that depth to its own shadow idiom.

```dart
enum Elevation { none, xs, sm, md, lg, xl }
```

The same `Elevation.lg` resolves through the selected stylesheet:

| Theme | How elevation renders |
|-------|-----------------------|
| Shadcn | Ambient blurred drop shadow via the palette's generated `--shadow-*` variables (alpha-black). |
| Neon | No elevation chrome; hierarchy comes from borders, spacing, and contrast. |
| Neubrutalism | A hard offset block that grows with the level (`2px` at `xs` up to `10px` at `xl`). |

```dart
Card(
  decoration: const ArcaneDecoration(elevation: Elevation.lg),
  child: const Text.body('One depth. Three idioms.'),
)
```

## The killer example

One decoration, three idioms. The exact same app code:

```dart
Card(
  decoration: const ArcaneDecoration(
    elevation: Elevation.lg,
  ),
  child: const Text.body('Same code, three renderings.'),
)
```

renders as:

| Theme | Result |
|-------|--------|
| Neubrutalism | A neutral hard-offset block shadow. |
| Neon | A flat bordered surface with no decorative shadow. |
| Shadcn | A soft, neutral ambient shadow. |

Nothing at the call site knows which theme is active. Swap the stylesheet on `ArcaneApp` and the same `Card` restyles itself.

## ArcaneStyleData: bounded literal overrides

`styles:` accepts a literal `ArcaneStyleData`. Whatever it sets is applied last and overrides both the theme and the decoration. Use it for values that must be exact regardless of theme.

```dart
Card(
  decoration: const ArcaneDecoration(elevation: Elevation.md),
  styles: const ArcaneStyleData(
    borderRadius: Radius.none,
    background: Background.surface,
  ),
  child: const Text.body('The literal styles layer always wins.'),
)
```

See [Styling](/docs/concepts/styling) for the full `ArcaneStyleData` reference.

## How the layers resolve

Every decoratable component composes its inline `style` in a fixed order, and later layers win in the CSS cascade:

1. Theme base styles
2. Theme variant styles
3. `decoration` universal fields (`color`, `borderRadius`, `border`, `padding`)
4. Theme-resolved `decorationStyles` (the theme's interpretation of `elevation`)
5. Bounded literal `styles:` overrides

That ordering is the permeability contract: intent flows through the theme, and the literal layer is always last.

Source: `lib/core/rendering/base/style_layering.dart`
