import 'package:arcane_jaspr/stylesheets/stylesheet.dart';
import 'package:arcane_jaspr/theme/index.dart';

import 'win95_css.dart';
import 'win95_font.dart';
import 'win95_loader_palette.dart';
import 'win95_theme.dart';
import 'renderers/win95_renderers.dart';

/// How much "window chrome" (navy title bars) the Windows 95 theme applies.
///
/// The user of the theme chooses this at the call site — it is a per-stylesheet
/// setting, threaded to the CSS through the body class, so no per-component
/// wiring is needed.
enum Win95Chrome {
  /// Dialog and command surfaces render as titled windows; plain cards stay as
  /// beveled panels. The default.
  classic,

  /// No title bars anywhere — just raised/sunken beveled surfaces.
  minimal;

  /// The body class that scopes the chrome-specific CSS in [Win95Css].
  String get bodyClass => 'win95-chrome-$name';
}

/// Windows 95 theme — a pixel-faithful recreation of the classic Win95 desktop.
///
/// Sharp-cornered `#c0c0c0` control faces with the signature layered-inset bevel
/// (raised buttons, sunken fields), solid navy title bars, segmented
/// progress wells, chunky beveled scrollbars, dotted focus rectangles, and the
/// MS Sans Serif bitmap font. Light mode is one of the real Win95 [Win95Theme]
/// appearance schemes (default: the teal-desktop [Win95Theme.standard]); dark
/// mode is the period-accurate "High Contrast Black" scheme.
///
/// All component styling lives in [Win95Css] scoped to
/// `#arcane-root.arcane-theme-win95`, so it never affects the shadcn, neon, or
/// neubrutalism themes.
class Win95Stylesheet extends ArcaneStylesheet {
  /// The light-mode appearance scheme. Defaults to [Win95Theme.standard].
  final Win95Theme theme;

  /// Whether semantic window title bars are shown. Defaults to
  /// [Win95Chrome.classic].
  final Win95Chrome chrome;

  /// The APNG palette used by every indeterminate loader in this stylesheet.
  final Win95LoaderPalette loaderPalette;

  const Win95Stylesheet({
    this.theme = Win95Theme.standard,
    this.chrome = Win95Chrome.classic,
    this.loaderPalette = Win95LoaderPalette.win98,
  });

  @override
  String get id => 'win95';

  @override
  String get name => 'Windows 95';

  @override
  ComponentRenderers get renderers => const Win95Renderers();

  @override
  ThemeSeed get lightSeed => ThemeSeed(
    primary: theme.accent,
    // Component surfaces are the silver Win95 control face. The component
    // CSS separately maps ArcaneApp's canvas hook to --w95-desktop so the
    // area outside those surfaces remains the iconic teal desktop.
    background: 0xFFC0C0C0,
    secondary: 0xFFC0C0C0,
    accent: theme.titleEnd,
    border: 0xFF808080,
    destructive: 0xFFC00000,
    success: 0xFF008000,
    warning: 0xFF808000,
    info: theme.accent,
  );

  /// High Contrast Black — the real Win95 accessibility scheme: black surfaces,
  /// white text, lime accents, bevels preserved (inverted) via [Win95Css].
  @override
  ThemeSeed get darkSeed => const ThemeSeed(
    primary: 0xFF1084D0,
    background: 0xFF000000,
    secondary: 0xFF1A1A1A,
    accent: 0xFF00FF00,
    border: 0xFF808080,
    destructive: 0xFFFF5050,
    success: 0xFF00FF00,
    warning: 0xFFFFFF00,
    info: 0xFF00FFFF,
    isDark: true,
  );

  @override
  FontConfig get fonts => const FontConfig(
    sans:
        "'Pixelated MS Sans Serif', 'MS Sans Serif', 'Microsoft Sans Serif', Tahoma, 'Segoe UI', sans-serif",
    heading:
        "'Pixelated MS Sans Serif', 'MS Sans Serif', 'Microsoft Sans Serif', Tahoma, 'Segoe UI', sans-serif",
    mono: "'Fixedsys', 'Consolas', 'Courier New', 'Lucida Console', monospace",
  );

  @override
  RadiusConfig get radius => const RadiusConfig.sharp();

  /// Self-hosted bitmap MS Sans Serif so the theme is authentic offline.
  @override
  String get fontFaces => win95FontFaces;

  // NOTE: a stylesheet's bodyClass must be a SINGLE CSS token — consumers feed it
  // to `DOMTokenList.remove()`, which throws on any string containing a space.
  // The active scheme (standard/rainyDay/…) is already baked into [componentCss]
  // via color interpolation, so it needs no class of its own; the chrome token
  // (`win95-chrome-*`) also carries the `win95-` prefix used for theme detection.
  @override
  String get bodyClass => chrome.bodyClass;

  @override
  String get componentCss => Win95Css.componentCss(theme, loaderPalette);
}
