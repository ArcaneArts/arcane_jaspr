import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Number input style variants
enum NumberInputStyle {
  /// Default style with buttons on sides
  sideBySide,

  /// Compact with stacked buttons on right
  stacked,

  /// Inline minimal style
  inline,
}

/// Number input size variants
enum NumberInputSize {
  sm,
  md,
  lg,
}

/// Numeric input with increment/decrement controls
///
/// ```dart
/// ArcaneNumberInput(
///   value: 5,
///   min: 0,
///   max: 100,
///   step: 1,
///   onChanged: (value) => print(value),
/// )
/// ```
class ArcaneNumberInput extends StatelessComponent {
  /// Current value
  final num value;

  /// Minimum value
  final num min;

  /// Maximum value
  final num max;

  /// Step increment
  final num step;

  /// Callback when value changes
  final void Function(num)? onChanged;

  /// Style variant
  final NumberInputStyle style;

  /// Size variant
  final NumberInputSize size;

  /// Whether the input is disabled
  final bool disabled;

  /// Label text
  final String? label;

  /// Prefix text (e.g., "$")
  final String? prefix;

  /// Suffix text (e.g., "kg")
  final String? suffix;

  /// Whether to allow decimal values
  final bool allowDecimals;

  /// Number of decimal places to display
  final int decimalPlaces;

  const ArcaneNumberInput({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.onChanged,
    this.style = NumberInputStyle.sideBySide,
    this.size = NumberInputSize.md,
    this.disabled = false,
    this.label,
    this.prefix,
    this.suffix,
    this.allowDecimals = false,
    this.decimalPlaces = 2,
    super.key,
  });

  (String height, String fontSize, String buttonSize) get _sizeStyles =>
      switch (size) {
        NumberInputSize.sm => ('32px', ArcaneTypography.fontSm, '28px'),
        NumberInputSize.md => ('40px', ArcaneTypography.fontMd, '36px'),
        NumberInputSize.lg => ('48px', ArcaneTypography.fontLg, '44px'),
      };

  void _increment() {
    if (disabled) return;
    final newValue = (value + step).clamp(min, max);
    onChanged?.call(allowDecimals ? newValue : newValue.toInt());
  }

  void _decrement() {
    if (disabled) return;
    final newValue = (value - step).clamp(min, max);
    onChanged?.call(allowDecimals ? newValue : newValue.toInt());
  }

  String _formatValue() {
    if (allowDecimals) {
      return value.toStringAsFixed(decimalPlaces);
    }
    return value.toInt().toString();
  }

  @override
  Component build(BuildContext context) {
    final (height, fontSize, buttonSize) = _sizeStyles;
    final canDecrement = value > min;
    final canIncrement = value < max;

    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.sm,
      }),
      [
        // Label
        if (label != null)
          Component.element(
            tag: 'label',
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
            }),
            children: [text(label!)],
          ),

        // Input container
        div(
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'height': height,
            'opacity': disabled ? '0.5' : '1',
          }),
          [
            if (style == NumberInputStyle.sideBySide) ...[
              // Decrement button
              _buildButton('-', canDecrement && !disabled, _decrement, buttonSize, fontSize,
                  isLeft: true),

              // Value display
              div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'gap': ArcaneSpacing.xs,
                  'height': '100%',
                  'min-width': '60px',
                  'padding': '0 ${ArcaneSpacing.sm}',
                  'background': ArcaneColors.input,
                  'border-top': '1px solid ${ArcaneColors.border}',
                  'border-bottom': '1px solid ${ArcaneColors.border}',
                  'font-size': fontSize,
                  'font-weight': ArcaneTypography.weightMedium,
                  'color': ArcaneColors.onSurface,
                }),
                [
                  if (prefix != null)
                    span(
                      styles: const Styles(raw: {'color': ArcaneColors.muted}),
                      [text(prefix!)],
                    ),
                  text(_formatValue()),
                  if (suffix != null)
                    span(
                      styles: const Styles(raw: {'color': ArcaneColors.muted}),
                      [text(suffix!)],
                    ),
                ],
              ),

              // Increment button
              _buildButton('+', canIncrement && !disabled, _increment, buttonSize, fontSize,
                  isRight: true),
            ] else if (style == NumberInputStyle.stacked) ...[
              // Value display with stacked buttons
              div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'height': '100%',
                  'padding': '0 ${ArcaneSpacing.md}',
                  'background': ArcaneColors.input,
                  'border': '1px solid ${ArcaneColors.border}',
                  'border-radius': '${ArcaneRadius.md} 0 0 ${ArcaneRadius.md}',
                  'font-size': fontSize,
                  'color': ArcaneColors.onSurface,
                  'gap': ArcaneSpacing.xs,
                }),
                [
                  if (prefix != null)
                    span(
                      styles: const Styles(raw: {'color': ArcaneColors.muted}),
                      [text(prefix!)],
                    ),
                  text(_formatValue()),
                  if (suffix != null)
                    span(
                      styles: const Styles(raw: {'color': ArcaneColors.muted}),
                      [text(suffix!)],
                    ),
                ],
              ),
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'flex-direction': 'column',
                  'height': '100%',
                }),
                [
                  _buildStackedButton('▲', canIncrement && !disabled, _increment),
                  _buildStackedButton('▼', canDecrement && !disabled, _decrement),
                ],
              ),
            ] else ...[
              // Inline style
              _buildInlineButton('-', canDecrement && !disabled, _decrement),
              span(
                styles: Styles(raw: {
                  'padding': '0 ${ArcaneSpacing.sm}',
                  'font-size': fontSize,
                  'font-weight': ArcaneTypography.weightMedium,
                  'color': ArcaneColors.onSurface,
                  'min-width': '40px',
                  'text-align': 'center',
                }),
                [
                  if (prefix != null) text(prefix!),
                  text(_formatValue()),
                  if (suffix != null) text(suffix!),
                ],
              ),
              _buildInlineButton('+', canIncrement && !disabled, _increment),
            ],
          ],
        ),
      ],
    );
  }

  Component _buildButton(String content, bool enabled, VoidCallback onTap,
      String buttonSize, String fontSize,
      {bool isLeft = false, bool isRight = false}) {
    return button(
      type: ButtonType.button,
      attributes: enabled ? null : {'disabled': 'true'},
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': buttonSize,
        'height': '100%',
        'padding': '0',
        'border': '1px solid ${ArcaneColors.border}',
        'background': enabled ? ArcaneColors.surfaceVariant : ArcaneColors.surface,
        'color': enabled ? ArcaneColors.onSurface : ArcaneColors.muted,
        'font-size': fontSize,
        'font-weight': ArcaneTypography.weightBold,
        'cursor': enabled ? 'pointer' : 'not-allowed',
        'transition': ArcaneEffects.transitionFast,
        if (isLeft) 'border-radius': '${ArcaneRadius.md} 0 0 ${ArcaneRadius.md}',
        if (isRight) 'border-radius': '0 ${ArcaneRadius.md} ${ArcaneRadius.md} 0',
      }),
      events: enabled ? {'click': (_) => onTap()} : null,
      [text(content)],
    );
  }

  Component _buildStackedButton(String content, bool enabled, VoidCallback onTap) {
    return button(
      type: ButtonType.button,
      attributes: enabled ? null : {'disabled': 'true'},
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '24px',
        'flex': '1',
        'padding': '0',
        'border': '1px solid ${ArcaneColors.border}',
        'border-left': 'none',
        'background': enabled ? ArcaneColors.surfaceVariant : ArcaneColors.surface,
        'color': enabled ? ArcaneColors.onSurface : ArcaneColors.muted,
        'font-size': '8px',
        'cursor': enabled ? 'pointer' : 'not-allowed',
        'transition': ArcaneEffects.transitionFast,
      }),
      events: enabled ? {'click': (_) => onTap()} : null,
      [text(content)],
    );
  }

  Component _buildInlineButton(String content, bool enabled, VoidCallback onTap) {
    return button(
      type: ButtonType.button,
      attributes: enabled ? null : {'disabled': 'true'},
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '28px',
        'height': '28px',
        'padding': '0',
        'border': 'none',
        'background': 'transparent',
        'color': enabled ? ArcaneColors.accent : ArcaneColors.muted,
        'font-size': ArcaneTypography.fontLg,
        'font-weight': ArcaneTypography.weightBold,
        'cursor': enabled ? 'pointer' : 'not-allowed',
        'border-radius': ArcaneRadius.full,
        'transition': ArcaneEffects.transitionFast,
      }),
      events: enabled ? {'click': (_) => onTap()} : null,
      [text(content)],
    );
  }
}
