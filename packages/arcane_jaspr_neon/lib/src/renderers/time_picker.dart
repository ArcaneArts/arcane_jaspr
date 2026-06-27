import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/time_picker_props.dart';
import 'package:arcane_jaspr/core/rendering/base/time_picker_render_base.dart';

/// Neon Time Picker renderer.
class NeonTimePicker extends TimePickerRenderBase {
  const NeonTimePicker(super.props, {super.key});

  @override
  Map<String, String> get sizeStyles => switch (props.size) {
    ComponentSize.sm => const <String, String>{
      'height': '36px',
      'fontSize': '0.875rem',
    },
    ComponentSize.md => const <String, String>{
      'height': '44px',
      'fontSize': '0.875rem',
    },
    ComponentSize.lg => const <String, String>{
      'height': '52px',
      'fontSize': '1rem',
    },
  };

  @override
  String rootClasses(bool hasError) =>
      'neon-time-picker ${props.isOpen ? 'open' : ''} ${props.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}';

  @override
  Map<String, String> get rootAttributes => <String, String>{
    'data-state': props.isOpen ? 'open' : 'closed',
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
  String get triggerClasses =>
      'neon-time-picker-trigger ${props.disabled ? 'disabled' : ''}';

  @override
  Map<String, String> get triggerAttributes => <String, String>{
    'aria-haspopup': 'dialog',
    'aria-expanded': '${props.isOpen}',
    'data-state': props.isOpen ? 'open' : 'closed',
    'data-disabled': '${props.disabled}',
    if (props.disabled) 'disabled': 'true',
  };

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
    'border':
        '1px solid ${hasError ? 'var(--destructive)' : 'var(--neon-control-border)'}',
    'clip-path': 'var(--neon-control-clip)',
    'font-size': fontSize,
    'color': hasValue ? 'var(--foreground)' : 'var(--muted-foreground)',
    'cursor': props.disabled ? 'not-allowed' : 'pointer',
    'transition': 'border-color 0.18s ease, box-shadow 0.18s ease',
    'box-shadow': props.isOpen ? 'var(--neon-glow-md)' : 'var(--neon-inset)',
    'text-align': 'left',
    if (props.disabled) 'opacity': '0.5',
  };

  @override
  Map<String, String> get iconStyles => <String, String>{
    'color': props.isOpen ? 'var(--neon-accent)' : 'var(--muted-foreground)',
    'display': 'flex',
  };

  @override
  String get clearClasses => 'neon-time-picker-clear';

  @override
  Map<String, String> get clearStyles => const <String, String>{
    'color': 'var(--muted-foreground)',
    'cursor': 'pointer',
    'transition': 'color var(--arcane-transition)',
  };

  @override
  String get dropdownClasses => 'neon-time-picker-dropdown neon-time-picker';

  @override
  Map<String, String> get dropdownStyles => const <String, String>{
    'position': 'absolute',
    'top': '100%',
    'left': '0',
    'margin-top': '0.5rem',
    'z-index': '50',
    'padding': '1.25rem',
    'min-width': '300px',
  };

  @override
  Map<String, String> get columnsRowStyles => const <String, String>{
    'display': 'flex',
    'gap': '1.25rem',
  };

  @override
  Map<String, String> get columnStyles => const <String, String>{
    'display': 'flex',
    'flex-direction': 'column',
    'gap': 'var(--space-2)',
  };

  @override
  Map<String, String> get columnLabelStyles => const <String, String>{
    'font-family': 'var(--font-heading)',
    'font-size': '0.6875rem',
    'font-weight': '600',
    'letter-spacing': '0.12em',
    'color': 'var(--muted-foreground)',
    'text-transform': 'uppercase',
    'margin-bottom': '0.5rem',
  };

  @override
  Map<String, String> get columnScrollStyles => const <String, String>{
    'max-height': '220px',
    'overflow-y': 'auto',
    'display': 'flex',
    'flex-direction': 'column',
    'gap': '4px',
  };

  @override
  String get optionClass => 'neon-time-picker-option';

  @override
  Map<String, String> optionButtonStyles({required bool selected}) =>
      <String, String>{
        'padding': '0.375rem 0.875rem',
        'border': selected
            ? '1px solid var(--neon-accent)'
            : '1px solid transparent',
        'clip-path': 'var(--neon-clip-xs)',
        'background': selected ? 'var(--neon-accent)' : 'transparent',
        'color': selected ? 'var(--neon-on-accent)' : 'var(--foreground)',
        'cursor': 'pointer',
        'font-size': 'var(--font-size-sm)',
        'font-variant-numeric': 'tabular-nums',
        'text-align': 'center',
        'min-width': '52px',
        'transition': 'background 0.15s ease, color 0.15s ease',
      };

  @override
  Map<String, String> amPmButtonStyles({required bool selected}) =>
      <String, String>{
        'padding': '0.5rem 1rem',
        'border': selected
            ? '1px solid var(--neon-accent)'
            : '1px solid transparent',
        'clip-path': 'var(--neon-clip-xs)',
        'background': selected ? 'var(--neon-accent)' : 'transparent',
        'color': selected ? 'var(--neon-on-accent)' : 'var(--foreground)',
        'cursor': 'pointer',
        'font-size': 'var(--font-size-sm)',
        'font-weight': '600',
        'letter-spacing': '0.04em',
        'transition': 'background 0.15s ease, color 0.15s ease',
      };

  @override
  Map<String, String> get actionsRowStyles => const <String, String>{
    'display': 'flex',
    'justify-content': 'flex-end',
    'gap': '0.75rem',
    'margin-top': '1.25rem',
    'padding-top': '1.25rem',
    'border-top': '1px solid var(--neon-panel-border)',
  };

  @override
  Component buildActionButton({
    required bool primary,
    required void Function()? onClick,
    required String label,
  }) {
    return dom.button(
      type: dom.ButtonType.button,
      classes: 'neon-button',
      attributes: <String, String>{'data-variant': primary ? 'primary' : 'ghost'},
      styles: dom.Styles(
        raw: primary
            ? const <String, String>{
                'padding': '0.5rem 1rem',
                'cursor': 'pointer',
                'font-size': 'var(--font-size-sm)',
              }
            : const <String, String>{
                'padding': '0.5rem 1rem',
                'background': 'transparent',
                'color': 'var(--foreground)',
                'cursor': 'pointer',
                'font-size': 'var(--font-size-sm)',
              },
      ),
      events: <String, EventCallback>{'click': (_) => onClick?.call()},
      <Component>[Component.text(label)],
    );
  }
}
