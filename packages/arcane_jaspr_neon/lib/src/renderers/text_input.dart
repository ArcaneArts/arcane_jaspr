import 'package:arcane_jaspr/core/props/text_input_props.dart';
import 'package:arcane_jaspr/core/rendering/base/text_input_render_base.dart';

class NeonTextInput extends TextInputRenderBase {
  const NeonTextInput(super.props, {super.key});

  static const String _surface =
      'linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 5%, transparent), color-mix(in srgb, var(--card) 86%, transparent))';

  @override
  String get classPrefix => 'neon';

  @override
  String get wrapperGap => '0.625rem';

  @override
  bool get borderlessInputReflectsState => false;

  @override
  (String, String, String, String) sizeValues(ComponentSize size) =>
      switch (size) {
        ComponentSize.sm => ('38px', '0.875rem', '0.5rem', '0.8125rem'),
        ComponentSize.md => ('46px', '1rem', '0.675rem', '0.875rem'),
        ComponentSize.lg => ('54px', '1.125rem', '0.875rem', '1rem'),
      };

  @override
  Map<String, String> inputStyles({
    required bool hasError,
    required bool isDisabled,
    required String height,
    required String paddingX,
    required String paddingY,
    required String fontSize,
  }) {
    final String borderColor = hasError
        ? 'var(--destructive)'
        : 'var(--neon-control-border)';
    return <String, String>{
      'display': 'flex',
      'height': height,
      'width': '100%',
      'border-radius': 'var(--neon-radius-control)',
      'clip-path': 'var(--neon-control-clip)',
      'border': '1px solid $borderColor',
      'background': _surface,
      'padding': '$paddingY $paddingX',
      'font-size': fontSize,
      'font-family': 'inherit',
      'line-height': '1.5',
      'color': 'var(--foreground)',
      'outline': 'none',
      'box-shadow': 'var(--neon-inset)',
      if (isDisabled) 'cursor': 'not-allowed',
      if (isDisabled) 'opacity': '0.45',
      'transition': 'border-color 0.18s ease, box-shadow 0.18s ease',
    };
  }

  @override
  Map<String, String> containerStyles(bool hasError) {
    final String borderColor = hasError
        ? 'var(--destructive)'
        : 'var(--neon-control-border)';
    return <String, String>{
      'display': 'flex',
      'align-items': 'center',
      'border-radius': 'var(--neon-radius-control)',
      'clip-path': 'var(--neon-control-clip)',
      'border': '1px solid $borderColor',
      'background': _surface,
      'overflow': 'hidden',
      'box-shadow': 'var(--neon-inset)',
      'transition': 'border-color 0.18s ease, box-shadow 0.18s ease',
    };
  }

  @override
  Map<String, String> borderlessInputStyles({
    required bool isDisabled,
    required String height,
    required String paddingX,
    required String paddingY,
    required String fontSize,
  }) => <String, String>{
    'flex': '1',
    'height': height,
    'border': 'none',
    'background': 'transparent',
    'padding': '$paddingY $paddingX',
    'font-size': fontSize,
    'font-family': 'inherit',
    'color': 'var(--foreground)',
    'outline': 'none',
    if (isDisabled) 'cursor': 'not-allowed',
    if (isDisabled) 'opacity': '0.45',
  };

  @override
  Map<String, String> prefixStyles() => <String, String>{
    'display': 'flex',
    'align-items': 'center',
    'padding-left': '0.875rem',
    'color': 'var(--muted-foreground)',
  };

  @override
  Map<String, String> suffixStyles() => <String, String>{
    'display': 'flex',
    'align-items': 'center',
    'padding-right': '0.875rem',
    'color': 'var(--muted-foreground)',
  };
}
