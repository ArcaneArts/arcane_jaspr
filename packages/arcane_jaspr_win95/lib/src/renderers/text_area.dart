import 'package:arcane_jaspr/core/rendering/base/text_area_render_base.dart';

/// Windows 95 text area renderer.
class Win95TextArea extends TextAreaRenderBase {
  const Win95TextArea(super.props, {super.key});

  @override
  String get classPrefix => 'win95';

  @override
  String get wrapperGap => '0.3rem';

  @override
  Map<String, String> textAreaStyles({
    required bool hasError,
    required bool isDisabled,
    required bool isReadOnly,
  }) => <String, String>{
    'padding': '0.4rem 0.5rem',
    'font-size': '1.219rem',
    'font-family': 'var(--font-sans)',
    'line-height': '1.4',
    'background-color': 'var(--w95-field)',
    'color': 'var(--w95-field-text)',
    'caret-color': 'var(--w95-field-text)',
    'border': '0',
    'border-radius': '0',
    'box-shadow': 'var(--w95-sunken)',
    'outline': hasError ? '1px solid #c00000' : 'none',
    if (hasError) 'outline-offset': '-3px',
    'transition': 'none',
  };

  @override
  Map<String, String> labelStyles() => const <String, String>{
    'font-size': '1.125rem',
    'font-weight': '700',
    'color': 'var(--w95-face-text)',
  };

  @override
  Map<String, String> errorStyles() => const <String, String>{
    'font-size': '1.125rem',
    'color': '#c00000',
  };

  @override
  Map<String, String> helperStyles() => const <String, String>{
    'font-size': '1.125rem',
    'color': 'var(--w95-face-text)',
  };
}
