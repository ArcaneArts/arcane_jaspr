import 'package:arcane_jaspr/theme/index.dart';
import 'package:arcane_jaspr/stylesheets/stylesheet.dart';

import 'neubrutalism_css.dart';
import 'neubrutalism_layout_renderers.dart';
import 'neubrutalism_theme.dart';
import 'renderers/neubrutalism_renderers.dart';

class NeubrutalismStylesheet extends ArcaneStylesheet {
  final NeubrutalismTheme theme;

  const NeubrutalismStylesheet({this.theme = NeubrutalismTheme.yellow});

  @override
  String get id => 'neubrutalism';

  @override
  String get name => 'Neubrutalism';

  @override
  ComponentRenderers get renderers => const NeubrutalismRenderers();

  @override
  LayoutRenderers get layouts => const NeubrutalismLayoutRenderers();

  @override
  ThemeSeed get lightSeed => ThemeSeed(
    primary: theme.color,
    background: theme.lightSurface,
    secondary: theme.lightSecondary,
    accent: theme.lightAccent,
    border: theme.lightBorder,
    destructive: 0xFFFF4747,
    success: 0xFF7BCB6A,
    warning: 0xFFFFD23F,
    info: 0xFF6FB3FF,
  );

  @override
  ThemeSeed get darkSeed => ThemeSeed(
    primary: theme.color,
    background: 0xFF202A4F,
    secondary: 0xFF1A1A1A,
    accent: theme.color,
    border: 0xFF000000,
    destructive: 0xFFFF4747,
    success: 0xFF7BCB6A,
    warning: 0xFFFFD23F,
    info: 0xFF6FB3FF,
    isDark: true,
  );

  @override
  FontConfig get fonts => const FontConfig(
    sans: "'Akzidenz-GroteskPro'",
    heading: "'ITCAvantGardeStd'",
    mono: "'Hack'",
  );

  @override
  RadiusConfig get radius => const RadiusConfig.compact();

  @override
  String get bodyClass => 'neubrutalism-${theme.name}';

  @override
  String get componentCss => NeubrutalismCss.componentCss(theme);
}
