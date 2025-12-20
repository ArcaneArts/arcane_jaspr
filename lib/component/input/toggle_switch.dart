import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

/// Toggle switch size variants
enum ToggleSwitchSize {
  small,
  medium,
  large,
}

/// A toggle switch component
///
/// Use style presets for cleaner code:
/// ```dart
/// ToggleSwitch(
///   value: true,
///   style: ToggleStyle.success,
/// )
/// ```
class ArcaneToggleSwitch extends StatefulComponent {
  /// Whether the switch is on
  final bool value;

  /// Callback when the switch is toggled
  final void Function(bool)? onChanged;

  /// Whether the switch is disabled
  final bool disabled;

  /// Size of the switch
  final ToggleSwitchSize size;

  /// Style preset
  final ToggleStyle? style;

  /// Optional label text
  final String? label;

  /// Whether to show the label on the left side
  final bool labelLeft;

  const ArcaneToggleSwitch({
    required this.value,
    this.onChanged,
    this.disabled = false,
    this.size = ToggleSwitchSize.medium,
    this.style,
    this.label,
    this.labelLeft = false,
    super.key,
  });

  /// Primary toggle
  const ArcaneToggleSwitch.primary({
    required this.value,
    this.onChanged,
    this.disabled = false,
    this.size = ToggleSwitchSize.medium,
    this.label,
    this.labelLeft = false,
    super.key,
  }) : style = ToggleStyle.primary;

  /// Success toggle
  const ArcaneToggleSwitch.success({
    required this.value,
    this.onChanged,
    this.disabled = false,
    this.size = ToggleSwitchSize.medium,
    this.label,
    this.labelLeft = false,
    super.key,
  }) : style = ToggleStyle.success;

  @override
  State<ArcaneToggleSwitch> createState() => _ArcaneToggleSwitchState();
}

class _ArcaneToggleSwitchState extends State<ArcaneToggleSwitch> {
  @override
  Component build(BuildContext context) {
    final effectiveStyle = component.style ?? ToggleStyle.primary;

    // Get size-specific dimensions
    final (width, height, thumbSize, thumbOffset) = switch (component.size) {
      ToggleSwitchSize.small => (36.0, 20.0, 16.0, 2.0),
      ToggleSwitchSize.medium => (44.0, 24.0, 20.0, 2.0),
      ToggleSwitchSize.large => (52.0, 28.0, 24.0, 2.0),
    };

    final thumbTranslate =
        component.value ? (width - thumbSize - thumbOffset * 2) : 0.0;

    final switchWidget = button(
      classes:
          'arcane-toggle-switch ${component.value ? 'active' : ''} ${component.disabled ? 'disabled' : ''}',
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
        'border-radius': ArcaneRadius.full,
        'background-color': component.value
            ? effectiveStyle.activeColor
            : effectiveStyle.inactiveColor,
        'cursor': component.disabled ? 'not-allowed' : 'pointer',
        'opacity': component.disabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
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
            'border-radius': ArcaneRadius.full,
            'background-color': effectiveStyle.thumbColor,
            'box-shadow': ArcaneEffects.shadowSm,
            'transform': 'translateX(${thumbTranslate}px)',
            'transition': ArcaneEffects.transitionFast,
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
        'font-size': ArcaneTypography.fontMd,
        'color': component.disabled ? ArcaneColors.muted : ArcaneColors.onSurface,
        'user-select': 'none',
      }),
      [text(component.label!)],
    );

    return label(
      classes: 'arcane-toggle-wrapper',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
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
class ArcaneToggleButtonGroup extends StatelessComponent {
  /// The available options
  final List<String> options;

  /// The currently selected index
  final int selectedIndex;

  /// Callback when selection changes
  final void Function(int)? onChanged;

  /// Size of the toggle group
  final ToggleSwitchSize size;

  const ArcaneToggleButtonGroup({
    required this.options,
    required this.selectedIndex,
    this.onChanged,
    this.size = ToggleSwitchSize.medium,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final (paddingH, paddingV, fontSize) = switch (size) {
      ToggleSwitchSize.small => (ArcaneSpacing.sm, '6px', ArcaneTypography.fontSm),
      ToggleSwitchSize.medium =>
        (ArcaneSpacing.md, ArcaneSpacing.sm, ArcaneTypography.fontMd),
      ToggleSwitchSize.large =>
        (ArcaneSpacing.lg, ArcaneSpacing.sm, ArcaneTypography.fontReg),
    };

    return div(
      classes: 'arcane-toggle-button-group',
      styles: const Styles(raw: {
        'display': 'inline-flex',
        'padding': ArcaneSpacing.xs,
        'background-color': ArcaneColors.surfaceVariant,
        'border-radius': ArcaneRadius.md,
        'gap': '2px',
      }),
      [
        for (var i = 0; i < options.length; i++)
          button(
            classes: 'arcane-toggle-button ${i == selectedIndex ? 'active' : ''}',
            attributes: {'type': 'button'},
            styles: Styles(raw: {
              'padding': '$paddingV $paddingH',
              'font-size': fontSize,
              'font-weight': ArcaneTypography.weightMedium,
              'border': 'none',
              'border-radius': ArcaneRadius.sm,
              'background-color':
                  i == selectedIndex ? ArcaneColors.surface : ArcaneColors.transparent,
              'color': i == selectedIndex
                  ? ArcaneColors.onSurface
                  : ArcaneColors.muted,
              'cursor': 'pointer',
              'transition': ArcaneEffects.transitionFast,
              if (i == selectedIndex) 'box-shadow': ArcaneEffects.shadowSm,
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