import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/props/feature_card_props.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

/// A feature/navigation surface: an optional accent-tinted icon badge, a bold
/// title, a muted description, and an optional call-to-action row. Lays out
/// vertically by default and horizontally when [horizontal] is set. Becomes an
/// anchor when [href] is set, or a clickable button when [onTap] is set. Themed
/// automatically by the active stylesheet.
class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget? icon;
  final String? href;
  final void Function()? onTap;
  final bool showArrow;
  final bool horizontal;

  /// Custom accent color (CSS color value) tinting the icon badge, the CTA, and
  /// the card's leading border.
  final String? accentColor;

  /// Custom CTA text. Defaults to 'Learn More', or 'View Docs' when external.
  final String? ctaText;

  /// Whether the link opens in a new tab (external link).
  final bool isExternal;

  /// Whether to show the CTA row at the bottom.
  final bool showCta;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const FeatureCard({
    required this.title,
    required this.description,
    this.icon,
    this.href,
    this.onTap,
    this.showArrow = false,
    this.horizontal = false,
    this.accentColor,
    this.ctaText,
    this.isExternal = false,
    this.showCta = false,
    this.styles,
    this.decoration,
    super.key,
  });

  /// Creates a feature card with accent color styling and a CTA row.
  const FeatureCard.accented({
    required this.title,
    required this.description,
    required Widget this.icon,
    required String this.accentColor,
    this.href,
    this.onTap,
    this.ctaText,
    this.isExternal = false,
    this.styles,
    this.decoration,
    super.key,
  })  : showArrow = false,
        horizontal = false,
        showCta = true;

  @override
  Widget build(BuildContext context) => context.renderers.featureCard(
        FeatureCardProps(
          title: title,
          description: description,
          icon: icon,
          href: href,
          onTap: onTap,
          showArrow: showArrow,
          horizontal: horizontal,
          accentColor: accentColor,
          ctaText: ctaText,
          isExternal: isExternal,
          showCta: showCta,
          styles: styles,
          decoration: decoration,
        ),
      );
}

/// A compact surface: an accent-tinted icon badge, a bold title, and an optional
/// muted subtitle. Becomes an anchor when [href] is set, or a clickable button
/// when [onTap] is set. Themed automatically by the active stylesheet.
class IconCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget icon;
  final void Function()? onTap;
  final String? href;

  const IconCard({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.href,
    super.key,
  });

  @override
  Widget build(BuildContext context) => context.renderers.iconCard(
        IconCardProps(
          title: title,
          icon: icon,
          subtitle: subtitle,
          onTap: onTap,
          href: href,
        ),
      );
}
