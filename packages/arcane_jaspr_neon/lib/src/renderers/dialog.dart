import 'package:arcane_jaspr/core/rendering/base/dialog_render_base.dart';

class NeonDialog extends DialogRenderBase {
  const NeonDialog(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  Map<String, String> get overlayStyles => <String, String>{
    'position': 'fixed',
    'inset': '0',
    'z-index': '50',
    'display': 'flex',
    'align-items': 'center',
    'justify-content': 'center',
    'padding': '1.5rem',
    'background-color':
        'color-mix(in srgb, var(--neon-surface-0, #12151C) 78%, transparent)',
    'backdrop-filter': 'blur(8px) saturate(1.1)',
    '-webkit-backdrop-filter': 'blur(8px) saturate(1.1)',
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
    'border-radius': 'var(--neon-radius-control)',
    'color': 'var(--muted-foreground)',
    'cursor': 'pointer',
    'font-size': '1.125rem',
    'transition': 'color 0.15s ease, background 0.15s ease, transform 0.15s ease',
  };

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
  Map<String, String> get overlayBackdropStyles => <String, String>{
    'background-color':
        'color-mix(in srgb, var(--neon-surface-0, #12151C) 78%, transparent)',
    'backdrop-filter': 'blur(8px) saturate(1.1)',
    '-webkit-backdrop-filter': 'blur(8px) saturate(1.1)',
  };

  @override
  String get dragHandleColor => 'var(--neon-panel-border-hot)';

  @override
  String get panelBorder => '1px solid var(--neon-panel-border)';

  @override
  Map<String, String> get sheetCloseButtonStyles => <String, String>{
    'width': '28px',
    'height': '28px',
    'display': 'inline-flex',
    'align-items': 'center',
    'justify-content': 'center',
    'background': 'transparent',
    'border': 'none',
    'border-radius': 'var(--neon-radius-control)',
    'color': 'var(--muted-foreground)',
    'cursor': 'pointer',
    'transition': 'color 0.15s ease, background 0.15s ease',
  };

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'neon-sheet-$_autoCounter';
  }
}
