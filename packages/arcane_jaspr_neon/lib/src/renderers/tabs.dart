import 'package:arcane_jaspr/core/rendering/base/tabs_render_base.dart';

class NeonTabs extends TabsRenderBase {
  const NeonTabs(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  String get tabFontWeight => '600';

  @override
  String get tabLetterSpacing => 'normal';

  @override
  String get tabTextTransform => 'none';

  @override
  String get tabDisabledOpacity => '0.45';

  @override
  Map<String, String> get badgeStyles => const <String, String>{};
}

class NeonTabBar extends TabBarRenderBase {
  const NeonTabBar(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  String get tabFontWeight => '600';

  @override
  String get tabLetterSpacing => 'normal';

  @override
  String get tabTextTransform => 'none';
}
