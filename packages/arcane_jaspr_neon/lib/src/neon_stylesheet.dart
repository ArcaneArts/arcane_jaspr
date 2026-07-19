import 'package:arcane_jaspr/stylesheets/stylesheet.dart';
import 'package:arcane_jaspr/theme/index.dart';

import 'neon_css.dart';
import 'neon_theme.dart';
import 'renderers/neon_renderers.dart';

/// Neon theme — a dark-first "gamer" aesthetic.
///
/// Distilled from the QualityNode site: near-black surfaces, a vivid accent with
/// a cool gradient companion, neon glow on interactive elements, gradient accent
/// bars on cards, and uppercase tracked labels. The palette is fully seeded from
/// [NeonTheme] (like the shadcn and neubrutalism themes), so switching variants
/// or overriding fonts is a one-line change. All component styling lives in
/// [NeonCss] scoped to `#arcane-root.arcane-theme-neon`, so it never affects
/// other themes.
class NeonStylesheet extends ArcaneStylesheet {
  /// The color variant. Defaults to [NeonTheme.green] (QualityNode emerald/cyan).
  final NeonTheme theme;

  const NeonStylesheet({this.theme = NeonTheme.green});

  @override
  String get id => 'neon';

  @override
  String get name => 'Neon';

  @override
  ComponentRenderers get renderers => const NeonRenderers();

  @override
  ThemeSeed get lightSeed => ThemeSeed(
        primary: theme.color,
        background: theme.lightSurface,
        secondary: theme.lightSecondary,
        accent: theme.lightAccent,
        border: theme.lightBorder,
        destructive: 0xFFEF4444,
        success: 0xFF22C55E,
        warning: 0xFFF59E0B,
        info: 0xFF3B82F6,
        glowColor: theme.color,
      );

  @override
  ThemeSeed get darkSeed => ThemeSeed(
        primary: theme.color,
        background: 0xFF0A0A0B,
        secondary: 0xFF151518,
        accent: theme.accentCool,
        border: 0xFF26262B,
        destructive: 0xFFFF4D4D,
        success: 0xFF2DD48A,
        warning: 0xFFFBBF24,
        info: 0xFF38BDF8,
        isDark: true,
        accentGlow: true,
        glowColor: theme.color,
      );

  @override
  FontConfig get fonts => const FontConfig(
        sans:
            "'Inter', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
        heading:
            "'Oxanium', 'Inter', ui-sans-serif, system-ui, -apple-system, sans-serif",
        mono:
            "'JetBrains Mono', 'IBM Plex Mono', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace",
      );

  @override
  RadiusConfig get radius => const RadiusConfig(
        xs: '3px',
        sm: '5px',
        md: '8px',
        lg: '12px',
        xl: '16px',
        xxl: '20px',
        full: '9999px',
      );

  @override
  List<String> get externalCssUrls => const [
        'https://fonts.googleapis.com/css2?family=Oxanium:wght@400;500;600;700;800&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;700&display=swap',
      ];

  @override
  String get bodyClass => 'neon-${theme.name}';

  @override
  String get componentCss => NeonCss.componentCss(theme);
}
