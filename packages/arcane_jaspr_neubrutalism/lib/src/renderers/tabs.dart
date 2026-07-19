import 'package:arcane_jaspr/core/rendering/base/tabs_render_base.dart';

class NeubrutalismTabs extends TabsRenderBase {
  const NeubrutalismTabs(super.props, {super.key});

  @override
  String get classPrefix => 'neubrutalism';

  @override
  String get tabFontWeight => '800';

  @override
  String get tabLetterSpacing => '0';

  @override
  String get tabTextTransform => 'none';

  @override
  String get tabDisabledOpacity => '0.5';

  @override
  Map<String, String> get badgeStyles => const <String, String>{
    'background-color': 'var(--nb-accent, var(--primary))',
    'color': 'var(--nb-ink, #000)',
    'font-size': '0.6875rem',
    'font-weight': '900',
    'padding': '0.125rem 0.5rem',
    'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
    'border-radius': '9999px',
    'margin-left': '0.375rem',
    'line-height': '1.2',
  };
}

class NeubrutalismTabBar extends TabBarRenderBase {
  const NeubrutalismTabBar(super.props, {super.key});

  @override
  String get classPrefix => 'neubrutalism';

  @override
  String get tabFontWeight => '800';

  @override
  String get tabLetterSpacing => '0';

  @override
  String get tabTextTransform => 'none';
}
