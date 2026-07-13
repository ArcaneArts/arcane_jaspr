import 'package:arcane_jaspr/core/rendering/base/tabs_render_base.dart';

class Win95Tabs extends TabsRenderBase {
  const Win95Tabs(super.props, {super.key});

  @override
  String get classPrefix => 'win95';

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

class Win95TabBar extends TabBarRenderBase {
  const Win95TabBar(super.props, {super.key});

  @override
  String get classPrefix => 'win95';

  @override
  String get tabFontWeight => '600';

  @override
  String get tabLetterSpacing => 'normal';

  @override
  String get tabTextTransform => 'none';
}
