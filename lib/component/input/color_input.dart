import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Color input style variants
enum ColorInputStyle {
  /// Color swatch only
  swatch,

  /// Swatch with hex input
  withInput,

  /// Inline swatch in text input
  inline,
}

/// Color input size variants
enum ColorInputSize {
  sm,
  md,
  lg,
}

/// Color picker/input component
///
/// Allows users to select colors.
///
/// ```dart
/// ArcaneColorInput(
///   value: '#10b981',
///   onChanged: (color) => print(color),
/// )
/// ```
class ArcaneColorInput extends StatelessComponent {
  /// Current color value (hex string)
  final String value;

  /// Callback when color changes
  final void Function(String color)? onChanged;

  /// Style variant
  final ColorInputStyle style;

  /// Size variant
  final ColorInputSize size;

  /// Whether the input is disabled
  final bool disabled;

  /// Label text
  final String? label;

  /// Preset color swatches
  final List<String>? presets;

  /// Whether to show the alpha channel
  final bool showAlpha;

  const ArcaneColorInput({
    required this.value,
    this.onChanged,
    this.style = ColorInputStyle.withInput,
    this.size = ColorInputSize.md,
    this.disabled = false,
    this.label,
    this.presets,
    this.showAlpha = false,
    super.key,
  });

  /// Common color presets
  static const defaultPresets = [
    '#ef4444', // red
    '#f97316', // orange
    '#eab308', // yellow
    '#22c55e', // green
    '#14b8a6', // teal
    '#3b82f6', // blue
    '#8b5cf6', // violet
    '#ec4899', // pink
    '#6b7280', // gray
    '#000000', // black
  ];

  (String swatchSize, String fontSize, String padding) get _sizeStyles =>
      switch (size) {
        ColorInputSize.sm => ('24px', ArcaneTypography.fontSm, '6px 10px'),
        ColorInputSize.md => ('32px', ArcaneTypography.fontMd, '8px 12px'),
        ColorInputSize.lg => ('40px', ArcaneTypography.fontLg, '10px 16px'),
      };

  @override
  Component build(BuildContext context) {
    final (swatchSize, fontSize, inputPadding) = _sizeStyles;
    final colorPresets = presets ?? defaultPresets;

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

        // Input row
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.sm,
          }),
          [
            // Color swatch/picker
            div(
              styles: Styles(raw: {
                'position': 'relative',
                'width': swatchSize,
                'height': swatchSize,
                'border-radius': ArcaneRadius.md,
                'overflow': 'hidden',
                'border': '2px solid ${ArcaneColors.border}',
                'cursor': disabled ? 'not-allowed' : 'pointer',
                'opacity': disabled ? '0.5' : '1',
              }),
              [
                // Background checkerboard (for alpha)
                if (showAlpha)
                  const div(
                    styles: Styles(raw: {
                      'position': 'absolute',
                      'inset': '0',
                      'background': 'repeating-conic-gradient(#ccc 0% 25%, #fff 0% 50%) 50% / 8px 8px',
                    }),
                    [],
                  ),

                // Color display
                div(
                  styles: Styles(raw: {
                    'position': 'absolute',
                    'inset': '0',
                    'background': value,
                  }),
                  [],
                ),

                // Native color input (hidden but functional)
                input(
                  type: InputType.color,
                  attributes: {
                    'value': value.length == 7 ? value : '#000000',
                    if (disabled) 'disabled': 'true',
                  },
                  styles: const Styles(raw: {
                    'position': 'absolute',
                    'inset': '0',
                    'width': '100%',
                    'height': '100%',
                    'opacity': '0',
                    'cursor': 'pointer',
                  }),
                  events: disabled
                      ? null
                      : {
                          'input': (e) {
                            final color = (e.target as dynamic)?.value as String?;
                            if (color != null) {
                              onChanged?.call(color);
                            }
                          },
                        },
                ),
              ],
            ),

            // Hex input
            if (style == ColorInputStyle.withInput)
              input(
                type: InputType.text,
                attributes: {
                  'value': value.toUpperCase(),
                  'placeholder': '#000000',
                  'maxlength': showAlpha ? '9' : '7',
                  if (disabled) 'disabled': 'true',
                },
                styles: Styles(raw: {
                  'flex': '1',
                  'padding': inputPadding,
                  'font-size': fontSize,
                  'font-family': ArcaneTypography.fontFamilyMono,
                  'background': ArcaneColors.input,
                  'border': '1px solid ${ArcaneColors.border}',
                  'border-radius': ArcaneRadius.md,
                  'color': ArcaneColors.onSurface,
                  'outline': 'none',
                  'text-transform': 'uppercase',
                }),
                events: disabled
                    ? null
                    : {
                        'input': (e) {
                          var color = (e.target as dynamic)?.value as String?;
                          if (color != null) {
                            if (!color.startsWith('#')) {
                              color = '#$color';
                            }
                            if (RegExp(r'^#[0-9A-Fa-f]{6,8}$').hasMatch(color)) {
                              onChanged?.call(color);
                            }
                          }
                        },
                      },
              ),
          ],
        ),

        // Preset swatches
        if (colorPresets.isNotEmpty)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'flex-wrap': 'wrap',
              'gap': ArcaneSpacing.xs,
            }),
            [
              for (final preset in colorPresets)
                button(
                  type: ButtonType.button,
                  attributes: {
                    if (disabled) 'disabled': 'true',
                    'title': preset,
                  },
                  styles: Styles(raw: {
                    'width': '24px',
                    'height': '24px',
                    'padding': '0',
                    'border': preset == value
                        ? '2px solid ${ArcaneColors.accent}'
                        : '2px solid transparent',
                    'border-radius': ArcaneRadius.sm,
                    'background': preset,
                    'cursor': disabled ? 'not-allowed' : 'pointer',
                    'transition': ArcaneEffects.transitionFast,
                    'outline': '2px solid transparent',
                    'outline-offset': '1px',
                  }),
                  events: disabled
                      ? null
                      : {
                          'click': (_) => onChanged?.call(preset),
                        },
                  [],
                ),
            ],
          ),
      ],
    );
  }
}