import 'package:arcane_jaspr/core/shared/shared.dart';
import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

export 'package:arcane_jaspr/core/shared/shared.dart' show ComponentSize;

/// Represents a time of day with hour and minute.
class TimeOfDay {
  final int hour;
  final int minute;

  const TimeOfDay({required this.hour, required this.minute});

  factory TimeOfDay.now() {
    final now = DateTime.now();
    return TimeOfDay(hour: now.hour, minute: now.minute);
  }

  factory TimeOfDay.fromDateTime(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  int get hourOfPeriod => hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);

  bool get isPM => hour >= 12;

  String format({bool use24Hour = false}) {
    if (use24Hour) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
    final period = isPM ? 'PM' : 'AM';
    return '${hourOfPeriod.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  TimeOfDay copyWith({int? hour, int? minute}) {
    return TimeOfDay(hour: hour ?? this.hour, minute: minute ?? this.minute);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeOfDay && hour == other.hour && minute == other.minute;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;

  @override
  String toString() => format();
}

/// Time picker component properties.
class TimePickerProps {
  final String? id;
  final TimeOfDay? value;
  final String displayText;
  final String? placeholder;
  final String? label;
  final bool disabled;
  final String? error;
  final bool clearable;
  final ComponentSize size;
  final bool use24Hour;
  final int minuteInterval;
  final bool isOpen;
  final int selectedHour;
  final int selectedMinute;
  final bool isPM;
  final void Function()? onToggle;
  final void Function()? onClear;
  final void Function(int hour)? onSelectHour;
  final void Function(int minute)? onSelectMinute;
  final void Function()? onTogglePeriod;
  final void Function()? onCancel;
  final void Function()? onConfirm;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const TimePickerProps({
    required this.value,
    required this.displayText,
    required this.disabled,
    required this.clearable,
    required this.size,
    required this.use24Hour,
    required this.minuteInterval,
    required this.isOpen,
    required this.selectedHour,
    required this.selectedMinute,
    required this.isPM,
    this.id,
    this.placeholder,
    this.label,
    this.error,
    this.onToggle,
    this.onClear,
    this.onSelectHour,
    this.onSelectMinute,
    this.onTogglePeriod,
    this.onCancel,
    this.onConfirm,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for time picker components.
mixin TimePickerRendererContract {
  /// Render a time picker component.
  Component timePicker(TimePickerProps props);
}
