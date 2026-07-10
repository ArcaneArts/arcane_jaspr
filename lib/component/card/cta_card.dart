import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/props/cta_card_props.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

/// A dashed-border, centered call-to-action card: an optional icon in an accent
/// circle, a bold title, a muted description, and a prominent CTA control that
/// links via [href] or invokes [onTap]. Themed automatically by the active
/// stylesheet.
class CtaCard extends StatelessWidget {
  /// Icon to display at the top of the card.
  final Widget? icon;

  /// Main title/heading text.
  final String title;

  /// Description text below the title.
  final String? description;

  /// CTA button text.
  final String ctaText;

  /// Link destination (renders the CTA as an anchor when set).
  final String? href;

  /// Callback for click events (used when [href] is null).
  final void Function()? onTap;

  /// Custom minimum height for the card.
  final String height;

  /// Animation delay in milliseconds for staggered grid animations.
  final int? animationDelayMs;

  /// Whether to show hover effects.
  final bool showHoverEffects;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const CtaCard({
    this.icon,
    required this.title,
    this.description,
    required this.ctaText,
    this.href,
    this.onTap,
    this.height = '420px',
    this.animationDelayMs,
    this.showHoverEffects = true,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) => context.renderers.ctaCard(
        CTACardProps(
          icon: icon,
          title: title,
          description: description,
          ctaText: ctaText,
          href: href,
          onTap: onTap,
          height: height,
          animationDelayMs: animationDelayMs,
          showHoverEffects: showHoverEffects,
          styles: styles,
          decoration: decoration,
        ),
      );
}
