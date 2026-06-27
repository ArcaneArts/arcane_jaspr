import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/calendar_props.dart';
import 'package:arcane_jaspr/core/props/date_picker_props.dart';
import 'package:arcane_jaspr/core/rendering/base/date_picker_render_base.dart';
import 'calendar.dart';

/// Neon date picker renderer with restrained panel styling.
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
  Map<String, String> get rootStyles => const <String, String>{
    'position': 'relative',
    'display': 'flex',
    'flex-direction': 'column',
    'gap': 'var(--space-2)',
  };

  @override
  Map<String, String> get labelStyles => const <String, String>{
    'font-family': 'var(--font-heading)',
    'font-size': '0.75rem',
    'font-weight': '600',
    'letter-spacing': '0.08em',
    'text-transform': 'uppercase',
    'color': 'var(--muted-foreground)',
  };

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
  }) => <String, String>{
    'display': 'flex',
    'align-items': 'center',
    'gap': '0.75rem',
    'width': '100%',
    'height': height,
    'padding': '0 1rem',
    'background':
        'linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 5%, transparent), color-mix(in srgb, var(--card) 86%, transparent))',
    'border': hasError
        ? '1px solid var(--destructive)'
        : '1px solid var(--neon-control-border)',
    'clip-path': 'var(--neon-control-clip)',
    'font-size': fontSize,
    'color': hasValue ? 'var(--foreground)' : 'var(--muted-foreground)',
    'cursor': props.disabled ? 'not-allowed' : 'pointer',
    'transition': 'border-color 0.18s ease, box-shadow 0.18s ease',
    'box-shadow': 'var(--neon-inset)',
    if (props.disabled) 'opacity': '0.5',
  };

  @override
  Map<String, String> get iconStyles => const <String, String>{
    'display': 'flex',
    'color': 'var(--muted-foreground)',
  };

  @override
  Map<String, String> get displayStyles => const <String, String>{
    'flex': '1',
    'overflow': 'hidden',
    'text-overflow': 'ellipsis',
    'white-space': 'nowrap',
    'text-align': 'left',
  };

  @override
  String get clearClasses => 'neon-date-picker-clear';

  @override
  Map<String, String> get clearExtraAttrs => const <String, String>{
    'data-state': 'clearable',
  };

  @override
  Map<String, String> get clearStyles => const <String, String>{
    'display': 'flex',
    'color': 'var(--muted-foreground)',
    'cursor': 'pointer',
  };

  @override
  String get dropdownClasses => 'neon-date-picker-dropdown neon-date-picker';

  @override
  Map<String, String> get dropdownStyles => const <String, String>{
    'position': 'absolute',
    'top': '100%',
    'left': '0',
    'margin-top': '0.5rem',
    'z-index': '50',
  };

  @override
  Component buildCalendar(CalendarProps calendarProps) =>
      NeonCalendar(calendarProps);
}
