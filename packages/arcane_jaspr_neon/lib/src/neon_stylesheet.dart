import 'package:arcane_jaspr/stylesheets/stylesheet.dart';
import 'package:arcane_jaspr/theme/index.dart';

import 'neon_theme.dart';
import 'renderers/neon_renderers.dart';

/// Neon theme — skeleton placeholder pending a full rewrite.
///
/// All neon-specific styling (palette, fonts, component CSS, and layout
/// overrides) has been stripped to a neutral baseline. Components render plainly
/// through the shared base renderers (see [NeonRenderers]); the base
/// [ArcaneStylesheet] supplies the default fonts, radius, layout renderers, and
/// empty component CSS. This is intentionally a blank canvas to rebuild on.
class NeonStylesheet extends ArcaneStylesheet {
  final NeonTheme theme;

  const NeonStylesheet({this.theme = NeonTheme.green});

  @override
  String get id => 'neon';

  @override
  String get name => 'Neon';

  @override
  ComponentRenderers get renderers => const NeonRenderers();

  @override
  ThemeSeed get lightSeed => const ThemeSeed(
        primary: 0xFF52525b,
        background: 0xFFFFFFFF,
        secondary: 0xFFF4F4F5,
        accent: 0xFFF4F4F5,
        border: 0xFFE4E4E7,
        destructive: 0xFFB4233C,
        success: 0xFF087F5B,
        warning: 0xFF9A5B00,
        info: 0xFF075985,
      );

  @override
  ThemeSeed get darkSeed => const ThemeSeed(
        primary: 0xFFA1A1AA,
        background: 0xFF0A0A0A,
        secondary: 0xFF171717,
        accent: 0xFF171717,
        border: 0xFF262626,
        destructive: 0xFF661B1C,
        success: 0xFF1F8A65,
        warning: 0xFFB86B16,
        info: 0xFF007ACC,
        isDark: true,
      );
}
