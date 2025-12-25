import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Color input size variants
enum ColorInputSize {
  sm,
  md,
  lg,
}

/// Color picker/input component with swatch preview and hex input.
///
/// Uses native color picker with custom styling for consistent appearance.
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

  /// Size variant
  final ColorInputSize size;

  /// Whether the input is disabled
  final bool disabled;

  /// Label text
  final String? label;

  /// Preset color swatches
  final List<String>? presets;

  /// Whether to show the hex text input
  final bool showHexInput;

  const ArcaneColorInput({
    required this.value,
    this.onChanged,
    this.size = ColorInputSize.md,
    this.disabled = false,
    this.label,
    this.presets,
    this.showHexInput = true,
    super.key,
  });

  /// Common color presets
  static const defaultPresets = [
    '#ef4444',
    '#f97316',
    '#eab308',
    '#22c55e',
    '#14b8a6',
    '#3b82f6',
    '#8b5cf6',
    '#ec4899',
    '#6b7280',
    '#000000',
  ];

  @override
  Component build(BuildContext context) {
    final (swatchSize, fontSize, inputPadding) = switch (size) {
      ColorInputSize.sm => ('28px', ArcaneTypography.fontSm, '6px 10px'),
      ColorInputSize.md => ('36px', ArcaneTypography.fontMd, '8px 12px'),
      ColorInputSize.lg => ('44px', ArcaneTypography.fontLg, '10px 16px'),
    };

    final colorPresets = presets ?? defaultPresets;
    final normalizedValue = _normalizeColor(value);

    return div(
      classes: 'arcane-color-input',
      attributes: {
        'data-value': normalizedValue,
        'data-disabled': disabled.toString(),
      },
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.sm,
      }),
      [
        // Label
        if (label != null)
          span(
            classes: 'arcane-color-input-label',
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
            }),
            [text(label!)],
          ),

        // Main input row
        div(
          classes: 'arcane-color-input-row',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.sm,
          }),
          [
            // Color swatch with native picker
            div(
              classes: 'arcane-color-input-swatch',
              styles: Styles(raw: {
                'position': 'relative',
                'width': swatchSize,
                'height': swatchSize,
                'border-radius': ArcaneRadius.md,
                'background': normalizedValue,
                'border': '2px solid ${ArcaneColors.border}',
                'cursor': disabled ? 'not-allowed' : 'pointer',
                'opacity': disabled ? '0.5' : '1',
                'overflow': 'hidden',
                'flex-shrink': '0',
              }),
              [
                // Native color input (invisible but functional)
                input(
                  type: InputType.color,
                  classes: 'arcane-color-input-native',
                  attributes: {
                    'value': normalizedValue,
                    if (disabled) 'disabled': 'true',
                  },
                  styles: const Styles(raw: {
                    'position': 'absolute',
                    'inset': '0',
                    'width': '100%',
                    'height': '100%',
                    'opacity': '0',
                    'cursor': 'inherit',
                    'border': 'none',
                    'padding': '0',
                  }),
                  events: disabled
                      ? null
                      : {
                          'input': (e) {
                            final color =
                                (e.target as dynamic)?.value as String?;
                            if (color != null) {
                              onChanged?.call(color.toUpperCase());
                            }
                          },
                        },
                ),
              ],
            ),

            // Hex text input
            if (showHexInput)
              input(
                type: InputType.text,
                classes: 'arcane-color-input-hex',
                attributes: {
                  'value': normalizedValue.toUpperCase(),
                  'placeholder': '#000000',
                  'maxlength': '7',
                  'spellcheck': 'false',
                  if (disabled) 'disabled': 'true',
                },
                styles: Styles(raw: {
                  'width': '90px',
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
                            if (RegExp(r'^#[0-9A-Fa-f]{6}$').hasMatch(color)) {
                              onChanged?.call(color.toUpperCase());
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
            classes: 'arcane-color-input-presets',
            styles: const Styles(raw: {
              'display': 'flex',
              'flex-wrap': 'wrap',
              'gap': ArcaneSpacing.xs,
            }),
            [
              for (final preset in colorPresets)
                button(
                  type: ButtonType.button,
                  classes: 'arcane-color-input-preset',
                  attributes: {
                    'data-color': preset.toUpperCase(),
                    if (disabled) 'disabled': 'true',
                  },
                  styles: Styles(raw: {
                    'width': '24px',
                    'height': '24px',
                    'padding': '0',
                    'border': preset.toUpperCase() == normalizedValue.toUpperCase()
                        ? '2px solid ${ArcaneColors.accent}'
                        : '2px solid ${ArcaneColors.border}',
                    'border-radius': ArcaneRadius.sm,
                    'background': preset,
                    'cursor': disabled ? 'not-allowed' : 'pointer',
                    'transition': ArcaneEffects.transitionFast,
                  }),
                  events: disabled
                      ? null
                      : {
                          'click': (_) => onChanged?.call(preset.toUpperCase()),
                        },
                  [],
                ),
            ],
          ),
      ],
    );
  }

  String _normalizeColor(String color) {
    if (!color.startsWith('#')) {
      color = '#$color';
    }
    if (color.length == 4) {
      // Expand shorthand #RGB to #RRGGBB
      color = '#${color[1]}${color[1]}${color[2]}${color[2]}${color[3]}${color[3]}';
    }
    return color.length == 7 ? color : '#000000';
  }
}
