# Arcane Jaspr Windows 95

A pixel-faithful **Windows 95** theme for Arcane Jaspr — silver 3D bevels (raised
faces, sunken wells), navy→cyan gradient title bars, segmented progress meters,
chunky beveled scrollbars, dotted focus rectangles, and the self-hosted
MS Sans Serif bitmap font. Everything is sharp-cornered and un-blurred.

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_win95/arcane_jaspr_win95.dart';

ArcaneApp(
  stylesheet: const Win95Stylesheet(
    theme: Win95Theme.standard,
    chrome: Win95Chrome.classic,
  ),
  home: MyApp(),
)
```

- **Light mode** uses the real Win95 appearance schemes: `Win95Theme.standard`
  (teal desktop / navy title), `rainyDay`, `eggplant`, `desert`, `rose`.
- **Dark mode** is the period-accurate **High Contrast Black** scheme.
- **`Win95Chrome`** controls how far the navy title-bar chrome reaches:
  `classic` (dialogs are windows, cards are panels — the default),
  `everything` (cards get title bars too), or `minimal` (no title bars).

Use `package:arcane_jaspr` for core widgets and this package only for the
concrete stylesheet. Swapping themes is a one-line change at the `ArcaneApp`
call site.

## Fonts

The embedded font is bundled by `tool/bundle_font.js` (run with `node`), which
downloads the MIT-licensed "Pixelated MS Sans Serif" faces from the 98.css
project and inlines them as base64 `@font-face` blocks in `lib/src/win95_font.dart`.
If the bundle has not been generated the theme falls back to the system
`MS Sans Serif` / `Tahoma` stack.
