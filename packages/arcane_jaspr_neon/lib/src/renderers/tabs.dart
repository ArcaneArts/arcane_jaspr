import 'package:arcane_jaspr/core/rendering/base/tabs_render_base.dart';

class NeonTabs extends TabsRenderBase {
  const NeonTabs(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  String get tabFontWeight => '600';

  @override
  String get tabLetterSpacing => '0.06em';

  @override
  String get tabTextTransform => 'uppercase';

  @override
  String get tabDisabledOpacity => '0.45';

  @override
  Map<String, String> get badgeStyles => const <String, String>{
    'background':
        'linear-gradient(135deg, var(--neon-accent), var(--neon-accent-cool))',
    'color': '#03110f',
    'font-size': '0.625rem',
    'font-weight': '700',
    'letter-spacing': '0.04em',
    'padding': '0.125rem 0.5rem',
    'border-radius': '9999px',
    'margin-left': '0.375rem',
  };
}

class NeonTabBar extends TabBarRenderBase {
  const NeonTabBar(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  String get tabFontWeight => '600';

  @override
  String get tabLetterSpacing => '0.06em';

  @override
  String get tabTextTransform => 'uppercase';
}
