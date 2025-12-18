import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// A toggle switch component (Supabase-style)
class ToggleSwitch extends StatefulComponent {
  /// Whether the switch is on
  final bool value;

  /// Callback when the switch is toggled
  final void Function(bool)? onChanged;

  /// Whether the switch is disabled
  final bool disabled;

  /// Size of the switch (sm, md, lg)
  final String size;

  /// Optional label text
  final String? label;

  /// Whether to show the label on the left side
  final bool labelLeft;

  const ToggleSwitch({
    required this.value,
    this.onChanged,
    this.disabled = false,
    this.size = 'md',
    this.label,
    this.labelLeft = false,
    super.key,
  });

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  @override
  Component build(BuildContext context) {
    // Get size-specific dimensions
    final (width, height, thumbSize, thumbOffset) = switch (component.size) {
      'sm' => (36.0, 20.0, 16.0, 2.0),
      'md' => (44.0, 24.0, 20.0, 2.0),
      'lg' => (52.0, 28.0, 24.0, 2.0),
      _ => (44.0, 24.0, 20.0, 2.0),
    };

    final thumbTranslate = component.value ? (width - thumbSize - thumbOffset * 2) : 0.0;

    final switchWidget = button(
      classes: 'arcane-toggle-switch ${component.value ? 'active' : ''} ${component.disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        'role': 'switch',
        'aria-checked': component.value.toString(),
        if (component.disabled) 'disabled': 'true',
      },
      styles: Styles(raw: {
        'position': 'relative',
        'display': 'inline-flex',
        'flex-shrink': '0',
        'width': '${width}px',
        'height': '${height}px',
        'padding': '0',
        'border': 'none',
        'border-radius': 'var(--arcane-radius-full)',
        'background-color': component.value
            ? 'var(--arcane-accent)'
            : 'var(--arcane-surface-variant)',
        'cursor': component.disabled ? 'not-allowed' : 'pointer',
        'opacity': component.disabled ? '0.5' : '1',
        'transition': 'background-color var(--arcane-transition-fast)',
      }),
      events: {
        'click': (event) {
          if (!component.disabled && component.onChanged != null) {
            component.onChanged!(!component.value);
          }
        },
      },
      [
        // Thumb
        span(
          classes: 'arcane-toggle-thumb',
          styles: Styles(raw: {
            'position': 'absolute',
            'top': '${thumbOffset}px',
            'left': '${thumbOffset}px',
            'width': '${thumbSize}px',
            'height': '${thumbSize}px',
            'border-radius': '50%',
            'background-color': 'white',
            'box-shadow': '0 1px 3px rgba(0, 0, 0, 0.2)',
            'transform': 'translateX(${thumbTranslate}px)',
            'transition': 'transform var(--arcane-transition-fast)',
          }),
          [],
        ),
      ],
    );

    // If no label, return just the switch
    if (component.label == null) {
      return switchWidget;
    }

    // With label
    final labelWidget = span(
      classes: 'arcane-toggle-label',
      styles: Styles(raw: {
        'font-size': '0.875rem',
        'color': component.disabled
            ? 'var(--arcane-muted)'
            : 'var(--arcane-on-surface)',
        'user-select': 'none',
      }),
      [text(component.label!)],
    );

    return label(
      classes: 'arcane-toggle-wrapper',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '12px',
        'cursor': component.disabled ? 'not-allowed' : 'pointer',
      }),
      events: {
        'click': (event) {
          if (!component.disabled && component.onChanged != null) {
            component.onChanged!(!component.value);
          }
        },
      },
      component.labelLeft
          ? [labelWidget, switchWidget]
          : [switchWidget, labelWidget],
    );
  }
}

/// A toggle button group (like pricing monthly/yearly)
class ToggleButtonGroup extends StatelessComponent {
  /// The available options
  final List<String> options;

  /// The currently selected index
  final int selectedIndex;

  /// Callback when selection changes
  final void Function(int)? onChanged;

  /// Size of the toggle group
  final String size;

  const ToggleButtonGroup({
    required this.options,
    required this.selectedIndex,
    this.onChanged,
    this.size = 'md',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final (paddingH, paddingV, fontSize) = switch (size) {
      'sm' => (10.0, 6.0, '0.8125rem'),
      'md' => (14.0, 8.0, '0.875rem'),
      'lg' => (18.0, 10.0, '1rem'),
      _ => (14.0, 8.0, '0.875rem'),
    };

    return div(
      classes: 'arcane-toggle-button-group',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'padding': '4px',
        'background-color': 'var(--arcane-surface-variant)',
        'border-radius': 'var(--arcane-radius)',
        'gap': '2px',
      }),
      [
        for (var i = 0; i < options.length; i++)
          button(
            classes: 'arcane-toggle-button ${i == selectedIndex ? 'active' : ''}',
            attributes: {'type': 'button'},
            styles: Styles(raw: {
              'padding': '${paddingV}px ${paddingH}px',
              'font-size': fontSize,
              'font-weight': '500',
              'border': 'none',
              'border-radius': 'calc(var(--arcane-radius) - 2px)',
              'background-color': i == selectedIndex
                  ? 'var(--arcane-surface)'
                  : 'transparent',
              'color': i == selectedIndex
                  ? 'var(--arcane-on-surface)'
                  : 'var(--arcane-muted)',
              'cursor': 'pointer',
              'transition': 'var(--arcane-transition-fast)',
              if (i == selectedIndex) 'box-shadow': 'var(--arcane-shadow-sm)',
            }),
            events: {
              'click': (event) {
                if (onChanged != null && i != selectedIndex) {
                  onChanged!(i);
                }
              },
            },
            [text(options[i])],
          ),
      ],
    );
  }
}
