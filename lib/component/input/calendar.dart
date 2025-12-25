import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';

/// A calendar component for date selection.
///
/// Example:
/// ```dart
/// ArcaneCalendar(
///   selected: selectedDate,
///   onSelect: (date) => setState(() => selectedDate = date),
/// )
/// ```
class ArcaneCalendar extends StatefulComponent {
  /// Currently selected date
  final DateTime? selected;

  /// Called when a date is selected
  final void Function(DateTime)? onSelect;

  /// The month to display (defaults to current month)
  final DateTime? month;

  /// Called when month changes
  final void Function(DateTime)? onMonthChange;

  /// Minimum selectable date
  final DateTime? minDate;

  /// Maximum selectable date
  final DateTime? maxDate;

  /// Custom function to disable specific dates
  final bool Function(DateTime)? disabledDates;

  /// Whether to show week numbers
  final bool showWeekNumbers;

  /// Whether to highlight today
  final bool showToday;

  /// First day of week (0 = Sunday, 1 = Monday)
  final int firstDayOfWeek;

  /// Selection mode
  final CalendarMode mode;

  /// Selected date range (for range mode)
  final DateRange? selectedRange;

  /// Called when range is selected
  final void Function(DateRange)? onRangeSelect;

  const ArcaneCalendar({
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
    super.key,
  });

  @override
  State<ArcaneCalendar> createState() => _ArcaneCalendarState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-calendar-day:hover:not(.disabled):not(.outside)').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-calendar-day.selected').styles(raw: {
      'background-color': ArcaneColors.accent,
      'color': ArcaneColors.accentForeground,
    }),
    css('.arcane-calendar-day.today:not(.selected)').styles(raw: {
      'border': '1px solid ${ArcaneColors.accent}',
    }),
    css('.arcane-calendar-day.in-range').styles(raw: {
      'background-color': ArcaneColors.accentContainer,
    }),
    css('.arcane-calendar-day.range-start').styles(raw: {
      'border-top-left-radius': ArcaneRadius.md,
      'border-bottom-left-radius': ArcaneRadius.md,
    }),
    css('.arcane-calendar-day.range-end').styles(raw: {
      'border-top-right-radius': ArcaneRadius.md,
      'border-bottom-right-radius': ArcaneRadius.md,
    }),
    css('.arcane-calendar-nav-btn:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}

class _ArcaneCalendarState extends State<ArcaneCalendar> {
  late DateTime _displayMonth;
  DateTime? _rangeStart;

  static const List<String> _weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
  static const List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

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
    if (component.minDate != null && date.isBefore(component.minDate!)) return true;
    if (component.maxDate != null && date.isAfter(component.maxDate!)) return true;
    return false;
  }

  bool _isSelected(DateTime date) {
    if (component.selected == null) return false;
    return _isSameDay(date, component.selected!);
  }

  bool _isToday(DateTime date) {
    return _isSameDay(date, DateTime.now());
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isInRange(DateTime date) {
    if (component.selectedRange == null) return false;
    return date.isAfter(component.selectedRange!.start.subtract(const Duration(days: 1))) &&
           date.isBefore(component.selectedRange!.end.add(const Duration(days: 1)));
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

  List<DateTime> _getDaysInMonth() {
    final days = <DateTime>[];
    final firstDay = DateTime(_displayMonth.year, _displayMonth.month, 1);
    final lastDay = DateTime(_displayMonth.year, _displayMonth.month + 1, 0);

    // Add days from previous month to fill first week
    var startWeekday = firstDay.weekday % 7; // Convert to 0-6 (Sun-Sat)
    if (component.firstDayOfWeek == 1) {
      startWeekday = (firstDay.weekday - 1) % 7;
    }

    for (var i = startWeekday - 1; i >= 0; i--) {
      days.add(firstDay.subtract(Duration(days: i + 1)));
    }

    // Add days of current month
    for (var i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(_displayMonth.year, _displayMonth.month, i));
    }

    // Add days from next month to complete last week
    final remaining = 7 - (days.length % 7);
    if (remaining < 7) {
      for (var i = 1; i <= remaining; i++) {
        days.add(DateTime(_displayMonth.year, _displayMonth.month + 1, i));
      }
    }

    return days;
  }

  int _getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final dayOfYear = date.difference(firstDayOfYear).inDays + 1;
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  @override
  Component build(BuildContext context) {
    final days = _getDaysInMonth();
    final weekDays = component.firstDayOfWeek == 1
        ? [..._weekDays.sublist(1), _weekDays[0]]
        : _weekDays;

    return div(
      classes: 'arcane-calendar',
      attributes: {
        'data-calendar': 'true',
        'role': 'application',
        'aria-label': 'Calendar',
      },
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.sm,
        'padding': ArcaneSpacing.md,
        'background-color': ArcaneColors.surface,
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.lg,
        'width': 'fit-content',
      }),
      [
        // Header with navigation
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'gap': ArcaneSpacing.sm,
          }),
          [
            button(
              classes: 'arcane-calendar-nav-btn',
              attributes: {
                'type': 'button',
                'aria-label': 'Previous month',
              },
              styles: const Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '32px',
                'height': '32px',
                'background': 'transparent',
                'border': 'none',
                'border-radius': ArcaneRadius.sm,
                'cursor': 'pointer',
                'color': ArcaneColors.onSurface,
                'transition': ArcaneEffects.transitionFast,
              }),
              events: {'click': (e) => _previousMonth()},
              [Component.text('◀')],
            ),
            span(
              styles: const Styles(raw: {
                'font-weight': ArcaneTypography.weightSemibold,
                'font-size': ArcaneTypography.fontMd,
                'color': ArcaneColors.onSurface,
              }),
              [Component.text('${_months[_displayMonth.month - 1]} ${_displayMonth.year}')],
            ),
            button(
              classes: 'arcane-calendar-nav-btn',
              attributes: {
                'type': 'button',
                'aria-label': 'Next month',
              },
              styles: const Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '32px',
                'height': '32px',
                'background': 'transparent',
                'border': 'none',
                'border-radius': ArcaneRadius.sm,
                'cursor': 'pointer',
                'color': ArcaneColors.onSurface,
                'transition': ArcaneEffects.transitionFast,
              }),
              events: {'click': (e) => _nextMonth()},
              [Component.text('▶')],
            ),
          ],
        ),

        // Week day headers
        div(
          styles: Styles(raw: {
            'display': 'grid',
            'grid-template-columns': component.showWeekNumbers
                ? 'auto repeat(7, 1fr)'
                : 'repeat(7, 1fr)',
            'gap': '2px',
          }),
          [
            if (component.showWeekNumbers)
              div(
                styles: const Styles(raw: {
                  'width': '32px',
                }),
                [],
              ),
            for (final day in weekDays)
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'height': '32px',
                  'font-size': ArcaneTypography.fontXs,
                  'font-weight': ArcaneTypography.weightMedium,
                  'color': ArcaneColors.muted,
                }),
                [Component.text(day)],
              ),
          ],
        ),

        // Calendar grid
        div(
          styles: Styles(raw: {
            'display': 'grid',
            'grid-template-columns': component.showWeekNumbers
                ? 'auto repeat(7, 1fr)'
                : 'repeat(7, 1fr)',
            'gap': '2px',
          }),
          [
            for (var i = 0; i < days.length; i++) ...[
              // Week number at start of each row
              if (component.showWeekNumbers && i % 7 == 0)
                div(
                  styles: const Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'width': '32px',
                    'height': '32px',
                    'font-size': ArcaneTypography.fontXs,
                    'color': ArcaneColors.muted,
                  }),
                  [Component.text('${_getWeekNumber(days[i])}')],
                ),
              _buildDay(days[i]),
            ],
          ],
        ),

        // Today button
        if (component.showToday)
          button(
            attributes: {
              'type': 'button',
            },
            styles: const Styles(raw: {
              'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
              'background': 'transparent',
              'border': '1px solid ${ArcaneColors.border}',
              'border-radius': ArcaneRadius.sm,
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
              'cursor': 'pointer',
              'transition': ArcaneEffects.transitionFast,
              'align-self': 'center',
            }),
            events: {'click': (e) => _goToToday()},
            [Component.text('Today')],
          ),
      ],
    );
  }

  Component _buildDay(DateTime date) {
    final isOutside = date.month != _displayMonth.month;
    final isDisabled = _isDisabled(date);
    final isSelected = _isSelected(date);
    final isToday = _isToday(date);
    final isInRange = _isInRange(date);
    final isRangeStart = component.selectedRange != null &&
        _isSameDay(date, component.selectedRange!.start);
    final isRangeEnd = component.selectedRange != null &&
        _isSameDay(date, component.selectedRange!.end);

    final classes = [
      'arcane-calendar-day',
      if (isOutside) 'outside',
      if (isDisabled) 'disabled',
      if (isSelected) 'selected',
      if (isToday && component.showToday) 'today',
      if (isInRange) 'in-range',
      if (isRangeStart) 'range-start',
      if (isRangeEnd) 'range-end',
    ].join(' ');

    return button(
      classes: classes,
      attributes: {
        'type': 'button',
        'aria-label': '${date.day} ${_months[date.month - 1]} ${date.year}',
        'aria-selected': '$isSelected',
        if (isDisabled) 'disabled': 'true',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '32px',
        'height': '32px',
        'border': 'none',
        'border-radius': ArcaneRadius.sm,
        'background': isSelected ? ArcaneColors.accent : 'transparent',
        'font-size': ArcaneTypography.fontSm,
        'color': isSelected
            ? ArcaneColors.accentForeground
            : isOutside
                ? ArcaneColors.muted
                : ArcaneColors.onSurface,
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'transition': ArcaneEffects.transitionFast,
        if (isDisabled) 'opacity': '0.5',
      }),
      events: {
        'click': (e) => _selectDate(date),
      },
      [Component.text('${date.day}')],
    );
  }
}

/// Calendar selection mode
enum CalendarMode {
  /// Select a single date
  single,

  /// Select a date range
  range,
}

/// A date range
class DateRange {
  final DateTime start;
  final DateTime end;

  const DateRange({
    required this.start,
    required this.end,
  });
}
