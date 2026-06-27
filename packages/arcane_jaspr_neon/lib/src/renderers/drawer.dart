import 'package:arcane_jaspr/core/rendering/base/drawer_render_base.dart';

/// Neon Drawer renderer.
class NeonDrawer extends DrawerRenderBase {
  const NeonDrawer(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  String get positionBorder => 'none';

  @override
  Map<String, String> get overlayBackdropStyles => const <String, String>{};

  @override
  Map<String, String> get panelDecorationStyles => const <String, String>{};

  @override
  String get headerFooterBorder => 'none';

  @override
  Map<String, String> get closeButtonStyles => const <String, String>{};

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'neon-drawer-$_autoCounter';
  }
}
