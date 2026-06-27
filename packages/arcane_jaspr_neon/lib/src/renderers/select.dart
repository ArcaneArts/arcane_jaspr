import 'package:arcane_jaspr/core/rendering/base/select_render_base.dart';

/// Neon Select renderer (neutralized skeleton).
class NeonSelect<T> extends SelectRenderBase<T> {
  const NeonSelect(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  String get surfaceIdPrefix => 'neon-select-';

  @override
  String get requiredAsteriskColor => 'var(--foreground)';

  @override
  String get controlBorderColor => 'var(--border)';

  @override
  Map<String, String> triggerStyles(
    String height,
    String padding,
    String fontSize,
    String triggerColor,
    String borderColor,
  ) => const <String, String>{};

  @override
  Map<String, String> dropdownStyles(String maxHeight) =>
      const <String, String>{};

  @override
  Map<String, String> get searchWrapperStyles => const <String, String>{};

  @override
  Map<String, String> get searchInputStyles => const <String, String>{};

  @override
  Map<String, String> optionStyles(bool isSelected, bool isDisabled) =>
      const <String, String>{};

  @override
  Map<String, String> optionCheckboxStyles(bool isSelected) =>
      const <String, String>{};

  @override
  String get optionCheckColor => 'var(--foreground)';

  @override
  String optionIconColor(bool isSelected) => 'var(--foreground)';
}
