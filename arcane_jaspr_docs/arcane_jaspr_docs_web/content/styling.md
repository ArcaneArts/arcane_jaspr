---
title: Styling
description: Preview renderer-owned styling and copy the ArcaneStyleData shape used by the active stylesheet.
layout: kb
component: styling
pageNav: false
---

# Styling

Use this page as the quick visual check for the active stylesheet and palette. The selector in the top bar swaps the renderer package and palette, while the preview below keeps the same neutral Arcane Jaspr code.

## What Changes

| Control | Effect |
|---|---|
| Stylesheet | Swaps the concrete renderer package, such as Shadcn, Neon, or Neubrutalism |
| Palette | Swaps the renderer palette while preserving the same widget API |
| Theme | Switches between light and dark theme variables |

## Copy Pattern

```dart
ArcaneThemeProvider(
  stylesheet: const NeubrutalismStylesheet(
    theme: NeubrutalismTheme.red,
  ),
  child: const ArcaneBox(
    style: ArcaneStyleData(
      padding: PaddingPreset.lg,
      display: Display.flex,
      flexDirection: FlexDirection.column,
      gap: Gap.md,
      background: Background.surface,
      border: BorderPreset.standard,
      borderRadius: Radius.md,
      shadow: Shadow.md,
    ),
    children: [
      Text.heading3('Renderer-owned styling'),
      Text.body('The active stylesheet owns border, color, spacing, and interaction treatment.'),
    ],
  ),
)
```
