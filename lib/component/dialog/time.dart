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
import '../input/button.dart';
import '../input/time_picker.dart';
import 'dialog.dart';

/// A time picker dialog.
///
/// ```dart
/// ArcaneTimeDialog(
///   title: 'Select Time',
///   initialTime: TimeOfDay(hour: 14, minute: 30),
///   onConfirm: (time) => handleTime(time),
///   onCancel: () => closeDialog(),
/// )
/// ```
class ArcaneTimeDialog extends StatefulComponent {
  /// Dialog title
  final String title;

  /// Optional message/description
  final String? message;

  /// Initial time
  final TimeOfDay? initialTime;

  /// Confirm button text
  final String confirmText;

  /// Cancel button text
  final String cancelText;

  /// Confirm callback with the selected time
  final void Function(TimeOfDay time)? onConfirm;

  /// Cancel callback
  final void Function()? onCancel;

  /// Whether to use 24-hour format
  final bool use24Hour;

  /// Minute interval
  final int minuteInterval;

  /// Whether to show seconds selector
  final bool showSeconds;

  const ArcaneTimeDialog({
    required this.title,
    this.message,
    this.initialTime,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.use24Hour = false,
    this.minuteInterval = 1,
    this.showSeconds = false,
    super.key,
  });

  @override
  State<ArcaneTimeDialog> createState() => _TimeDialogState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-time-dialog-column::-webkit-scrollbar').styles(raw: {
      'width': '4px',
    }),
    css('.arcane-time-dialog-column::-webkit-scrollbar-thumb').styles(raw: {
      'background': ArcaneColors.border,
      'border-radius': ArcaneRadius.full,
    }),
    css('.arcane-time-dialog-option:hover').styles(raw: {
      'background': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-time-dialog-option.selected').styles(raw: {
      'background': ArcaneColors.accent,
      'color': ArcaneColors.accentForeground,
    }),
  ];
}

class _TimeDialogState extends State<ArcaneTimeDialog> {
  late int _hour;
  late int _minute;
  late int _second;
  late bool _isPM;

  @override
  void initState() {
    super.initState();
    final initial = component.initialTime ?? TimeOfDay.now();
    _hour = component.use24Hour ? initial.hour : initial.hourOfPeriod;
    _minute = initial.minute;
    _second = 0;
    _isPM = initial.isPM;
  }

  void _handleConfirm() {
    int hour24 = _hour;
    if (!component.use24Hour) {
      if (_isPM && _hour != 12) {
        hour24 = _hour + 12;
      } else if (!_isPM && _hour == 12) {
        hour24 = 0;
      }
    }
    component.onConfirm?.call(TimeOfDay(hour: hour24, minute: _minute));
  }

  @override
  Component build(BuildContext context) {
    return ArcaneDialog(
      title: component.title,
      onClose: component.onCancel,
      maxWidth: 400,
      child: div(
        classes: 'arcane-time-dialog-content',
        styles: const Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': ArcaneSpacing.lg,
        }),
        [
          if (component.message != null)
            div(
              styles: const Styles(raw: {
                'color': ArcaneColors.muted,
                'font-size': ArcaneTypography.fontSm,
                'line-height': ArcaneTypography.lineHeightRelaxed,
              }),
              [text(component.message!)],
            ),

          // Time display
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'justify-content': 'center',
              'align-items': 'center',
              'gap': ArcaneSpacing.sm,
              'font-size': ArcaneTypography.font3xl,
              'font-weight': ArcaneTypography.weightBold,
              'font-variant-numeric': 'tabular-nums',
              'color': ArcaneColors.onSurface,
            }),
            [
              text(_hour.toString().padLeft(2, '0')),
              text(':'),
              text(_minute.toString().padLeft(2, '0')),
              if (component.showSeconds) ...[
                text(':'),
                text(_second.toString().padLeft(2, '0')),
              ],
              if (!component.use24Hour)
                span(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontLg,
                    'margin-left': ArcaneSpacing.sm,
                    'color': ArcaneColors.muted,
                  }),
                  [text(_isPM ? 'PM' : 'AM')],
                ),
            ],
          ),

          // Time selection columns
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'justify-content': 'center',
              'gap': ArcaneSpacing.md,
            }),
            [
              // Hours column
              _buildTimeColumn(
                label: 'Hour',
                values: component.use24Hour
                    ? List.generate(24, (i) => i)
                    : List.generate(12, (i) => i == 0 ? 12 : i),
                selectedValue: _hour,
                onSelect: (h) => setState(() => _hour = h),
              ),

              // Minutes column
              _buildTimeColumn(
                label: 'Minute',
                values: List.generate(
                  60 ~/ component.minuteInterval,
                  (i) => i * component.minuteInterval,
                ),
                selectedValue: _minute,
                onSelect: (m) => setState(() => _minute = m),
                padZero: true,
              ),

              // Seconds column (if enabled)
              if (component.showSeconds)
                _buildTimeColumn(
                  label: 'Second',
                  values: List.generate(60, (i) => i),
                  selectedValue: _second,
                  onSelect: (s) => setState(() => _second = s),
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
                    span(
                      styles: const Styles(raw: {
                        'font-size': ArcaneTypography.fontXs,
                        'font-weight': ArcaneTypography.weightMedium,
                        'color': ArcaneColors.muted,
                        'text-transform': 'uppercase',
                        'text-align': 'center',
                        'margin-bottom': ArcaneSpacing.xs,
                      }),
                      [text('Period')],
                    ),
                    button(
                      classes:
                          'arcane-time-dialog-option ${!_isPM ? 'selected' : ''}',
                      styles: Styles(raw: {
                        'padding':
                            '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
                        'border': 'none',
                        'border-radius': ArcaneRadius.md,
                        'background': !_isPM
                            ? ArcaneColors.accent
                            : 'transparent',
                        'color': !_isPM
                            ? ArcaneColors.accentForeground
                            : ArcaneColors.onSurface,
                        'cursor': 'pointer',
                        'font-size': ArcaneTypography.fontSm,
                        'transition': ArcaneEffects.transitionFast,
                      }),
                      events: {
                        'click': (_) {
                          if (_isPM) setState(() => _isPM = false);
                        },
                      },
                      [text('AM')],
                    ),
                    button(
                      classes:
                          'arcane-time-dialog-option ${_isPM ? 'selected' : ''}',
                      styles: Styles(raw: {
                        'padding':
                            '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
                        'border': 'none',
                        'border-radius': ArcaneRadius.md,
                        'background':
                            _isPM ? ArcaneColors.accent : 'transparent',
                        'color': _isPM
                            ? ArcaneColors.accentForeground
                            : ArcaneColors.onSurface,
                        'cursor': 'pointer',
                        'font-size': ArcaneTypography.fontSm,
                        'transition': ArcaneEffects.transitionFast,
                      }),
                      events: {
                        'click': (_) {
                          if (!_isPM) setState(() => _isPM = true);
                        },
                      },
                      [text('PM')],
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
      actions: [
        ArcaneButton.outline(
          label: component.cancelText,
          onPressed: component.onCancel,
        ),
        ArcaneButton.primary(
          label: component.confirmText,
          onPressed: _handleConfirm,
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
            'text-align': 'center',
            'margin-bottom': ArcaneSpacing.xs,
          }),
          [text(label)],
        ),
        div(
          classes: 'arcane-time-dialog-column',
          styles: const Styles(raw: {
            'max-height': '160px',
            'overflow-y': 'auto',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '2px',
          }),
          [
            for (final value in values)
              button(
                classes:
                    'arcane-time-dialog-option ${value == selectedValue ? 'selected' : ''}',
                styles: Styles(raw: {
                  'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.md}',
                  'border': 'none',
                  'border-radius': ArcaneRadius.md,
                  'background': value == selectedValue
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
                  'click': (_) => onSelect(value),
                },
                [
                  text(padZero ? value.toString().padLeft(2, '0') : '$value')
                ],
              ),
          ],
        ),
      ],
    );
  }
}
