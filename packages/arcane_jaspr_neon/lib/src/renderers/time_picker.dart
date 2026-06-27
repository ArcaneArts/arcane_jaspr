import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/time_picker_props.dart';
import 'package:arcane_jaspr/core/rendering/base/time_picker_render_base.dart';

/// Neon Time Picker renderer (neutralized skeleton).
class NeonTimePicker extends TimePickerRenderBase {
  const NeonTimePicker(super.props, {super.key});

  @override
  Map<String, String> get sizeStyles => switch (props.size) {
    ComponentSize.sm => const <String, String>{
      'height': '36px',
      'fontSize': '0.875rem',
    },
    ComponentSize.md => const <String, String>{
      'height': '44px',
      'fontSize': '0.875rem',
    },
    ComponentSize.lg => const <String, String>{
      'height': '52px',
      'fontSize': '1rem',
    },
  };

  @override
  String rootClasses(bool hasError) =>
      'neon-time-picker ${props.isOpen ? 'open' : ''} ${props.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}';

  @override
  Map<String, String> get rootAttributes => <String, String>{
    'data-state': props.isOpen ? 'open' : 'closed',
    'data-disabled': '${props.disabled}',
    'data-size': props.size.name,
  };

  @override
  Map<String, String> get rootStyles => const <String, String>{};

  @override
  Map<String, String> get labelStyles => const <String, String>{};

  @override
  String get triggerClasses =>
      'neon-time-picker-trigger ${props.disabled ? 'disabled' : ''}';

  @override
  Map<String, String> get triggerAttributes => <String, String>{
    'aria-haspopup': 'dialog',
    'aria-expanded': '${props.isOpen}',
    'data-state': props.isOpen ? 'open' : 'closed',
    'data-disabled': '${props.disabled}',
    if (props.disabled) 'disabled': 'true',
  };

  @override
  Map<String, String> triggerStyles({
    required String height,
    required String fontSize,
    required bool hasError,
    required bool hasValue,
  }) => const <String, String>{};

  @override
  Map<String, String> get iconStyles => const <String, String>{};

  @override
  String get clearClasses => 'neon-time-picker-clear';

  @override
  Map<String, String> get clearStyles => const <String, String>{};

  @override
  String get dropdownClasses => 'neon-time-picker-dropdown neon-time-picker';

  @override
  Map<String, String> get dropdownStyles => const <String, String>{};

  @override
  Map<String, String> get columnsRowStyles => const <String, String>{};

  @override
  Map<String, String> get columnStyles => const <String, String>{};

  @override
  Map<String, String> get columnLabelStyles => const <String, String>{};

  @override
  Map<String, String> get columnScrollStyles => const <String, String>{};

  @override
  String get optionClass => 'neon-time-picker-option';

  @override
  Map<String, String> optionButtonStyles({required bool selected}) =>
      const <String, String>{};

  @override
  Map<String, String> amPmButtonStyles({required bool selected}) =>
      const <String, String>{};

  @override
  Map<String, String> get actionsRowStyles => const <String, String>{};

  @override
  Component buildActionButton({
    required bool primary,
    required void Function()? onClick,
    required String label,
  }) {
    return dom.button(
      type: dom.ButtonType.button,
      classes: 'neon-button',
      events: <String, EventCallback>{'click': (_) => onClick?.call()},
      <Component>[Component.text(label)],
    );
  }
}
