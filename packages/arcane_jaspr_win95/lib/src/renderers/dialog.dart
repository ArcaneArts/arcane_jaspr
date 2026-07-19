import 'package:arcane_jaspr/core/rendering/base/dialog_render_base.dart';

class Win95Dialog extends DialogRenderBase {
  const Win95Dialog(super.props, {super.key});

  @override
  String get themePrefix => 'win95';

  @override
  Map<String, String> get overlayStyles => const <String, String>{};

  @override
  Map<String, String> get closeButtonStyles => const <String, String>{};

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'win95-dialog-$_autoCounter';
  }
}

class Win95Sheet extends SheetRenderBase {
  const Win95Sheet(super.props, {super.key});

  @override
  String get themePrefix => 'win95';

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
    return 'win95-sheet-$_autoCounter';
  }
}
