import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';
import 'calendar.dart';

export '../../core/props/date_picker_props.dart'
    show DatePickerSizeVariant, DatePickerProps;

/// Size variants for date picker.
enum DatePickerSize {
  sm,
  md,
  lg,
}

/// A date picker input with calendar dropdown.
class ArcaneDatePicker extends StatefulWidget {
  final String? id;
  final DateTime? value;
  final void Function(DateTime?)? onChanged;
  final String? label;
  final String? placeholder;
  final String Function(DateTime)? formatDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool Function(DateTime)? disabledDates;
  final bool disabled;
  final String? error;
  final bool clearable;
  final DatePickerSize size;
  final CalendarMode mode;
  final DateRange? rangeValue;
  final void Function(DateRange?)? onRangeChanged;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneDatePicker({
    this.id,
    this.value,
    this.onChanged,
    this.label,
    this.placeholder,
    this.formatDate,
    this.minDate,
    this.maxDate,
    this.disabledDates,
    this.disabled = false,
    this.error,
    this.clearable = true,
    this.size = DatePickerSize.md,
    this.mode = CalendarMode.single,
    this.rangeValue,
    this.onRangeChanged,
    this.styles,
    this.decoration,
    super.key,
  });

  const ArcaneDatePicker.range({
    this.id,
    this.rangeValue,
    this.onRangeChanged,
    this.label,
    this.placeholder,
    this.formatDate,
    this.minDate,
    this.maxDate,
    this.disabledDates,
    this.disabled = false,
    this.error,
    this.clearable = true,
    this.size = DatePickerSize.md,
    this.styles,
    this.decoration,
    super.key,
  })  : value = null,
        onChanged = null,
        mode = CalendarMode.range;

  @override
  State<ArcaneDatePicker> createState() => _ArcaneDatePickerState();
}

class _ArcaneDatePickerState extends State<ArcaneDatePicker> {
  bool _isOpen = false;
  late DateTime _displayMonth;

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  @override
  void initState() {
    super.initState();
    _displayMonth = component.value ?? DateTime.now();
    _displayMonth = DateTime(_displayMonth.year, _displayMonth.month, 1);
  }

  String _defaultFormat(DateTime date) {
    return '${_months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String get _displayText {
    if (component.mode == CalendarMode.range) {
      if (component.rangeValue == null) {
        return component.placeholder ?? 'Select date range...';
      }
      final format = component.formatDate ?? _defaultFormat;
      return '${format(component.rangeValue!.start)} - ${format(component.rangeValue!.end)}';
    }

    if (component.value == null) {
      return component.placeholder ?? 'Select date...';
    }
    return (component.formatDate ?? _defaultFormat)(component.value!);
  }

  void _toggleOpen() {
    if (component.disabled) return;
    setState(() => _isOpen = !_isOpen);
  }

  void _selectDate(DateTime date) {
    component.onChanged?.call(date);
    setState(() => _isOpen = false);
  }

  void _selectRange(DateRange range) {
    component.onRangeChanged?.call(range);
    setState(() => _isOpen = false);
  }

  void _clear() {
    if (component.mode == CalendarMode.range) {
      component.onRangeChanged?.call(null);
    } else {
      component.onChanged?.call(null);
    }
  }

  bool _isDisabled(DateTime date) {
    if (component.disabledDates?.call(date) ?? false) return true;
    if (component.minDate != null && date.isBefore(component.minDate!)) return true;
    if (component.maxDate != null && date.isAfter(component.maxDate!)) return true;
    return false;
  }

  DatePickerSizeVariant get _propsSize => switch (component.size) {
        DatePickerSize.sm => DatePickerSizeVariant.sm,
        DatePickerSize.md => DatePickerSizeVariant.md,
        DatePickerSize.lg => DatePickerSizeVariant.lg,
      };

  CalendarModeVariant get _propsMode => switch (component.mode) {
        CalendarMode.single => CalendarModeVariant.single,
        CalendarMode.range => CalendarModeVariant.range,
      };

  DateRangeValue? get _propsRangeValue {
    if (component.rangeValue == null) return null;
    return DateRangeValue(
      start: component.rangeValue!.start,
      end: component.rangeValue!.end,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String resolvedId = component.id ?? 'datepicker-${identityHashCode(component)}';
    final String calendarId = '$resolvedId-cal';
    return context.renderers.datePicker(DatePickerProps(
      id: resolvedId,
      value: component.value,
      label: component.label,
      placeholder: component.placeholder,
      minDate: component.minDate,
      maxDate: component.maxDate,
      disabled: component.disabled,
      error: component.error,
      clearable: component.clearable,
      size: _propsSize,
      mode: _propsMode,
      rangeValue: _propsRangeValue,
      isOpen: _isOpen,
      displayText: _displayText,
      onToggle: _toggleOpen,
      onSelect: _selectDate,
      onRangeSelect: (range) => _selectRange(DateRange(start: range.start, end: range.end)),
      onClear: _clear,
      styles: component.styles,
      decoration: component.decoration,
      calendarProps: CalendarProps(
        id: calendarId,
        selected: component.value,
        displayMonth: _displayMonth,
        minDate: component.minDate,
        maxDate: component.maxDate,
        mode: _propsMode,
        selectedRange: _propsRangeValue,
        isDisabled: _isDisabled,
        onPreviousMonth: () {
          setState(() {
            _displayMonth = DateTime(_displayMonth.year, _displayMonth.month - 1, 1);
          });
        },
        onNextMonth: () {
          setState(() {
            _displayMonth = DateTime(_displayMonth.year, _displayMonth.month + 1, 1);
          });
        },
        onGoToToday: () {
          final DateTime now = DateTime.now();
          setState(() {
            _displayMonth = DateTime(now.year, now.month, 1);
          });
        },
        onSelectDate: _selectDate,
      ),
    ));
  }
}
