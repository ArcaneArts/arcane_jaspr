import 'package:arcane_jaspr/core/rendering/base/drawer_render_base.dart';

/// Win95 Drawer renderer.
class Win95Drawer extends DrawerRenderBase {
  const Win95Drawer(super.props, {super.key});

  @override
  String get themePrefix => 'win95';

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
    return 'win95-drawer-$_autoCounter';
  }
}
