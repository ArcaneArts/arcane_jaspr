import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/calendar_props.dart';
import 'package:arcane_jaspr/core/props/date_picker_props.dart';
import 'package:arcane_jaspr/core/rendering/base/date_picker_render_base.dart';
import 'calendar.dart';

/// Neon date picker renderer.
class NeonDatePicker extends DatePickerRenderBase {
  const NeonDatePicker(super.props, {super.key});

  @override
  (String, String) sizeStyles(DatePickerSizeVariant size) => switch (size) {
    DatePickerSizeVariant.sm => ('42px', '0.8125rem'),
    DatePickerSizeVariant.md => ('48px', '0.875rem'),
    DatePickerSizeVariant.lg => ('54px', '0.95rem'),
  };

  @override
  String get anchorOffset => '8';

  @override
  String get rootClasses => 'neon-date-picker ${props.disabled ? 'disabled' : ''}';

  @override
  Map<String, String> get rootAttributes => <String, String>{
    'data-disabled': '${props.disabled}',
    'data-size': props.size.name,
  };

  @override
  Map<String, String> get rootStyles => const <String, String>{};

  @override
  Map<String, String> get labelStyles => const <String, String>{};

  @override
  String get triggerClasses => 'neon-date-picker-trigger';

  @override
  Map<String, String> triggerExtraAttrs(bool hasError) =>
      const <String, String>{};

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
  Map<String, String> get displayStyles => const <String, String>{};

  @override
  String get clearClasses => 'neon-date-picker-clear';

  @override
  Map<String, String> get clearExtraAttrs => const <String, String>{
    'data-state': 'clearable',
  };

  @override
  Map<String, String> get clearStyles => const <String, String>{};

  @override
  String get dropdownClasses => 'neon-date-picker-dropdown neon-date-picker';

  @override
  Map<String, String> get dropdownStyles => const <String, String>{};

  @override
  Component buildCalendar(CalendarProps calendarProps) =>
      NeonCalendar(calendarProps);
}
