import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

enum CalendarModeVariant {
  single,
  range,
}

/// Date range value.
class DateRangeValue {
  final DateTime start;
  final DateTime end;

  const DateRangeValue({
    required this.start,
    required this.end,
  });
}

/// Calendar component properties.
class CalendarProps {
  final String? id;
  final DateTime? selected;
  final DateTime displayMonth;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool showWeekNumbers;
  final bool showToday;
  final int firstDayOfWeek;
  final CalendarModeVariant mode;
  final DateRangeValue? selectedRange;
  final DateTime? rangeStart;
  final bool Function(DateTime)? isDisabled;
  final void Function()? onPreviousMonth;
  final void Function()? onNextMonth;
  final void Function()? onGoToToday;
  final void Function(DateTime date)? onSelectDate;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const CalendarProps({
    this.id,
    this.selected,
    required this.displayMonth,
    this.minDate,
    this.maxDate,
    this.showWeekNumbers = false,
    this.showToday = true,
    this.firstDayOfWeek = 0,
    this.mode = CalendarModeVariant.single,
    this.selectedRange,
    this.rangeStart,
    this.isDisabled,
    this.onPreviousMonth,
    this.onNextMonth,
    this.onGoToToday,
    this.onSelectDate,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for calendar components.
mixin CalendarRendererContract {
  Component calendar(CalendarProps props);
}
