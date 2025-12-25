import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// CTA link button style variants
enum CtaLinkVariant {
  /// Solid accent background
  primary,

  /// Outline/border style
  secondary,

  /// Text-only, no background or border
  ghost,

  /// Gradient background (uses accentGradient)
  accent,
}

/// CTA link button size
enum CtaLinkSize {
  /// Small: compact padding
  sm,

  /// Medium: default size
  md,

  /// Large: prominent CTA
  lg,
}

/// A call-to-action link styled as a button.
///
/// Provides multiple variants for different visual hierarchies:
/// - `primary`: Solid accent background, high prominence
/// - `secondary`: Outline style, medium prominence
/// - `ghost`: Text only, low prominence
/// - `accent`: Gradient background, highest prominence
///
/// ```dart
/// ArcaneCtaLink.primary(
///   label: 'Get Started',
///   href: '/signup',
///   showArrow: true,
/// )
///
/// ArcaneCtaLink.secondary(
///   label: 'Learn More',
///   href: '/about',
/// )
/// ```
class ArcaneCtaLink extends StatelessComponent {
  /// The button label text
  final String label;

  /// The link href
  final String href;

  /// Whether to show an arrow after the label
  final bool showArrow;

  /// The button variant
  final CtaLinkVariant variant;

  /// The button size
  final CtaLinkSize size;

  /// Custom background (overrides variant default)
  final String? background;

  /// Custom border (overrides variant default)
  final String? border;

  /// Additional raw CSS styles
  final Map<String, String>? raw;

  const ArcaneCtaLink({
    required this.label,
    required this.href,
    this.showArrow = false,
    this.variant = CtaLinkVariant.primary,
    this.size = CtaLinkSize.md,
    this.background,
    this.border,
    this.raw,
    super.key,
  });

  /// Primary CTA with solid accent background
  const ArcaneCtaLink.primary({
    required this.label,
    required this.href,
    this.showArrow = false,
    this.size = CtaLinkSize.md,
    this.background,
    this.border,
    this.raw,
    super.key,
  }) : variant = CtaLinkVariant.primary;

  /// Secondary CTA with outline style
  const ArcaneCtaLink.secondary({
    required this.label,
    required this.href,
    this.showArrow = false,
    this.size = CtaLinkSize.md,
    this.background,
    this.border,
    this.raw,
    super.key,
  }) : variant = CtaLinkVariant.secondary;

  /// Ghost CTA with text-only style
  const ArcaneCtaLink.ghost({
    required this.label,
    required this.href,
    this.showArrow = false,
    this.size = CtaLinkSize.md,
    this.background,
    this.border,
    this.raw,
    super.key,
  }) : variant = CtaLinkVariant.ghost;

  /// Accent CTA with gradient background
  const ArcaneCtaLink.accent({
    required this.label,
    required this.href,
    this.showArrow = true,
    this.size = CtaLinkSize.md,
    this.background,
    this.border,
    this.raw,
    super.key,
  }) : variant = CtaLinkVariant.accent;

  @override
  Component build(BuildContext context) {
    final padding = _getPadding();
    final fontSize = _getFontSize();
    final styles = _getVariantStyles();

    return a(
      href: href,
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'padding': padding,
        'border-radius': ArcaneRadius.md,
        'font-size': fontSize,
        'font-weight': '500',
        'text-decoration': 'none',
        'transition': 'all 150ms ease',
        'cursor': 'pointer',
        ...styles,
        ...?raw,
      }),
      [
        text(label),
        if (showArrow) text(' \u2192'),
      ],
    );
  }

  String _getPadding() {
    switch (size) {
      case CtaLinkSize.sm:
        return '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}';
      case CtaLinkSize.md:
        return '${ArcaneSpacing.sm} ${ArcaneSpacing.lg}';
      case CtaLinkSize.lg:
        return '${ArcaneSpacing.md} ${ArcaneSpacing.xl}';
    }
  }

  String _getFontSize() {
    switch (size) {
      case CtaLinkSize.sm:
        return ArcaneTypography.fontSizeXs;
      case CtaLinkSize.md:
        return ArcaneTypography.fontSizeSm;
      case CtaLinkSize.lg:
        return ArcaneTypography.fontSizeBase;
    }
  }

  Map<String, String> _getVariantStyles() {
    switch (variant) {
      case CtaLinkVariant.primary:
        return {
          'background': background ?? ArcaneColors.accent,
          'color': ArcaneColors.accentForeground,
          'border': border ?? 'none',
        };
      case CtaLinkVariant.secondary:
        return {
          'background': background ?? 'transparent',
          'color': ArcaneColors.onBackground,
          'border': border ?? '1px solid ${ArcaneColors.border}',
        };
      case CtaLinkVariant.ghost:
        return {
          'background': background ?? 'transparent',
          'color': ArcaneColors.muted,
          'border': border ?? 'none',
        };
      case CtaLinkVariant.accent:
        return {
          'background': background ?? ArcaneColors.accentGradient,
          'color': ArcaneColors.onBackground,
          'border': border ?? 'none',
        };
    }
  }
}
