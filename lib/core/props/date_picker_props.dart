import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';
import 'calendar_props.dart';

enum DatePickerSizeVariant { sm, md, lg }

/// Date picker component properties.
class DatePickerProps {
  final String? id;
  final DateTime? value;
  final String? label;
  final String? placeholder;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool disabled;
  final String? error;
  final bool clearable;
  final DatePickerSizeVariant size;
  final CalendarModeVariant mode;
  final DateRangeValue? rangeValue;
  final bool isOpen;
  final String displayText;
  final void Function()? onToggle;
  final void Function(DateTime date)? onSelect;
  final void Function(DateRangeValue range)? onRangeSelect;
  final void Function()? onClear;
  final CalendarProps? calendarProps;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const DatePickerProps({
    this.id,
    this.value,
    this.label,
    this.placeholder,
    this.minDate,
    this.maxDate,
    this.disabled = false,
    this.error,
    this.clearable = true,
    this.size = DatePickerSizeVariant.md,
    this.mode = CalendarModeVariant.single,
    this.rangeValue,
    this.isOpen = false,
    this.displayText = 'Select date...',
    this.onToggle,
    this.onSelect,
    this.onRangeSelect,
    this.onClear,
    this.calendarProps,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for date picker components.
mixin DatePickerRendererContract {
  Component datePicker(DatePickerProps props);
}
