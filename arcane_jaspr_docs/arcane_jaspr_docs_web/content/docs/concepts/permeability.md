---
title: Authoring like Flutter
description: The two-surface permeability model — semantic decoration that each theme interprets, and a literal styles escape hatch that always wins
layout: kb
---

# Authoring like Flutter

Arcane Jaspr lets you decorate a single component instance and have every stylesheet render it in its own idiom. You describe *intent*; the active theme decides how that intent looks. This is the permeability model, and it is what keeps app code portable across Shadcn, Neon, and Neubrutalism without branching on the theme.

Two per-instance surfaces sit on every decoratable component (`Card`, `Button`, the card family, and more):

| Surface | Type | Role | Behavior |
|---------|------|------|----------|
| `decoration:` | `ArcaneDecoration?` | **Primary** | Semantic and theme-interpreted. The theme maps intent (like elevation) to its own visual language. |
| `styles:` | `ArcaneStyleData?` | **Escape hatch** | Literal CSS. Always applied last, always wins over the theme. |

Reach for `decoration:` first. It is the surface that stays portable. Drop to `styles:` only when you need a literal, non-negotiable value that should override the theme entirely.

## ArcaneDecoration

`ArcaneDecoration` is the semantic, theme-permeable surface. Its fields fall into three buckets.

Source: `lib/core/decoration/arcane_decoration.dart`

### Universal fields

Universal fields render literally and identically on every theme. They are compiled straight to CSS by `universalStyles()`.

| Field | Type | Notes |
|-------|------|-------|
| `color` | `String?` | Background color as a CSS string (hex, `var(--x)`, an `ArcaneColor.*.css` token, or a runtime accent). |
| `gradient` | `String?` | CSS gradient. Takes precedence over `color` for the background. |
| `borderRadius` | `Radius?` | Typed radius token (`Radius.sm`, `Radius.lg`, `Radius.full`, ...). |
| `borderRadiusCustom` | `String?` | Literal radius string when a token does not fit. |
| `border` | `String?` | Full CSS `border` shorthand (e.g. `'1px solid var(--border)'`). |
| `padding` | `EdgeInsets?` | Typed insets (`EdgeInsets.all`, `EdgeInsets.symmetric`, `EdgeInsets.only`). |
| `paddingCustom` | `String?` | Literal padding string. |
| `backdropFilter` | `BackdropFilter?` | `BackdropFilter.blur`, `blurStrong`, `blurLight`, or `none`. |
| `backdropFilterCustom` | `String?` | Literal `backdrop-filter` string. |

```dart
Card(
  decoration: const ArcaneDecoration(
    color: 'var(--card)',
    borderRadius: Radius.lg,
    border: '1px solid var(--border)',
    padding: EdgeInsets.all(24),
    backdropFilter: BackdropFilter.blurLight,
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
| Neon | Ambient `--shadow-*` at low levels; a colored glow at `lg` and `xl` — its signature look. |
| Neubrutalism | A hard offset block that grows with the level (`2px` at `xs` up to `10px` at `xl`). |

```dart
Card(
  decoration: const ArcaneDecoration(elevation: Elevation.lg),
  child: const Text.body('One depth. Three idioms.'),
)
```

### Theme-specific: shadowColor

`shadowColor` is read only by the themes that implement it and silently ignored by the rest:

| Theme | shadowColor behavior |
|-------|----------------------|
| Neubrutalism | Recolors the hard offset shadow for this element only. |
| Neon | Tints the colored glow (at `lg`/`xl`) for this element only. |
| Shadcn | Ignored — Shadcn shadows are alpha-black and have no single flat color to recolor. |

## The killer example

One decoration, three idioms. The exact same app code:

```dart
Card(
  decoration: const ArcaneDecoration(
    elevation: Elevation.lg,
    shadowColor: '#FF00FF',
  ),
  child: const Text.body('Same code, three renderings.'),
)
```

renders as:

| Theme | Result |
|-------|--------|
| Neubrutalism | A pink (`#FF00FF`) hard-offset block shadow. |
| Neon | A pink glow around the card. |
| Shadcn | A soft, neutral ambient shadow — `shadowColor` is ignored. |

Nothing at the call site knows which theme is active. Swap the stylesheet on `ArcaneApp` and the same `Card` restyles itself.

## ArcaneStyleData: the escape hatch

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
3. `decoration` universal fields (`color`, `gradient`, `borderRadius`, `border`, `padding`, `backdropFilter`)
4. Theme-resolved `decorationStyles` (the theme's interpretation of `elevation` and `shadowColor`)
5. Literal `styles:` (the escape hatch)

That ordering is the permeability contract: intent flows through the theme, and the literal layer is always last.

Source: `lib/core/rendering/base/style_layering.dart`
