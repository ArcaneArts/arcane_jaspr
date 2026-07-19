import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/time_picker_props.dart';
import 'package:arcane_jaspr/core/rendering/base/time_picker_render_base.dart';

/// Neubrutalism Time Picker renderer.
class NeubrutalismTimePicker extends TimePickerRenderBase {
  const NeubrutalismTimePicker(super.props, {super.key});

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
      'neubrutalism-time-picker ${props.isOpen ? 'open' : ''} ${props.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}';

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
      'neubrutalism-time-picker-trigger ${props.disabled ? 'disabled' : ''}';

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
    'background': 'var(--nb-paper, var(--card))',
    'border':
        'var(--nb-border-thick, 3px) solid ${hasError ? 'var(--destructive)' : 'var(--nb-line, #000)'}',
    'font-size': fontSize,
    'font-weight': '600',
    'color': hasValue
        ? 'var(--nb-ink, var(--foreground))'
        : 'var(--muted-foreground)',
    'cursor': props.disabled ? 'not-allowed' : 'pointer',
    'transition':
        'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease)',
    'box-shadow': props.isOpen
        ? 'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))'
        : 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
    'transform': props.isOpen ? 'translate(2px, 2px)' : 'translate(0, 0)',
    'text-align': 'left',
    if (props.disabled) 'opacity': '0.5',
  };

  @override
  Map<String, String> get iconStyles => <String, String>{
    'color': props.isOpen
        ? 'var(--nb-accent, var(--primary))'
        : 'var(--muted-foreground)',
    'display': 'flex',
  };

  @override
  String get clearClasses => 'neubrutalism-time-picker-clear';

  @override
  Map<String, String> get clearStyles => const <String, String>{
    'color': 'var(--muted-foreground)',
    'cursor': 'pointer',
    'transition': 'color var(--nb-transition, 120ms ease)',
  };

  @override
  String get dropdownClasses =>
      'neubrutalism-time-picker-dropdown neubrutalism-time-picker';

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
  String get optionClass => 'neubrutalism-time-picker-option';

  @override
  Map<String, String> optionButtonStyles({required bool selected}) =>
      <String, String>{
        'padding': '0.375rem 0.875rem',
        'border':
            'var(--nb-border-thick, 3px) solid ${selected ? 'var(--nb-line, #000)' : 'transparent'}',
        'background': selected ? 'var(--nb-accent, var(--primary))' : 'transparent',
        'color': selected ? 'var(--nb-ink, #000)' : 'var(--foreground)',
        'cursor': 'pointer',
        'font-weight': selected ? '700' : '500',
        'font-size': 'var(--font-size-sm)',
        'font-variant-numeric': 'tabular-nums',
        'text-align': 'center',
        'min-width': '52px',
        'box-shadow': selected
            ? 'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))'
            : 'none',
        'transition':
            'background var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
      };

  @override
  Map<String, String> amPmButtonStyles({required bool selected}) =>
      <String, String>{
        'padding': '0.5rem 1rem',
        'border':
            'var(--nb-border-thick, 3px) solid ${selected ? 'var(--nb-line, #000)' : 'transparent'}',
        'background': selected ? 'var(--nb-accent, var(--primary))' : 'transparent',
        'color': selected ? 'var(--nb-ink, #000)' : 'var(--foreground)',
        'cursor': 'pointer',
        'font-size': 'var(--font-size-sm)',
        'font-weight': '700',
        'letter-spacing': '0.04em',
        'box-shadow': selected
            ? 'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))'
            : 'none',
        'transition':
            'background var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
      };

  @override
  Map<String, String> get actionsRowStyles => const <String, String>{
    'display': 'flex',
    'justify-content': 'flex-end',
    'gap': '0.75rem',
    'margin-top': '1.25rem',
    'padding-top': '1.25rem',
    'border-top': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
  };

  @override
  Component buildActionButton({
    required bool primary,
    required void Function()? onClick,
    required String label,
  }) {
    return dom.button(
      type: dom.ButtonType.button,
      classes: 'neubrutalism-button',
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
