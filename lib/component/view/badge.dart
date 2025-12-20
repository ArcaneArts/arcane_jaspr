import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

/// Badge variants (legacy - prefer using BadgeStyle presets)
@Deprecated('Use style parameter with BadgeStyle presets instead')
enum BadgeVariant {
  /// Default/neutral badge
  default_,
  /// Primary/accent colored badge
  primary,
  /// Secondary/muted badge
  secondary,
  /// Success badge (green)
  success,
  /// Warning badge (amber)
  warning,
  /// Destructive/error badge (red)
  destructive,
  /// Outline badge
  outline,
}

/// Badge size
enum BadgeSize { sm, md, lg }

/// A pill-shaped badge/label component
///
/// Use style presets for cleaner code:
/// ```dart
/// ArcaneBadge('Active', style: BadgeStyle.success)
/// ```
class ArcaneBadge extends StatelessComponent {
  /// The badge text
  final String label;

  /// Optional leading icon
  final Component? icon;

  /// Style preset (preferred over variant)
  final BadgeStyle? style;

  /// Badge variant (legacy - use style instead)
  @Deprecated('Use style parameter with BadgeStyle presets instead')
  final BadgeVariant? variant;

  /// Badge size
  final BadgeSize size;

  const ArcaneBadge(
    this.label, {
    this.icon,
    this.style,
    @Deprecated('Use style parameter instead') this.variant,
    this.size = BadgeSize.md,
    super.key,
  });

  /// Primary badge
  const ArcaneBadge.primary(
    this.label, {
    this.icon,
    this.size = BadgeSize.md,
    super.key,
  })  : style = BadgeStyle.primary,
        variant = null;

  /// Success badge
  const ArcaneBadge.success(
    this.label, {
    this.icon,
    this.size = BadgeSize.md,
    super.key,
  })  : style = BadgeStyle.success,
        variant = null;

  /// Warning badge
  const ArcaneBadge.warning(
    this.label, {
    this.icon,
    this.size = BadgeSize.md,
    super.key,
  })  : style = BadgeStyle.warning,
        variant = null;

  /// Error/destructive badge
  const ArcaneBadge.error(
    this.label, {
    this.icon,
    this.size = BadgeSize.md,
    super.key,
  })  : style = BadgeStyle.error,
        variant = null;

  /// Alias for error
  const ArcaneBadge.destructive(
    this.label, {
    this.icon,
    this.size = BadgeSize.md,
    super.key,
  })  : style = BadgeStyle.error,
        variant = null;

  /// Info badge
  const ArcaneBadge.info(
    this.label, {
    this.icon,
    this.size = BadgeSize.md,
    super.key,
  })  : style = BadgeStyle.info,
        variant = null;

  /// Outline badge
  const ArcaneBadge.outline(
    this.label, {
    this.icon,
    this.size = BadgeSize.md,
    super.key,
  })  : style = BadgeStyle.outline,
        variant = null;

  /// Convert legacy variant to style preset
  BadgeStyle _variantToStyle(BadgeVariant v) {
    return switch (v) {
      BadgeVariant.default_ => BadgeStyle.standard,
      BadgeVariant.primary => BadgeStyle.primary,
      BadgeVariant.secondary => BadgeStyle.secondary,
      BadgeVariant.success => BadgeStyle.success,
      BadgeVariant.warning => BadgeStyle.warning,
      BadgeVariant.destructive => BadgeStyle.error,
      BadgeVariant.outline => BadgeStyle.outline,
    };
  }

  @override
  Component build(BuildContext context) {
    // Resolve effective style
    final effectiveStyle = style ??
        (variant != null ? _variantToStyle(variant!) : BadgeStyle.standard);

    // Get size-specific styles
    final (paddingH, paddingV, fontSize) = switch (size) {
      BadgeSize.sm => (ArcaneSpacing.xs, '2px', ArcaneTypography.fontXs),
      BadgeSize.md => (ArcaneSpacing.sm, '3px', ArcaneTypography.fontXs),
      BadgeSize.lg => (ArcaneSpacing.sm, ArcaneSpacing.xs, ArcaneTypography.fontSm),
    };

    return span(
      classes: 'arcane-badge',
      styles: Styles(raw: {
        // Layout
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,

        // Size
        'padding': '$paddingV $paddingH',
        'font-size': fontSize,

        // Typography
        'font-weight': ArcaneTypography.weightMedium,
        'line-height': '1',
        'white-space': 'nowrap',

        // Appearance from style preset
        ...effectiveStyle.styles,

        // Border radius (pill shape)
        'border-radius': ArcaneRadius.full,
      }),
      [
        if (icon != null) icon!,
        text(label),
      ],
    );
  }
}
