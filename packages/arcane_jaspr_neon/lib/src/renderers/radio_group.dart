import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/radio_group_props.dart';
import 'package:arcane_jaspr/core/rendering/base/radio_group_render_base.dart';

/// Neon radio group renderer (neutralized skeleton).
class NeonRadioGroup<T> extends RadioGroupRenderBase<T> {
  const NeonRadioGroup(super.props, {super.key});

  @override
  String get groupIdPrefix => 'neon-radio-';

  @override
  String get rootClasses =>
      'neon-radio-group ${props.disabled ? 'disabled' : ''}';

  @override
  Map<String, String> rootDataAttrs(String groupName) => <String, String>{
    'data-disabled': '${props.disabled}',
    'data-layout': props.layout.name,
    'data-variant': props.variant.name,
  };

  @override
  Map<String, String> get rootStyles => const <String, String>{};

  @override
  Component buildLabel(String groupName) => dom.div(
    classes: 'neon-radio-group-label',
    <Component>[Component.text(props.label!)],
  );

  @override
  String get optionsClasses => 'neon-radio-group-options';

  @override
  Map<String, String> get optionsStyles => const <String, String>{};

  @override
  List<Component> buildMessage() {
    if (props.error != null) {
      return <Component>[
        dom.div(classes: 'neon-radio-group-error', <Component>[
          Component.text(props.error!),
        ]),
      ];
    } else if (props.helperText != null) {
      return <Component>[
        dom.div(classes: 'neon-radio-group-helper', <Component>[
          Component.text(props.helperText!),
        ]),
      ];
    }
    return const <Component>[];
  }

  @override
  Component buildStandardRadio(
    RadioOptionProps<T> option,
    String groupName,
    bool isSelected,
    bool isDisabled,
    bool hasError,
    Map<String, String> itemAttrs,
  ) {
    return dom.label(
      classes: 'neon-radio-option',
      attributes: itemAttrs,
      events: isDisabled
          ? null
          : <String, EventCallback>{
              'click': (_) => props.onChanged?.call(option.value),
            },
      <Component>[Component.text(option.label)],
    );
  }

  @override
  Component buildCardRadio(
    RadioOptionProps<T> option,
    String groupName,
    bool isSelected,
    bool isDisabled,
    bool hasError,
    Map<String, String> itemAttrs,
  ) {
    return dom.div(
      classes: 'neon-radio-card',
      attributes: itemAttrs,
      events: isDisabled
          ? null
          : <String, EventCallback>{
              'click': (_) => props.onChanged?.call(option.value),
            },
      <Component>[Component.text(option.label)],
    );
  }

  @override
  Component buildButtonRadio(
    RadioOptionProps<T> option,
    String groupName,
    bool isSelected,
    bool isDisabled,
    bool hasError,
    Map<String, String> itemAttrs,
  ) {
    return dom.button(
      classes: 'neon-radio-button',
      attributes: <String, String>{
        'type': 'button',
        ...itemAttrs,
        if (isDisabled) 'disabled': 'true',
      },
      events: isDisabled
          ? null
          : <String, EventCallback>{
              'click': (_) => props.onChanged?.call(option.value),
            },
      <Component>[Component.text(option.label)],
    );
  }
}
