import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

/// Checkbox size variants
enum CheckboxSize {
  small,
  medium,
  large,
}

/// Checkbox input component
///
/// Use style presets for cleaner code:
/// ```dart
/// ArcaneCheckbox(
///   checked: true,
///   style: CheckboxStyle.success,
///   onToggle: (value) => print(value),  // or use onChanged
/// )
/// ```
class ArcaneCheckbox extends StatelessComponent {
  final bool checked;
  final String? label;
  final String? description;
  final CheckboxSize size;
  final CheckboxStyle? style;
  final bool disabled;
  final void Function(bool)? _onChanged;

  /// Creates a checkbox.
  ///
  /// Use [onChanged] or [onToggle] for value change handling.
  const ArcaneCheckbox({
    required this.checked,
    this.label,
    this.description,
    this.size = CheckboxSize.medium,
    this.style,
    this.disabled = false,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    super.key,
  }) : _onChanged = onChanged ?? onToggle;

  /// Primary checkbox
  const ArcaneCheckbox.primary({
    required this.checked,
    this.label,
    this.description,
    this.size = CheckboxSize.medium,
    this.disabled = false,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    super.key,
  })  : _onChanged = onChanged ?? onToggle,
        style = CheckboxStyle.primary;

  /// Success checkbox
  const ArcaneCheckbox.success({
    required this.checked,
    this.label,
    this.description,
    this.size = CheckboxSize.medium,
    this.disabled = false,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    super.key,
  })  : _onChanged = onChanged ?? onToggle,
        style = CheckboxStyle.success;

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? CheckboxStyle.success;

    // Size dimensions
    final boxSize = switch (size) {
      CheckboxSize.small => '16px',
      CheckboxSize.medium => '20px',
      CheckboxSize.large => '24px',
    };

    final checkSize = switch (size) {
      CheckboxSize.small => ArcaneTypography.fontXs,
      CheckboxSize.medium => ArcaneTypography.fontSm,
      CheckboxSize.large => ArcaneTypography.fontMd,
    };

    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': ArcaneSpacing.sm,
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
      }),
      events: disabled || _onChanged == null
          ? null
          : {
              'click': (event) => _onChanged!(!checked),
            },
      [
        // Checkbox box
        div(
          styles: Styles(raw: {
            'width': boxSize,
            'height': boxSize,
            'border-radius': ArcaneRadius.sm,
            'background': checked
                ? effectiveStyle.checkedColor
                : ArcaneColors.transparent,
            'border': checked
                ? '2px solid ${effectiveStyle.checkedColor}'
                : '2px solid ${effectiveStyle.uncheckedBorder}',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            'transition': ArcaneEffects.transitionFast,
          }),
          [
            if (checked)
              span(
                styles: Styles(raw: {
                  'color': effectiveStyle.checkColor,
                  'font-size': checkSize,
                  'font-weight': ArcaneTypography.weightBold,
                  'line-height': '1',
                }),
                [text('✓')],
              ),
          ],
        ),
        // Label and description
        if (label != null || description != null)
          div(
            styles: const Styles(raw: {
              'flex': '1',
            }),
            [
              if (label != null)
                span(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontMd,
                    'font-weight': ArcaneTypography.weightMedium,
                    'color': ArcaneColors.onSurface,
                    'display': 'block',
                  }),
                  [text(label!)],
                ),
              if (description != null)
                span(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontSm,
                    'color': ArcaneColors.muted,
                    'display': 'block',
                    'margin-top': '2px',
                  }),
                  [text(description!)],
                ),
            ],
          ),
      ],
    );
  }
}

/// Radio button component
class ArcaneRadio extends StatelessComponent {
  final bool selected;
  final String? label;
  final String? description;
  final CheckboxSize size;
  final CheckboxStyle? style;
  final bool disabled;
  final void Function()? _onSelected;

  /// Creates a radio button.
  ///
  /// Use [onSelected] or [onTap] for selection handling.
  const ArcaneRadio({
    required this.selected,
    this.label,
    this.description,
    this.size = CheckboxSize.medium,
    this.style,
    this.disabled = false,
    void Function()? onSelected,
    void Function()? onTap,
    super.key,
  }) : _onSelected = onSelected ?? onTap;

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? CheckboxStyle.success;

    // Size dimensions
    final radioSize = switch (size) {
      CheckboxSize.small => '16px',
      CheckboxSize.medium => '20px',
      CheckboxSize.large => '24px',
    };

    final dotSize = switch (size) {
      CheckboxSize.small => '8px',
      CheckboxSize.medium => '10px',
      CheckboxSize.large => '12px',
    };

    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': ArcaneSpacing.sm,
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
      }),
      events: disabled || _onSelected == null
          ? null
          : {
              'click': (event) => _onSelected!(),
            },
      [
        // Radio circle
        div(
          styles: Styles(raw: {
            'width': radioSize,
            'height': radioSize,
            'border-radius': ArcaneRadius.full,
            'background': ArcaneColors.transparent,
            'border': selected
                ? '2px solid ${effectiveStyle.checkedColor}'
                : '2px solid ${effectiveStyle.uncheckedBorder}',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            'transition': ArcaneEffects.transitionFast,
          }),
          [
            if (selected)
              div(
                styles: Styles(raw: {
                  'width': dotSize,
                  'height': dotSize,
                  'border-radius': ArcaneRadius.full,
                  'background': effectiveStyle.checkedColor,
                }),
                [],
              ),
          ],
        ),
        // Label and description
        if (label != null || description != null)
          div(
            styles: const Styles(raw: {
              'flex': '1',
            }),
            [
              if (label != null)
                span(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontMd,
                    'font-weight': ArcaneTypography.weightMedium,
                    'color': ArcaneColors.onSurface,
                    'display': 'block',
                  }),
                  [text(label!)],
                ),
              if (description != null)
                span(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontSm,
                    'color': ArcaneColors.muted,
                    'display': 'block',
                    'margin-top': '2px',
                  }),
                  [text(description!)],
                ),
            ],
          ),
      ],
    );
  }
}