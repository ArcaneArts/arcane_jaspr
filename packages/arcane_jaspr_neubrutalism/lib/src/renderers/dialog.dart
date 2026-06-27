import 'package:arcane_jaspr/core/rendering/base/dialog_render_base.dart';

class NeubrutalismDialog extends DialogRenderBase {
  const NeubrutalismDialog(super.props, {super.key});

  @override
  String get themePrefix => 'neubrutalism';

  @override
  Map<String, String> get overlayStyles => <String, String>{
    'position': 'fixed',
    'inset': '0',
    'z-index': '50',
    'display': 'flex',
    'align-items': 'center',
    'justify-content': 'center',
    'padding': '1.5rem',
    'background-color': 'rgba(0, 0, 0, 0.55)',
  };

  @override
  Map<String, String> get closeButtonStyles => <String, String>{
    'position': 'absolute',
    'top': '0.875rem',
    'right': '0.875rem',
    'width': '32px',
    'height': '32px',
    'display': 'inline-flex',
    'align-items': 'center',
    'justify-content': 'center',
    'background': 'transparent',
    'border': 'none',
    'color': 'var(--foreground)',
    'cursor': 'pointer',
    'font-size': '1.125rem',
    'font-weight': '700',
    'transition':
        'transform var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
  };

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'neubrutalism-dialog-$_autoCounter';
  }
}

class NeubrutalismSheet extends SheetRenderBase {
  const NeubrutalismSheet(super.props, {super.key});

  @override
  String get themePrefix => 'neubrutalism';

  @override
  Map<String, String> get overlayBackdropStyles => <String, String>{
    'background-color': 'rgba(0, 0, 0, 0.55)',
  };

  @override
  String get dragHandleColor => 'var(--nb-ink, #000)';

  @override
  String get panelBorder => 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)';

  @override
  Map<String, String> get sheetCloseButtonStyles => <String, String>{
    'width': '28px',
    'height': '28px',
    'display': 'inline-flex',
    'align-items': 'center',
    'justify-content': 'center',
    'background': 'transparent',
    'border': 'none',
    'color': 'var(--foreground)',
    'cursor': 'pointer',
    'font-weight': '700',
    'transition':
        'transform var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
  };

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'neubrutalism-sheet-$_autoCounter';
  }
}
