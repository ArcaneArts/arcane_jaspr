import 'package:arcane_jaspr/core/rendering/base/menubar_render_base.dart';

/// Win95 menubar component.
class Win95Menubar extends MenubarRenderBase {
  const Win95Menubar(super.props, {super.key});

  @override
  String get themePrefix => 'win95';

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

  /// A Win95 menu item inverted to the selection bar on the frame the pointer
  /// entered it; nothing about it eased.
  @override
  String get itemTransition => 'none';

  @override
  String get indicatorColor => 'var(--foreground)';
}
