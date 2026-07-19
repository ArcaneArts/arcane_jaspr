import 'package:arcane_jaspr/core/rendering/base/toggle_group_render_base.dart';

/// Win95 toggle group renderer (neutralized skeleton).
class Win95ToggleGroup extends ToggleGroupRenderBase {
  const Win95ToggleGroup(super.props, {super.key});

  @override
  String get cssClass => 'win95-toggle-group';

  @override
  String get itemBaseClass => 'win95-toggle-group-item';

  @override
  Map<String, String> get containerStyles => const <String, String>{};

  @override
  Map<String, String> extraRootAttrs() => <String, String>{
    'data-disabled': '${props.disabled}',
    'data-variant': props.variant.name,
    'data-size': props.size.name,
  };

  @override
  Map<String, String> extraItemAttrs(bool isSelected, bool isDisabled) =>
      <String, String>{
        'data-state': isSelected ? 'on' : 'off',
        'data-disabled': '$isDisabled',
      };

  @override
  Map<String, String> itemStyles(bool isSelected, bool isDisabled) =>
      const <String, String>{};
}
