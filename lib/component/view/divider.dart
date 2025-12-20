import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

/// A horizontal divider component
///
/// Use style presets for cleaner code:
/// ```dart
/// ArcaneDivider(
///   style: DividerStyle.subtle,
/// )
/// ```
class ArcaneDivider extends StatelessComponent {
  /// Vertical margin
  final double? margin;

  /// Style preset
  final DividerStyle? style;

  /// Optional label in the middle
  final String? label;

  /// Whether to use a dashed style
  final bool dashed;

  const ArcaneDivider({
    this.margin,
    this.style,
    this.label,
    this.dashed = false,
    super.key,
  });

  /// Standard divider
  const ArcaneDivider.standard({
    this.margin,
    this.label,
    this.dashed = false,
    super.key,
  }) : style = DividerStyle.standard;

  /// Subtle divider
  const ArcaneDivider.subtle({
    this.margin,
    this.label,
    this.dashed = false,
    super.key,
  }) : style = DividerStyle.subtle;

  /// Bold divider
  const ArcaneDivider.bold({
    this.margin,
    this.label,
    this.dashed = false,
    super.key,
  }) : style = DividerStyle.bold;

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? DividerStyle.standard;
    final effectiveMargin = margin ?? 16;

    if (label != null) {
      return div(
        classes: 'arcane-divider with-label',
        styles: Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': ArcaneSpacing.md,
          'margin': '${effectiveMargin}px 0',
        }),
        [
          div(
            styles: Styles(raw: {
              'flex': '1',
              ...effectiveStyle.styles,
              if (dashed)
                'background':
                    'repeating-linear-gradient(to right, ${effectiveStyle.styles['background-color']} 0, ${effectiveStyle.styles['background-color']} 4px, transparent 4px, transparent 8px)',
            }),
            [],
          ),
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
              'white-space': 'nowrap',
            }),
            [text(label!)],
          ),
          div(
            styles: Styles(raw: {
              'flex': '1',
              ...effectiveStyle.styles,
              if (dashed)
                'background':
                    'repeating-linear-gradient(to right, ${effectiveStyle.styles['background-color']} 0, ${effectiveStyle.styles['background-color']} 4px, transparent 4px, transparent 8px)',
            }),
            [],
          ),
        ],
      );
    }

    return hr(
      classes: 'arcane-divider',
      styles: Styles(raw: {
        'margin': '${effectiveMargin}px 0',
        'border': 'none',
        ...effectiveStyle.styles,
        if (dashed)
          'background':
              'repeating-linear-gradient(to right, ${effectiveStyle.styles['background-color']} 0, ${effectiveStyle.styles['background-color']} 4px, transparent 4px, transparent 8px)',
      }),
    );
  }
}

/// A vertical divider component
class ArcaneVerticalDivider extends StatelessComponent {
  /// Horizontal margin
  final double? margin;

  /// Style preset
  final DividerStyle? style;

  /// Height (null for full height)
  final double? height;

  const ArcaneVerticalDivider({
    this.margin,
    this.style,
    this.height,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? DividerStyle.standard;
    final effectiveMargin = margin ?? 16;

    return div(
      classes: 'arcane-divider-vertical',
      styles: Styles(raw: {
        'width': effectiveStyle.styles['height'] ?? '1px',
        'margin': '0 ${effectiveMargin}px',
        'background-color': effectiveStyle.styles['background-color'] ?? ArcaneColors.border,
        if (height != null) 'height': '${height}px' else 'align-self': 'stretch',
      }),
      [],
    );
  }
}

/// Legacy alias for backwards compatibility
@Deprecated('Use ArcaneDivider instead')
typedef Divider = ArcaneDivider;

/// Legacy alias for backwards compatibility
@Deprecated('Use ArcaneVerticalDivider instead')
typedef VerticalDivider = ArcaneVerticalDivider;