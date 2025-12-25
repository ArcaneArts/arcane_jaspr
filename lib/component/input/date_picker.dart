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
import 'calendar.dart';

/// A date picker input with calendar dropdown.
///
/// Example:
/// ```dart
/// ArcaneDatePicker(
///   value: selectedDate,
///   onChanged: (date) => setState(() => selectedDate = date),
///   label: 'Birth Date',
///   placeholder: 'Select date...',
/// )
/// ```
class ArcaneDatePicker extends StatefulComponent {
  /// Currently selected date
  final DateTime? value;

  /// Called when date changes
  final void Function(DateTime?)? onChanged;

  /// Label above the input
  final String? label;

  /// Placeholder text
  final String? placeholder;

  /// Date format function
  final String Function(DateTime)? formatDate;

  /// Minimum selectable date
  final DateTime? minDate;

  /// Maximum selectable date
  final DateTime? maxDate;

  /// Custom function to disable specific dates
  final bool Function(DateTime)? disabledDates;

  /// Whether the picker is disabled
  final bool disabled;

  /// Error message
  final String? error;

  /// Whether to allow clearing the date
  final bool clearable;

  /// Size variant
  final DatePickerSize size;

  /// Selection mode
  final CalendarMode mode;

  /// Selected date range (for range mode)
  final DateRange? rangeValue;

  /// Called when range is selected
  final void Function(DateRange?)? onRangeChanged;

  const ArcaneDatePicker({
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
    super.key,
  });

  /// Creates a date range picker
  const ArcaneDatePicker.range({
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
    super.key,
  })  : value = null,
        onChanged = null,
        mode = CalendarMode.range;

  @override
  State<ArcaneDatePicker> createState() => _ArcaneDatePickerState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-date-picker-trigger:hover:not(.disabled)').styles(raw: {
      'border-color': ArcaneColors.accent,
    }),
    css('.arcane-date-picker-trigger:focus').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
      'outline': 'none',
    }),
    css('.arcane-date-picker-clear:hover').styles(raw: {
      'color': ArcaneColors.error,
    }),
  ];
}

class _ArcaneDatePickerState extends State<ArcaneDatePicker> {
  bool _isOpen = false;

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

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

  @override
  Component build(BuildContext context) {
    final hasError = component.error != null;
    final hasValue = component.mode == CalendarMode.range
        ? component.rangeValue != null
        : component.value != null;
    final sizeStyles = component.size.styles;

    return div(
      classes: 'arcane-date-picker ${_isOpen ? 'open' : ''} ${component.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}',
      attributes: {
        'data-date-picker': 'true',
      },
      styles: const Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.xs,
      }),
      [
        // Label
        if (component.label != null)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
            }),
            [Component.text(component.label!)],
          ),

        // Trigger button
        button(
          classes: 'arcane-date-picker-trigger ${component.disabled ? 'disabled' : ''}',
          attributes: {
            'type': 'button',
            'aria-haspopup': 'dialog',
            'aria-expanded': '$_isOpen',
            if (component.disabled) 'disabled': 'true',
          },
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.sm,
            'width': '100%',
            'height': sizeStyles['height']!,
            'padding': '0 ${ArcaneSpacing.md}',
            'background-color': ArcaneColors.surface,
            'border': '1px solid ${hasError ? ArcaneColors.error : ArcaneColors.border}',
            'border-radius': ArcaneRadius.md,
            'font-size': sizeStyles['fontSize']!,
            'color': hasValue ? ArcaneColors.onSurface : ArcaneColors.muted,
            'cursor': component.disabled ? 'not-allowed' : 'pointer',
            'transition': ArcaneEffects.transitionFast,
            'text-align': 'left',
            if (component.disabled) 'opacity': '0.5',
          }),
          events: {
            'click': (e) => _toggleOpen(),
          },
          [
            span(
              styles: const Styles(raw: {
                'color': ArcaneColors.muted,
              }),
              [Component.text('📅')],
            ),
            span(
              styles: const Styles(raw: {
                'flex': '1',
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
              }),
              [Component.text(_displayText)],
            ),
            if (hasValue && component.clearable)
              span(
                classes: 'arcane-date-picker-clear',
                attributes: {
                  'role': 'button',
                  'aria-label': 'Clear date',
                },
                styles: const Styles(raw: {
                  'color': ArcaneColors.muted,
                  'cursor': 'pointer',
                  'transition': ArcaneEffects.transitionFast,
                }),
                events: {
                  'click': (e) {
                    e.stopPropagation();
                    _clear();
                  },
                },
                [Component.text('✕')],
              ),
          ],
        ),

        // Calendar dropdown
        if (_isOpen)
          div(
            classes: 'arcane-date-picker-dropdown',
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'margin-top': ArcaneSpacing.xs,
              'z-index': '100',
              'box-shadow': ArcaneEffects.shadowLg,
            }),
            [
              ArcaneCalendar(
                selected: component.value,
                onSelect: _selectDate,
                selectedRange: component.rangeValue,
                onRangeSelect: _selectRange,
                mode: component.mode,
                minDate: component.minDate,
                maxDate: component.maxDate,
                disabledDates: component.disabledDates,
              ),
            ],
          ),

        // Error message
        if (hasError)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.error,
            }),
            [Component.text(component.error!)],
          ),
      ],
    );
  }
}

/// Size variants for date picker
enum DatePickerSize {
  sm,
  md,
  lg,
}

extension DatePickerSizeExtension on DatePickerSize {
  Map<String, String> get styles => switch (this) {
        DatePickerSize.sm => {
            'height': ArcaneLayout.inputHeightSm,
            'fontSize': ArcaneTypography.fontSm,
          },
        DatePickerSize.md => {
            'height': ArcaneLayout.inputHeightMd,
            'fontSize': ArcaneTypography.fontSm,
          },
        DatePickerSize.lg => {
            'height': ArcaneLayout.inputHeightLg,
            'fontSize': ArcaneTypography.fontMd,
          },
      };
}
