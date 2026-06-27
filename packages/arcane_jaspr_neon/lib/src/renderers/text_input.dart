import 'package:arcane_jaspr/core/props/text_input_props.dart';
import 'package:arcane_jaspr/core/rendering/base/text_input_render_base.dart';

/// Neon Text Input renderer (neutralized skeleton).
class NeonTextInput extends TextInputRenderBase {
  const NeonTextInput(super.props, {super.key});

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
  }) => const <String, String>{};

  @override
  Map<String, String> containerStyles(bool hasError) => const <String, String>{};

  @override
  Map<String, String> borderlessInputStyles({
    required bool isDisabled,
    required String height,
    required String paddingX,
    required String paddingY,
    required String fontSize,
  }) => const <String, String>{};

  @override
  Map<String, String> prefixStyles() => const <String, String>{};

  @override
  Map<String, String> suffixStyles() => const <String, String>{};
}
