import 'package:arcane_jaspr/core/rendering/base/menubar_render_base.dart';

/// Neon menubar component.
class NeonMenubar extends MenubarRenderBase {
  const NeonMenubar(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  Map<String, String> get rootStyles => const <String, String>{};

  @override
  Map<String, String> triggerStyles(bool isOpen) => const <String, String>{};

  @override
  Map<String, String> get contentStyles => const <String, String>{};

  @override
  Map<String, String> get separatorStyles => const <String, String>{};

  @override
  String get itemBorderRadius => 'var(--radius-sm)';

  @override
  String get itemTransition =>
      'background-color var(--arcane-transition), color var(--arcane-transition)';

  @override
  String get indicatorColor => 'var(--foreground)';
}
