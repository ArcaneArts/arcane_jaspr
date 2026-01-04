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

/// Represents a time of day with hour and minute.
class TimeOfDay {
  final int hour;
  final int minute;

  const TimeOfDay({required this.hour, required this.minute});

  /// Creates a TimeOfDay from the current time.
  factory TimeOfDay.now() {
    final now = DateTime.now();
    return TimeOfDay(hour: now.hour, minute: now.minute);
  }

  /// Creates a TimeOfDay from a DateTime.
  factory TimeOfDay.fromDateTime(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  /// Returns the hour in 12-hour format (1-12).
  int get hourOfPeriod => hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);

  /// Returns whether this time is AM or PM.
  bool get isPM => hour >= 12;

  /// Returns a formatted string.
  String format({bool use24Hour = false}) {
    if (use24Hour) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
    final period = isPM ? 'PM' : 'AM';
    return '${hourOfPeriod.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  /// Creates a copy with the given fields replaced.
  TimeOfDay copyWith({int? hour, int? minute}) {
    return TimeOfDay(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
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

/// A time picker input with dropdown selection.
///
/// Example:
/// ```dart
/// ArcaneTimePicker(
///   value: selectedTime,
///   onChanged: (time) => setState(() => selectedTime = time),
///   label: 'Start Time',
/// )
/// ```
class ArcaneTimePicker extends StatefulComponent {
  /// Currently selected time
  final TimeOfDay? value;

  /// Called when time changes
  final void Function(TimeOfDay?)? onChanged;

  /// Label above the input
  final String? label;

  /// Placeholder text
  final String? placeholder;

  /// Whether to use 24-hour format
  final bool use24Hour;

  /// Minute interval (1, 5, 10, 15, 30)
  final int minuteInterval;

  /// Whether the picker is disabled
  final bool disabled;

  /// Error message
  final String? error;

  /// Whether to allow clearing
  final bool clearable;

  /// Whether to show seconds
  final bool showSeconds;

  /// Size variant
  final TimePickerSize size;

  const ArcaneTimePicker({
    this.value,
    this.onChanged,
    this.label,
    this.placeholder,
    this.use24Hour = false,
    this.minuteInterval = 1,
    this.disabled = false,
    this.error,
    this.clearable = true,
    this.showSeconds = false,
    this.size = TimePickerSize.md,
    super.key,
  });

  @override
  State<ArcaneTimePicker> createState() => _ArcaneTimePickerState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-time-picker-trigger:hover:not(.disabled)').styles(raw: {
      'border-color': ArcaneColors.accent,
    }),
    css('.arcane-time-picker-trigger:focus').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
      'outline': 'none',
    }),
    css('.arcane-time-picker-clear:hover').styles(raw: {
      'color': ArcaneColors.error,
    }),
    css('.arcane-time-picker-option:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-time-picker-option.selected').styles(raw: {
      'background-color': ArcaneColors.accent,
      'color': ArcaneColors.accentForeground,
    }),
  ];
}

class _ArcaneTimePickerState extends State<ArcaneTimePicker> {
  bool _isOpen = false;
  int _selectedHour = 0;
  int _selectedMinute = 0;
  bool _isPM = false;

  @override
  void initState() {
    super.initState();
    _initFromValue();
  }

  void _initFromValue() {
    if (component.value != null) {
      _selectedHour = component.use24Hour
          ? component.value!.hour
          : component.value!.hourOfPeriod;
      _selectedMinute = component.value!.minute;
      _isPM = component.value!.isPM;
    } else {
      final now = TimeOfDay.now();
      _selectedHour = component.use24Hour ? now.hour : now.hourOfPeriod;
      _selectedMinute = 0;
      _isPM = now.isPM;
    }
  }

  String get _displayText {
    if (component.value == null) {
      return component.placeholder ?? 'Select time...';
    }
    return component.value!.format(use24Hour: component.use24Hour);
  }

  void _toggleOpen() {
    if (component.disabled) return;
    setState(() => _isOpen = !_isOpen);
  }

  void _selectHour(int hour) {
    setState(() => _selectedHour = hour);
    _emitChange();
  }

  void _selectMinute(int minute) {
    setState(() => _selectedMinute = minute);
    _emitChange();
  }

  void _togglePeriod() {
    setState(() => _isPM = !_isPM);
    _emitChange();
  }

  void _emitChange() {
    int hour24 = _selectedHour;
    if (!component.use24Hour) {
      if (_isPM && _selectedHour != 12) {
        hour24 = _selectedHour + 12;
      } else if (!_isPM && _selectedHour == 12) {
        hour24 = 0;
      }
    }
    component.onChanged?.call(TimeOfDay(hour: hour24, minute: _selectedMinute));
  }

  void _clear() {
    component.onChanged?.call(null);
    setState(() => _isOpen = false);
  }

  void _confirm() {
    _emitChange();
    setState(() => _isOpen = false);
  }

  @override
  Component build(BuildContext context) {
    final hasError = component.error != null;
    final hasValue = component.value != null;
    final sizeStyles = component.size.styles;

    return div(
      classes:
          'arcane-time-picker ${_isOpen ? 'open' : ''} ${component.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}',
      attributes: {
        'data-time-picker': 'true',
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
          classes:
              'arcane-time-picker-trigger ${component.disabled ? 'disabled' : ''}',
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
            'border':
                '1px solid ${hasError ? ArcaneColors.error : ArcaneColors.border}',
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
            const span(
              styles: Styles(raw: {
                'color': ArcaneColors.muted,
              }),
              [Component.text('🕐')],
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
                classes: 'arcane-time-picker-clear',
                attributes: {
                  'role': 'button',
                  'aria-label': 'Clear time',
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
                [const Component.text('✕')],
              ),
          ],
        ),

        // Time picker dropdown
        if (_isOpen)
          div(
            classes: 'arcane-time-picker-dropdown',
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'margin-top': ArcaneSpacing.xs,
              'z-index': '100',
              'background-color': ArcaneColors.surface,
              'border': '1px solid ${ArcaneColors.border}',
              'border-radius': ArcaneRadius.lg,
              'box-shadow': ArcaneEffects.shadowLg,
              'padding': ArcaneSpacing.md,
              'min-width': '280px',
            }),
            [
              // Time selection columns
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'gap': ArcaneSpacing.md,
                }),
                [
                  // Hours column
                  _buildTimeColumn(
                    label: 'Hour',
                    values: component.use24Hour
                        ? List.generate(24, (i) => i)
                        : List.generate(12, (i) => i == 0 ? 12 : i),
                    selectedValue: _selectedHour,
                    onSelect: _selectHour,
                  ),

                  // Minutes column
                  _buildTimeColumn(
                    label: 'Minute',
                    values: List.generate(
                      60 ~/ component.minuteInterval,
                      (i) => i * component.minuteInterval,
                    ),
                    selectedValue: _selectedMinute,
                    onSelect: _selectMinute,
                    padZero: true,
                  ),

                  // AM/PM selector (12-hour mode only)
                  if (!component.use24Hour)
                    div(
                      styles: const Styles(raw: {
                        'display': 'flex',
                        'flex-direction': 'column',
                        'gap': ArcaneSpacing.xs,
                      }),
                      [
                        const span(
                          styles: Styles(raw: {
                            'font-size': ArcaneTypography.fontXs,
                            'font-weight': ArcaneTypography.weightMedium,
                            'color': ArcaneColors.muted,
                            'text-transform': 'uppercase',
                            'margin-bottom': ArcaneSpacing.xs,
                          }),
                          [Component.text('Period')],
                        ),
                        button(
                          classes:
                              'arcane-time-picker-option ${!_isPM ? 'selected' : ''}',
                          styles: Styles(raw: {
                            'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
                            'border': 'none',
                            'border-radius': ArcaneRadius.md,
                            'background-color':
                                !_isPM ? ArcaneColors.accent : 'transparent',
                            'color': !_isPM
                                ? ArcaneColors.accentForeground
                                : ArcaneColors.onSurface,
                            'cursor': 'pointer',
                            'font-size': ArcaneTypography.fontSm,
                            'transition': ArcaneEffects.transitionFast,
                          }),
                          events: {
                            'click': (e) {
                              if (_isPM) _togglePeriod();
                            },
                          },
                          [const Component.text('AM')],
                        ),
                        button(
                          classes:
                              'arcane-time-picker-option ${_isPM ? 'selected' : ''}',
                          styles: Styles(raw: {
                            'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
                            'border': 'none',
                            'border-radius': ArcaneRadius.md,
                            'background-color':
                                _isPM ? ArcaneColors.accent : 'transparent',
                            'color': _isPM
                                ? ArcaneColors.accentForeground
                                : ArcaneColors.onSurface,
                            'cursor': 'pointer',
                            'font-size': ArcaneTypography.fontSm,
                            'transition': ArcaneEffects.transitionFast,
                          }),
                          events: {
                            'click': (e) {
                              if (!_isPM) _togglePeriod();
                            },
                          },
                          [const Component.text('PM')],
                        ),
                      ],
                    ),
                ],
              ),

              // Action buttons
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'flex-end',
                  'gap': ArcaneSpacing.sm,
                  'margin-top': ArcaneSpacing.md,
                  'padding-top': ArcaneSpacing.md,
                  'border-top': '1px solid ${ArcaneColors.border}',
                }),
                [
                  button(
                    styles: const Styles(raw: {
                      'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
                      'border': '1px solid ${ArcaneColors.border}',
                      'border-radius': ArcaneRadius.md,
                      'background-color': 'transparent',
                      'color': ArcaneColors.onSurface,
                      'cursor': 'pointer',
                      'font-size': ArcaneTypography.fontSm,
                    }),
                    events: {
                      'click': (e) => setState(() => _isOpen = false),
                    },
                    [const Component.text('Cancel')],
                  ),
                  button(
                    styles: const Styles(raw: {
                      'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
                      'border': 'none',
                      'border-radius': ArcaneRadius.md,
                      'background-color': ArcaneColors.accent,
                      'color': ArcaneColors.accentForeground,
                      'cursor': 'pointer',
                      'font-size': ArcaneTypography.fontSm,
                    }),
                    events: {
                      'click': (e) => _confirm(),
                    },
                    [const Component.text('Confirm')],
                  ),
                ],
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

  Component _buildTimeColumn({
    required String label,
    required List<int> values,
    required int selectedValue,
    required void Function(int) onSelect,
    bool padZero = false,
  }) {
    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.xs,
      }),
      [
        span(
          styles: const Styles(raw: {
            'font-size': ArcaneTypography.fontXs,
            'font-weight': ArcaneTypography.weightMedium,
            'color': ArcaneColors.muted,
            'text-transform': 'uppercase',
            'margin-bottom': ArcaneSpacing.xs,
          }),
          [Component.text(label)],
        ),
        div(
          styles: const Styles(raw: {
            'max-height': '200px',
            'overflow-y': 'auto',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '2px',
          }),
          [
            for (final value in values)
              button(
                classes:
                    'arcane-time-picker-option ${value == selectedValue ? 'selected' : ''}',
                styles: Styles(raw: {
                  'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.md}',
                  'border': 'none',
                  'border-radius': ArcaneRadius.md,
                  'background-color': value == selectedValue
                      ? ArcaneColors.accent
                      : 'transparent',
                  'color': value == selectedValue
                      ? ArcaneColors.accentForeground
                      : ArcaneColors.onSurface,
                  'cursor': 'pointer',
                  'font-size': ArcaneTypography.fontSm,
                  'text-align': 'center',
                  'min-width': '48px',
                  'transition': ArcaneEffects.transitionFast,
                }),
                events: {
                  'click': (e) => onSelect(value),
                },
                [
                  Component.text(
                      padZero ? value.toString().padLeft(2, '0') : '$value')
                ],
              ),
          ],
        ),
      ],
    );
  }
}

/// Size variants for time picker
enum TimePickerSize {
  sm,
  md,
  lg,
}

extension TimePickerSizeExtension on TimePickerSize {
  Map<String, String> get styles => switch (this) {
        TimePickerSize.sm => {
            'height': ArcaneLayout.inputHeightSm,
            'fontSize': ArcaneTypography.fontSm,
          },
        TimePickerSize.md => {
            'height': ArcaneLayout.inputHeightMd,
            'fontSize': ArcaneTypography.fontSm,
          },
        TimePickerSize.lg => {
            'height': ArcaneLayout.inputHeightLg,
            'fontSize': ArcaneTypography.fontMd,
          },
      };
}