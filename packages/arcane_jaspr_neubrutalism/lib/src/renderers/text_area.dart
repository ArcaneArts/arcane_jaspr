import 'package:arcane_jaspr/core/rendering/base/text_area_render_base.dart';

/// Neubrutalism text area renderer.
class NeubrutalismTextArea extends TextAreaRenderBase {
  const NeubrutalismTextArea(super.props, {super.key});

  @override
  String get classPrefix => 'neubrutalism';

  @override
  String get wrapperGap => '0.625rem';

  @override
  Map<String, String> textAreaStyles({
    required bool hasError,
    required bool isDisabled,
    required bool isReadOnly,
  }) => <String, String>{
    'padding': '0.675rem 1rem',
    'font-size': '0.875rem',
    'font-family': 'var(--font-sans)',
    'font-weight': '500',
    'line-height': '1.625',
    'background-color': 'var(--nb-control-paper, var(--muted))',
    'color':
        'var(--nb-control-foreground, var(--nb-surface-foreground, '
        'var(--foreground)))',
    'caret-color': 'currentColor',
    'border': hasError
        ? 'var(--nb-border-base, 3px) solid var(--destructive)'
        : 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
    'border-radius': 'var(--nb-radius-soft, 4px)',
    'box-shadow':
        'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
    'outline': 'none',
    'transition':
        'box-shadow var(--nb-transition), transform var(--nb-transition)',
  };

  @override
  Map<String, String> labelStyles() => const <String, String>{
    'font-size': '1rem',
    'font-family': 'var(--font-heading)',
    'font-weight': '800',
    'color': 'var(--foreground)',
  };

  @override
  Map<String, String> errorStyles() => const <String, String>{
    'font-size': '0.875rem',
    'font-weight': '600',
    'color': 'var(--destructive)',
  };

  @override
  Map<String, String> helperStyles() => const <String, String>{
    'font-size': '0.875rem',
    'font-weight': '600',
    'color': 'var(--muted-foreground)',
  };
}
