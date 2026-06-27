import 'package:arcane_jaspr/core/rendering/base/dialog_render_base.dart';

class NeonDialog extends DialogRenderBase {
  const NeonDialog(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  Map<String, String> get overlayStyles => const <String, String>{};

  @override
  Map<String, String> get closeButtonStyles => const <String, String>{};

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'neon-dialog-$_autoCounter';
  }
}

class NeonSheet extends SheetRenderBase {
  const NeonSheet(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  Map<String, String> get overlayBackdropStyles => const <String, String>{};

  @override
  String get dragHandleColor => 'var(--muted-foreground)';

  @override
  String get panelBorder => 'none';

  @override
  Map<String, String> get sheetCloseButtonStyles => const <String, String>{};

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'neon-sheet-$_autoCounter';
  }
}
