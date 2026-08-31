import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

export '../../core/props/calendar_props.dart'
    show CalendarModeVariant, DateRangeValue, CalendarProps;

/// Calendar selection mode.
enum CalendarMode { single, range }

/// A date range.
class DateRange {
  final DateTime start;
  final DateTime end;

  const DateRange({required this.start, required this.end});
}

/// A calendar component for date selection.
class ArcaneCalendar extends StatefulWidget {
  final String? id;
  final DateTime? selected;
  final void Function(DateTime)? onSelect;
  final DateTime? month;
  final void Function(DateTime)? onMonthChange;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool Function(DateTime)? disabledDates;
  final bool showWeekNumbers;
  final bool showToday;
  final int firstDayOfWeek;
  final CalendarMode mode;
  final DateRange? selectedRange;
  final void Function(DateRange)? onRangeSelect;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneCalendar({
    this.id,
    this.selected,
    this.onSelect,
    this.month,
    this.onMonthChange,
    this.minDate,
    this.maxDate,
    this.disabledDates,
    this.showWeekNumbers = false,
    this.showToday = true,
    this.firstDayOfWeek = 0,
    this.mode = CalendarMode.single,
    this.selectedRange,
    this.onRangeSelect,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  State<ArcaneCalendar> createState() => _ArcaneCalendarState();
}

class _ArcaneCalendarState extends State<ArcaneCalendar> {
  late DateTime _displayMonth;
  DateTime? _rangeStart;

  @override
  void initState() {
    super.initState();
    _displayMonth = component.month ?? component.selected ?? DateTime.now();
    _displayMonth = DateTime(_displayMonth.year, _displayMonth.month, 1);
  }

  void _previousMonth() {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month - 1, 1);
    });
    component.onMonthChange?.call(_displayMonth);
  }

  void _nextMonth() {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month + 1, 1);
    });
    component.onMonthChange?.call(_displayMonth);
  }

  void _goToToday() {
    final now = DateTime.now();
    setState(() {
      _displayMonth = DateTime(now.year, now.month, 1);
    });
    component.onMonthChange?.call(_displayMonth);
  }

  bool _isDisabled(DateTime date) {
    if (component.disabledDates?.call(date) ?? false) return true;
    if (component.minDate != null && date.isBefore(component.minDate!))
      return true;
    if (component.maxDate != null && date.isAfter(component.maxDate!))
      return true;
    return false;
  }

  void _selectDate(DateTime date) {
    if (_isDisabled(date)) return;

    if (component.mode == CalendarMode.range) {
      if (_rangeStart == null) {
        setState(() => _rangeStart = date);
      } else {
        final start = _rangeStart!.isBefore(date) ? _rangeStart! : date;
        final end = _rangeStart!.isBefore(date) ? date : _rangeStart!;
        component.onRangeSelect?.call(DateRange(start: start, end: end));
        setState(() => _rangeStart = null);
      }
    } else {
      component.onSelect?.call(date);
    }
  }

  CalendarModeVariant get _propsMode => switch (component.mode) {
    CalendarMode.single => CalendarModeVariant.single,
    CalendarMode.range => CalendarModeVariant.range,
  };

  DateRangeValue? get _propsSelectedRange {
    if (component.selectedRange == null) return null;
    return DateRangeValue(
      start: component.selectedRange!.start,
      end: component.selectedRange!.end,
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.renderers.calendar(
      CalendarProps(
        id: component.id,
        selected: component.selected,
        displayMonth: _displayMonth,
        minDate: component.minDate,
        maxDate: component.maxDate,
        showWeekNumbers: component.showWeekNumbers,
        showToday: component.showToday,
        firstDayOfWeek: component.firstDayOfWeek,
        mode: _propsMode,
        selectedRange: _propsSelectedRange,
        rangeStart: _rangeStart,
        isDisabled: _isDisabled,
        onPreviousMonth: _previousMonth,
        onNextMonth: _nextMonth,
        onGoToToday: _goToToday,
        onSelectDate: _selectDate,
        styles: component.styles,
        decoration: component.decoration,
      ),
    );
  }
}
